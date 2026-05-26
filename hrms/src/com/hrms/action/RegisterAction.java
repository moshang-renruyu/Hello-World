package com.hrms.action;

import com.hrms.controller.BaseAction;
import com.hrms.dao.UserDao;
import com.hrms.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegisterAction extends BaseAction {

    private UserDao userDao = new UserDao();

    public String page(HttpServletRequest request, HttpServletResponse response) {
        return "/jsp/register.jsp";
    }

    public String register(HttpServletRequest request, HttpServletResponse response) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");
        String realName = request.getParameter("realName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "用户名和密码不能为空");
            return "/jsp/register.jsp";
        }
        if (!password.equals(confirm)) {
            request.setAttribute("error", "两次密码输入不一致");
            return "/jsp/register.jsp";
        }
        if (userDao.existsByUsername(username)) {
            request.setAttribute("error", "用户名已存在");
            return "/jsp/register.jsp";
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setRealName(realName);
        user.setEmail(email);
        user.setPhone(phone);

        if (userDao.register(user)) {
            request.setAttribute("success", "注册成功，请登录");
            return "/jsp/login.jsp";
        } else {
            request.setAttribute("error", "注册失败，请重试");
            return "/jsp/register.jsp";
        }
    }
}
