<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý Nhà hàng</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
        rel="stylesheet">

  <style>
    .preview-img {
      width: 100%;
      height: 200px;
      object-fit: cover;
      border: 1px dashed #ccc;
    }
    iframe {
      width: 100%;
      height: 200px;
      border: none;
    }
  </style>
</head>

<body class="container py-4">

<h2 class="mb-4">⚙️ Quản lý Nhà hàng</h2>

<form action="${pageContext.request.contextPath}/admin/restaurant"
      method="post"
      class="row g-4">

  <input type="hidden" name="id" value="${form.restaurantId}"/>

  <!-- ===== FORM ===== -->
  <div class="col-md-7">
    <div class="card shadow-sm">
      <div class="card-body">

        <div class="mb-3">
          <label class="form-label">Tên nhà hàng</label>
          <input name="name"
                 value="${form.name}"
                 class="form-control"
                 required>
        </div>

        <div class="mb-3">
          <label class="form-label">Link ảnh poster</label>
          <input name="posterUrl"
                 value="${form.posterUrl}"
                 class="form-control"
                 placeholder="https://images.unsplash.com/..."
                 oninput="imgPreview.src=this.value">
        </div>

        <div class="mb-3">
          <label class="form-label">Link video YouTube (embed)</label>
          <input name="videoUrl"
                 value="${form.videoUrl}"
                 class="form-control"
                 placeholder="https://www.youtube.com/embed/abc123"
                 oninput="videoPreview.src=this.value">
        </div>

        <button class="btn btn-primary">
          <c:choose>
            <c:when test="${empty form.restaurantId}">➕ Thêm quán</c:when>
            <c:otherwise>💾 Cập nhật</c:otherwise>
          </c:choose>
        </button>

        <a href="${pageContext.request.contextPath}/admin/restaurant"
           class="btn btn-outline-secondary ms-2">
          Làm mới
        </a>

      </div>
    </div>
  </div>

  <!-- ===== PREVIEW ===== -->
  <div class="col-md-5">
    <div class="card shadow-sm">
      <div class="card-header">Xem trước</div>
      <div class="card-body text-center">

        <!-- IMAGE -->
        <img id="imgPreview"
             class="preview-img mb-3"
             src="${empty form.posterUrl
                          ? 'https://placehold.co/600x400?text=No+Image'
                          : form.posterUrl}">

        <!-- VIDEO -->
        <c:if test="${not empty form.videoUrl}">
          <iframe id="videoPreview"
                  src="${form.videoUrl}"
                  allowfullscreen>
          </iframe>
        </c:if>

        <c:if test="${empty form.videoUrl}">
          <iframe id="videoPreview"
                  src=""
                  style="display:none"></iframe>
        </c:if>

      </div>
    </div>
  </div>
</form>

<hr class="my-4">

<!-- ===== TABLE ===== -->
<table class="table table-bordered table-hover">
  <thead class="table-dark">
  <tr>
    <th>ID</th>
    <th>Tên</th>
    <th>Poster</th>
    <th>View</th>
    <th width="160">Thao tác</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="r" items="${items}">
    <tr>
      <td>${r.restaurantId}</td>
      <td>${r.name}</td>
      <td>
        <c:if test="${not empty r.posterUrl}">
          <img src="${r.posterUrl}" width="80">
        </c:if>
      </td>
      <td>${r.viewCount}</td>
      <td>
        <a href="${pageContext.request.contextPath}/admin/restaurant?id=${r.restaurantId}"
           class="btn btn-sm btn-warning">Sửa</a>
        <a href="${pageContext.request.contextPath}/admin/restaurant?delete=${r.restaurantId}"
           class="btn btn-sm btn-danger"
           onclick="return confirm('Xóa quán này?')">Xóa</a>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
