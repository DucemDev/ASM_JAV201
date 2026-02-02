<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Owl Review - Authentication</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        .auth-card {
            transition: all 0.3s ease;
        }
    </style>
</head>
<body class="bg-light">

<div class="container">
    <div class="row justify-content-center mt-5">
        <div class="col-md-4">

            <div class="card shadow auth-card">
                <div class="card-header text-center fw-bold">
                    🦉 <span id="formTitle">Đăng nhập</span>
                </div>

                <div class="card-body">

                    <!-- LOGIN FORM -->
                    <form id="loginForm"
                          method="post"
                          action="<c:url value='/login'/>">

                        <div class="mb-3">
                            <label>Email</label>
                            <input type="email" name="emailip"
                                   class="form-control"
                                   placeholder="Nhập email" required>
                        </div>

                        <div class="mb-3">
                            <label>Mật khẩu</label>
                            <input type="password" name="passwordip"
                                   class="form-control"
                                   placeholder="Nhập mật khẩu" required>
                        </div>

                        <button class="btn btn-primary w-100">
                            Đăng nhập
                        </button>
                        <div class="text-center mt-3">
                            <a href="<c:url value='/forgot-password'/>"
                               class="text-decoration-none">
                                Quên mật khẩu?
                            </a>

                        </div>

                    </form>

                    <!-- REGISTER FORM -->
                    <form id="registerForm"
                          method="post"
                          action="<c:url value='/register'/>"
                          style="display:none">

                        <div class="mb-3">
                            <label>Email</label>
                            <input type="email" name="emailip"
                                   class="form-control"
                                   placeholder="Nhập email" required>
                        </div>

                        <div class="mb-3">
                            <label>Tên hiển thị</label>
                            <input type="text" name="usernameip"
                                   class="form-control"
                                   placeholder="Nhập tên tài khoản của bạn" required>
                        </div>

                        <div class="mb-3">
                            <label>Mật khẩu</label>
                            <input type="password" name="passwordip"
                                   class="form-control"
                                   placeholder="Tạo mật khẩu" required>
                        </div>

                        <button class="btn btn-success w-100">
                            Tạo tài khoản
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
                    <small id="switchText">
                        Chưa có tài khoản?
                        <a href="#" onclick="showRegister()">Tạo tài khoản</a>
                    </small>
                </div>

            </div>

        </div>
    </div>
</div>

<script>
    function showRegister() {
        document.getElementById("loginForm").style.display = "none";
        document.getElementById("registerForm").style.display = "block";
        document.getElementById("formTitle").innerText = "Đăng ký";
        document.getElementById("switchText").innerHTML =
            'Đã có tài khoản? <a href="#" onclick="showLogin()">Đăng nhập</a>';
    }

    function showLogin() {
        document.getElementById("registerForm").style.display = "none";
        document.getElementById("loginForm").style.display = "block";
        document.getElementById("formTitle").innerText = "Đăng nhập";
        document.getElementById("switchText").innerHTML =
            'Chưa có tài khoản? <a href="#" onclick="showRegister()">Tạo tài khoản</a>';
    }
</script>
<c:if test="${showRegister}">
    <script>
        showRegister();
    </script>
</c:if>

</body>
</html>
