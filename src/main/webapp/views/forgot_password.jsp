<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Quên mật khẩu - Owl Review</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">

<div class="container">
    <div class="row justify-content-center align-items-center min-vh-100">

        <div class="col-md-4">

            <div class="card border-0 shadow-sm rounded-4">

                <div class="card-body p-4">

                    <div class="text-center mb-4">
                        <h5 class="fw-bold mb-1">🦉 Quên mật khẩu</h5>
                        <small class="text-muted">
                            Nhập email để nhận mã OTP
                        </small>
                    </div>

                    <form method="post"
                          action="<c:url value='/forgot-password'/>">

                        <div class="mb-4">
                            <label class="form-label small text-muted">
                                Email đã đăng ký
                            </label>
                            <input type="email"
                                   name="email"
                                   class="form-control rounded-pill px-3"
                                   placeholder="you@email.com"
                                   required>
                        </div>

                        <button class="btn btn-primary rounded-pill w-100">
                            Gửi mã OTP
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
