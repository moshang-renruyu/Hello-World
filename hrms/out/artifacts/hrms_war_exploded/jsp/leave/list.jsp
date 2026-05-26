<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="请假管理"/>
    <jsp:param name="menu" value="leave"/>
</jsp:include>

<div class="page-header">
    <h2>请假管理</h2>
    <a href="${ctx}/leave.do?method=add" class="btn btn-primary">请假申请</a>
</div>

<div class="card">
    <div class="card-body">
        <form id="searchForm" method="get" action="${ctx}/leave.do">
            <input type="hidden" name="method" value="list">
            <div class="toolbar">
                <div class="search-box">
                    <input type="text" name="keyword" class="form-control" placeholder="搜索姓名/工号" value="${keyword}">
                </div>
                <div class="filter-box">
                    <select name="status" class="form-control" onchange="this.form.submit()">
                        <option value="-1">全部状态</option>
                        <option value="0" ${status == 0 ? 'selected' : ''}>待审批</option>
                        <option value="1" ${status == 1 ? 'selected' : ''}>已批准</option>
                        <option value="2" ${status == 2 ? 'selected' : ''}>已拒绝</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary btn-sm">搜索</button>
            </div>
        </form>
        <div class="table-wrapper">
            <table class="data-table">
                <thead>
                <tr><th>工号</th><th>姓名</th><th>部门</th><th>类型</th><th>开始日期</th><th>结束日期</th><th>天数</th><th>状态</th><th>申请时间</th><th>操作</th></tr>
                </thead>
                <tbody>
                <c:forEach items="${page.list}" var="l">
                    <tr>
                        <td><strong>${l.empNo}</strong></td>
                        <td>${l.empName}</td>
                        <td>${l.deptName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${l.type==1}">事假</c:when><c:when test="${l.type==2}">病假</c:when>
                                <c:when test="${l.type==3}">年假</c:when><c:when test="${l.type==4}">婚假</c:when>
                                <c:when test="${l.type==5}">产假</c:when><c:when test="${l.type==6}">丧假</c:when>
                            </c:choose>
                        </td>
                        <td><fmt:formatDate value="${l.startDate}" pattern="yyyy-MM-dd"/></td>
                        <td><fmt:formatDate value="${l.endDate}" pattern="yyyy-MM-dd"/></td>
                        <td>${l.days}</td>
                        <td>
                            <c:choose>
                                <c:when test="${l.status==0}"><span class="badge badge-warning">待审批</span></c:when>
                                <c:when test="${l.status==1}"><span class="badge badge-success">已批准</span></c:when>
                                <c:when test="${l.status==2}"><span class="badge badge-danger">已拒绝</span></c:when>
                                <c:when test="${l.status==3}"><span class="badge badge-secondary">已撤销</span></c:when>
                            </c:choose>
                        </td>
                        <td><fmt:formatDate value="${l.createTime}" pattern="MM-dd HH:mm"/></td>
                        <td class="actions">
                            <a href="${ctx}/leave.do?method=detail&id=${l.id}" class="btn btn-xs btn-outline">详情</a>
                            <c:if test="${l.status==0}">
                                <a href="javascript:void(0)" onclick="approveLeave(${l.id},1)" class="btn btn-xs btn-success">批准</a>
                                <a href="javascript:void(0)" onclick="approveLeave(${l.id},2)" class="btn btn-xs btn-danger">拒绝</a>
                            </c:if>
                            <a href="javascript:void(0)" onclick="confirmDelete('${ctx}/leave.do?method=delete&id=${l.id}')" class="btn btn-xs btn-danger">删除</a>
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

<script>
function approveLeave(id, status) {
    var msg = status == 1 ? '确认批准该请假申请？' : '确认拒绝该请假申请？';
    var remark = prompt(msg + '\n请输入审批意见：', '');
    if (remark !== null) {
        window.location.href = '${ctx}/leave.do?method=approve&id=' + id + '&approveStatus=' + status + '&approveRemark=' + encodeURIComponent(remark);
    }
}
</script>

<jsp:include page="/jsp/common/footer.jsp"/>
