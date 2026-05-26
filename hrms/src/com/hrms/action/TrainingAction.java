package com.hrms.action;

import com.hrms.controller.BaseAction;
import com.hrms.dao.DepartmentDao;
import com.hrms.dao.TrainingDao;
import com.hrms.model.Training;
import com.hrms.util.PageBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;

public class TrainingAction extends BaseAction {

    private TrainingDao trainingDao = new TrainingDao();
    private DepartmentDao departmentDao = new DepartmentDao();

    public String list(HttpServletRequest request, HttpServletResponse response) {
        int pageNum = 1;
        try { pageNum = Integer.parseInt(request.getParameter("pageNum")); } catch (Exception e) {}
        String keyword = request.getParameter("keyword");
        int status = 0;
        try { status = Integer.parseInt(request.getParameter("status")); } catch (Exception e) {}
        PageBean<Training> page = trainingDao.findByPage(pageNum, 10, keyword, status);
        request.setAttribute("page", page);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        return "/jsp/training/list.jsp";
    }

    public String add(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("deptList", departmentDao.findAll());
        return "/jsp/training/form.jsp";
    }

    public String edit(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        Training t = trainingDao.findById(id);
        request.setAttribute("training", t);
        request.setAttribute("deptList", departmentDao.findAll());
        return "/jsp/training/form.jsp";
    }

    public String save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Training t = new Training();
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) t.setId(Integer.parseInt(idStr));
        t.setTitle(request.getParameter("title"));
        try { t.setType(Integer.parseInt(request.getParameter("type"))); } catch (Exception e) {}
        t.setTrainer(request.getParameter("trainer"));
        try { t.setDeptId(Integer.parseInt(request.getParameter("deptId"))); } catch (Exception e) {}
        String sd = request.getParameter("startDate");
        if (sd != null && !sd.isEmpty()) t.setStartDate(sdf.parse(sd));
        String ed = request.getParameter("endDate");
        if (ed != null && !ed.isEmpty()) t.setEndDate(sdf.parse(ed));
        t.setLocation(request.getParameter("location"));
        t.setContent(request.getParameter("content"));
        try { t.setMaxCount(Integer.parseInt(request.getParameter("maxCount"))); } catch (Exception e) {}
        t.setStatus(Integer.parseInt(request.getParameter("status")));

        if (t.getId() > 0) {
            trainingDao.update(t);
        } else {
            trainingDao.insert(t);
        }
        return "redirect:/training.do?method=list";
    }

    public String detail(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        Training t = trainingDao.findById(id);
        request.setAttribute("training", t);
        return "/jsp/training/detail.jsp";
    }

    public String delete(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        trainingDao.delete(id);
        return "redirect:/training.do?method=list";
    }
}
