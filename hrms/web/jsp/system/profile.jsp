<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="个人中心"/>
    <jsp:param name="menu" value="profile"/>
</jsp:include>

<div class="page-header">
    <h2>个人中心</h2>
</div>

<c:if test="${not empty success}">
    <div class="alert alert-success">${success}</div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>

<div style="display:grid;grid-template-columns:1fr 1fr;gap:20px;">
    <div class="card">
        <div class="card-header"><h3>个人信息</h3></div>
        <div class="card-body">
            <form action="${ctx}/system.do?method=updateProfile" method="post">
                <div class="form-group">
                    <label>用户名</label>
                    <input type="text" class="form-control" value="${profileUser.username}" disabled>
                </div>
                <div class="form-group">
                    <label>真实姓名</label>
                    <input type="text" name="realName" class="form-control" value="${profileUser.realName}">
                </div>
                <div class="form-group">
                    <label>邮箱</label>
                    <input type="text" name="email" class="form-control" value="${profileUser.email}">
                </div>
                <div class="form-group">
                    <label>手机号</label>
                    <input type="text" name="phone" class="form-control" value="${profileUser.phone}">
                </div>
                <div class="form-group">
                    <label>角色</label>
                    <input type="text" class="form-control" value="${profileUser.role == 1 ? '管理员' : '普通用户'}" disabled>
                </div>
                <div class="form-group">
                    <label>注册时间</label>
                    <input type="text" class="form-control" value="<fmt:formatDate value='${profileUser.createTime}' pattern='yyyy-MM-dd HH:mm:ss'/>" disabled>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">保存修改</button>
                </div>
            </form>
        </div>
    </div>

    <div class="card">
        <div class="card-header"><h3>修改密码</h3></div>
        <div class="card-body">
            <form action="${ctx}/system.do?method=changePwd" method="post" onsubmit="return validateChangePwd()">
                <div class="form-group">
                    <label>原密码 <span class="required">*</span></label>
                    <input type="password" id="oldPassword" name="oldPassword" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>新密码 <span class="required">*</span></label>
                    <input type="password" id="newPassword" name="newPassword" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>确认新密码 <span class="required">*</span></label>
                    <input type="password" id="confirmPassword" class="form-control" required>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-warning">修改密码</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function validateChangePwd() {
    var oldPwd = document.getElementById('oldPassword');
    var newPwd = document.getElementById('newPassword');
    var confirm = document.getElementById('confirmPassword');
    if (!oldPwd.value) { alert('请输入原密码'); oldPwd.focus(); return false; }
    if (!newPwd.value) { alert('请输入新密码'); newPwd.focus(); return false; }
    if (newPwd.value.length < 6) { alert('新密码至少6位'); newPwd.focus(); return false; }
    if (newPwd.value !== confirm.value) { alert('两次密码输入不一致'); confirm.focus(); return false; }
    return true;
}
</script>

<jsp:include page="/jsp/common/footer.jsp"/>
