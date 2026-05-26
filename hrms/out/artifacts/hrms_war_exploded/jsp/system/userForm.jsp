<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="编辑用户"/>
    <jsp:param name="menu" value="user"/>
</jsp:include>

<div class="page-header">
    <h2>编辑用户</h2>
    <a href="${ctx}/system.do?method=userList" class="btn btn-outline">返回列表</a>
</div>

<div class="card">
    <div class="card-body">
        <form action="${ctx}/system.do?method=saveUser" method="post">
            <input type="hidden" name="id" value="${editUser.id}">
            <div class="form-row">
                <div class="form-group">
                    <label>用户名</label>
                    <input type="text" class="form-control" value="${editUser.username}" disabled>
                </div>
                <div class="form-group">
                    <label>真实姓名</label>
                    <input type="text" name="realName" class="form-control" value="${editUser.realName}">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>邮箱</label>
                    <input type="text" name="email" class="form-control" value="${editUser.email}">
                </div>
                <div class="form-group">
                    <label>手机号</label>
                    <input type="text" name="phone" class="form-control" value="${editUser.phone}">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>角色</label>
                    <select name="role" class="form-control">
                        <option value="0" ${editUser.role == 0 ? 'selected' : ''}>普通用户</option>
                        <option value="1" ${editUser.role == 1 ? 'selected' : ''}>管理员</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>状态</label>
                    <select name="status" class="form-control">
                        <option value="1" ${editUser.status == 1 ? 'selected' : ''}>启用</option>
                        <option value="0" ${editUser.status == 0 ? 'selected' : ''}>禁用</option>
                    </select>
                </div>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">保 存</button>
                <a href="${ctx}/system.do?method=userList" class="btn btn-outline">取 消</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/jsp/common/footer.jsp"/>
