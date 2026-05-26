<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="员工详情"/>
    <jsp:param name="menu" value="employee"/>
</jsp:include>

<div class="page-header">
    <h2>员工详情</h2>
    <div>
        <a href="${ctx}/employee.do?method=edit&id=${emp.id}" class="btn btn-primary btn-sm">编辑</a>
        <a href="${ctx}/employee.do?method=list" class="btn btn-outline btn-sm">返回列表</a>
    </div>
</div>

<div class="card mb-20">
    <div class="card-header"><h3>基本信息</h3></div>
    <div class="card-body">
        <div class="detail-grid">
            <div class="detail-item"><span class="detail-label">工号</span><span class="detail-value"><strong>${emp.empNo}</strong></span></div>
            <div class="detail-item"><span class="detail-label">姓名</span><span class="detail-value">${emp.name}</span></div>
            <div class="detail-item"><span class="detail-label">性别</span><span class="detail-value">${emp.gender == 1 ? '男' : '女'}</span></div>
            <div class="detail-item"><span class="detail-label">出生日期</span><span class="detail-value"><fmt:formatDate value="${emp.birthDate}" pattern="yyyy-MM-dd"/></span></div>
            <div class="detail-item"><span class="detail-label">身份证号</span><span class="detail-value">${emp.idCard}</span></div>
            <div class="detail-item"><span class="detail-label">手机号</span><span class="detail-value">${emp.phone}</span></div>
            <div class="detail-item"><span class="detail-label">邮箱</span><span class="detail-value">${emp.email}</span></div>
            <div class="detail-item"><span class="detail-label">地址</span><span class="detail-value">${emp.address}</span></div>
        </div>
    </div>
</div>

<div class="card mb-20">
    <div class="card-header"><h3>岗位信息</h3></div>
    <div class="card-body">
        <div class="detail-grid">
            <div class="detail-item"><span class="detail-label">部门</span><span class="detail-value">${emp.deptName}</span></div>
            <div class="detail-item"><span class="detail-label">职位</span><span class="detail-value">${emp.positionName}</span></div>
            <div class="detail-item"><span class="detail-label">入职日期</span><span class="detail-value"><fmt:formatDate value="${emp.hireDate}" pattern="yyyy-MM-dd"/></span></div>
            <div class="detail-item">
                <span class="detail-label">状态</span>
                <span class="detail-value">
                    <c:choose>
                        <c:when test="${emp.status == 1}"><span class="badge badge-success">在职</span></c:when>
                        <c:when test="${emp.status == 2}"><span class="badge badge-danger">离职</span></c:when>
                        <c:when test="${emp.status == 3}"><span class="badge badge-warning">试用期</span></c:when>
                    </c:choose>
                </span>
            </div>
            <div class="detail-item"><span class="detail-label">合同开始</span><span class="detail-value"><fmt:formatDate value="${emp.contractStart}" pattern="yyyy-MM-dd"/></span></div>
            <div class="detail-item"><span class="detail-label">合同结束</span><span class="detail-value"><fmt:formatDate value="${emp.contractEnd}" pattern="yyyy-MM-dd"/></span></div>
        </div>
    </div>
</div>

<div class="card mb-20">
    <div class="card-header"><h3>教育背景与其他</h3></div>
    <div class="card-body">
        <div class="detail-grid">
            <div class="detail-item"><span class="detail-label">学历</span><span class="detail-value">${emp.education}</span></div>
            <div class="detail-item"><span class="detail-label">毕业院校</span><span class="detail-value">${emp.university}</span></div>
            <div class="detail-item"><span class="detail-label">专业</span><span class="detail-value">${emp.major}</span></div>
            <div class="detail-item"><span class="detail-label">紧急联系人</span><span class="detail-value">${emp.emergencyContact}</span></div>
            <div class="detail-item"><span class="detail-label">紧急电话</span><span class="detail-value">${emp.emergencyPhone}</span></div>
            <div class="detail-item"><span class="detail-label">备注</span><span class="detail-value">${emp.remark}</span></div>
            <div class="detail-item"><span class="detail-label">爱好</span><span class="detail-value">${emp.hobbies}</span></div>
        </div>
    </div>
</div>

<c:if test="${not empty emp.photo}">
<div class="card mb-20">
    <div class="card-header"><h3>员工照片</h3></div>
    <div class="card-body">
        <img src="${ctx}/upload/${emp.photo}" style="max-width:200px;border-radius:8px;">
        <div class="mt-10">
            <a href="${ctx}/file.do?method=download&fileName=${emp.photo}&displayName=${emp.name}_photo" class="btn btn-outline btn-sm">下载照片</a>
        </div>
    </div>
</div>
</c:if>

<jsp:include page="/jsp/common/footer.jsp"/>
