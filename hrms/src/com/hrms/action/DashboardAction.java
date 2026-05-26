package com.hrms.action;

import com.hrms.controller.BaseAction;
import com.hrms.dao.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DashboardAction extends BaseAction {

    private EmployeeDao employeeDao = new EmployeeDao();
    private DepartmentDao departmentDao = new DepartmentDao();
    private AttendanceDao attendanceDao = new AttendanceDao();
    private LeaveDao leaveDao = new LeaveDao();
    private RecruitmentDao recruitmentDao = new RecruitmentDao();
    private TrainingDao trainingDao = new TrainingDao();

    public String index(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("empCount", employeeDao.countAll());
        request.setAttribute("deptCount", departmentDao.countAll());
        request.setAttribute("empActive", employeeDao.countByStatus(1));
        request.setAttribute("empTrial", employeeDao.countByStatus(3));
        request.setAttribute("empLeave", employeeDao.countByStatus(2));
        request.setAttribute("todayNormal", attendanceDao.countTodayNormal());
        request.setAttribute("todayLate", attendanceDao.countTodayLate());
        request.setAttribute("pendingLeave", leaveDao.countPending());
        request.setAttribute("activeRecruit", recruitmentDao.countActive());
        request.setAttribute("activeTraining", trainingDao.countActive());
        return "/jsp/dashboard.jsp";
    }
}
