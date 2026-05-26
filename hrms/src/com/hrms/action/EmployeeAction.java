package com.hrms.action;

import com.hrms.controller.BaseAction;
import com.hrms.dao.DepartmentDao;
import com.hrms.dao.EmployeeDao;
import com.hrms.dao.PositionDao;
import com.hrms.model.Employee;
import com.hrms.util.PageBean;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.UUID;

public class EmployeeAction extends BaseAction {

    private EmployeeDao employeeDao = new EmployeeDao();
    private DepartmentDao departmentDao = new DepartmentDao();
    private PositionDao positionDao = new PositionDao();
    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    public String list(HttpServletRequest request, HttpServletResponse response) {
        int pageNum = 1;
        try { pageNum = Integer.parseInt(request.getParameter("pageNum")); } catch (Exception e) {}
        String keyword = request.getParameter("keyword");
        int deptId = 0;
        try { deptId = Integer.parseInt(request.getParameter("deptId")); } catch (Exception e) {}
        int status = 0;
        try { status = Integer.parseInt(request.getParameter("status")); } catch (Exception e) {}

        PageBean<Employee> page = employeeDao.findByPage(pageNum, 10, keyword, deptId, status);
        request.setAttribute("page", page);
        request.setAttribute("keyword", keyword);
        request.setAttribute("deptId", deptId);
        request.setAttribute("status", status);
        request.setAttribute("deptList", departmentDao.findAll());
        return "/jsp/employee/list.jsp";
    }

    public String add(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("deptList", departmentDao.findAll());
        request.setAttribute("positionList", positionDao.findAll());
        request.setAttribute("empNo", employeeDao.generateEmpNo());
        return "/jsp/employee/form.jsp";
    }

    public String edit(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        Employee emp = employeeDao.findById(id);
        request.setAttribute("emp", emp);
        request.setAttribute("deptList", departmentDao.findAll());
        request.setAttribute("positionList", positionDao.findAll());
        return "/jsp/employee/form.jsp";
    }

    public String save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Employee emp = new Employee();
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) emp.setId(Integer.parseInt(idStr));
        emp.setEmpNo(request.getParameter("empNo"));
        emp.setName(request.getParameter("name"));
        emp.setGender(Integer.parseInt(request.getParameter("gender")));
        String birthDate = request.getParameter("birthDate");
        if (birthDate != null && !birthDate.isEmpty()) emp.setBirthDate(sdf.parse(birthDate));
        emp.setIdCard(request.getParameter("idCard"));
        emp.setPhone(request.getParameter("phone"));
        emp.setEmail(request.getParameter("email"));
        emp.setAddress(request.getParameter("address"));
        try { emp.setDeptId(Integer.parseInt(request.getParameter("deptId"))); } catch (Exception e) {}
        try { emp.setPositionId(Integer.parseInt(request.getParameter("positionId"))); } catch (Exception e) {}
        String hireDate = request.getParameter("hireDate");
        if (hireDate != null && !hireDate.isEmpty()) emp.setHireDate(sdf.parse(hireDate));
        emp.setStatus(Integer.parseInt(request.getParameter("status")));
        emp.setEducation(request.getParameter("education"));
        emp.setUniversity(request.getParameter("university"));
        emp.setMajor(request.getParameter("major"));
        emp.setEmergencyContact(request.getParameter("emergencyContact"));
        emp.setEmergencyPhone(request.getParameter("emergencyPhone"));
        String cs = request.getParameter("contractStart");
        if (cs != null && !cs.isEmpty()) emp.setContractStart(sdf.parse(cs));
        String ce = request.getParameter("contractEnd");
        if (ce != null && !ce.isEmpty()) emp.setContractEnd(sdf.parse(ce));
        emp.setRemark(request.getParameter("remark"));
        
        // 处理爱好复选框
        String[] hobbiesArray = request.getParameterValues("hobbies");
        if (hobbiesArray != null && hobbiesArray.length > 0) {
            StringBuilder hobbiesBuilder = new StringBuilder();
            for (int i = 0; i < hobbiesArray.length; i++) {
                if (i > 0) hobbiesBuilder.append(",");
                hobbiesBuilder.append(hobbiesArray[i]);
            }
            emp.setHobbies(hobbiesBuilder.toString());
        } else {
            emp.setHobbies(null);
        }

        // 处理照片上传
        try {
            Part photoPart = request.getPart("photo");
            if (photoPart != null && photoPart.getSize() > 0) {
                String origName = getFileName(photoPart);
                if (origName != null && !origName.isEmpty()) {
                    String ext = origName.contains(".") ? origName.substring(origName.lastIndexOf(".")) : "";
                    String newFileName = UUID.randomUUID().toString().replace("-", "") + ext;
                    String uploadPath = request.getServletContext().getRealPath("/upload");
                    File dir = new File(uploadPath);
                    if (!dir.exists()) dir.mkdirs();
                    try (InputStream is = photoPart.getInputStream();
                         FileOutputStream fos = new FileOutputStream(new File(uploadPath, newFileName))) {
                        byte[] buf = new byte[4096];
                        int len;
                        while ((len = is.read(buf)) != -1) fos.write(buf, 0, len);
                    }
                    emp.setPhoto(newFileName);
                }
            }
        } catch (Exception ignored) {}

        boolean ok;
        if (emp.getId() > 0) {
            if (emp.getPhoto() != null) {
                employeeDao.updatePhoto(emp.getId(), emp.getPhoto());
            }
            ok = employeeDao.update(emp);
        } else {
            ok = employeeDao.insert(emp);
        }
        if (ok) {
            return "redirect:/employee.do?method=list";
        } else {
            request.setAttribute("error", "操作失败");
            request.setAttribute("emp", emp);
            request.setAttribute("deptList", departmentDao.findAll());
            request.setAttribute("positionList", positionDao.findAll());
            return "/jsp/employee/form.jsp";
        }
    }

    public String detail(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        Employee emp = employeeDao.findById(id);
        request.setAttribute("emp", emp);
        return "/jsp/employee/detail.jsp";
    }

    private String getFileName(Part part) {
        String header = part.getHeader("content-disposition");
        if (header == null) return null;
        for (String token : header.split(";")) {
            token = token.trim();
            if (token.startsWith("filename")) {
                String name = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                if (name.contains("\\")) name = name.substring(name.lastIndexOf("\\") + 1);
                if (name.contains("/")) name = name.substring(name.lastIndexOf("/") + 1);
                return name;
            }
        }
        return null;
    }

    public String delete(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        employeeDao.delete(id);
        return "redirect:/employee.do?method=list";
    }
}