<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>HRMS - ${param.title}</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<input type="hidden" id="ctx" value="${ctx}">
<div class="app">
    <aside class="sidebar">
        <div class="sidebar-header">
            <h2>HRMS</h2>
            <span>人事管理系统</span>
        </div>
        <nav class="sidebar-nav">
            <c:if test="${sessionScope.loginUser.role == 1}">
            <div class="nav-group">
                <div class="nav-group-title">主菜单</div>
                <a class="nav-item ${param.menu == 'dashboard' ? 'active' : ''}" href="${ctx}/dashboard.do?method=index">
                    <span class="nav-icon">H</span> 系统首页
                </a>
            </div>
            <div class="nav-group">
                <div class="nav-group-title">组织管理</div>
                <a class="nav-item ${param.menu == 'department' ? 'active' : ''}" href="${ctx}/department.do?method=list">
                    <span class="nav-icon">D</span> 部门管理
                </a>
                <a class="nav-item ${param.menu == 'position' ? 'active' : ''}" href="${ctx}/position.do?method=list">
                    <span class="nav-icon">P</span> 职位管理
                </a>
            </div>
            <div class="nav-group">
                <div class="nav-group-title">人事管理</div>
                <a class="nav-item ${param.menu == 'employee' ? 'active' : ''}" href="${ctx}/employee.do?method=list">
                    <span class="nav-icon">E</span> 员工管理
                </a>
                <a class="nav-item ${param.menu == 'attendance' ? 'active' : ''}" href="${ctx}/attendance.do?method=list">
                    <span class="nav-icon">A</span> 考勤管理
                </a>
                <a class="nav-item ${param.menu == 'salary' ? 'active' : ''}" href="${ctx}/salary.do?method=list">
                    <span class="nav-icon">S</span> 薪资管理
                </a>
                <a class="nav-item ${param.menu == 'leave' ? 'active' : ''}" href="${ctx}/leave.do?method=list">
                    <span class="nav-icon">L</span> 请假管理
                </a>
            </div>
            <div class="nav-group">
                <div class="nav-group-title">发展管理</div>
                <a class="nav-item ${param.menu == 'recruitment' ? 'active' : ''}" href="${ctx}/recruitment.do?method=list">
                    <span class="nav-icon">R</span> 招聘管理
                </a>
                <a class="nav-item ${param.menu == 'training' ? 'active' : ''}" href="${ctx}/training.do?method=list">
                    <span class="nav-icon">T</span> 培训管理
                </a>
            </div>
            </c:if>
            
            <c:if test="${sessionScope.loginUser.role == 0}">
            <div class="nav-group">
                <div class="nav-group-title">个人管理</div>
                <a class="nav-item ${param.menu == 'leave' ? 'active' : ''}" href="${ctx}/leave.do?method=list">
                    <span class="nav-icon">L</span> 请假管理
                </a>
            </div>
            </c:if>
            
            <div class="nav-group">
                <div class="nav-group-title">系统管理</div>
                <c:if test="${sessionScope.loginUser.role == 1}">
                <a class="nav-item ${param.menu == 'user' ? 'active' : ''}" href="${ctx}/system.do?method=userList">
                    <span class="nav-icon">U</span> 用户管理
                </a>
                <a class="nav-item ${param.menu == 'log' ? 'active' : ''}" href="${ctx}/system.do?method=log">
                    <span class="nav-icon">G</span> 操作日志
                </a>
                </c:if>
                <a class="nav-item ${param.menu == 'profile' ? 'active' : ''}" href="${ctx}/system.do?method=profile">
                    <span class="nav-icon">M</span> 个人中心
                </a>
            </div>
        </nav>
    </aside>
    <div class="main-content">
        <div class="topbar">
            <div class="topbar-left">
                <div class="breadcrumb">
                    <span>HRMS</span> / <span>${param.title}</span>
                </div>
            </div>
            <div class="topbar-right">
                <span class="online-info">在线: ${applicationScope.onlineCount}</span>
                <div class="user-info">
                    <div class="user-avatar">${sessionScope.loginUser.realName.substring(0,1)}</div>
                    <span class="user-name">${sessionScope.loginUser.realName}</span>
                </div>
                <a href="${ctx}/login.do?method=logout" class="btn-logout">退出</a>
            </div>
        </div>
        <div class="content">
