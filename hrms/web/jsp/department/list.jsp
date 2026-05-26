<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="部门管理"/>
    <jsp:param name="menu" value="department"/>
</jsp:include>

<div class="page-header">
    <h2>部门管理</h2>
    <a href="${ctx}/department.do?method=add" class="btn btn-primary">新增部门</a>
</div>

<div class="card">
    <div class="card-body">
        <form id="searchForm" method="get" action="${ctx}/department.do">
            <input type="hidden" name="method" value="list">
            <div class="toolbar">
                <div class="search-box">
                    <input type="text" name="keyword" class="form-control" placeholder="搜索部门名称/编码" value="${keyword}">
                    <button type="submit" class="btn btn-primary btn-sm">搜索</button>
                </div>
            </div>
        </form>
        <div class="table-wrapper">
            <table class="data-table">
                <thead>
                <tr><th>编码</th><th>部门名称</th><th>负责人</th><th>联系电话</th><th>员工数</th><th>排序</th><th>状态</th><th>创建时间</th><th>操作</th></tr>
                </thead>
                <tbody>
                <c:forEach items="${page.list}" var="d">
                    <tr>
                        <td><strong>${d.code}</strong></td>
                        <td>${d.name}</td>
                        <td>${d.manager}</td>
                        <td>${d.phone}</td>
                        <td>${d.empCount}</td>
                        <td>${d.sortOrder}</td>
                        <td><c:choose><c:when test="${d.status == 1}"><span class="badge badge-success">正常</span></c:when><c:otherwise><span class="badge badge-danger">停用</span></c:otherwise></c:choose></td>
                        <td><fmt:formatDate value="${d.createTime}" pattern="yyyy-MM-dd"/></td>
                        <td class="actions">
                            <a href="${ctx}/department.do?method=edit&id=${d.id}" class="btn btn-xs btn-primary">编辑</a>
                            <a href="javascript:void(0)" onclick="confirmDelete('${ctx}/department.do?method=delete&id=${d.id}')" class="btn btn-xs btn-danger">删除</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty page.list}"><tr><td colspan="9" class="text-center text-light" style="padding:32px;">暂无数据</td></tr></c:if>
                </tbody>
            </table>
        </div>
        <c:if test="${page.totalPage > 0}">
        <div class="pagination">
            <div class="page-info">共 ${page.totalCount} 条，第 ${page.pageNum}/${page.totalPage} 页</div>
            <div class="page-links">
                <c:if test="${page.hasPrev()}"><a href="javascript:goToPage(${page.prevPage})">上一页</a></c:if>
                <c:if test="${!page.hasPrev()}"><span class="disabled">上一页</span></c:if>
                <c:forEach begin="1" end="${page.totalPage}" var="i">
                    <c:choose><c:when test="${i == page.pageNum}"><span class="current">${i}</span></c:when><c:otherwise><a href="javascript:goToPage(${i})">${i}</a></c:otherwise></c:choose>
                </c:forEach>
                <c:if test="${page.hasNext()}"><a href="javascript:goToPage(${page.nextPage})">下一页</a></c:if>
                <c:if test="${!page.hasNext()}"><span class="disabled">下一页</span></c:if>
            </div>
        </div>
        </c:if>
    </div>
</div>

<jsp:include page="/jsp/common/footer.jsp"/>
