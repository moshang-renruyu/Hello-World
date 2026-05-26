<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="员工管理"/>
    <jsp:param name="menu" value="employee"/>
</jsp:include>

<div class="page-header">
    <h2>员工管理</h2>
    <a href="${ctx}/employee.do?method=add" class="btn btn-primary">新增员工</a>
</div>

<div class="card">
    <div class="card-body">
        <form id="searchForm" method="get" action="${ctx}/employee.do">
            <input type="hidden" name="method" value="list">
            <div class="toolbar">
                <div class="search-box">
                    <input type="text" name="keyword" class="form-control" placeholder="搜索姓名/工号/手机" value="${keyword}">
                </div>
                <div class="filter-box">
                    <select name="deptId" class="form-control" onchange="this.form.submit()">
                        <option value="0">全部部门</option>
                        <c:forEach items="${deptList}" var="d">
                            <option value="${d.id}" ${deptId == d.id ? 'selected' : ''}>${d.name}</option>
                        </c:forEach>
                    </select>
                    <select name="status" class="form-control" onchange="this.form.submit()">
                        <option value="0">全部状态</option>
                        <option value="1" ${status == 1 ? 'selected' : ''}>在职</option>
                        <option value="2" ${status == 2 ? 'selected' : ''}>离职</option>
                        <option value="3" ${status == 3 ? 'selected' : ''}>试用期</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary btn-sm">搜索</button>
            </div>
        </form>
        <div class="table-wrapper">
            <table class="data-table">
                <thead>
                <tr>
                    <th>工号</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>部门</th>
                    <th>职位</th>
                    <th>手机</th>
                    <th>入职日期</th>
                    <th>学历</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${page.list}" var="e">
                    <tr>
                        <td><strong>${e.empNo}</strong></td>
                        <td>${e.name}</td>
                        <td>${e.gender == 1 ? '男' : '女'}</td>
                        <td>${e.deptName}</td>
                        <td>${e.positionName}</td>
                        <td>${e.phone}</td>
                        <td><fmt:formatDate value="${e.hireDate}" pattern="yyyy-MM-dd"/></td>
                        <td>${e.education}</td>
                        <td>
                            <c:choose>
                                <c:when test="${e.status == 1}"><span class="badge badge-success">在职</span></c:when>
                                <c:when test="${e.status == 2}"><span class="badge badge-danger">离职</span></c:when>
                                <c:when test="${e.status == 3}"><span class="badge badge-warning">试用期</span></c:when>
                            </c:choose>
                        </td>
                        <td class="actions">
                            <a href="${ctx}/employee.do?method=detail&id=${e.id}" class="btn btn-xs btn-outline">详情</a>
                            <a href="${ctx}/employee.do?method=edit&id=${e.id}" class="btn btn-xs btn-primary">编辑</a>
                            <a href="javascript:void(0)" onclick="confirmDelete('${ctx}/employee.do?method=delete&id=${e.id}')" class="btn btn-xs btn-danger">删除</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty page.list}">
                    <tr><td colspan="10" class="text-center text-light" style="padding:32px;">暂无数据</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <c:if test="${page.totalPage > 0}">
        <div class="pagination">
            <div class="page-info">共 ${page.totalCount} 条记录，第 ${page.pageNum}/${page.totalPage} 页</div>
            <div class="page-links">
                <c:if test="${page.hasPrev()}"><a href="javascript:goToPage(${page.prevPage})">上一页</a></c:if>
                <c:if test="${!page.hasPrev()}"><span class="disabled">上一页</span></c:if>
                <c:forEach begin="1" end="${page.totalPage}" var="i">
                    <c:choose>
                        <c:when test="${i == page.pageNum}"><span class="current">${i}</span></c:when>
                        <c:otherwise><a href="javascript:goToPage(${i})">${i}</a></c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${page.hasNext()}"><a href="javascript:goToPage(${page.nextPage})">下一页</a></c:if>
                <c:if test="${!page.hasNext()}"><span class="disabled">下一页</span></c:if>
            </div>
        </div>
        </c:if>
    </div>
</div>

<jsp:include page="/jsp/common/footer.jsp"/>
