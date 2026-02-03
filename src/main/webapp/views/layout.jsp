<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Owl Review</title>

    <!-- ICONS + BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
          rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body {
            font-family: Inter, -apple-system, BlinkMacSystemFont, "Segoe UI",
            Roboto, Arial, sans-serif;
            background-color: #f5f6f8;
        }

        /* ===== HEADER ===== */
        .app-header {
            height: 64px;
            backdrop-filter: blur(8px);
        }

        .navbar-brand {
            font-size: 20px;
            letter-spacing: 0.5px;
        }

        .user-box {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 14px;
        }

        .user-name {
            font-weight: 500;
            color: #f8f9fa;
        }

        /* ===== SIDEBAR ===== */
        .sidebar {
            min-height: calc(100vh - 64px);
            background: linear-gradient(180deg, #212529, #1b1f23);
        }

        .sidebar .section-title {
            font-size: 11px;
            letter-spacing: 1.2px;
            color: #9aa0a6;
            margin-bottom: 12px;
            text-transform: uppercase;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 9px 12px;
            margin-bottom: 6px;
            border-radius: 8px;
            color: #e9ecef;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.2s ease;
        }

        .sidebar a:hover {
            background-color: rgba(255, 255, 255, 0.12);
            transform: translateX(2px);
        }

        .sidebar hr {
            opacity: 0.15;
        }

        /* ===== CONTENT ===== */
        .content-area {
            background-color: #f5f6f8;
            min-height: calc(100vh - 64px);
        }

        /* ===== HEART ICON ===== */
        .heart-btn {
            font-size: 18px;
            text-decoration: none;
            transition: transform 0.15s ease;
        }

        .heart-btn:hover {
            transform: scale(1.15);
        }

        /* ===== SEARCH ===== */
        .search-box input,
        .search-box select {
            border-radius: 999px;
        }
    </style>
</head>

<body>

<!-- ===== HEADER ===== -->
<nav class="navbar navbar-dark bg-dark px-4 app-header shadow-sm">
    <a class="navbar-brand fw-bold text-warning"
       href="${pageContext.request.contextPath}/home">
        🦉 Owl Review
    </a>

    <div class="ms-auto d-flex align-items-center">

        <!-- SEARCH + FILTER -->
        <form class="d-flex align-items-center gap-2 search-box"
              method="get"
              action="${pageContext.request.contextPath}/home">

            <input class="form-control form-control-sm"
                   type="search"
                   name="keyword"
                   value="${keyword}"
                   placeholder="Tìm quán ăn...">

            <select name="sort"
                    class="form-select form-select-sm"
                    style="width:160px">
                <option value="">Bộ lọc</option>
                <option value="view-desc" ${sort == 'view-desc' ? 'selected' : ''}>
                    🔥 View cao
                </option>
                <option value="view-asc" ${sort == 'view-asc' ? 'selected' : ''}>
                    🔻 View thấp
                </option>
                <option value="random" ${sort == 'random' ? 'selected' : ''}>
                    🎲 Ngẫu nhiên
                </option>
            </select>

            <button class="btn btn-outline-light btn-sm px-3 rounded-pill">
                Tìm
            </button>
        </form>

        <!-- USER -->
        <c:if test="${not empty sessionScope.authUser}">
            <div class="user-box ms-3">
                <span class="user-name">
                        ${sessionScope.authUser.username}
                </span>

                <a href="${pageContext.request.contextPath}/setting?action=logout"
                   class="btn btn-outline-warning btn-sm rounded-pill px-3">
                    Đăng xuất
                </a>
            </div>
        </c:if>

        <c:if test="${empty sessionScope.authUser}">
            <a href="${pageContext.request.contextPath}/login"
               class="btn btn-outline-light btn-sm rounded-pill px-3 ms-3">
                Đăng nhập
            </a>
        </c:if>

    </div>
</nav>

<!-- ===== BODY ===== -->
<div class="container-fluid">
    <div class="row">

        <!-- ===== SIDEBAR ===== -->
        <div class="col-2 sidebar p-3">

            <div class="section-title">Menu</div>

            <a href="${pageContext.request.contextPath}/home">
                <i class="bi bi-house"></i> Trang chủ
            </a>

            <a href="${pageContext.request.contextPath}/favorite">
                <i class="bi bi-heart"></i> Yêu thích
            </a>

            <a href="${pageContext.request.contextPath}/history">
                <i class="bi bi-clock-history"></i> Đã xem
            </a>

            <a href="${pageContext.request.contextPath}/setting">
                <i class="bi bi-gear"></i> Cài đặt
            </a>

            <!-- ADMIN -->
            <c:if test="${sessionScope.authUser.role}">
                <hr>
                <div class="section-title">Admin</div>

                <a href="${pageContext.request.contextPath}/admin/users/index">
                    <i class="bi bi-people"></i> Người dùng
                </a>

                <a href="${pageContext.request.contextPath}/admin/restaurants">
                    <i class="bi bi-shop"></i> Quán ăn
                </a>

                <a href="${pageContext.request.contextPath}/admin/reports">
                    <i class="bi bi-bar-chart"></i> Báo cáo
                </a>
            </c:if>

        </div>

        <!-- ===== CONTENT ===== -->
        <div class="col-10 p-4 content-area">
            <jsp:include page="${contentPage}"/>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
