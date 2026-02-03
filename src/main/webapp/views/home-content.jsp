<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
      rel="stylesheet">

<h2 class="mb-4 fw-semibold">Danh sách quán ăn</h2>

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
                    <div class="card h-100 border-0 shadow-sm rounded-4 overflow-hidden">

                        <!-- IMAGE -->
                        <div class="ratio ratio-16x9 bg-light">
                            <img src="${r.posterUrl}"
                                 class="img-fluid w-100"
                                 alt="${r.name}"
                                 style="object-fit: cover;">
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
                            <div class="d-flex align-items-center justify-content-between">

                                <!-- LEFT: VIEW DETAIL -->
                                <a href="${pageContext.request.contextPath}/restaurant/detail?id=${r.restaurantId}"
                                   class="btn btn-primary btn-sm px-3 rounded-pill">
                                    Xem chi tiết
                                </a>

                                <!-- RIGHT: ICON ACTIONS -->
                                <div class="d-flex align-items-center gap-3">

                                    <!-- HEART -->
                                    <c:set var="liked" value="${likedMap[r.restaurantId]}" />

                                    <a href="${pageContext.request.contextPath}/${liked ? 'unlike' : 'like'}?id=${r.restaurantId}"
                                       class="fs-5"
                                       title="${liked ? 'Bỏ yêu thích' : 'Yêu thích'}"
                                       style="text-decoration:none;">

                                        <i class="bi ${liked ? 'bi-heart-fill text-danger' : 'bi-heart text-muted'}"></i>

                                    </a>


                                    <!-- SHARE -->
                                    <a href="${pageContext.request.contextPath}/share/form?id=${r.restaurantId}"
                                       class="text-muted fs-5"
                                       title="Chia sẻ"
                                       style="text-decoration:none;">
                                        <i class="bi bi-share"></i>
                                    </a>

                                </div>

                            </div>
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
