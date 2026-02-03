<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu - Owl Review</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container">
    <div class="row justify-content-center align-items-center min-vh-100">

        <div class="col-md-5 col-lg-4">

            <div class="card border-0 shadow-sm rounded-4">

                <div class="card-body p-4">

                    <div class="text-center mb-4">
                        <h5 class="fw-bold mb-1">🔐 Đặt lại mật khẩu</h5>
                        <small class="text-muted">
                            Nhập mã OTP và mật khẩu mới
                        </small>
                    </div>

                    <form method="post"
                          action="<c:url value='/reset-password'/>">

                        <div class="mb-3">
                            <label class="form-label small text-muted">
                                Mã OTP
                            </label>
                            <input type="text"
                                   name="otp"
                                   class="form-control rounded-pill px-3"
                                   placeholder="Nhập mã OTP"
                                   required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label small text-muted">
                                Mật khẩu mới
                            </label>
                            <input type="password"
                                   name="password"
                                   class="form-control rounded-pill px-3"
                                   placeholder="••••••••"
                                   required>
                        </div>

                        <button class="btn btn-success rounded-pill w-100">
                            Xác nhận đổi mật khẩu
                        </button>
                    </form>

                    <c:if test="${not empty message}">
                        <div class="alert alert-danger mt-3 text-center small">
                                ${message}
                        </div>
                    </c:if>

                </div>

                <div class="card-footer bg-white border-0 text-center pb-4">
                    <a href="<c:url value='/login'/>"
                       class="text-decoration-none small">
                        ← Quay lại đăng nhập
                    </a>
                </div>

            </div>

        </div>

    </div>
</div>

</body>
</html>
