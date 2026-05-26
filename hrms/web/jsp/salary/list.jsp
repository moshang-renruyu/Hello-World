<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="薪资管理"/>
    <jsp:param name="menu" value="salary"/>
</jsp:include>

<div class="page-header">
    <h2>薪资管理</h2>
    <a href="${ctx}/salary.do?method=add" class="btn btn-primary">薪资录入</a>
</div>

<div class="card">
    <div class="card-body">
        <form id="searchForm" method="get" action="${ctx}/salary.do">
            <input type="hidden" name="method" value="list">
            <div class="toolbar">
                <div class="search-box">
                    <input type="text" name="keyword" class="form-control" placeholder="搜索姓名/工号" value="${keyword}">
                </div>
                <div class="filter-box">
                    <input type="month" name="month" class="form-control" value="${month}" style="width:160px;">
                </div>
                <button type="submit" class="btn btn-primary btn-sm">搜索</button>
            </div>
        </form>
        <div class="table-wrapper">
            <table class="data-table">
                <thead>
                <tr><th>工号</th><th>姓名</th><th>部门</th><th>月份</th><th>基本工资</th><th>奖金</th><th>扣除合计</th><th>实发工资</th><th>状态</th><th>操作</th></tr>
                </thead>
                <tbody>
                <c:forEach items="${page.list}" var="s">
                    <tr>
                        <td><strong>${s.empNo}</strong></td>
                        <td>${s.empName}</td>
                        <td>${s.deptName}</td>
                        <td>${s.month}</td>
                        <td><fmt:formatNumber value="${s.baseSalary}" pattern="#,##0.00"/></td>
                        <td><fmt:formatNumber value="${s.bonus}" pattern="#,##0.00"/></td>
                        <td class="text-danger"><fmt:formatNumber value="${s.deduction + s.insurance + s.tax}" pattern="#,##0.00"/></td>
                        <td class="font-bold"><fmt:formatNumber value="${s.actualSalary}" pattern="#,##0.00"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${s.status == 0}"><span class="badge badge-warning">未发放</span></c:when>
                                <c:when test="${s.status == 1}"><span class="badge badge-success">已发放</span></c:when>
                            </c:choose>
                        </td>
                        <td class="actions">
                            <a href="${ctx}/salary.do?method=detail&id=${s.id}" class="btn btn-xs btn-outline">详情</a>
                            <a href="${ctx}/salary.do?method=edit&id=${s.id}" class="btn btn-xs btn-primary">编辑</a>
                            <a href="javascript:void(0)" onclick="confirmDelete('${ctx}/salary.do?method=delete&id=${s.id}')" class="btn btn-xs btn-danger">删除</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty page.list}"><tr><td colspan="10" class="text-center text-light" style="padding:32px;">暂无数据</td></tr></c:if>
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
