<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<h3 class="mb-4">Danh sách quán ăn</h3>

<c:choose>
    <c:when test="${empty list}">
        <div class="alert alert-warning">
            Không có dữ liệu quán ăn.
        </div>
    </c:when>

    <c:otherwise>
        <div class="row g-4">
            <c:forEach var="r" items="${list}">
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm border-0">

                        <!-- IMAGE -->
                        <img src="${pageContext.request.contextPath}/images/${r.posterUrl}"
                             class="card-img-top"
                             alt="${r.name}"
                             style="height:180px; object-fit:cover;">

                        <!-- BODY -->
                        <div class="card-body">
                            <h5 class="card-title fw-semibold">
                                    ${r.name}
                            </h5>

                            <p class="text-muted mb-2">
                                Lượt xem: ${r.viewCount}
                            </p>
                        </div>

                        <!-- ACTIONS -->
                        <div class="card-footer bg-white border-0 text-center">
                            <a href="${pageContext.request.contextPath}/restaurant/detail?id=${r.restaurantId}"
                               class="btn btn-primary btn-sm me-1">
                                Xem chi tiết
                            </a>

                            <a href="${pageContext.request.contextPath}/like?id=${r.restaurantId}"
                               class="btn btn-outline-danger btn-sm me-1">
                                Yêu thích
                            </a>

                            <a href="${pageContext.request.contextPath}/share?id=${r.restaurantId}"
                               class="btn btn-outline-secondary btn-sm">
                                Chia sẻ
                            </a>
                        </div>

                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>
