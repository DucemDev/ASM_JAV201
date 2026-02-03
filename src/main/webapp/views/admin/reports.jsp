<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Reports</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        .sidebar-scroll { max-height: 70vh; overflow-y: auto; }
        .stat-card { border-left: 4px solid var(--bs-primary); }
        .stat-title { font-size: 12px; letter-spacing: .5px; color: #6c757d; }
    </style>
</head>
<body class="bg-light">

<c:if test="${empty sessionScope.authUser || !sessionScope.authUser.role}">
    <c:redirect url="/login"/>
</c:if>

<div class="container-fluid py-4">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <a href="${pageContext.request.contextPath}/home"
               class="btn btn-sm btn-outline-secondary mb-2">
                ← Trang chủ
            </a>
            <h4 class="fw-bold mb-0">Báo cáo & Thống kê</h4>
            <small class="text-muted">Tổng quan hoạt động hệ thống</small>
        </div>

        <a href="${pageContext.request.contextPath}/admin/reports"
           class="btn btn-primary btn-sm">
            Làm mới
        </a>
    </div>

    <div class="row g-4">

        <!-- LEFT -->
        <div class="col-md-3">
            <div class="card shadow-sm border-0">
                <div class="card-header fw-semibold bg-white">
                    Nhà hàng
                </div>

                <div class="list-group list-group-flush sidebar-scroll">
                    <c:forEach var="r" items="${allRestaurants}">
                        <a href="?restaurantId=${r.restaurantId}"
                           class="list-group-item list-group-item-action
                           ${param.restaurantId == r.restaurantId ? 'active' : ''}">
                            ${r.name}
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- RIGHT -->
        <div class="col-md-9">
            <c:choose>
                <c:when test="${not empty selectedRest}">

                    <div class="card shadow-sm border-0 mb-4 stat-card">
                        <div class="card-body">
                            <h5 class="fw-bold mb-1">${selectedRest.name}</h5>
                            <small class="text-muted">
                                ID: ${selectedRest.restaurantId} ·
                                👁 ${selectedRest.viewCount} lượt xem
                            </small>
                        </div>
                    </div>

                    <div class="row g-3">

                        <!-- LIKE -->
                        <div class="col-md-4">
                            <div class="card h-100 shadow-sm border-0">
                                <div class="card-body">
                                    <div class="stat-title">LƯỢT YÊU THÍCH</div>
                                    <h3 class="fw-bold text-danger">${countLikes}</h3>
                                </div>
                            </div>
                        </div>

                        <!-- SHARE -->
                        <div class="col-md-4">
                            <div class="card h-100 shadow-sm border-0">
                                <div class="card-body">
                                    <div class="stat-title">EMAIL ĐÃ CHIA SẺ</div>
                                    <h3 class="fw-bold text-info">${countShares}</h3>
                                </div>
                            </div>
                        </div>

                        <!-- COMMENT -->
                        <div class="col-md-4">
                            <div class="card h-100 shadow-sm border-0">
                                <div class="card-body">
                                    <div class="stat-title">BÌNH LUẬN</div>
                                    <h3 class="fw-bold text-warning">${countComms}</h3>
                                </div>
                            </div>
                        </div>

                    </div>

                </c:when>

                <c:otherwise>
                    <div class="card shadow-sm border-0 p-5 text-center">
                        <span class="text-muted">
                            Chọn một nhà hàng để xem báo cáo chi tiết
                        </span>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</div>
</body>
</html>
