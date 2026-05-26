<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>HRMS - 注册</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="login-wrapper">
    <div class="login-box" style="width:460px;">
        <div class="logo">
            <h1>HRMS</h1>
            <p>新用户注册</p>
        </div>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/register.do?method=register" method="post" onsubmit="return validateRegister()">
            <div class="form-row">
                <div class="form-group">
                    <label>用户名 <span class="required">*</span></label>
                    <input type="text" id="username" name="username" class="form-control" placeholder="至少3个字符">
                </div>
                <div class="form-group">
                    <label>真实姓名 <span class="required">*</span></label>
                    <input type="text" id="realName" name="realName" class="form-control" placeholder="请输入真实姓名">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>密码 <span class="required">*</span></label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="至少6位">
                </div>
                <div class="form-group">
                    <label>确认密码 <span class="required">*</span></label>
                    <input type="password" id="confirm" name="confirm" class="form-control" placeholder="再次输入密码">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>邮箱</label>
                    <input type="text" name="email" class="form-control" placeholder="example@mail.com">
                </div>
                <div class="form-group">
                    <label>手机号</label>
                    <input type="text" name="phone" class="form-control" placeholder="11位手机号">
                </div>
            </div>
            <div class="form-group" style="margin-top:8px;">
                <button type="submit" class="btn btn-primary" style="width:100%;height:42px;font-size:15px;">注 册</button>
            </div>
            <div class="text-center" style="margin-top:16px;">
                <span class="text-secondary" style="font-size:13px;">已有账号？</span>
                <a href="${pageContext.request.contextPath}/login.do?method=page" style="font-size:13px;">返回登录</a>
            </div>
        </form>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/js/main.js"></script>
</body>
</html>
