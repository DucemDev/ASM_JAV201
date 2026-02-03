<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<h2 class="fw-bold mb-4">Quán ăn đã yêu thích</h2>

<c:choose>
    <c:when test="${empty list}">
        <div class="alert alert-light border text-center py-4">
            <i class="bi bi-heart text-danger fs-4"></i>
            <p class="mb-0 mt-2 text-muted">
                Bạn chưa yêu thích quán nào.
            </p>
        </div>
    </c:when>

    <c:otherwise>
        <div class="row g-4">

            <c:forEach var="f" items="${list}">
                <div class="col-lg-4 col-md-6">
                    <div class="card h-100 border-0 shadow-sm rounded-4 overflow-hidden">

                        <!-- IMAGE -->
                        <div class="ratio ratio-16x9 bg-light">
                            <img src="${pageContext.request.contextPath}/images/${f.restaurant.posterUrl}"
                                 class="img-fluid w-100"
                                 alt="${f.restaurant.name}"
                                 style="object-fit:cover;">
                        </div>

                        <!-- BODY -->
                        <div class="card-body">
                            <h5 class="fw-semibold mb-1 text-truncate">
                                ${f.restaurant.name}
                            </h5>

                            <small class="text-muted">
                                <i class="bi bi-eye"></i>
                                ${f.restaurant.viewCount} lượt xem
                            </small>
                        </div>

                        <!-- FOOTER -->
                        <div class="card-footer bg-white border-0 px-3 pb-3">
                            <div class="d-flex justify-content-between align-items-center">

                                <a href="${pageContext.request.contextPath}/restaurant/detail?id=${f.restaurant.restaurantId}"
                                   class="btn btn-outline-primary btn-sm rounded-pill px-3">
                                    Xem lại
                                </a>

                                <a href="${pageContext.request.contextPath}/unlike?id=${f.restaurant.restaurantId}"
                                   class="btn btn-outline-danger btn-sm rounded-pill px-3"
                                   title="Bỏ yêu thích">
                                    <i class="bi bi-heartbreak"></i>
                                </a>

                            </div>
                        </div>

                    </div>
                </div>
            </c:forEach>

        </div>
    </c:otherwise>
</c:choose>
