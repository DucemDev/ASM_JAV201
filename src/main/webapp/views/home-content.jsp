<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<h3 class="mb-4 fw-semibold">Danh sách quán ăn</h3>

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
                    <div class="card h-100 shadow-sm border-0">

                        <!-- IMAGE -->
                        <img src="${pageContext.request.contextPath}/images/${r.posterUrl}"
                             class="card-img-top"
                             alt="${r.name}"
                             style="height:180px; object-fit:cover;">

                        <!-- BODY -->
                        <div class="card-body">
                            <h5 class="card-title fw-semibold mb-2">
                                    ${r.name}
                            </h5>

                            <p class="text-muted mb-0">
                                Lượt xem: ${r.viewCount}
                            </p>
                        </div>

                        <!-- FOOTER -->
                        <div class="card-footer bg-white border-0 text-center pb-3">

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

        <!-- PAGINATION -->
        <nav class="mt-5">
            <ul class="pagination justify-content-center">

                <c:if test="${page > 1}">
                    <li class="page-item">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/home?page=${page - 1}">
                            Trước
                        </a>
                    </li>
                </c:if>

                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${i == page ? 'active' : ''}">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/home?page=${i}">
                                ${i}
                        </a>
                    </li>
                </c:forEach>

                <c:if test="${page < totalPages}">
                    <li class="page-item">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/home?page=${page + 1}">
                            Sau
                        </a>
                    </li>
                </c:if>

            </ul>
        </nav>
    </c:otherwise>
</c:choose>
