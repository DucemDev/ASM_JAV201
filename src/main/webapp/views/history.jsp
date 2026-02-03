<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<h2 class="fw-bold mb-4">Quán đã xem gần đây</h2>

<c:choose>
    <c:when test="${empty list}">
        <div class="alert alert-light border text-center py-4">
            <i class="bi bi-clock-history fs-4 text-secondary"></i>
            <p class="mb-0 mt-2 text-muted">
                Bạn chưa xem quán nào gần đây.
            </p>
        </div>
    </c:when>

    <c:otherwise>
        <div class="row g-4">

            <c:forEach var="h" items="${list}">
                <div class="col-lg-4 col-md-6">
                    <div class="card h-100 border-0 shadow-sm rounded-4 overflow-hidden">

                        <!-- IMAGE -->
                        <div class="ratio ratio-16x9 bg-light">
                            <img src="${pageContext.request.contextPath}/images/${h.restaurant.posterUrl}"
                                 class="img-fluid w-100"
                                 alt="${h.restaurant.name}"
                                 style="object-fit: cover;">
                        </div>

                        <!-- BODY -->
                        <div class="card-body">
                            <h5 class="fw-semibold mb-1 text-truncate">
                                ${h.restaurant.name}
                            </h5>

                            <div class="d-flex flex-column gap-1">
                                <small class="text-muted">
                                    <i class="bi bi-eye"></i>
                                    ${h.restaurant.viewCount} lượt xem
                                </small>


                            </div>
                        </div>

                        <!-- FOOTER -->
                        <div class="card-footer bg-white border-0 px-3 pb-3">
                            <a href="${pageContext.request.contextPath}/restaurant/detail?id=${h.restaurant.restaurantId}"
                               class="btn btn-outline-primary btn-sm rounded-pill px-3">
                                Xem lại
                            </a>
                        </div>

                    </div>
                </div>
            </c:forEach>

        </div>
    </c:otherwise>
</c:choose>
