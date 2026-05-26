<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="${empty att ? '考勤登记' : '编辑考勤'}"/>
    <jsp:param name="menu" value="attendance"/>
</jsp:include>

<div class="page-header">
    <h2>${empty att ? '考勤登记' : '编辑考勤'}</h2>
    <a href="${ctx}/attendance.do?method=list" class="btn btn-outline">返回列表</a>
</div>

<div class="card">
    <div class="card-body">
        <form action="${ctx}/attendance.do?method=save" method="post">
            <c:if test="${not empty att}"><input type="hidden" name="id" value="${att.id}"></c:if>
            <div class="form-row">
                <div class="form-group">
                    <label>员工 <span class="required">*</span></label>
                    <select name="empId" class="form-control" required ${not empty att ? 'disabled' : ''}>
                        <option value="">-- 请选择员工 --</option>
                        <c:forEach items="${empList}" var="e">
                            <option value="${e.id}" ${att.empId == e.id ? 'selected' : ''}>${e.empNo} - ${e.name}</option>
                        </c:forEach>
                    </select>
                    <c:if test="${not empty att}"><input type="hidden" name="empId" value="${att.empId}"></c:if>
                </div>
                <div class="form-group">
                    <label>日期 <span class="required">*</span></label>
                    <input type="date" name="workDate" class="form-control" value="<fmt:formatDate value='${att.workDate}' pattern='yyyy-MM-dd'/>" required>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>签到时间</label>
                    <input type="time" name="checkIn" class="form-control" value="${att.checkIn}">
                </div>
                <div class="form-group">
                    <label>签退时间</label>
                    <input type="time" name="checkOut" class="form-control" value="${att.checkOut}">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>状态</label>
                    <select name="status" class="form-control">
                        <option value="1" ${att.status == 1 ? 'selected' : ''}>正常</option>
                        <option value="2" ${att.status == 2 ? 'selected' : ''}>迟到</option>
                        <option value="3" ${att.status == 3 ? 'selected' : ''}>早退</option>
                        <option value="4" ${att.status == 4 ? 'selected' : ''}>缺勤</option>
                        <option value="5" ${att.status == 5 ? 'selected' : ''}>请假</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>备注</label>
                    <input type="text" name="remark" class="form-control" value="${att.remark}">
                </div>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">保 存</button>
                <a href="${ctx}/attendance.do?method=list" class="btn btn-outline">取 消</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/jsp/common/footer.jsp"/>
