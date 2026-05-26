<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="${empty pos ? '新增职位' : '编辑职位'}"/>
    <jsp:param name="menu" value="position"/>
</jsp:include>

<div class="page-header">
    <h2>${empty pos ? '新增职位' : '编辑职位'}</h2>
    <a href="${ctx}/position.do?method=list" class="btn btn-outline">返回列表</a>
</div>

<div class="card">
    <div class="card-body">
        <form action="${ctx}/position.do?method=save" method="post">
            <c:if test="${not empty pos}"><input type="hidden" name="id" value="${pos.id}"></c:if>
            <div class="form-row">
                <div class="form-group">
                    <label>职位名称 <span class="required">*</span></label>
                    <input type="text" name="name" class="form-control" value="${pos.name}" required>
                </div>
                <div class="form-group">
                    <label>职位编码</label>
                    <input type="text" name="code" class="form-control" value="${pos.code}">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>所属部门</label>
                    <select name="deptId" class="form-control">
                        <option value="">-- 请选择 --</option>
                        <c:forEach items="${deptList}" var="d">
                            <option value="${d.id}" ${pos.deptId == d.id ? 'selected' : ''}>${d.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>职位级别</label>
                    <select name="level" class="form-control">
                        <option value="1" ${pos.level == 1 ? 'selected' : ''}>初级</option>
                        <option value="2" ${pos.level == 2 ? 'selected' : ''}>中级</option>
                        <option value="3" ${pos.level == 3 ? 'selected' : ''}>高级</option>
                        <option value="4" ${pos.level == 4 ? 'selected' : ''}>专家</option>
                    </select>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>最低薪资</label>
                    <input type="number" name="salaryMin" class="form-control" value="${pos.salaryMin}" step="100">
                </div>
                <div class="form-group">
                    <label>最高薪资</label>
                    <input type="number" name="salaryMax" class="form-control" value="${pos.salaryMax}" step="100">
                </div>
            </div>
            <div class="form-group">
                <label>状态</label>
                <select name="status" class="form-control" style="width:200px;">
                    <option value="1" ${pos.status == 1 ? 'selected' : ''}>正常</option>
                    <option value="0" ${pos.status == 0 && not empty pos ? 'selected' : ''}>停用</option>
                </select>
            </div>
            <div class="form-group">
                <label>职位描述</label>
                <textarea name="description" class="form-control" rows="3">${pos.description}</textarea>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">保 存</button>
                <a href="${ctx}/position.do?method=list" class="btn btn-outline">取 消</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/jsp/common/footer.jsp"/>
