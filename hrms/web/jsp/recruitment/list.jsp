<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="招聘管理"/>
    <jsp:param name="menu" value="recruitment"/>
</jsp:include>

<div class="page-header">
    <h2>招聘管理</h2>
    <a href="${ctx}/recruitment.do?method=add" class="btn btn-primary">发布招聘</a>
</div>

<div class="card">
    <div class="card-body">
        <form id="searchForm" method="get" action="${ctx}/recruitment.do">
            <input type="hidden" name="method" value="list">
            <div class="toolbar">
                <div class="search-box">
                    <input type="text" name="keyword" class="form-control" placeholder="搜索标题/职位" value="${keyword}">
                </div>
                <div class="filter-box">
                    <select name="status" class="form-control" onchange="this.form.submit()">
                        <option value="0">全部状态</option>
                        <option value="1" ${status == 1 ? 'selected' : ''}>招聘中</option>
                        <option value="2" ${status == 2 ? 'selected' : ''}>已暂停</option>
                        <option value="3" ${status == 3 ? 'selected' : ''}>已结束</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary btn-sm">搜索</button>
            </div>
        </form>
        <div class="table-wrapper">
            <table class="data-table">
                <thead>
                <tr><th>标题</th><th>部门</th><th>职位</th><th>人数</th><th>学历</th><th>薪资范围</th><th>截止日期</th><th>状态</th><th>操作</th></tr>
                </thead>
                <tbody>
                <c:forEach items="${page.list}" var="r">
                    <tr>
                        <td><strong>${r.title}</strong></td>
                        <td>${r.deptName}</td>
                        <td>${r.positionName}</td>
                        <td>${r.headCount}</td>
                        <td>${r.education}</td>
                        <td>${r.salaryRange}</td>
                        <td><fmt:formatDate value="${r.deadline}" pattern="yyyy-MM-dd"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${r.status==1}"><span class="badge badge-success">招聘中</span></c:when>
                                <c:when test="${r.status==2}"><span class="badge badge-warning">已暂停</span></c:when>
                                <c:when test="${r.status==3}"><span class="badge badge-secondary">已结束</span></c:when>
                            </c:choose>
                        </td>
                        <td class="actions">
                            <a href="${ctx}/recruitment.do?method=detail&id=${r.id}" class="btn btn-xs btn-outline">详情</a>
                            <a href="${ctx}/recruitment.do?method=edit&id=${r.id}" class="btn btn-xs btn-primary">编辑</a>
                            <a href="javascript:void(0)" onclick="confirmDelete('${ctx}/recruitment.do?method=delete&id=${r.id}')" class="btn btn-xs btn-danger">删除</a>
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
