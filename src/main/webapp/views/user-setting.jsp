<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="container">

    <!-- TITLE -->
    <div class="mb-4">
        <h3 class="fw-semibold">Cài đặt tài khoản</h3>
        <p class="text-muted mb-0">
            Xin chào <strong>${sessionScope.authUser.username}</strong>
        </p>
    </div>

    <!-- MESSAGE -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
                ${error}
        </div>
    </c:if>

    <c:if test="${not empty message}">
        <div class="alert alert-success">
                ${message}
        </div>
    </c:if>

    <div class="row g-4">

        <!-- ===== ĐỔI MẬT KHẨU ===== -->
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-header fw-semibold">
                    Đổi mật khẩu
                </div>

                <div class="card-body">
                    <form method="post"
                          action="${pageContext.request.contextPath}/setting">

                        <input type="hidden" name="action" value="changePassword"/>

                        <div class="mb-3">
                            <label class="form-label">Mật khẩu cũ</label>
                            <input type="password"
                                   name="oldPassword"
                                   class="form-control"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Mật khẩu mới</label>
                            <input type="password"
                                   name="newPassword"
                                   class="form-control"
                                   required>
                        </div>

                        <button class="btn btn-primary">
                            Cập nhật mật khẩu
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- ===== CẬP NHẬT THÔNG TIN ===== -->
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-header fw-semibold">
                    Thông tin cá nhân
                </div>

                <div class="card-body">
                    <form method="post"
                          action="${pageContext.request.contextPath}/setting">

                        <input type="hidden" name="action" value="updateInfo"/>

                        <div class="mb-3">
                            <label class="form-label">Tên hiển thị</label>
                            <input type="text"
                                   name="username"
                                   class="form-control"
                                   value="${sessionScope.authUser.username}"
                                   required>
                        </div>

                        <button class="btn btn-success">
                            Lưu thay đổi
                        </button>
                    </form>
                </div>
            </div>
        </div>

    </div>

    <!-- LOGOUT -->
    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/setting?action=logout"
           class="btn btn-outline-danger btn-sm">
            Đăng xuất
        </a>
    </div>

</div>
