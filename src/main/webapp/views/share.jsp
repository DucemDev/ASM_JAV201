<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="container mt-4">

    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">

            <div class="card border-0 shadow-sm rounded-4">

                <div class="card-body p-4">

                    <h5 class="fw-semibold mb-1">
                        📤 Chia sẻ quán ăn
                    </h5>
                    <p class="text-muted small mb-4">
                        Gửi link quán ăn cho bạn bè qua email
                    </p>

                    <form method="post"
                          action="<c:url value='/share-send' />">

                        <input type="hidden"
                               name="restaurantId"
                               value="${param.id}" />

                        <div class="mb-4">
                            <label class="form-label small text-muted">
                                Email người nhận
                            </label>
                            <input type="email"
                                   name="email"
                                   class="form-control rounded-pill px-3"
                                   placeholder="example@email.com"
                                   required />
                        </div>

                        <div class="d-flex gap-2">
                            <button class="btn btn-primary rounded-pill px-4 flex-fill">
                                Gửi chia sẻ
                            </button>

                            <a href="${pageContext.request.contextPath}/home"
                               class="btn btn-outline-secondary rounded-pill px-4">
                                Hủy
                            </a>
                        </div>

                    </form>

                </div>

            </div>

        </div>
    </div>

</div>
