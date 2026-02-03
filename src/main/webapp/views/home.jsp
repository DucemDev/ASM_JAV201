<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<style>
    .restaurant-card {
        border-radius: 14px;
        overflow: hidden;
        transition: all 0.25s ease;
        background: #fff;
    }

    .restaurant-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 12px 30px rgba(0,0,0,0.08);
    }

    .restaurant-img {
        height: 180px;
        object-fit: cover;
        transition: transform 0.4s ease;
    }

    .restaurant-card:hover .restaurant-img {
        transform: scale(1.05);
    }

    .view-count {
        font-size: 13px;
        color: #6c757d;
    }

    /* ===== ACTION BUTTONS ===== */
    .action-group {
        display: flex;
        gap: 10px;
    }

    .btn-action {
        flex: 1;                 /* 🔥 QUAN TRỌNG: 2 nút bằng nhau */
        height: 50px;            /* 🔥 CÙNG CHIỀU CAO */
        font-size: 14px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 0;              /* bỏ padding lệch */
        white-space: nowrap;
    }
</style>

<h2 class="mb-4 fw-semibold"> test nó nằmở đâu z</h2>

<c:choose>
    <c:when test="${empty list}">
        <div class="alert alert-warning">
            Không có dữ liệu quán ăn.
        </div>
    </c:when>

    <c:otherwise>
        <div class="row g-4">
            <c:forEach var="r" items="${list}">
                <div class="col-lg-4 col-md-6">
                    <div class="restaurant-card h-100">

                        <!-- IMAGE -->
                        <img src="${pageContext.request.contextPath}/images/${r.posterUrl}"
                             class="restaurant-img w-100"
                             alt="${r.name}">

                        <!-- BODY -->
                        <div class="p-3">
                            <h5 class="fw-semibold mb-1 text-truncate">
                                ${r.name}
                            </h5>

                            <div class="view-count mb-3">
                                 ${r.viewCount} lượt xem
                            </div>

                            <!-- ACTIONS -->
                            <div class="action-group">
                                <a href="${pageContext.request.contextPath}/restaurant/detail?id=${r.restaurantId}"
                                   class="btn btn-primary btn-action">
                                    Xem chi tiết
                                </a>

                                <a href="${pageContext.request.contextPath}/share/form?id=${r.restaurantId}"
                                   class="btn btn-outline-primary btn-action">
                                    Chia sẻ
                                </a>
                            </div>
                        </div>

                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>
