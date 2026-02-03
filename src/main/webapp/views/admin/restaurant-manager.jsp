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

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }

        .page-header {
            border-bottom: 1px solid #e5e7eb;
            padding-bottom: 12px;
            margin-bottom: 24px;
        }

        .preview-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px dashed #ced4da;
            background: #fff;
        }

        iframe {
            width: 100%;
            height: 200px;
            border-radius: 8px;
        }

        .table img {
            border-radius: 6px;
        }
    </style>
</head>

<body class="container py-4">

<!-- ===== HEADER ===== -->
<div class="page-header d-flex justify-content-between align-items-center">
    <div>
        <a href="${pageContext.request.contextPath}/home"
           class="btn btn-sm btn-outline-secondary mb-2">
            ⬅️ Trang chủ
        </a>
        <h4 class="fw-bold mb-0 text-primary">Quản lý quán ăn</h4>
        <small class="text-muted">Thêm – sửa – quản lý danh sách nhà hàng</small>
    </div>
</div>

<!-- ===== FORM + PREVIEW ===== -->
<form action="${pageContext.request.contextPath}/admin/restaurant"
      method="post"
      class="row g-4">

    <input type="hidden" name="id" value="${form.restaurantId}"/>

    <!-- FORM -->
    <div class="col-md-7">
        <div class="card shadow-sm border-0">
            <div class="card-body">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Tên nhà hàng</label>
                    <input name="name"
                           value="${form.name}"
                           class="form-control"
                           required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Link ảnh poster</label>
                    <input name="posterUrl"
                           value="${form.posterUrl}"
                           class="form-control"
                           placeholder="https://images.unsplash.com/..."
                           oninput="imgPreview.src=this.value">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Link video YouTube (embed)</label>
                    <input name="videoUrl"
                           value="${form.videoUrl}"
                           class="form-control"
                           placeholder="https://www.youtube.com/embed/abc123"
                           oninput="videoPreview.src=this.value">
                </div>

                <div class="d-flex gap-2">
                    <button class="btn btn-primary px-4">
                        <c:choose>
                            <c:when test="${empty form.restaurantId}">➕ Thêm quán</c:when>
                            <c:otherwise>💾 Cập nhật</c:otherwise>
                        </c:choose>
                    </button>

                    <a href="${pageContext.request.contextPath}/admin/restaurant"
                       class="btn btn-outline-secondary">
                        Làm mới
                    </a>
                </div>

            </div>
        </div>
    </div>

    <!-- PREVIEW -->
    <div class="col-md-5">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white fw-semibold">
                Xem trước
            </div>
            <div class="card-body">

                <img id="imgPreview"
                     class="preview-img mb-3"
                     src="${empty form.posterUrl
                            ? 'https://placehold.co/600x400?text=No+Image'
                            : form.posterUrl}">

                <c:if test="${not empty form.videoUrl}">
                    <iframe id="videoPreview"
                            src="${form.videoUrl}"
                            allowfullscreen></iframe>
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

<!-- ===== TABLE ===== -->
<div class="card shadow-sm border-0 mt-4">
    <div class="card-header bg-white fw-semibold">
        Danh sách nhà hàng
    </div>

    <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
            <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Poster</th>
                <th>View</th>
                <th class="text-end">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="r" items="${items}">
                <tr>
                    <td>${r.restaurantId}</td>
                    <td class="fw-semibold">${r.name}</td>
                    <td>
                        <c:if test="${not empty r.posterUrl}">
                            <img src="${r.posterUrl}" width="80">
                        </c:if>
                    </td>
                    <td>${r.viewCount}</td>
                    <td class="text-end">
                        <a href="${pageContext.request.contextPath}/admin/restaurant?id=${r.restaurantId}"
                           class="btn btn-sm btn-warning">Sửa</a>

                        <a href="${pageContext.request.contextPath}/admin/restaurant?delete=${r.restaurantId}"
                           class="btn btn-sm btn-danger ms-1"
                           onclick="return confirm('Xóa quán này?')">
                            Xóa
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
