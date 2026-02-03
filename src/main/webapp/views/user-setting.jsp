<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<h2 class="fw-bold mb-1">Cài đặt tài khoản</h2>
<p class="text-muted mb-4">
    Xin chào <strong>${sessionScope.authUser.username}</strong>
</p>

<!-- MESSAGE -->
<c:if test="${not empty error}">
    <div class="alert alert-danger d-flex align-items-center gap-2">
        <i class="bi bi-exclamation-triangle-fill"></i>
        <span>${error}</span>
    </div>
</c:if>

<c:if test="${not empty message}">
    <div class="alert alert-success d-flex align-items-center gap-2">
        <i class="bi bi-check-circle-fill"></i>
        <span>${message}</span>
    </div>
</c:if>

<div class="row g-4">

    <!-- ===== CHANGE PASSWORD ===== -->
    <div class="col-lg-6">
        <div class="card border-0 shadow-sm rounded-4 h-100">
            <div class="card-body p-4">

                <h5 class="fw-semibold mb-3">
                    <i class="bi bi-shield-lock me-1"></i>
                    Đổi mật khẩu
                </h5>

                <form method="post"
                      action="${pageContext.request.contextPath}/setting">

                    <input type="hidden" name="action" value="changePassword"/>

                    <div class="mb-3">
                        <label class="form-label small text-muted">
                            Mật khẩu cũ
                        </label>
                        <input type="password"
                               name="oldPassword"
                               class="form-control rounded-pill px-3"
                               required>
                    </div>

                    <div class="mb-4">
                        <label class="form-label small text-muted">
                            Mật khẩu mới
                        </label>
                        <input type="password"
                               name="newPassword"
                               class="form-control rounded-pill px-3"
                               required>
                    </div>

                    <button class="btn btn-primary rounded-pill px-4">
                        Cập nhật mật khẩu
                    </button>
                </form>

            </div>
        </div>
    </div>

    <!-- ===== UPDATE PROFILE ===== -->
    <div class="col-lg-6">
        <div class="card border-0 shadow-sm rounded-4 h-100">
            <div class="card-body p-4">

                <h5 class="fw-semibold mb-3">
                    <i class="bi bi-person-circle me-1"></i>
                    Thông tin cá nhân
                </h5>

                <form method="post"
                      action="${pageContext.request.contextPath}/setting">

                    <input type="hidden" name="action" value="updateInfo"/>

                    <div class="mb-4">
                        <label class="form-label small text-muted">
                            Tên hiển thị
                        </label>
                        <input type="text"
                               name="username"
                               class="form-control rounded-pill px-3"
                               value="${sessionScope.authUser.username}"
                               required>
                    </div>

                    <button class="btn btn-success rounded-pill px-4">
                        Lưu thay đổi
                    </button>
                </form>

            </div>
        </div>
    </div>

</div>

<!-- LOGOUT -->
<div class="mt-5 pt-3 border-top text-center">
    <a href="${pageContext.request.contextPath}/setting?action=logout"
       class="btn btn-outline-danger rounded-pill px-4">
        <i class="bi bi-box-arrow-right me-1"></i>
        Đăng xuất
    </a>
</div>
