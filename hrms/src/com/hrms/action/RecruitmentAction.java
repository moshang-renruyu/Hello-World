package com.hrms.action;

import com.hrms.controller.BaseAction;
import com.hrms.dao.DepartmentDao;
import com.hrms.dao.RecruitmentDao;
import com.hrms.model.Recruitment;
import com.hrms.model.User;
import com.hrms.util.PageBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;

public class RecruitmentAction extends BaseAction {

    private RecruitmentDao recruitmentDao = new RecruitmentDao();
    private DepartmentDao departmentDao = new DepartmentDao();

    public String list(HttpServletRequest request, HttpServletResponse response) {
        int pageNum = 1;
        try { pageNum = Integer.parseInt(request.getParameter("pageNum")); } catch (Exception e) {}
        String keyword = request.getParameter("keyword");
        int status = 0;
        try { status = Integer.parseInt(request.getParameter("status")); } catch (Exception e) {}
        PageBean<Recruitment> page = recruitmentDao.findByPage(pageNum, 10, keyword, status);
        request.setAttribute("page", page);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        return "/jsp/recruitment/list.jsp";
    }

    public String add(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("deptList", departmentDao.findAll());
        return "/jsp/recruitment/form.jsp";
    }

    public String edit(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        Recruitment rec = recruitmentDao.findById(id);
        request.setAttribute("rec", rec);
        request.setAttribute("deptList", departmentDao.findAll());
        return "/jsp/recruitment/form.jsp";
    }

    public String save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Recruitment rec = new Recruitment();
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) rec.setId(Integer.parseInt(idStr));
        rec.setTitle(request.getParameter("title"));
        try { rec.setDeptId(Integer.parseInt(request.getParameter("deptId"))); } catch (Exception e) {}
        rec.setPositionName(request.getParameter("positionName"));
        try { rec.setHeadCount(Integer.parseInt(request.getParameter("headCount"))); } catch (Exception e) { rec.setHeadCount(1); }
        rec.setEducation(request.getParameter("education"));
        rec.setExperience(request.getParameter("experience"));
        rec.setSalaryRange(request.getParameter("salaryRange"));
        rec.setDescription(request.getParameter("description"));
        rec.setRequirement(request.getParameter("requirement"));
        rec.setStatus(Integer.parseInt(request.getParameter("status")));
        String dl = request.getParameter("deadline");
        if (dl != null && !dl.isEmpty()) rec.setDeadline(sdf.parse(dl));

        if (rec.getId() > 0) {
            recruitmentDao.update(rec);
        } else {
            User user = (User) request.getSession().getAttribute("loginUser");
            rec.setPublisher(user.getRealName());
            rec.setPublishDate(new java.util.Date());
            recruitmentDao.insert(rec);
        }
        return "redirect:/recruitment.do?method=list";
    }

    public String detail(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        Recruitment rec = recruitmentDao.findById(id);
        request.setAttribute("rec", rec);
        return "/jsp/recruitment/detail.jsp";
    }

    public String delete(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        recruitmentDao.delete(id);
        return "redirect:/recruitment.do?method=list";
    }
}
