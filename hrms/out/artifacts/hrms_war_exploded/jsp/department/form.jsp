<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="${empty dept ? '新增部门' : '编辑部门'}"/>
    <jsp:param name="menu" value="department"/>
</jsp:include>

<div class="page-header">
    <h2>${empty dept ? '新增部门' : '编辑部门'}</h2>
    <a href="${ctx}/department.do?method=list" class="btn btn-outline">返回列表</a>
</div>

<div class="card">
    <div class="card-body">
        <form action="${ctx}/department.do?method=save" method="post">
            <c:if test="${not empty dept}"><input type="hidden" name="id" value="${dept.id}"></c:if>
            <div class="form-row">
                <div class="form-group">
                    <label>部门名称 <span class="required">*</span></label>
                    <input type="text" name="name" class="form-control" value="${dept.name}" required>
                </div>
                <div class="form-group">
                    <label>部门编码</label>
                    <input type="text" name="code" class="form-control" value="${dept.code}">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>负责人</label>
                    <input type="text" name="manager" class="form-control" value="${dept.manager}">
                </div>
                <div class="form-group">
                    <label>联系电话</label>
                    <input type="text" name="phone" class="form-control" value="${dept.phone}">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>上级部门</label>
                    <select name="parentId" class="form-control">
                        <option value="0">无（顶级部门）</option>
                        <c:forEach items="${parentList}" var="p">
                            <c:if test="${p.id != dept.id}">
                                <option value="${p.id}" ${dept.parentId == p.id ? 'selected' : ''}>${p.name}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>排序号</label>
                    <input type="number" name="sortOrder" class="form-control" value="${empty dept ? 0 : dept.sortOrder}">
                </div>
            </div>
            <div class="form-group">
                <label>状态</label>
                <select name="status" class="form-control" style="width:200px;">
                    <option value="1" ${dept.status == 1 ? 'selected' : ''}>正常</option>
                    <option value="0" ${dept.status == 0 && not empty dept ? 'selected' : ''}>停用</option>
                </select>
            </div>
            <div class="form-group">
                <label>部门描述</label>
                <textarea name="description" class="form-control" rows="3">${dept.description}</textarea>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">保 存</button>
                <a href="${ctx}/department.do?method=list" class="btn btn-outline">取 消</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/jsp/common/footer.jsp"/>
