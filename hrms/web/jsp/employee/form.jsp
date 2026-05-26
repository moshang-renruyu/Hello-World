<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="${empty emp ? '新增员工' : '编辑员工'}"/>
    <jsp:param name="menu" value="employee"/>
</jsp:include>

<div class="page-header">
    <h2>${empty emp ? '新增员工' : '编辑员工'}</h2>
    <a href="${ctx}/employee.do?method=list" class="btn btn-outline">返回列表</a >
</div>

<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>

<form id="empForm" action="${ctx}/employee.do?method=save" method="post" enctype="multipart/form-data" onsubmit="return validateEmployee()">
    <c:if test="${not empty emp}">
        <input type="hidden" name="id" value="${emp.id}">
    </c:if>
    <div class="card mb-20">
        <div class="card-header"><h3>基本信息</h3></div>
        <div class="card-body">
            <div class="form-row-3">
                <div class="form-group">
                    <label>工号 <span class="required">*</span></label>
                    <input type="text" id="empNo" name="empNo" class="form-control" value="${not empty emp ? emp.empNo : empNo}" ${not empty emp ? 'readonly' : ''}>
                </div>
                <div class="form-group">
                    <label>姓名 <span class="required">*</span></label>
                    <input type="text" id="name" name="name" class="form-control" value="${emp.name}">
                </div>
                <div class="form-group">
                    <label>性别</label>
                    <select name="gender" class="form-control">
                        <option value="1" ${emp.gender == 1 ? 'selected' : ''}>男</option>
                        <option value="2" ${emp.gender == 2 ? 'selected' : ''}>女</option>
                    </select>
                </div>
            </div>
            <div class="form-row-3">
                <div class="form-group">
                    <label>出生日期</label>
                    <input type="date" name="birthDate" class="form-control" value="<fmt:formatDate value='${emp.birthDate}' pattern='yyyy-MM-dd'/>">
                </div>
                <div class="form-group">
                    <label>身份证号</label>
                    <input type="text" id="idCard" name="idCard" class="form-control" value="${emp.idCard}" maxlength="18">
                </div>
                <div class="form-group">
                    <label>学历</label>
                    <select name="education" class="form-control">
                        <option value="">-- 请选择 --</option>
                        <option value="高中" ${emp.education == '高中' ? 'selected' : ''}>高中</option>
                        <option value="大专" ${emp.education == '大专' ? 'selected' : ''}>大专</option>
                        <option value="本科" ${emp.education == '本科' ? 'selected' : ''}>本科</option>
                        <option value="硕士" ${emp.education == '硕士' ? 'selected' : ''}>硕士</option>
                        <option value="博士" ${emp.education == '博士' ? 'selected' : ''}>博士</option>
                    </select>
                </div>
            </div>
            <div class="form-row-3">
                <div class="form-group">
                    <label>手机号</label>
                    <input type="text" id="phone" name="phone" class="form-control" value="${emp.phone}">
                </div>
                <div class="form-group">
                    <label>邮箱</label>
                    <input type="text" id="email" name="email" class="form-control" value="${emp.email}">
                </div>
                <div class="form-group">
                    <label>地址</label>
                    <input type="text" name="address" class="form-control" value="${emp.address}">
                </div>
            </div>
        </div>
    </div>

    <div class="card mb-20">
        <div class="card-header"><h3>岗位信息</h3></div>
        <div class="card-body">
            <div class="form-row-3">
                <div class="form-group">
                    <label>所属部门</label>
                    <select name="deptId" id="deptId" class="form-control" onchange="loadPositions(this.value)">
                        <option value="">-- 请选择部门 --</option>
                        <c:forEach items="${deptList}" var="d">
                            <option value="${d.id}" ${emp.deptId == d.id ? 'selected' : ''}>${d.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>职位</label>
                    <select name="positionId" id="positionId" class="form-control">
                        <option value="">-- 请选择职位 --</option>
                        <c:forEach items="${positionList}" var="p">
                            <option value="${p.id}" ${emp.positionId == p.id ? 'selected' : ''}>${p.name}（${p.deptName}）</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>状态</label>
                    <select name="status" class="form-control">
                        <option value="1" ${emp.status == 1 ? 'selected' : ''}>在职</option>
                        <option value="3" ${emp.status == 3 ? 'selected' : ''}>试用期</option>
                        <option value="2" ${emp.status == 2 ? 'selected' : ''}>离职</option>
                    </select>
                </div>
            </div>
            <div class="form-row-3">
                <div class="form-group">
                    <label>入职日期</label>
                    <input type="date" name="hireDate" class="form-control" value="<fmt:formatDate value='${emp.hireDate}' pattern='yyyy-MM-dd'/>">
                </div>
                <div class="form-group">
                    <label>合同开始</label>
                    <input type="date" name="contractStart" class="form-control" value="<fmt:formatDate value='${emp.contractStart}' pattern='yyyy-MM-dd'/>">
                </div>
                <div class="form-group">
                    <label>合同结束</label>
                    <input type="date" name="contractEnd" class="form-control" value="<fmt:formatDate value='${emp.contractEnd}' pattern='yyyy-MM-dd'/>">
                </div>
            </div>
        </div>
    </div>

    <div class="card mb-20">
        <div class="card-header"><h3>教育与紧急联系人</h3></div>
        <div class="card-body">
            <div class="form-row-3">
                <div class="form-group">
                    <label>毕业院校</label>
                    <input type="text" name="university" class="form-control" value="${emp.university}">
                </div>
                <div class="form-group">
                    <label>专业</label>
                    <input type="text" name="major" class="form-control" value="${emp.major}">
                </div>
                <div class="form-group">
                    <label>备注</label>
                    <input type="text" name="remark" class="form-control" value="${emp.remark}">
                </div>
            </div>
            <div class="form-row-3">
                <div class="form-group">
                    <label>紧急联系人</label>
                    <input type="text" name="emergencyContact" class="form-control" value="${emp.emergencyContact}">
                </div>
                <div class="form-group">
                    <label>紧急联系电话</label>
                    <input type="text" name="emergencyPhone" class="form-control" value="${emp.emergencyPhone}">
                </div>
                <div class="form-group">
                    <label>员工照片</label>
                    <c:if test="${not empty emp and not empty emp.photo}">
                        <div style="margin-bottom:8px;">
                            < img src="${ctx}/upload/${emp.photo}" style="max-width:100px;border-radius:6px;border:1px solid var(--border);">
                        </div>
                    </c:if>
                    <input type="file" name="photo" class="form-control" accept="image/*">
                    <span class="text-secondary" style="font-size:12px;">支持 jpg/png/gif，不选则保留原照片</span>
                </div>
            </div>
            <div class="form-group">
                <label>爱好</label>
                <div class="checkbox-group">
                    <label class="checkbox-item"><input type="checkbox" name="hobbies" value="读书" ${fn:contains(emp.hobbies, '读书') ? 'checked' : ''}> 读书</label>
                    <label class="checkbox-item"><input type="checkbox" name="hobbies" value="运动" ${fn:contains(emp.hobbies, '运动') ? 'checked' : ''}> 运动</label>
                    <label class="checkbox-item"><input type="checkbox" name="hobbies" value="音乐" ${fn:contains(emp.hobbies, '音乐') ? 'checked' : ''}> 音乐</label>
                    <label class="checkbox-item"><input type="checkbox" name="hobbies" value="旅行" ${fn:contains(emp.hobbies, '旅行') ? 'checked' : ''}> 旅行</label>
                    <label class="checkbox-item"><input type="checkbox" name="hobbies" value="摄影" ${fn:contains(emp.hobbies, '摄影') ? 'checked' : ''}> 摄影</label>
                    <label class="checkbox-item"><input type="checkbox" name="hobbies" value="美食" ${fn:contains(emp.hobbies, '美食') ? 'checked' : ''}> 美食</label>
                </div>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">保 存</button>
                <a href="${ctx}/employee.do?method=list" class="btn btn-outline">取 消</a >
            </div>
        </div>
    </div>
</form>

<jsp:include page="/jsp/common/footer.jsp"/>