<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Quản lý Nhà hàng</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .preview-box {
      width: 100%;
      height: 200px;
      object-fit: cover;
      border: 1px dashed #ccc;
    }
    .video-container {
      width: 100%;
      height: 200px;
      border: 1px dashed #ccc;
      overflow: hidden;
    }
    video {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  </style>
</head>

<body class="container py-4">

<h2 class="mb-3">⚙️ Quản lý Nhà hàng</h2>

<form action="${pageContext.request.contextPath}/admin/restaurant"
      method="post"
      enctype="multipart/form-data"
      class="row g-4">

  <input type="hidden" name="id" value="${form.restaurantId}"/>

  <!-- FORM -->
  <div class="col-md-7">
    <div class="card shadow-sm">
      <div class="card-body">

        <div class="mb-3">
          <label class="form-label">Tên nhà hàng</label>
          <input name="name" value="${form.name}" class="form-control" required>
        </div>

        <div class="mb-3">
          <label class="form-label">Ảnh poster</label>
          <input type="file"
                 name="posterFile"
                 accept="image/*"
                 class="form-control"
                 onchange="previewImage(this)">
        </div>

        <div class="mb-3">
          <label class="form-label">Upload video (.mp4)</label>
          <input type="file"
                 name="videoFile"
                 accept="video/mp4"
                 class="form-control"
                 onchange="previewVideo(this)">
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

  <!-- PREVIEW -->
  <div class="col-md-5">
    <div class="card shadow-sm">
      <div class="card-header">Xem trước</div>
      <div class="card-body text-center">

        <!-- ===== IMAGE PREVIEW (FIX URL ENCODE) ===== -->
        <c:url var="posterSrc" value="/${form.posterUrl}" />
        <img id="imgPreview"
             class="preview-box mb-3"
             src="${empty form.posterUrl
                  ? 'https://placehold.co/600x400?text=No+Image'
                  : posterSrc}">

        <!-- ===== VIDEO PREVIEW (FIX URL ENCODE – 1 KHUNG DUY NHẤT) ===== -->
        <c:url var="videoSrc" value="/${form.videoUrl}" />
        <div class="video-container">
          <video id="videoPreview"
                 controls
                 style="${empty form.videoUrl ? 'display:none' : ''}">
            <c:if test="${not empty form.videoUrl}">
              <source src="${videoSrc}" type="video/mp4">
            </c:if>
          </video>
        </div>

      </div>
    </div>
  </div>

</form>

<hr class="my-4">

<!-- TABLE -->
<h4>📋 Danh sách nhà hàng</h4>

<table class="table table-bordered table-hover">
  <thead class="table-dark">
  <tr>
    <th>ID</th>
    <th>Tên</th>
    <th>Poster</th>
    <th>View</th>
    <th width="150">Thao tác</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="r" items="${items}">
    <tr>
      <td>${r.restaurantId}</td>
      <td>${r.name}</td>
      <td>
        <c:if test="${not empty r.posterUrl}">
          <c:url var="rowPoster" value="/${r.posterUrl}" />
          <img src="${rowPoster}" width="80">
        </c:if>
      </td>
      <td>${r.viewCount}</td>
      <td>
        <a href="${pageContext.request.contextPath}/admin/restaurant?id=${r.restaurantId}"
           class="btn btn-sm btn-warning">Sửa</a>
        <a href="${pageContext.request.contextPath}/admin/restaurant?delete=${r.restaurantId}"
           class="btn btn-sm btn-danger"
           onclick="return confirm('Xóa nhà hàng này?')">Xóa</a>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>

<script>
  function previewImage(input) {
    const img = document.getElementById("imgPreview");
    if (input.files && input.files[0]) {
      const reader = new FileReader();
      reader.onload = e => img.src = e.target.result;
      reader.readAsDataURL(input.files[0]);
    }
  }

  function previewVideo(input) {
    const video = document.getElementById("videoPreview");
    if (input.files && input.files[0]) {
      video.src = URL.createObjectURL(input.files[0]);
      video.style.display = "block";
      video.load();
    }
  }
</script>

</body>
</html>
