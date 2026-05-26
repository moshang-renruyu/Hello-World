package com.hrms.action;

import com.hrms.controller.BaseAction;
import com.hrms.dao.SystemLogDao;
import com.hrms.dao.UserDao;
import com.hrms.model.SystemLog;
import com.hrms.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginAction extends BaseAction {

    private UserDao userDao = new UserDao();
    private SystemLogDao logDao = new SystemLogDao();

    public String page(HttpServletRequest request, HttpServletResponse response) {
        return "/jsp/login.jsp";
    }

    public String login(HttpServletRequest request, HttpServletResponse response) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "用户名和密码不能为空");
            return "/jsp/login.jsp";
        }

        User user = userDao.login(username, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", user);
            SystemLog log = new SystemLog();
            log.setUserId(user.getId());
            log.setUsername(user.getUsername());
            log.setOperation("用户登录");
            log.setModule("系统");
            log.setIp(request.getRemoteAddr());
            logDao.insert(log);
            
            // 根据用户角色跳转到不同页面
            if (user.getRole() == 1) {
                // 管理员跳转到系统首页
                return "redirect:/dashboard.do?method=index";
            } else {
                // 普通员工跳转到个人中心
                return "redirect:/system.do?method=profile";
            }
        } else {
            request.setAttribute("error", "用户名或密码错误");
            request.setAttribute("username", username);
            return "/jsp/login.jsp";
        }
    }

    public String logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("loginUser");
            if (user != null) {
                SystemLog log = new SystemLog();
                log.setUserId(user.getId());
                log.setUsername(user.getUsername());
                log.setOperation("用户登出");
                log.setModule("系统");
                log.setIp(request.getRemoteAddr());
                logDao.insert(log);
            }
            session.invalidate();
        }
        return "redirect:/login.do?method=page";
    }
}
