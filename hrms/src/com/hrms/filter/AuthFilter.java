package com.hrms.filter;

import com.hrms.model.User;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig config) throws ServletException {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        String uri = request.getRequestURI();

        if (uri.contains("/login") || uri.contains("/register")
                || uri.contains("/static/") || uri.contains(".css")
                || uri.contains(".js") || uri.contains(".png")
                || uri.contains(".jpg") || uri.contains(".ico")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loginUser") != null) {
            User user = (User) session.getAttribute("loginUser");
            
            // 检查权限
            if (!checkPermission(user, uri)) {
                request.setAttribute("error", "您没有权限访问该功能");
                request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
                return;
            }
            
            chain.doFilter(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login.do?method=page");
        }
    }

    private boolean checkPermission(User user, String uri) {
        int role = user.getRole();
        
        // 管理员拥有所有权限
        if (role == 1) {
            return true;
        }
        
        // 普通用户权限
        if (role == 0) {
            // 允许访问的功能
            if (uri.contains("/leave") ||
                uri.contains("/system.do?method=profile") ||
                uri.contains("/system.do?method=updateProfile") ||
                uri.contains("/system.do?method=changePwd")) {
                return true;
            }
            
            // 禁止访问的功能
            if (uri.contains("/dashboard") ||
                uri.contains("/employee") ||
                uri.contains("/system.do?method=userList") ||
                uri.contains("/system.do?method=editUser") ||
                uri.contains("/system.do?method=saveUser") ||
                uri.contains("/system.do?method=deleteUser") ||
                uri.contains("/system.do?method=resetPwd") ||
                uri.contains("/system.do?method=log") ||
                uri.contains("/system.do?method=clearLog") ||
                uri.contains("/department") ||
                uri.contains("/position") ||
                uri.contains("/attendance") ||
                uri.contains("/salary") ||
                uri.contains("/recruitment") ||
                uri.contains("/training") ||
                uri.contains("/file") ||
                uri.contains("/register") ||
                uri.contains("/login.do?method=register")) {
                return false;
            }
        }
        
        return true;
    }

    @Override
    public void destroy() {}
}
