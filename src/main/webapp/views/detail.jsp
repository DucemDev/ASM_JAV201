<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<div class="container">

    <!-- HEADER -->
    <div class="mb-4">
        <h2 class="fw-bold mb-1">${restaurant.name}</h2>
        <span class="text-muted small">
            <i class="bi bi-eye"></i> ${restaurant.viewCount} lượt xem
        </span>
    </div>

    <!-- VIDEO -->
    <c:if test="${not empty restaurant.videoUrl}">
        <div class="ratio ratio-16x9 mb-4 rounded-4 overflow-hidden shadow-sm">
            <iframe
                    src="${restaurant.videoUrl}"
                    title="${restaurant.name}"
                    allowfullscreen>
            </iframe>
        </div>
    </c:if>

    <div class="row g-4">

        <!-- POSTER -->
        <div class="col-md-5">
            <c:if test="${not empty restaurant.posterUrl}">
                <c:choose>
                    <c:when test="${fn:startsWith(restaurant.posterUrl, 'http')}">
                        <img src="${restaurant.posterUrl}"
                             class="img-fluid rounded-4 shadow-sm w-100"
                             style="object-fit:cover"
                             alt="${restaurant.name}">
                    </c:when>

                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/${restaurant.posterUrl}"
                             class="img-fluid rounded-4 shadow-sm w-100"
                             style="object-fit:cover"
                             alt="${restaurant.name}">
                    </c:otherwise>
                </c:choose>
            </c:if>
        </div>

        <!-- INFO -->
        <div class="col-md-7">
            <div class="card h-100 border-0 shadow-sm rounded-4">
                <div class="card-body d-flex flex-column p-4">

                    <h6 class="fw-semibold mb-2 text-uppercase text-secondary">
                        Thông tin quán
                    </h6>

                    <p class="text-muted mb-4" style="line-height:1.6">
                        Video giới thiệu và hình ảnh thực tế của quán ăn.
                        Bạn có thể chia sẻ quán này cho bạn bè hoặc quay lại danh sách để xem thêm quán khác.
                    </p>

                    <!-- ACTIONS -->
                    <div class="mt-auto d-flex align-items-center gap-3">

                        <a href="${pageContext.request.contextPath}/share/form?id=${restaurant.restaurantId}"
                           class="btn btn-outline-primary rounded-pill px-4">
                            <i class="bi bi-share me-1"></i> Chia sẻ
                        </a>

                        <a href="${pageContext.request.contextPath}/home"
                           class="btn btn-light rounded-pill px-4">
                            ← Quay lại
                        </a>

                    </div>

                </div>
            </div>
        </div>

    </div>

</div>
