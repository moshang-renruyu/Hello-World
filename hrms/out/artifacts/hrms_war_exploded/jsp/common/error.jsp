<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="错误"/>
    <jsp:param name="menu" value=""/>
</jsp:include>

<div style="text-align:center;padding:80px 20px;">
    <div style="font-size:48px;font-weight:700;color:var(--border);margin-bottom:16px;">OOPS</div>
    <h2 style="margin-bottom:12px;">操作出错</h2>
    <p class="text-secondary" style="margin-bottom:24px;">
        <c:choose>
            <c:when test="${not empty errorMsg}">${errorMsg}</c:when>
            <c:otherwise>系统处理请求时发生错误，请稍后再试。</c:otherwise>
        </c:choose>
    </p>
    <a href="${pageContext.request.contextPath}/dashboard.do?method=index" class="btn btn-primary">返回首页</a>
    <a href="javascript:history.back()" class="btn btn-outline" style="margin-left:8px;">返回上一页</a>
</div>

<jsp:include page="/jsp/common/footer.jsp"/>
