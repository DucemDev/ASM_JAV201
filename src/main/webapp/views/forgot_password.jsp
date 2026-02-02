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
    <div class="row justify-content-center mt-5">
        <div class="col-md-4">

            <div class="card shadow">
                <div class="card-header text-center fw-bold">
                    🦉 Quên mật khẩu
                </div>

                <div class="card-body">

                    <!-- FORM GỬI OTP -->
                    <form method="post"
                          action="<c:url value='/forgot-password'/>">

                        <div class="mb-3">
                            <label class="form-label">Email đã đăng ký</label>
                            <input type="email"
                                   name="email"
                                   class="form-control"
                                   placeholder="Nhập email của bạn"
                                   required>
                        </div>

                        <button class="btn btn-primary w-100">
                            Gửi mã OTP
                        </button>
                    </form>

                    <!-- MESSAGE -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-danger mt-3 text-center">
                                ${message}
                        </div>
                    </c:if>

                </div>

                <div class="card-footer text-center">
                    <a href="<c:url value='/login'/>"
                       class="text-decoration-none">
                        ← Quay lại đăng nhập
                    </a>
                </div>

            </div>

        </div>
    </div>
</div>

</body>
</html>
