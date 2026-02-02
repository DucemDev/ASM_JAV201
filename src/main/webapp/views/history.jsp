<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<h3 class="mb-4">Quán đã xem gần đây</h3>

<c:choose>
  <c:when test="${empty list}">
    <div class="alert alert-info">
      Bạn chưa xem quán nào.
    </div>
  </c:when>

  <c:otherwise>
    <div class="row g-4">
      <c:forEach var="h" items="${list}">
        <div class="col-md-4">
          <div class="card h-100 shadow-sm border-0">

            <!-- POSTER -->
            <img src="${pageContext.request.contextPath}/images/${h.restaurant.posterUrl}"
                 class="card-img-top"
                 alt="${h.restaurant.name}"
                 style="height:180px; object-fit:cover;">

            <!-- BODY -->
            <div class="card-body">
              <h5 class="card-title fw-semibold">
                  ${h.restaurant.name}
              </h5>

              <p class="text-muted mb-1">
                Lượt xem: ${h.restaurant.viewCount}
              </p>

              <p class="text-muted mb-0">
                Ngày xem: ${h.viewedAtFormatted}
              </p>
            </div>

            <!-- ACTION -->
            <div class="card-footer bg-white text-center border-0">
              <a href="${pageContext.request.contextPath}/restaurant/detail?id=${h.restaurant.restaurantId}"
                 class="btn btn-outline-primary btn-sm">
                Xem lại
              </a>
            </div>

          </div>
        </div>
      </c:forEach>
    </div>
  </c:otherwise>
</c:choose>
