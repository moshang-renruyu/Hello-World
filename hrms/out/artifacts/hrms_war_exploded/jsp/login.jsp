<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>HRMS - 登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="login-wrapper">
    <div class="login-box">
        <div class="logo">
            <h1>HRMS</h1>
            <p>人事管理系统</p>
        </div>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/login.do?method=login" method="post" onsubmit="return validateLogin()">
            <div class="form-group">
                <label>用户名</label>
                <input type="text" id="username" name="username" class="form-control" placeholder="请输入用户名" value="${username}">
            </div>
            <div class="form-group">
                <label>密码</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="请输入密码">
            </div>
            <div class="form-group" style="margin-top:24px;">
                <button type="submit" class="btn btn-primary" style="width:100%;height:42px;font-size:15px;">登 录</button>
            </div>
            <div class="text-center" style="margin-top:16px;">
                <span class="text-secondary" style="font-size:13px;">还没有账号？</span>
                <a href="${pageContext.request.contextPath}/register.do?method=page" style="font-size:13px;">立即注册</a>
            </div>
        </form>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/main.js"></script>
</body>
</html>
