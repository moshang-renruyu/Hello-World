<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="${empty sal ? '薪资录入' : '编辑薪资'}"/>
    <jsp:param name="menu" value="salary"/>
</jsp:include>

<div class="page-header">
    <h2>${empty sal ? '薪资录入' : '编辑薪资'}</h2>
    <a href="${ctx}/salary.do?method=list" class="btn btn-outline">返回列表</a>
</div>

<div class="card">
    <div class="card-body">
        <form action="${ctx}/salary.do?method=save" method="post" onsubmit="return validateSalary()">
            <c:if test="${not empty sal}"><input type="hidden" name="id" value="${sal.id}"></c:if>
            <div class="form-row-3">
                <div class="form-group">
                    <label>员工 <span class="required">*</span></label>
                    <select name="empId" id="empId" class="form-control" required ${not empty sal ? 'disabled' : ''}>
                        <option value="">-- 请选择员工 --</option>
                        <c:forEach items="${empList}" var="e">
                            <option value="${e.id}" ${sal.empId == e.id ? 'selected' : ''}>${e.empNo} - ${e.name}</option>
                        </c:forEach>
                    </select>
                    <c:if test="${not empty sal}"><input type="hidden" name="empId" value="${sal.empId}"></c:if>
                </div>
                <div class="form-group">
                    <label>月份 <span class="required">*</span></label>
                    <input type="month" id="month" name="month" class="form-control" value="${sal.month}" required>
                </div>
                <div class="form-group">
                    <label>发放状态</label>
                    <select name="status" class="form-control">
                        <option value="0" ${sal.status == 0 ? 'selected' : ''}>未发放</option>
                        <option value="1" ${sal.status == 1 ? 'selected' : ''}>已发放</option>
                    </select>
                </div>
            </div>
            <div style="border:1px solid var(--border);border-radius:var(--radius);padding:20px;margin-bottom:18px;">
                <h3 style="font-size:14px;margin-bottom:16px;color:var(--text-secondary);">收入项目</h3>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>基本工资</label>
                        <input type="number" id="baseSalary" name="baseSalary" class="form-control" value="${sal.baseSalary}" step="0.01" onchange="calcSalary()">
                    </div>
                    <div class="form-group">
                        <label>奖金</label>
                        <input type="number" id="bonus" name="bonus" class="form-control" value="${sal.bonus}" step="0.01" onchange="calcSalary()">
                    </div>
                    <div class="form-group">
                        <label>津贴</label>
                        <input type="number" id="allowance" name="allowance" class="form-control" value="${sal.allowance}" step="0.01" onchange="calcSalary()">
                    </div>
                </div>
                <div class="form-group">
                    <label>加班费</label>
                    <input type="number" id="overtimePay" name="overtimePay" class="form-control" value="${sal.overtimePay}" step="0.01" onchange="calcSalary()" style="width:33%;">
                </div>
            </div>
            <div style="border:1px solid var(--border);border-radius:var(--radius);padding:20px;margin-bottom:18px;">
                <h3 style="font-size:14px;margin-bottom:16px;color:var(--text-secondary);">扣除项目</h3>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>扣款</label>
                        <input type="number" id="deduction" name="deduction" class="form-control" value="${sal.deduction}" step="0.01" onchange="calcSalary()">
                    </div>
                    <div class="form-group">
                        <label>社保</label>
                        <input type="number" id="insurance" name="insurance" class="form-control" value="${sal.insurance}" step="0.01" onchange="calcSalary()">
                    </div>
                    <div class="form-group">
                        <label>个税</label>
                        <input type="number" id="tax" name="tax" class="form-control" value="${sal.tax}" step="0.01" onchange="calcSalary()">
                    </div>
                </div>
            </div>
            <div style="background:var(--primary-light);border-radius:var(--radius);padding:16px 20px;margin-bottom:18px;display:flex;align-items:center;justify-content:space-between;">
                <span style="font-size:15px;font-weight:600;">实发工资</span>
                <span id="actualDisplay" style="font-size:24px;font-weight:700;color:var(--primary);">${sal.actualSalary}</span>
                <input type="hidden" id="actualSalary" name="actualSalary" value="${sal.actualSalary}">
            </div>
            <div class="form-group">
                <label>备注</label>
                <input type="text" name="remark" class="form-control" value="${sal.remark}">
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">保 存</button>
                <a href="${ctx}/salary.do?method=list" class="btn btn-outline">取 消</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/jsp/common/footer.jsp"/>
