<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="系统首页"/>
    <jsp:param name="menu" value="dashboard"/>
</jsp:include>

<div class="page-header">
    <h2>系统首页</h2>
    <span class="text-secondary">欢迎回来，${sessionScope.loginUser.realName}</span>
</div>

<div class="stats-grid">
    <div class="stat-card">
        <div class="stat-title">员工总数</div>
        <div class="stat-value">${empCount}<span class="stat-unit">人</span></div>
    </div>
    <div class="stat-card success">
        <div class="stat-title">在职员工</div>
        <div class="stat-value">${empActive}<span class="stat-unit">人</span></div>
    </div>
    <div class="stat-card warning">
        <div class="stat-title">试用期员工</div>
        <div class="stat-value">${empTrial}<span class="stat-unit">人</span></div>
    </div>
    <div class="stat-card danger">
        <div class="stat-title">离职员工</div>
        <div class="stat-value">${empLeave}<span class="stat-unit">人</span></div>
    </div>
</div>

<div class="stats-grid">
    <div class="stat-card info">
        <div class="stat-title">部门数量</div>
        <div class="stat-value">${deptCount}<span class="stat-unit">个</span></div>
    </div>
    <div class="stat-card success">
        <div class="stat-title">今日正常出勤</div>
        <div class="stat-value">${todayNormal}<span class="stat-unit">人</span></div>
    </div>
    <div class="stat-card warning">
        <div class="stat-title">待审批请假</div>
        <div class="stat-value">${pendingLeave}<span class="stat-unit">条</span></div>
    </div>
    <div class="stat-card">
        <div class="stat-title">进行中招聘</div>
        <div class="stat-value">${activeRecruit}<span class="stat-unit">个</span></div>
    </div>
</div>

<div style="display:grid;grid-template-columns:1fr 1fr;gap:20px;">
    <div class="card">
        <div class="card-header">
            <h3>快捷操作</h3>
        </div>
        <div class="card-body" style="display:flex;flex-wrap:wrap;gap:10px;">
            <a href="${ctx}/employee.do?method=add" class="btn btn-primary">新增员工</a>
            <a href="${ctx}/attendance.do?method=add" class="btn btn-success">考勤登记</a>
            <a href="${ctx}/leave.do?method=add" class="btn btn-warning">请假申请</a>
            <a href="${ctx}/salary.do?method=add" class="btn btn-outline">薪资录入</a>
            <a href="${ctx}/recruitment.do?method=add" class="btn btn-outline">发布招聘</a>
            <a href="${ctx}/training.do?method=add" class="btn btn-outline">新增培训</a>
        </div>
    </div>
    <div class="card">
        <div class="card-header">
            <h3>系统信息</h3>
        </div>
        <div class="card-body">
            <div class="detail-item">
                <span class="detail-label">系统名称</span>
                <span class="detail-value">HRMS人事管理系统</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">系统版本</span>
                <span class="detail-value">V1.0</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">当前用户</span>
                <span class="detail-value">${sessionScope.loginUser.realName}（${sessionScope.loginUser.username}）</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">在线人数</span>
                <span class="detail-value">${applicationScope.onlineCount} 人</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">技术架构</span>
                <span class="detail-value">Servlet + JSP + JDBC</span>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/jsp/common/footer.jsp"/>
