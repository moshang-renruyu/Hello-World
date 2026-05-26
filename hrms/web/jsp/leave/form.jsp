<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="请假申请"/>
    <jsp:param name="menu" value="leave"/>
</jsp:include>

<div class="page-header">
    <h2>请假申请</h2>
    <a href="${ctx}/leave.do?method=list" class="btn btn-outline">返回列表</a>
</div>

<div class="card">
    <div class="card-body">
        <form action="${ctx}/leave.do?method=save" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label>员工 <span class="required">*</span></label>
                    <select name="empId" class="form-control" required>
                        <option value="">-- 请选择员工 --</option>
                        <c:forEach items="${empList}" var="e">
                            <option value="${e.id}">${e.empNo} - ${e.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>请假类型 <span class="required">*</span></label>
                    <select name="type" class="form-control" required>
                        <option value="1">事假</option>
                        <option value="2">病假</option>
                        <option value="3">年假</option>
                        <option value="4">婚假</option>
                        <option value="5">产假</option>
                        <option value="6">丧假</option>
                    </select>
                </div>
            </div>
            <div class="form-row-3">
                <div class="form-group">
                    <label>开始日期 <span class="required">*</span></label>
                    <input type="date" name="startDate" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>结束日期 <span class="required">*</span></label>
                    <input type="date" name="endDate" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>请假天数</label>
                    <input type="number" name="days" class="form-control" step="0.5" min="0.5">
                </div>
            </div>
            <div class="form-group">
                <label>请假事由 <span class="required">*</span></label>
                <textarea name="reason" class="form-control" rows="4" required placeholder="请详细说明请假原因"></textarea>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">提交申请</button>
                <a href="${ctx}/leave.do?method=list" class="btn btn-outline">取 消</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/jsp/common/footer.jsp"/>
