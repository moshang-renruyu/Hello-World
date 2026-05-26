<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="职位管理"/>
    <jsp:param name="menu" value="position"/>
</jsp:include>

<div class="page-header">
    <h2>职位管理</h2>
    <a href="${ctx}/position.do?method=add" class="btn btn-primary">新增职位</a>
</div>

<div class="card">
    <div class="card-body">
        <form id="searchForm" method="get" action="${ctx}/position.do">
            <input type="hidden" name="method" value="list">
            <div class="toolbar">
                <div class="search-box">
                    <input type="text" name="keyword" class="form-control" placeholder="搜索职位名称/编码" value="${keyword}">
                </div>
                <div class="filter-box">
                    <select name="deptId" class="form-control" onchange="this.form.submit()">
                        <option value="0">全部部门</option>
                        <c:forEach items="${deptList}" var="d">
                            <option value="${d.id}" ${deptId == d.id ? 'selected' : ''}>${d.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary btn-sm">搜索</button>
            </div>
        </form>
        <div class="table-wrapper">
            <table class="data-table">
                <thead>
                <tr><th>编码</th><th>职位名称</th><th>所属部门</th><th>级别</th><th>薪资范围</th><th>状态</th><th>操作</th></tr>
                </thead>
                <tbody>
                <c:forEach items="${page.list}" var="p">
                    <tr>
                        <td><strong>${p.code}</strong></td>
                        <td>${p.name}</td>
                        <td>${p.deptName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${p.level == 1}"><span class="badge badge-secondary">初级</span></c:when>
                                <c:when test="${p.level == 2}"><span class="badge badge-info">中级</span></c:when>
                                <c:when test="${p.level == 3}"><span class="badge badge-primary">高级</span></c:when>
                                <c:when test="${p.level == 4}"><span class="badge badge-warning">专家</span></c:when>
                            </c:choose>
                        </td>
                        <td><fmt:formatNumber value="${p.salaryMin}" pattern="#,##0"/> - <fmt:formatNumber value="${p.salaryMax}" pattern="#,##0"/></td>
                        <td><c:choose><c:when test="${p.status == 1}"><span class="badge badge-success">正常</span></c:when><c:otherwise><span class="badge badge-danger">停用</span></c:otherwise></c:choose></td>
                        <td class="actions">
                            <a href="${ctx}/position.do?method=edit&id=${p.id}" class="btn btn-xs btn-primary">编辑</a>
                            <a href="javascript:void(0)" onclick="confirmDelete('${ctx}/position.do?method=delete&id=${p.id}')" class="btn btn-xs btn-danger">删除</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty page.list}"><tr><td colspan="7" class="text-center text-light" style="padding:32px;">暂无数据</td></tr></c:if>
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
