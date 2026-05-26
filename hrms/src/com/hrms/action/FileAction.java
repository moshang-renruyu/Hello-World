package com.hrms.action;

import com.hrms.controller.BaseAction;
import com.hrms.dao.EmployeeDao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.net.URLEncoder;
import java.util.UUID;

public class FileAction extends BaseAction {

    private EmployeeDao employeeDao = new EmployeeDao();

    public String upload(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String contentType = request.getContentType();
        if (contentType == null || !contentType.startsWith("multipart/")) {
            request.setAttribute("error", "请选择文件");
            return "/jsp/common/error.jsp";
        }

        String uploadPath = request.getServletContext().getRealPath("/upload");
        File dir = new File(uploadPath);
        if (!dir.exists()) dir.mkdirs();

        Part filePart = request.getPart("file");
        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("error", "请选择文件");
            return "/jsp/common/error.jsp";
        }

        String fileName = getFileName(filePart);
        if (fileName == null || fileName.isEmpty()) {
            request.setAttribute("error", "文件名无效");
            return "/jsp/common/error.jsp";
        }

        String ext = "";
        if (fileName.contains(".")) {
            ext = fileName.substring(fileName.lastIndexOf("."));
        }
        String newFileName = UUID.randomUUID().toString().replace("-", "") + ext;

        File target = new File(uploadPath, newFileName);
        try (InputStream is = filePart.getInputStream();
             FileOutputStream fos = new FileOutputStream(target)) {
            byte[] buffer = new byte[4096];
            int len;
            while ((len = is.read(buffer)) != -1) {
                fos.write(buffer, 0, len);
            }
        }

        String empIdStr = request.getParameter("empId");
        if (empIdStr != null && !empIdStr.isEmpty()) {
            int empId = Integer.parseInt(empIdStr);
            employeeDao.updatePhoto(empId, newFileName);
            return "redirect:/employee.do?method=edit&id=" + empId;
        }

        request.setAttribute("success", "文件上传成功: " + fileName);
        request.setAttribute("filePath", newFileName);
        return "/jsp/common/success.jsp";
    }

    private String getFileName(Part part) {
        String header = part.getHeader("content-disposition");
        if (header == null) return null;
        for (String token : header.split(";")) {
            token = token.trim();
            if (token.startsWith("filename")) {
                String name = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                if (name.contains("\\")) {
                    name = name.substring(name.lastIndexOf("\\") + 1);
                }
                if (name.contains("/")) {
                    name = name.substring(name.lastIndexOf("/") + 1);
                }
                return name;
            }
        }
        return null;
    }

    public String download(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String fileName = request.getParameter("fileName");
        String displayName = request.getParameter("displayName");
        if (displayName == null || displayName.isEmpty()) displayName = fileName;

        String uploadPath = request.getServletContext().getRealPath("/upload");
        File file = new File(uploadPath, fileName);
        if (!file.exists()) {
            request.setAttribute("error", "文件不存在");
            return "/jsp/common/error.jsp";
        }

        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(displayName, "UTF-8"));
        response.setContentLength((int) file.length());

        FileInputStream fis = new FileInputStream(file);
        OutputStream os = response.getOutputStream();
        byte[] buffer = new byte[4096];
        int len;
        while ((len = fis.read(buffer)) != -1) {
            os.write(buffer, 0, len);
        }
        os.flush();
        fis.close();
        return null;
    }
}
