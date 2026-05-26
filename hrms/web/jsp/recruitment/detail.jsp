<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="招聘详情"/>
    <jsp:param name="menu" value="recruitment"/>
</jsp:include>

<div class="page-header">
    <h2>招聘详情</h2>
    <div>
        <a href="${ctx}/recruitment.do?method=edit&id=${rec.id}" class="btn btn-primary btn-sm">编辑</a>
        <a href="${ctx}/recruitment.do?method=list" class="btn btn-outline btn-sm">返回列表</a>
    </div>
</div>

<div class="card mb-20">
    <div class="card-header"><h3>${rec.title}</h3></div>
    <div class="card-body">
        <div class="detail-grid">
            <div class="detail-item"><span class="detail-label">招聘部门</span><span class="detail-value">${rec.deptName}</span></div>
            <div class="detail-item"><span class="detail-label">招聘职位</span><span class="detail-value">${rec.positionName}</span></div>
            <div class="detail-item"><span class="detail-label">招聘人数</span><span class="detail-value">${rec.headCount} 人</span></div>
            <div class="detail-item"><span class="detail-label">学历要求</span><span class="detail-value">${rec.education}</span></div>
            <div class="detail-item"><span class="detail-label">经验要求</span><span class="detail-value">${rec.experience}</span></div>
            <div class="detail-item"><span class="detail-label">薪资范围</span><span class="detail-value">${rec.salaryRange}</span></div>
            <div class="detail-item"><span class="detail-label">发布人</span><span class="detail-value">${rec.publisher}</span></div>
            <div class="detail-item"><span class="detail-label">发布日期</span><span class="detail-value"><fmt:formatDate value="${rec.publishDate}" pattern="yyyy-MM-dd"/></span></div>
            <div class="detail-item"><span class="detail-label">截止日期</span><span class="detail-value"><fmt:formatDate value="${rec.deadline}" pattern="yyyy-MM-dd"/></span></div>
            <div class="detail-item"><span class="detail-label">状态</span><span class="detail-value">
                <c:choose><c:when test="${rec.status==1}"><span class="badge badge-success">招聘中</span></c:when><c:when test="${rec.status==2}"><span class="badge badge-warning">已暂停</span></c:when><c:when test="${rec.status==3}"><span class="badge badge-secondary">已结束</span></c:when></c:choose>
            </span></div>
        </div>
    </div>
</div>
<c:if test="${not empty rec.description}">
<div class="card mb-20"><div class="card-header"><h3>职位描述</h3></div><div class="card-body" style="white-space:pre-line;">${rec.description}</div></div>
</c:if>
<c:if test="${not empty rec.requirement}">
<div class="card mb-20"><div class="card-header"><h3>任职要求</h3></div><div class="card-body" style="white-space:pre-line;">${rec.requirement}</div></div>
</c:if>

<jsp:include page="/jsp/common/footer.jsp"/>
