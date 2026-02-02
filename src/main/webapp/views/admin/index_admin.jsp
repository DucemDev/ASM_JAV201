<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin page</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>
<body>
<c:if test="${empty sessionScope.authUser || !sessionScope.authUser.role}">
    <c:redirect url="/login"/>
</c:if>
<ul>
    <li>
        <a href="<c:url value='/page/reports' />">Báo cáo & thống kê</a>
    </li>
    <li>
        <a href="<c:url value='/page/restaurant' />">Quản lý quán</a>
    </li>
    <li>
        <a href="<c:url value='/page/user' />">Quản lý người dùng</a>
    </li>
<%--    <li>--%>
<%--        <a href="<c:url value='/home' />">Trang chủ</a>--%>
<%--    </li>--%>
</ul>


</body>
</html>
