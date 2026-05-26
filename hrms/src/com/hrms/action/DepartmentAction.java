package com.hrms.action;

import com.hrms.controller.BaseAction;
import com.hrms.dao.DepartmentDao;
import com.hrms.model.Department;
import com.hrms.util.PageBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DepartmentAction extends BaseAction {

    private DepartmentDao departmentDao = new DepartmentDao();

    public String list(HttpServletRequest request, HttpServletResponse response) {
        int pageNum = 1;
        try { pageNum = Integer.parseInt(request.getParameter("pageNum")); } catch (Exception e) {}
        String keyword = request.getParameter("keyword");
        PageBean<Department> page = departmentDao.findByPage(pageNum, 10, keyword);
        request.setAttribute("page", page);
        request.setAttribute("keyword", keyword);
        return "/jsp/department/list.jsp";
    }

    public String add(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("parentList", departmentDao.findAll());
        return "/jsp/department/form.jsp";
    }

    public String edit(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        Department dept = departmentDao.findById(id);
        request.setAttribute("dept", dept);
        request.setAttribute("parentList", departmentDao.findAll());
        return "/jsp/department/form.jsp";
    }

    public String save(HttpServletRequest request, HttpServletResponse response) {
        Department dept = new Department();
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) dept.setId(Integer.parseInt(idStr));
        dept.setName(request.getParameter("name"));
        dept.setCode(request.getParameter("code"));
        dept.setManager(request.getParameter("manager"));
        dept.setPhone(request.getParameter("phone"));
        dept.setDescription(request.getParameter("description"));
        try { dept.setParentId(Integer.parseInt(request.getParameter("parentId"))); } catch (Exception e) {}
        try { dept.setSortOrder(Integer.parseInt(request.getParameter("sortOrder"))); } catch (Exception e) {}
        dept.setStatus(Integer.parseInt(request.getParameter("status")));

        boolean ok;
        if (dept.getId() > 0) {
            ok = departmentDao.update(dept);
        } else {
            ok = departmentDao.insert(dept);
        }
        return "redirect:/department.do?method=list";
    }

    public String delete(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        departmentDao.delete(id);
        return "redirect:/department.do?method=list";
    }
}
