package com.hrms.action;

import com.hrms.controller.BaseAction;
import com.hrms.dao.SystemLogDao;
import com.hrms.dao.UserDao;
import com.hrms.model.SystemLog;
import com.hrms.model.User;
import com.hrms.util.PageBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SystemAction extends BaseAction {

    private SystemLogDao logDao = new SystemLogDao();
    private UserDao userDao = new UserDao();

    public String log(HttpServletRequest request, HttpServletResponse response) {
        int pageNum = 1;
        try { pageNum = Integer.parseInt(request.getParameter("pageNum")); } catch (Exception e) {}
        String keyword = request.getParameter("keyword");
        String module = request.getParameter("module");
        PageBean<SystemLog> page = logDao.findByPage(pageNum, 15, keyword, module);
        request.setAttribute("page", page);
        request.setAttribute("keyword", keyword);
        request.setAttribute("module", module);
        return "/jsp/system/log.jsp";
    }

    public String clearLog(HttpServletRequest request, HttpServletResponse response) {
        logDao.clearAll();
        return "redirect:/system.do?method=log";
    }

    public String userList(HttpServletRequest request, HttpServletResponse response) {
        int pageNum = 1;
        try { pageNum = Integer.parseInt(request.getParameter("pageNum")); } catch (Exception e) {}
        String keyword = request.getParameter("keyword");
        PageBean<User> page = userDao.findByPage(pageNum, 10, keyword);
        request.setAttribute("page", page);
        request.setAttribute("keyword", keyword);
        return "/jsp/system/user.jsp";
    }

    public String editUser(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDao.findById(id);
        request.setAttribute("editUser", user);
        return "/jsp/system/userForm.jsp";
    }

    public String saveUser(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDao.findById(id);
        user.setRealName(request.getParameter("realName"));
        user.setEmail(request.getParameter("email"));
        user.setPhone(request.getParameter("phone"));
        try { user.setRole(Integer.parseInt(request.getParameter("role"))); } catch (Exception e) {}
        try { user.setStatus(Integer.parseInt(request.getParameter("status"))); } catch (Exception e) {}
        userDao.update(user);
        return "redirect:/system.do?method=userList";
    }

    public String deleteUser(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        userDao.delete(id);
        return "redirect:/system.do?method=userList";
    }

    public String resetPwd(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        userDao.updatePassword(id, "123456");
        return "redirect:/system.do?method=userList";
    }

    public String profile(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("loginUser");
        request.setAttribute("profileUser", userDao.findById(user.getId()));
        return "/jsp/system/profile.jsp";
    }

    public String updateProfile(HttpServletRequest request, HttpServletResponse response) {
        User loginUser = (User) request.getSession().getAttribute("loginUser");
        User user = userDao.findById(loginUser.getId());
        user.setRealName(request.getParameter("realName"));
        user.setEmail(request.getParameter("email"));
        user.setPhone(request.getParameter("phone"));
        userDao.update(user);
        user = userDao.findById(loginUser.getId());
        request.getSession().setAttribute("loginUser", user);
        request.setAttribute("profileUser", user);
        request.setAttribute("success", "个人信息更新成功");
        return "/jsp/system/profile.jsp";
    }

    public String changePwd(HttpServletRequest request, HttpServletResponse response) {
        User loginUser = (User) request.getSession().getAttribute("loginUser");
        String oldPwd = request.getParameter("oldPassword");
        String newPwd = request.getParameter("newPassword");
        if (!loginUser.getPassword().equals(oldPwd)) {
            request.setAttribute("profileUser", userDao.findById(loginUser.getId()));
            request.setAttribute("error", "原密码错误");
            return "/jsp/system/profile.jsp";
        }
        userDao.updatePassword(loginUser.getId(), newPwd);
        request.setAttribute("profileUser", userDao.findById(loginUser.getId()));
        request.setAttribute("success", "密码修改成功");
        return "/jsp/system/profile.jsp";
    }
}
