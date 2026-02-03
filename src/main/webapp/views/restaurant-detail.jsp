<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="container">

    <!-- NAME -->
    <h2 class="fw-bold mb-2">
        ${restaurant.name}
    </h2>

    <p class="text-muted">
        👁️ Lượt xem: ${restaurant.viewCount}
    </p>

    <!-- POSTER -->
    <c:if test="${not empty restaurant.posterUrl}">
        <c:choose>
            <!-- LINK NGOÀI -->
            <c:when test="${restaurant.posterUrl.startsWith('http')}">
                <img src="${restaurant.posterUrl}"
                     class="img-fluid rounded mb-4"
                     style="max-height:400px; object-fit:cover;">
            </c:when>

            <!-- LINK TRONG PROJECT -->
            <c:otherwise>
                <img src="${pageContext.request.contextPath}/${restaurant.posterUrl}"
                     class="img-fluid rounded mb-4"
                     style="max-height:400px; object-fit:cover;">
            </c:otherwise>
        </c:choose>
    </c:if>




    <!-- VIDEO -->
    <c:if test="${not empty restaurant.videoUrl}">
        <div class="ratio ratio-16x9 mb-4">
            <iframe src="${restaurant.videoUrl}"
                    title="Restaurant video"
                    allowfullscreen>
            </iframe>
        </div>
    </c:if>

    <!-- ACTIONS -->
    <div class="d-flex gap-2">

        <a href="${pageContext.request.contextPath}/like?id=${restaurant.restaurantId}"
           class="btn btn-outline-danger">
            ❤️ Yêu thích
        </a>

        <a href="${pageContext.request.contextPath}/share?id=${restaurant.restaurantId}"
           class="btn btn-outline-secondary">
            📤 Chia sẻ
        </a>

        <a href="${pageContext.request.contextPath}/home"
           class="btn btn-secondary">
            ⬅ Quay lại
        </a>

    </div>

</div>
