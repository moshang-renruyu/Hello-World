<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="考勤管理"/>
    <jsp:param name="menu" value="attendance"/>
</jsp:include>

<div class="page-header">
    <h2>考勤管理</h2>
    <a href="${ctx}/attendance.do?method=add" class="btn btn-primary">考勤登记</a>
</div>

<div class="card">
    <div class="card-body">
        <form id="searchForm" method="get" action="${ctx}/attendance.do">
            <input type="hidden" name="method" value="list">
            <div class="toolbar">
                <div class="search-box">
                    <input type="text" name="keyword" class="form-control" placeholder="搜索姓名/工号" value="${keyword}">
                </div>
                <div class="filter-box">
                    <input type="date" name="workDate" class="form-control" value="${workDate}" style="width:160px;">
                </div>
                <button type="submit" class="btn btn-primary btn-sm">搜索</button>
            </div>
        </form>
        <div class="table-wrapper">
            <table class="data-table">
                <thead>
                <tr><th>工号</th><th>姓名</th><th>部门</th><th>日期</th><th>签到</th><th>签退</th><th>状态</th><th>备注</th><th>操作</th></tr>
                </thead>
                <tbody>
                <c:forEach items="${page.list}" var="a">
                    <tr>
                        <td><strong>${a.empNo}</strong></td>
                        <td>${a.empName}</td>
                        <td>${a.deptName}</td>
                        <td><fmt:formatDate value="${a.workDate}" pattern="yyyy-MM-dd"/></td>
                        <td>${a.checkIn}</td>
                        <td>${a.checkOut}</td>
                        <td>
                            <c:choose>
                                <c:when test="${a.status == 1}"><span class="badge badge-success">正常</span></c:when>
                                <c:when test="${a.status == 2}"><span class="badge badge-warning">迟到</span></c:when>
                                <c:when test="${a.status == 3}"><span class="badge badge-warning">早退</span></c:when>
                                <c:when test="${a.status == 4}"><span class="badge badge-danger">缺勤</span></c:when>
                                <c:when test="${a.status == 5}"><span class="badge badge-info">请假</span></c:when>
                            </c:choose>
                        </td>
                        <td class="text-secondary">${a.remark}</td>
                        <td class="actions">
                            <a href="${ctx}/attendance.do?method=edit&id=${a.id}" class="btn btn-xs btn-primary">编辑</a>
                            <a href="javascript:void(0)" onclick="confirmDelete('${ctx}/attendance.do?method=delete&id=${a.id}')" class="btn btn-xs btn-danger">删除</a>
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
