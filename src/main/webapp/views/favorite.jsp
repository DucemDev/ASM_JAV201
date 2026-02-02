<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<h3 class="mb-4">️ Quán ăn đã yêu thích</h3>

<c:choose>
  <c:when test="${empty list}">
    <div class="alert alert-info">
      Bạn chưa yêu thích quán nào.
    </div>
  </c:when>

  <c:otherwise>
    <div class="row g-4">
      <c:forEach var="f" items="${list}">
        <div class="col-md-4">
          <div class="card h-100 shadow-sm">

            <img src="${pageContext.request.contextPath}/images/${f.restaurant.posterUrl}"
                 class="card-img-top"
                 style="height:160px; object-fit:cover">

            <div class="card-body">
              <h5 class="card-title">${f.restaurant.name}</h5>
              <p class="text-muted">
                👁 ${f.restaurant.viewCount} lượt xem
              </p>
            </div>

            <div class="card-footer text-center">
              <a href="${pageContext.request.contextPath}/restaurant/detail?id=${f.restaurant.restaurantId}"
                 class="btn btn-primary btn-sm">
                Xem lại
              </a>

              <a href="${pageContext.request.contextPath}/unlike?id=${f.restaurant.restaurantId}"
                 class="btn btn-outline-danger btn-sm ms-1">
                 Bỏ thích
              </a>
            </div>

          </div>
        </div>
      </c:forEach>
    </div>
  </c:otherwise>
</c:choose>
