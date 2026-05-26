<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="培训详情"/>
    <jsp:param name="menu" value="training"/>
</jsp:include>

<div class="page-header">
    <h2>培训详情</h2>
    <div>
        <a href="${ctx}/training.do?method=edit&id=${training.id}" class="btn btn-primary btn-sm">编辑</a>
        <a href="${ctx}/training.do?method=list" class="btn btn-outline btn-sm">返回列表</a>
    </div>
</div>

<div class="card mb-20">
    <div class="card-header"><h3>${training.title}</h3></div>
    <div class="card-body">
        <div class="detail-grid">
            <div class="detail-item"><span class="detail-label">培训类型</span><span class="detail-value">
                <c:choose><c:when test="${training.type==1}"><span class="badge badge-primary">内部培训</span></c:when><c:when test="${training.type==2}"><span class="badge badge-info">外部培训</span></c:when><c:when test="${training.type==3}"><span class="badge badge-secondary">在线培训</span></c:when></c:choose>
            </span></div>
            <div class="detail-item"><span class="detail-label">讲师</span><span class="detail-value">${training.trainer}</span></div>
            <div class="detail-item"><span class="detail-label">所属部门</span><span class="detail-value">${training.deptName}</span></div>
            <div class="detail-item"><span class="detail-label">培训地点</span><span class="detail-value">${training.location}</span></div>
            <div class="detail-item"><span class="detail-label">开始日期</span><span class="detail-value"><fmt:formatDate value="${training.startDate}" pattern="yyyy-MM-dd"/></span></div>
            <div class="detail-item"><span class="detail-label">结束日期</span><span class="detail-value"><fmt:formatDate value="${training.endDate}" pattern="yyyy-MM-dd"/></span></div>
            <div class="detail-item"><span class="detail-label">参加人数</span><span class="detail-value">${training.currentCount} / ${training.maxCount}</span></div>
            <div class="detail-item"><span class="detail-label">状态</span><span class="detail-value">
                <c:choose><c:when test="${training.status==1}"><span class="badge badge-warning">计划中</span></c:when><c:when test="${training.status==2}"><span class="badge badge-success">进行中</span></c:when><c:when test="${training.status==3}"><span class="badge badge-secondary">已结束</span></c:when></c:choose>
            </span></div>
        </div>
    </div>
</div>
<c:if test="${not empty training.content}">
<div class="card mb-20"><div class="card-header"><h3>培训内容</h3></div><div class="card-body" style="white-space:pre-line;">${training.content}</div></div>
</c:if>
<c:if test="${not empty training.attachment}">
<div class="card mb-20"><div class="card-header"><h3>培训资料</h3></div><div class="card-body">
    <a href="${ctx}/file.do?method=download&fileName=${training.attachment}&displayName=${training.title}_资料" class="btn btn-outline btn-sm">下载资料</a>
</div></div>
</c:if>

<jsp:include page="/jsp/common/footer.jsp"/>
