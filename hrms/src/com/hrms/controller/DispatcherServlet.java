package com.hrms.controller;

import com.hrms.action.*;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class DispatcherServlet extends HttpServlet {

    private Map<String, BaseAction> actions = new HashMap<>();

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        actions.put("/login", new LoginAction());
        actions.put("/register", new RegisterAction());
        actions.put("/employee", new EmployeeAction());
        actions.put("/department", new DepartmentAction());
        actions.put("/position", new PositionAction());
        actions.put("/attendance", new AttendanceAction());
        actions.put("/salary", new SalaryAction());
        actions.put("/leave", new LeaveAction());
        actions.put("/recruitment", new RecruitmentAction());
        actions.put("/training", new TrainingAction());
        actions.put("/system", new SystemAction());
        actions.put("/file", new FileAction());
        actions.put("/dashboard", new DashboardAction());
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = uri.substring(contextPath.length()).replace(".do", "");

        BaseAction action = actions.get(path);
        if (action == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        try {
            String result = action.execute(request, response);
            if (result != null && !result.isEmpty()) {
                if (result.startsWith("redirect:")) {
                    response.sendRedirect(contextPath + result.substring(9));
                } else if (result.startsWith("json:")) {
                    response.setContentType("application/json;charset=UTF-8");
                    response.getWriter().write(result.substring(5));
                } else {
                    request.getRequestDispatcher(result).forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", e.getMessage());
            request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
        }
    }
}
