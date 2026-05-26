package com.hrms.action;

import com.hrms.controller.BaseAction;
import com.hrms.dao.AttendanceDao;
import com.hrms.dao.EmployeeDao;
import com.hrms.model.Attendance;
import com.hrms.util.PageBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;

public class AttendanceAction extends BaseAction {

    private AttendanceDao attendanceDao = new AttendanceDao();
    private EmployeeDao employeeDao = new EmployeeDao();

    public String list(HttpServletRequest request, HttpServletResponse response) {
        int pageNum = 1;
        try { pageNum = Integer.parseInt(request.getParameter("pageNum")); } catch (Exception e) {}
        String keyword = request.getParameter("keyword");
        String workDate = request.getParameter("workDate");
        PageBean<Attendance> page = attendanceDao.findByPage(pageNum, 10, keyword, workDate);
        request.setAttribute("page", page);
        request.setAttribute("keyword", keyword);
        request.setAttribute("workDate", workDate);
        return "/jsp/attendance/list.jsp";
    }

    public String add(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("empList", employeeDao.findAll());
        return "/jsp/attendance/form.jsp";
    }

    public String save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Attendance att = new Attendance();
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) att.setId(Integer.parseInt(idStr));
        att.setEmpId(Integer.parseInt(request.getParameter("empId")));
        String wd = request.getParameter("workDate");
        if (wd != null && !wd.isEmpty()) att.setWorkDate(new SimpleDateFormat("yyyy-MM-dd").parse(wd));
        att.setCheckIn(request.getParameter("checkIn"));
        att.setCheckOut(request.getParameter("checkOut"));
        att.setStatus(Integer.parseInt(request.getParameter("status")));
        att.setRemark(request.getParameter("remark"));

        if (att.getId() > 0) {
            attendanceDao.update(att);
        } else {
            attendanceDao.insert(att);
        }
        return "redirect:/attendance.do?method=list";
    }

    public String edit(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        Attendance att = attendanceDao.findById(id);
        request.setAttribute("att", att);
        request.setAttribute("empList", employeeDao.findAll());
        return "/jsp/attendance/form.jsp";
    }

    public String delete(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        attendanceDao.delete(id);
        return "redirect:/attendance.do?method=list";
    }
}
