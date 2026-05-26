<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="薪资详情"/>
    <jsp:param name="menu" value="salary"/>
</jsp:include>

<div class="page-header">
    <h2>薪资详情</h2>
    <a href="${ctx}/salary.do?method=list" class="btn btn-outline">返回列表</a>
</div>

<div class="card mb-20">
    <div class="card-header"><h3>基本信息</h3></div>
    <div class="card-body">
        <div class="detail-grid">
            <div class="detail-item"><span class="detail-label">工号</span><span class="detail-value">${sal.empNo}</span></div>
            <div class="detail-item"><span class="detail-label">姓名</span><span class="detail-value">${sal.empName}</span></div>
            <div class="detail-item"><span class="detail-label">部门</span><span class="detail-value">${sal.deptName}</span></div>
            <div class="detail-item"><span class="detail-label">月份</span><span class="detail-value">${sal.month}</span></div>
            <div class="detail-item"><span class="detail-label">状态</span><span class="detail-value"><c:choose><c:when test="${sal.status==1}"><span class="badge badge-success">已发放</span></c:when><c:otherwise><span class="badge badge-warning">未发放</span></c:otherwise></c:choose></span></div>
        </div>
    </div>
</div>
<div style="display:grid;grid-template-columns:1fr 1fr;gap:20px;" class="mb-20">
    <div class="card">
        <div class="card-header"><h3>收入项目</h3></div>
        <div class="card-body">
            <div class="detail-item"><span class="detail-label">基本工资</span><span class="detail-value"><fmt:formatNumber value="${sal.baseSalary}" pattern="#,##0.00"/></span></div>
            <div class="detail-item"><span class="detail-label">奖金</span><span class="detail-value"><fmt:formatNumber value="${sal.bonus}" pattern="#,##0.00"/></span></div>
            <div class="detail-item"><span class="detail-label">津贴</span><span class="detail-value"><fmt:formatNumber value="${sal.allowance}" pattern="#,##0.00"/></span></div>
            <div class="detail-item"><span class="detail-label">加班费</span><span class="detail-value"><fmt:formatNumber value="${sal.overtimePay}" pattern="#,##0.00"/></span></div>
        </div>
    </div>
    <div class="card">
        <div class="card-header"><h3>扣除项目</h3></div>
        <div class="card-body">
            <div class="detail-item"><span class="detail-label">扣款</span><span class="detail-value text-danger"><fmt:formatNumber value="${sal.deduction}" pattern="#,##0.00"/></span></div>
            <div class="detail-item"><span class="detail-label">社保</span><span class="detail-value text-danger"><fmt:formatNumber value="${sal.insurance}" pattern="#,##0.00"/></span></div>
            <div class="detail-item"><span class="detail-label">个税</span><span class="detail-value text-danger"><fmt:formatNumber value="${sal.tax}" pattern="#,##0.00"/></span></div>
        </div>
    </div>
</div>
<div class="card mb-20">
    <div class="card-body" style="background:var(--primary-light);display:flex;align-items:center;justify-content:space-between;border-radius:var(--radius);">
        <span style="font-size:16px;font-weight:600;">实发工资</span>
        <span style="font-size:28px;font-weight:700;color:var(--primary);"><fmt:formatNumber value="${sal.actualSalary}" pattern="#,##0.00"/> 元</span>
    </div>
</div>
<c:if test="${not empty sal.remark}">
<div class="card"><div class="card-header"><h3>备注</h3></div><div class="card-body">${sal.remark}</div></div>
</c:if>

<jsp:include page="/jsp/common/footer.jsp"/>
