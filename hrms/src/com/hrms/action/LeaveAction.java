package com.hrms.action;

import com.hrms.controller.BaseAction;
import com.hrms.dao.EmployeeDao;
import com.hrms.dao.LeaveDao;
import com.hrms.model.LeaveRequest;
import com.hrms.model.User;
import com.hrms.util.PageBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;

public class LeaveAction extends BaseAction {

    private LeaveDao leaveDao = new LeaveDao();
    private EmployeeDao employeeDao = new EmployeeDao();

    public String list(HttpServletRequest request, HttpServletResponse response) {
        int pageNum = 1;
        try { pageNum = Integer.parseInt(request.getParameter("pageNum")); } catch (Exception e) {}
        String keyword = request.getParameter("keyword");
        int status = -1;
        try { status = Integer.parseInt(request.getParameter("status")); } catch (Exception e) {}
        PageBean<LeaveRequest> page = leaveDao.findByPage(pageNum, 10, keyword, status);
        request.setAttribute("page", page);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        return "/jsp/leave/list.jsp";
    }

    public String add(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("empList", employeeDao.findAll());
        return "/jsp/leave/form.jsp";
    }

    public String save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        LeaveRequest lr = new LeaveRequest();
        lr.setEmpId(Integer.parseInt(request.getParameter("empId")));
        lr.setType(Integer.parseInt(request.getParameter("type")));
        String sd = request.getParameter("startDate");
        if (sd != null && !sd.isEmpty()) lr.setStartDate(sdf.parse(sd));
        String ed = request.getParameter("endDate");
        if (ed != null && !ed.isEmpty()) lr.setEndDate(sdf.parse(ed));
        try { lr.setDays(Double.parseDouble(request.getParameter("days"))); } catch (Exception e) {}
        lr.setReason(request.getParameter("reason"));

        leaveDao.insert(lr);
        return "redirect:/leave.do?method=list";
    }

    public String detail(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        LeaveRequest lr = leaveDao.findById(id);
        request.setAttribute("lr", lr);
        return "/jsp/leave/detail.jsp";
    }

    public String approve(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        int status = Integer.parseInt(request.getParameter("approveStatus"));
        String remark = request.getParameter("approveRemark");
        User user = (User) request.getSession().getAttribute("loginUser");
        leaveDao.approve(id, status, user.getId(), remark);
        return "redirect:/leave.do?method=list";
    }

    public String delete(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        leaveDao.delete(id);
        return "redirect:/leave.do?method=list";
    }
}
