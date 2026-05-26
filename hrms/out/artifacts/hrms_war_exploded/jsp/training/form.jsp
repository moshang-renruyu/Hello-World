<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="${empty training ? '新增培训' : '编辑培训'}"/>
    <jsp:param name="menu" value="training"/>
</jsp:include>

<div class="page-header">
    <h2>${empty training ? '新增培训' : '编辑培训'}</h2>
    <a href="${ctx}/training.do?method=list" class="btn btn-outline">返回列表</a>
</div>

<div class="card">
    <div class="card-body">
        <form action="${ctx}/training.do?method=save" method="post">
            <c:if test="${not empty training}"><input type="hidden" name="id" value="${training.id}"></c:if>
            <div class="form-group">
                <label>培训标题 <span class="required">*</span></label>
                <input type="text" name="title" class="form-control" value="${training.title}" required>
            </div>
            <div class="form-row-3">
                <div class="form-group">
                    <label>培训类型</label>
                    <select name="type" class="form-control">
                        <option value="1" ${training.type == 1 ? 'selected' : ''}>内部培训</option>
                        <option value="2" ${training.type == 2 ? 'selected' : ''}>外部培训</option>
                        <option value="3" ${training.type == 3 ? 'selected' : ''}>在线培训</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>讲师</label>
                    <input type="text" name="trainer" class="form-control" value="${training.trainer}">
                </div>
                <div class="form-group">
                    <label>所属部门</label>
                    <select name="deptId" class="form-control">
                        <option value="0">全公司</option>
                        <c:forEach items="${deptList}" var="d">
                            <option value="${d.id}" ${training.deptId == d.id ? 'selected' : ''}>${d.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-row-3">
                <div class="form-group">
                    <label>开始日期</label>
                    <input type="date" name="startDate" class="form-control" value="<fmt:formatDate value='${training.startDate}' pattern='yyyy-MM-dd'/>">
                </div>
                <div class="form-group">
                    <label>结束日期</label>
                    <input type="date" name="endDate" class="form-control" value="<fmt:formatDate value='${training.endDate}' pattern='yyyy-MM-dd'/>">
                </div>
                <div class="form-group">
                    <label>最大人数</label>
                    <input type="number" name="maxCount" class="form-control" value="${empty training ? 30 : training.maxCount}" min="1">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>培训地点</label>
                    <input type="text" name="location" class="form-control" value="${training.location}">
                </div>
                <div class="form-group">
                    <label>状态</label>
                    <select name="status" class="form-control">
                        <option value="1" ${training.status == 1 ? 'selected' : ''}>计划中</option>
                        <option value="2" ${training.status == 2 ? 'selected' : ''}>进行中</option>
                        <option value="3" ${training.status == 3 ? 'selected' : ''}>已结束</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label>培训内容</label>
                <textarea name="content" class="form-control" rows="5">${training.content}</textarea>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">保 存</button>
                <a href="${ctx}/training.do?method=list" class="btn btn-outline">取 消</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/jsp/common/footer.jsp"/>
