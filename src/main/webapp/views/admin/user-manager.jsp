<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<c:if test="${empty sessionScope.authUser || !sessionScope.authUser.role}">
    <c:redirect url="/login"/>
</c:if>

<div class="container py-4">

    <div class="mb-4">
        <a href="${pageContext.request.contextPath}/home"
           class="btn btn-sm btn-outline-secondary mb-2">
            ← Trang chủ
        </a>
        <h4 class="fw-bold mb-0">Quản lý người dùng</h4>
        <small class="text-muted">Tạo và quản lý tài khoản</small>
    </div>

    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body">
            <form method="post"
                  action="${pageContext.request.contextPath}/admin/users/${empty form.userId ? 'create' : 'update'}">
                <div class="row g-3">
                    <div class="col-md-3">
                        <input name="userId" value="${form.userId}"
                               class="form-control" placeholder="ID"
                               ${not empty form.userId ? 'readonly' : ''}>
                    </div>
                    <div class="col-md-3">
                        <input name="username" value="${form.username}"
                               class="form-control" placeholder="Username">
                    </div>
                    <div class="col-md-3">
                        <input name="email" value="${form.email}"
                               class="form-control" placeholder="Email">
                    </div>
                    <div class="col-md-3">
                        <input type="password" name="password"
                               class="form-control" placeholder="Password">
                    </div>
                </div>

                <button class="btn btn-primary mt-3">
                    ${empty form.userId ? 'Thêm mới' : 'Cập nhật'}
                </button>
            </form>
        </div>
    </div>

    <div class="card shadow-sm border-0">
        <table class="table table-hover mb-0">
            <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="u" items="${items}">
                <tr>
                    <td>${u.userId}</td>
                    <td>${u.username}</td>
                    <td>${u.email}</td>
                    <td class="text-end">
                        <a href="edit/${u.userId}" class="btn btn-sm btn-warning">Sửa</a>
                        <a href="delete/${u.userId}"
                           class="btn btn-sm btn-danger"
                           onclick="return confirm('Xóa người dùng?')">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>
