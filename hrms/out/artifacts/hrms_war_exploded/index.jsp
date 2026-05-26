<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 检查用户是否已登录
    Object loginUser = session.getAttribute("loginUser");
    if (loginUser != null) {
        // 已登录，根据用户角色跳转到不同页面
        com.hrms.model.User user = (com.hrms.model.User) loginUser;
        if (user.getRole() == 1) {
            // 管理员跳转到系统首页
            response.sendRedirect(request.getContextPath() + "/dashboard.do?method=index");
        } else {
            // 普通员工跳转到个人中心
            response.sendRedirect(request.getContextPath() + "/system.do?method=profile");
        }
    } else {
        // 未登录，跳转到登录页面
        response.sendRedirect(request.getContextPath() + "/login.do?method=page");
    }
%>


