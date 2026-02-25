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

            <c:forEach var="f" items="${list}">
                <c:set var="r" value="${f.restaurant}" />

                <div class="col-lg-4 col-md-6">
                    <div class="card h-100 border-0 shadow-sm rounded-4 overflow-hidden">

                        <!-- POSTER -->
                        <div class="ratio ratio-16x9 bg-light">
                            <img src="${r.posterUrl}"
                                 class="img-fluid w-100"
                                 alt="${r.name}"
                                 style="object-fit:cover;">
                        </div>

                        <!-- BODY -->
                        <div class="card-body">
                            <h5 class="fw-semibold mb-1 text-truncate">
                                    ${r.name}
                            </h5>

                            <small class="text-muted">
                                    ${r.viewCount} lượt xem
                            </small>
                        </div>

                        <!-- FOOTER -->
                        <div class="card-footer bg-white border-0 px-3 pb-3">
                            <div class="d-flex justify-content-between align-items-center">

                                <a href="${pageContext.request.contextPath}/restaurant/detail?id=${r.restaurantId}"
                                   class="btn btn-primary btn-sm rounded-pill px-3">
                                    Xem lại
                                </a>

                                <a href="${pageContext.request.contextPath}/unlike?id=${r.restaurantId}"
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
