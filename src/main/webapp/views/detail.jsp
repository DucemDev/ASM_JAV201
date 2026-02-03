<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<div class="container">

    <!-- TITLE -->
    <div class="mb-4">
        <h2 class="fw-bold">${restaurant.name}</h2>
        <p class="text-muted mb-0">
            👁️ Lượt xem: ${restaurant.viewCount}
        </p>
    </div>

    <!-- VIDEO -->
    <c:if test="${not empty restaurant.videoUrl}">
        <div class="ratio ratio-16x9 mb-4 shadow-sm rounded overflow-hidden">
            <iframe
                    src="${restaurant.videoUrl}"
                    title="${restaurant.name}"
                    allowfullscreen>
            </iframe>
        </div>
    </c:if>

    <div class="row g-4">

        <!-- POSTER -->
        <div class="col-md-4">
            <c:if test="${not empty restaurant.posterUrl}">
                <c:choose>
                    <c:when test="${fn:startsWith(restaurant.posterUrl, 'http')}">
                        <img src="${restaurant.posterUrl}"
                             class="img-fluid rounded shadow-sm w-100"
                             alt="${restaurant.name}">
                    </c:when>

                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/${restaurant.posterUrl}"
                             class="img-fluid rounded shadow-sm w-100"
                             alt="${restaurant.name}">
                    </c:otherwise>
                </c:choose>
            </c:if>
        </div>

        <!-- INFO -->
        <div class="col-md-8">
            <div class="card h-100 shadow-sm border-0">
                <div class="card-body d-flex flex-column">

                    <h5 class="fw-semibold mb-3">Thông tin quán</h5>

                    <p class="text-muted mb-4">
                        Video giới thiệu và hình ảnh thực tế của quán ăn.
                        Bạn có thể chia sẻ quán này cho bạn bè hoặc quay lại danh sách.
                    </p>

                    <div class="mt-auto">
                        <a href="${pageContext.request.contextPath}/share/form?id=${r.restaurantId}"
                           class="btn btn-primary">
                            📤 Share
                        </a>


                        <a href="${pageContext.request.contextPath}/home"
                           class="btn btn-secondary">
                            ⬅ Quay lại
                        </a>
                    </div>

                </div>
            </div>
        </div>

    </div>

</div>
