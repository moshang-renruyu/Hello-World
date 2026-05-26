package com.hrms.action;

import com.hrms.controller.BaseAction;
import com.hrms.dao.EmployeeDao;
import com.hrms.dao.SalaryDao;
import com.hrms.model.Salary;
import com.hrms.util.PageBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SalaryAction extends BaseAction {

    private SalaryDao salaryDao = new SalaryDao();
    private EmployeeDao employeeDao = new EmployeeDao();

    public String list(HttpServletRequest request, HttpServletResponse response) {
        int pageNum = 1;
        try { pageNum = Integer.parseInt(request.getParameter("pageNum")); } catch (Exception e) {}
        String keyword = request.getParameter("keyword");
        String month = request.getParameter("month");
        PageBean<Salary> page = salaryDao.findByPage(pageNum, 10, keyword, month);
        request.setAttribute("page", page);
        request.setAttribute("keyword", keyword);
        request.setAttribute("month", month);
        return "/jsp/salary/list.jsp";
    }

    public String add(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("empList", employeeDao.findAll());
        return "/jsp/salary/form.jsp";
    }

    public String edit(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        Salary sal = salaryDao.findById(id);
        request.setAttribute("sal", sal);
        request.setAttribute("empList", employeeDao.findAll());
        return "/jsp/salary/form.jsp";
    }

    public String save(HttpServletRequest request, HttpServletResponse response) {
        Salary sal = new Salary();
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) sal.setId(Integer.parseInt(idStr));
        try { sal.setEmpId(Integer.parseInt(request.getParameter("empId"))); } catch (Exception e) {}
        sal.setMonth(request.getParameter("month"));
        try { sal.setBaseSalary(Double.parseDouble(request.getParameter("baseSalary"))); } catch (Exception e) {}
        try { sal.setBonus(Double.parseDouble(request.getParameter("bonus"))); } catch (Exception e) {}
        try { sal.setAllowance(Double.parseDouble(request.getParameter("allowance"))); } catch (Exception e) {}
        try { sal.setOvertimePay(Double.parseDouble(request.getParameter("overtimePay"))); } catch (Exception e) {}
        try { sal.setDeduction(Double.parseDouble(request.getParameter("deduction"))); } catch (Exception e) {}
        try { sal.setInsurance(Double.parseDouble(request.getParameter("insurance"))); } catch (Exception e) {}
        try { sal.setTax(Double.parseDouble(request.getParameter("tax"))); } catch (Exception e) {}
        double actual = sal.getBaseSalary() + sal.getBonus() + sal.getAllowance() + sal.getOvertimePay()
                - sal.getDeduction() - sal.getInsurance() - sal.getTax();
        sal.setActualSalary(actual);
        try { sal.setStatus(Integer.parseInt(request.getParameter("status"))); } catch (Exception e) {}
        sal.setRemark(request.getParameter("remark"));

        if (sal.getId() > 0) {
            salaryDao.update(sal);
        } else {
            salaryDao.insert(sal);
        }
        return "redirect:/salary.do?method=list";
    }

    public String detail(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        Salary sal = salaryDao.findById(id);
        request.setAttribute("sal", sal);
        return "/jsp/salary/detail.jsp";
    }

    public String delete(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        salaryDao.delete(id);
        return "redirect:/salary.do?method=list";
    }
}
