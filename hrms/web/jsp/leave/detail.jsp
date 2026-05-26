<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="请假详情"/>
    <jsp:param name="menu" value="leave"/>
</jsp:include>

<div class="page-header">
    <h2>请假详情</h2>
    <a href="${ctx}/leave.do?method=list" class="btn btn-outline">返回列表</a>
</div>

<div class="card mb-20">
    <div class="card-header"><h3>申请信息</h3></div>
    <div class="card-body">
        <div class="detail-grid">
            <div class="detail-item"><span class="detail-label">工号</span><span class="detail-value">${lr.empNo}</span></div>
            <div class="detail-item"><span class="detail-label">姓名</span><span class="detail-value">${lr.empName}</span></div>
            <div class="detail-item"><span class="detail-label">部门</span><span class="detail-value">${lr.deptName}</span></div>
            <div class="detail-item"><span class="detail-label">请假类型</span><span class="detail-value">
                <c:choose><c:when test="${lr.type==1}">事假</c:when><c:when test="${lr.type==2}">病假</c:when><c:when test="${lr.type==3}">年假</c:when><c:when test="${lr.type==4}">婚假</c:when><c:when test="${lr.type==5}">产假</c:when><c:when test="${lr.type==6}">丧假</c:when></c:choose>
            </span></div>
            <div class="detail-item"><span class="detail-label">开始日期</span><span class="detail-value"><fmt:formatDate value="${lr.startDate}" pattern="yyyy-MM-dd"/></span></div>
            <div class="detail-item"><span class="detail-label">结束日期</span><span class="detail-value"><fmt:formatDate value="${lr.endDate}" pattern="yyyy-MM-dd"/></span></div>
            <div class="detail-item"><span class="detail-label">请假天数</span><span class="detail-value">${lr.days} 天</span></div>
            <div class="detail-item"><span class="detail-label">状态</span><span class="detail-value">
                <c:choose><c:when test="${lr.status==0}"><span class="badge badge-warning">待审批</span></c:when><c:when test="${lr.status==1}"><span class="badge badge-success">已批准</span></c:when><c:when test="${lr.status==2}"><span class="badge badge-danger">已拒绝</span></c:when><c:when test="${lr.status==3}"><span class="badge badge-secondary">已撤销</span></c:when></c:choose>
            </span></div>
        </div>
        <div class="detail-item" style="margin-top:8px;"><span class="detail-label">请假事由</span><span class="detail-value">${lr.reason}</span></div>
    </div>
</div>

<c:if test="${lr.status != 0}">
<div class="card mb-20">
    <div class="card-header"><h3>审批信息</h3></div>
    <div class="card-body">
        <div class="detail-grid">
            <div class="detail-item"><span class="detail-label">审批时间</span><span class="detail-value"><fmt:formatDate value="${lr.approveTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span></div>
            <div class="detail-item"><span class="detail-label">审批意见</span><span class="detail-value">${lr.approveRemark}</span></div>
        </div>
    </div>
</div>
</c:if>

<jsp:include page="/jsp/common/footer.jsp"/>
