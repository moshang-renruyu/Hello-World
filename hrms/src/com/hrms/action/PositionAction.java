package com.hrms.action;

import com.hrms.controller.BaseAction;
import com.hrms.dao.DepartmentDao;
import com.hrms.dao.PositionDao;
import com.hrms.model.Position;
import com.hrms.util.PageBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PositionAction extends BaseAction {

    private PositionDao positionDao = new PositionDao();
    private DepartmentDao departmentDao = new DepartmentDao();

    public String list(HttpServletRequest request, HttpServletResponse response) {
        int pageNum = 1;
        try { pageNum = Integer.parseInt(request.getParameter("pageNum")); } catch (Exception e) {}
        String keyword = request.getParameter("keyword");
        int deptId = 0;
        try { deptId = Integer.parseInt(request.getParameter("deptId")); } catch (Exception e) {}
        PageBean<Position> page = positionDao.findByPage(pageNum, 10, keyword, deptId);
        request.setAttribute("page", page);
        request.setAttribute("keyword", keyword);
        request.setAttribute("deptId", deptId);
        request.setAttribute("deptList", departmentDao.findAll());
        return "/jsp/position/list.jsp";
    }

    public String add(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("deptList", departmentDao.findAll());
        return "/jsp/position/form.jsp";
    }

    public String edit(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        Position pos = positionDao.findById(id);
        request.setAttribute("pos", pos);
        request.setAttribute("deptList", departmentDao.findAll());
        return "/jsp/position/form.jsp";
    }

    public String save(HttpServletRequest request, HttpServletResponse response) {
        Position pos = new Position();
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) pos.setId(Integer.parseInt(idStr));
        pos.setName(request.getParameter("name"));
        pos.setCode(request.getParameter("code"));
        try { pos.setDeptId(Integer.parseInt(request.getParameter("deptId"))); } catch (Exception e) {}
        try { pos.setLevel(Integer.parseInt(request.getParameter("level"))); } catch (Exception e) {}
        try { pos.setSalaryMin(Double.parseDouble(request.getParameter("salaryMin"))); } catch (Exception e) {}
        try { pos.setSalaryMax(Double.parseDouble(request.getParameter("salaryMax"))); } catch (Exception e) {}
        pos.setDescription(request.getParameter("description"));
        pos.setStatus(Integer.parseInt(request.getParameter("status")));

        if (pos.getId() > 0) {
            positionDao.update(pos);
        } else {
            positionDao.insert(pos);
        }
        return "redirect:/position.do?method=list";
    }

    public String delete(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        positionDao.delete(id);
        return "redirect:/position.do?method=list";
    }

    public String getByDept(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int deptId = Integer.parseInt(request.getParameter("deptId"));
        java.util.List<Position> list = positionDao.findByDeptId(deptId);
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append("{\"id\":").append(list.get(i).getId())
              .append(",\"name\":\"").append(list.get(i).getName()).append("\"}");
        }
        sb.append("]");
        return "json:" + sb.toString();
    }
}
