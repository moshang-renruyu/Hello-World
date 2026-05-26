<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/jsp/common/header.jsp">
    <jsp:param name="title" value="操作成功"/>
    <jsp:param name="menu" value=""/>
</jsp:include>

<div style="text-align:center;padding:80px 20px;">
    <div style="font-size:48px;font-weight:700;color:var(--success);margin-bottom:16px;">OK</div>
    <h2 style="margin-bottom:12px;">操作成功</h2>
    <p class="text-secondary" style="margin-bottom:8px;">
        <c:choose>
            <c:when test="${not empty success}">${success}</c:when>
            <c:otherwise>您的操作已成功完成。</c:otherwise>
        </c:choose>
    </p>
    <c:if test="${not empty filePath}">
        <p class="text-secondary" style="margin-bottom:24px;">文件路径: ${filePath}</p>
    </c:if>
    <div style="margin-top:24px;">
        <a href="${pageContext.request.contextPath}/dashboard.do?method=index" class="btn btn-primary">返回首页</a>
        <a href="javascript:history.back()" class="btn btn-outline" style="margin-left:8px;">返回上一页</a>
    </div>
</div>

<jsp:include page="/jsp/common/footer.jsp"/>
