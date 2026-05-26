<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="操作日志"/>
    <jsp:param name="menu" value="log"/>
</jsp:include>

<div class="page-header">
    <h2>操作日志</h2>
    <a href="javascript:void(0)" onclick="confirmAction('确认清空所有日志？','${ctx}/system.do?method=clearLog')" class="btn btn-danger btn-sm">清空日志</a>
</div>

<div class="card">
    <div class="card-body">
        <form id="searchForm" method="get" action="${ctx}/system.do">
            <input type="hidden" name="method" value="log">
            <div class="toolbar">
                <div class="search-box">
                    <input type="text" name="keyword" class="form-control" placeholder="搜索用户名/操作" value="${keyword}">
                </div>
                <div class="filter-box">
                    <select name="module" class="form-control" onchange="this.form.submit()">
                        <option value="">全部模块</option>
                        <option value="系统" ${'系统' == module ? 'selected' : ''}>系统</option>
                        <option value="员工" ${'员工' == module ? 'selected' : ''}>员工</option>
                        <option value="部门" ${'部门' == module ? 'selected' : ''}>部门</option>
                        <option value="考勤" ${'考勤' == module ? 'selected' : ''}>考勤</option>
                        <option value="薪资" ${'薪资' == module ? 'selected' : ''}>薪资</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary btn-sm">搜索</button>
            </div>
        </form>
        <div class="table-wrapper">
            <table class="data-table">
                <thead>
                <tr><th>ID</th><th>用户名</th><th>操作</th><th>模块</th><th>IP地址</th><th>操作时间</th></tr>
                </thead>
                <tbody>
                <c:forEach items="${page.list}" var="l">
                    <tr>
                        <td>${l.id}</td>
                        <td><strong>${l.username}</strong></td>
                        <td>${l.operation}</td>
                        <td><span class="badge badge-secondary">${l.module}</span></td>
                        <td class="text-secondary">${l.ip}</td>
                        <td><fmt:formatDate value="${l.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty page.list}"><tr><td colspan="6" class="text-center text-light" style="padding:32px;">暂无数据</td></tr></c:if>
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
