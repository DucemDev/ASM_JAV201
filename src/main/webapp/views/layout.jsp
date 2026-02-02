<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Owl Review</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI",
            Roboto, Arial, sans-serif;
        }

        /* ===== HEADER ===== */
        .app-header {
            height: 60px;
        }

        .navbar-brand {
            font-size: 20px;
            letter-spacing: 0.5px;
        }

        .user-box {
            display: flex;
            align-items: center;
            gap: 12px;
            color: #f8f9fa;
            font-size: 14px;
        }

        .user-name {
            font-weight: 500;
            opacity: 0.9;
        }

        /* ===== SIDEBAR ===== */
        .sidebar {
            min-height: calc(100vh - 60px);
            background-color: #212529;
        }

        .sidebar .section-title {
            font-size: 12px;
            letter-spacing: 1px;
            color: #adb5bd;
            margin-bottom: 10px;
            text-transform: uppercase;
        }

        .sidebar a {
            display: block;
            padding: 8px 10px;
            margin-bottom: 4px;
            border-radius: 4px;
            color: #fff;
            text-decoration: none;
            transition: background-color 0.2s;
        }

        .sidebar a:hover {
            background-color: rgba(255, 255, 255, 0.12);
        }

        /* ===== CONTENT ===== */
        .content-area {
            background-color: #f8f9fa;
            min-height: calc(100vh - 60px);
        }
    </style>
</head>

<body>

<!-- ===== HEADER ===== -->
<nav class="navbar navbar-dark bg-dark px-4 app-header">
    <a class="navbar-brand fw-bold text-warning"
       href="${pageContext.request.contextPath}/home">
        Owl Review
    </a>

    <div class="ms-auto d-flex align-items-center">

        <!-- SEARCH -->
        <form class="d-flex me-3"
              method="get"
              action="${pageContext.request.contextPath}/home">
            <input class="form-control form-control-sm me-2"
                   type="search"
                   name="keyword"
                   placeholder="Tìm quán ăn...">
            <button class="btn btn-outline-light btn-sm">
                Tìm
            </button>
        </form>

        <!-- ĐÃ ĐĂNG NHẬP -->
        <c:if test="${not empty sessionScope.authUser}">
            <div class="user-box">
                <span class="user-name">
                        ${sessionScope.authUser.username}
                </span>

                <a href="${pageContext.request.contextPath}/setting?action=logout"
                   class="btn btn-outline-warning btn-sm">
                    Đăng xuất
                </a>
            </div>
        </c:if>

        <!-- CHƯA ĐĂNG NHẬP -->
        <c:if test="${empty sessionScope.authUser}">
            <a href="${pageContext.request.contextPath}/login"
               class="btn btn-outline-light btn-sm">
                Đăng nhập
            </a>
        </c:if>

    </div>
</nav>

<!-- ===== BODY ===== -->
<div class="container-fluid">
    <div class="row">

        <!-- ===== SIDEBAR ===== -->
        <div class="col-2 sidebar text-white p-3">

            <div class="section-title">Menu</div>

            <a href="${pageContext.request.contextPath}/home">
                Trang chủ
            </a>

            <a href="${pageContext.request.contextPath}/favorite">
                Yêu thích
            </a>

            <a href="${pageContext.request.contextPath}/history">
                Đã xem
            </a>

            <a href="${pageContext.request.contextPath}/setting">
                Cài đặt tài khoản
            </a>

            <!-- ===== MENU ADMIN ===== -->
            <c:if test="${sessionScope.authUser.role}">
                <hr class="border-secondary">

                <h6 class="text-uppercase text-secondary mt-3">ADMIN</h6>

                <a href="${pageContext.request.contextPath}/admin/users/index"
                   class="text-white d-block my-2 text-decoration-none">
                    Quản lý người dùng
                </a>

                <a href="${pageContext.request.contextPath}/admin/restaurants"
                   class="text-white d-block my-2">
                    Quản lý quán
                </a>

                <a href="${pageContext.request.contextPath}/admin/reports"
                   class="text-white d-block my-2 text-decoration-none">
                    Báo cáo & thống kê
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
