<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="${empty rec ? '发布招聘' : '编辑招聘'}"/>
    <jsp:param name="menu" value="recruitment"/>
</jsp:include>

<div class="page-header">
    <h2>${empty rec ? '发布招聘' : '编辑招聘'}</h2>
    <a href="${ctx}/recruitment.do?method=list" class="btn btn-outline">返回列表</a>
</div>

<div class="card">
    <div class="card-body">
        <form action="${ctx}/recruitment.do?method=save" method="post">
            <c:if test="${not empty rec}"><input type="hidden" name="id" value="${rec.id}"></c:if>
            <div class="form-group">
                <label>招聘标题 <span class="required">*</span></label>
                <input type="text" name="title" class="form-control" value="${rec.title}" required>
            </div>
            <div class="form-row-3">
                <div class="form-group">
                    <label>招聘部门</label>
                    <select name="deptId" class="form-control">
                        <option value="">-- 请选择 --</option>
                        <c:forEach items="${deptList}" var="d">
                            <option value="${d.id}" ${rec.deptId == d.id ? 'selected' : ''}>${d.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>招聘职位</label>
                    <input type="text" name="positionName" class="form-control" value="${rec.positionName}">
                </div>
                <div class="form-group">
                    <label>招聘人数</label>
                    <input type="number" name="headCount" class="form-control" value="${empty rec ? 1 : rec.headCount}" min="1">
                </div>
            </div>
            <div class="form-row-3">
                <div class="form-group">
                    <label>学历要求</label>
                    <select name="education" class="form-control">
                        <option value="不限" ${rec.education == '不限' ? 'selected' : ''}>不限</option>
                        <option value="大专" ${rec.education == '大专' ? 'selected' : ''}>大专</option>
                        <option value="本科" ${rec.education == '本科' ? 'selected' : ''}>本科</option>
                        <option value="硕士" ${rec.education == '硕士' ? 'selected' : ''}>硕士</option>
                        <option value="博士" ${rec.education == '博士' ? 'selected' : ''}>博士</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>经验要求</label>
                    <input type="text" name="experience" class="form-control" value="${rec.experience}" placeholder="如：3-5年">
                </div>
                <div class="form-group">
                    <label>薪资范围</label>
                    <input type="text" name="salaryRange" class="form-control" value="${rec.salaryRange}" placeholder="如：10K-20K">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>截止日期</label>
                    <input type="date" name="deadline" class="form-control" value="<fmt:formatDate value='${rec.deadline}' pattern='yyyy-MM-dd'/>">
                </div>
                <div class="form-group">
                    <label>状态</label>
                    <select name="status" class="form-control">
                        <option value="1" ${rec.status == 1 ? 'selected' : ''}>招聘中</option>
                        <option value="2" ${rec.status == 2 ? 'selected' : ''}>已暂停</option>
                        <option value="3" ${rec.status == 3 ? 'selected' : ''}>已结束</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label>职位描述</label>
                <textarea name="description" class="form-control" rows="4">${rec.description}</textarea>
            </div>
            <div class="form-group">
                <label>任职要求</label>
                <textarea name="requirement" class="form-control" rows="4">${rec.requirement}</textarea>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">保 存</button>
                <a href="${ctx}/recruitment.do?method=list" class="btn btn-outline">取 消</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/jsp/common/footer.jsp"/>
