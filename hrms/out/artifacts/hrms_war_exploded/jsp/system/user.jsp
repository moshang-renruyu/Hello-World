<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="用户管理"/>
    <jsp:param name="menu" value="user"/>
</jsp:include>

<div class="page-header">
    <h2>用户管理</h2>
</div>

<div class="card">
    <div class="card-body">
        <form id="searchForm" method="get" action="${ctx}/system.do">
            <input type="hidden" name="method" value="userList">
            <div class="toolbar">
                <div class="search-box">
                    <input type="text" name="keyword" class="form-control" placeholder="搜索用户名/姓名" value="${keyword}">
                    <button type="submit" class="btn btn-primary btn-sm">搜索</button>
                </div>
            </div>
        </form>
        <div class="table-wrapper">
            <table class="data-table">
                <thead>
                <tr><th>ID</th><th>用户名</th><th>姓名</th><th>角色</th><th>邮箱</th><th>手机</th><th>状态</th><th>最后登录</th><th>操作</th></tr>
                </thead>
                <tbody>
                <c:forEach items="${page.list}" var="u">
                    <tr>
                        <td>${u.id}</td>
                        <td><strong>${u.username}</strong></td>
                        <td>${u.realName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${u.role == 1}"><span class="badge badge-primary">管理员</span></c:when>
                                <c:otherwise><span class="badge badge-secondary">普通用户</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>${u.email}</td>
                        <td>${u.phone}</td>
                        <td>
                            <c:choose>
                                <c:when test="${u.status == 1}"><span class="badge badge-success">启用</span></c:when>
                                <c:otherwise><span class="badge badge-danger">禁用</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td><fmt:formatDate value="${u.lastLogin}" pattern="MM-dd HH:mm"/></td>
                        <td class="actions">
                            <a href="${ctx}/system.do?method=editUser&id=${u.id}" class="btn btn-xs btn-primary">编辑</a>
                            <a href="javascript:void(0)" onclick="confirmAction('确认重置该用户密码为123456？','${ctx}/system.do?method=resetPwd&id=${u.id}')" class="btn btn-xs btn-warning">重置密码</a>
                            <a href="javascript:void(0)" onclick="confirmDelete('${ctx}/system.do?method=deleteUser&id=${u.id}')" class="btn btn-xs btn-danger">删除</a>
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
