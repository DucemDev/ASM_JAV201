<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý Người dùng</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">

<c:if test="${empty sessionScope.authUser || !sessionScope.authUser.role}">
  <c:redirect url="/login"/>
</c:if>

<h2 class="mb-2 text-primary">👥 Quản lý tài khoản người dùng</h2>

<!-- BACK HOME -->
<div class="mb-3">
  <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-dark">
    ⬅️ Quay về trang chủ
  </a>
</div>

<div class="card mb-4 shadow-sm">
  <div class="card-header bg-dark text-white">Thông tin người dùng</div>
  <div class="card-body">
    <form action="${pageContext.request.contextPath}/admin/users/${not empty form.userId ? 'update' : 'create'}" method="post">
      <div class="row">
        <div class="col-md-3 mb-3">
          <label class="form-label">ID</label>
          <input name="userId" value="${form.userId}" class="form-control" ${not empty form.userId ? 'readonly' : ''}>
        </div>
        <div class="col-md-3 mb-3">
          <label class="form-label">Username</label>
          <input name="username" value="${form.username}" class="form-control">
        </div>
        <div class="col-md-3 mb-3">
          <label class="form-label">Email</label>
          <input name="email" value="${form.email}" class="form-control">
        </div>
        <div class="col-md-3 mb-3">
          <label class="form-label">Password</label>
          <input type="password" name="password" value="${form.password}" class="form-control">
        </div>
      </div>
      <button class="btn btn-primary">
        ${not empty form.userId ? 'Cập nhật' : 'Thêm mới'}
      </button>
    </form>
  </div>
</div>

<div class="card shadow-sm">
  <table class="table table-hover">
    <thead>
    <tr>
      <th>ID</th><th>Username</th><th>Email</th><th>Action</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="u" items="${items}">
      <tr>
        <td>${u.userId}</td>
        <td>${u.username}</td>
        <td>${u.email}</td>
        <td>
          <a href="${pageContext.request.contextPath}/admin/users/edit/${u.userId}" class="btn btn-sm btn-warning">Sửa</a>
          <a href="${pageContext.request.contextPath}/admin/users/delete/${u.userId}"
             class="btn btn-sm btn-danger"
             onclick="return confirm('Xóa người dùng?')">Xóa</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>

</body>
</html>
