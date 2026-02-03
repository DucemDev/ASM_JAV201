<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Owl Review</title>

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
                        <h4 class="fw-bold text-warning mb-1">🦉 Owl Review</h4>
                        <small class="text-muted" id="formTitle">
                            Đăng nhập tài khoản
                        </small>
                    </div>

                    <!-- LOGIN -->
                    <form id="loginForm"
                          method="post"
                          action="<c:url value='/login'/>">

                        <div class="mb-3">
                            <label class="form-label small text-muted">
                                Email
                            </label>
                            <input type="email"
                                   name="emailip"
                                   class="form-control rounded-pill px-3"
                                   placeholder="you@email.com"
                                   required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label small text-muted">
                                Mật khẩu
                            </label>
                            <input type="password"
                                   name="passwordip"
                                   class="form-control rounded-pill px-3"
                                   placeholder="••••••••"
                                   required>
                        </div>

                        <button class="btn btn-primary rounded-pill w-100 mb-3">
                            Đăng nhập
                        </button>

                        <div class="text-center">
                            <a href="<c:url value='/forgot-password'/>"
                               class="small text-decoration-none">
                                Quên mật khẩu?
                            </a>
                        </div>

                    </form>

                    <!-- REGISTER -->
                    <form id="registerForm"
                          method="post"
                          action="<c:url value='/register'/>"
                          style="display:none">

                        <div class="mb-3">
                            <label class="form-label small text-muted">
                                Email
                            </label>
                            <input type="email"
                                   name="emailip"
                                   class="form-control rounded-pill px-3"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small text-muted">
                                Tên hiển thị
                            </label>
                            <input type="text"
                                   name="usernameip"
                                   class="form-control rounded-pill px-3"
                                   required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label small text-muted">
                                Mật khẩu
                            </label>
                            <input type="password"
                                   name="passwordip"
                                   class="form-control rounded-pill px-3"
                                   required>
                        </div>

                        <button class="btn btn-success rounded-pill w-100">
                            Tạo tài khoản
                        </button>

                    </form>

                    <!-- MESSAGE -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-danger mt-3 text-center small">
                                ${message}
                        </div>
                    </c:if>

                </div>

                <div class="card-footer bg-white border-0 text-center pb-4">

                    <a href="${pageContext.request.contextPath}/home"
                       class="btn btn-outline-secondary btn-sm rounded-pill px-3 mb-2">
                        ⬅️ Quay về trang chủ
                    </a>

                    <div class="small text-muted" id="switchText">
                        Chưa có tài khoản?
                        <a href="#" onclick="showRegister()">Tạo tài khoản</a>
                    </div>

                </div>

            </div>

        </div>

    </div>
</div>

<script>
    function showRegister() {
        loginForm.style.display = "none";
        registerForm.style.display = "block";
        formTitle.innerText = "Đăng ký tài khoản";
        switchText.innerHTML =
            'Đã có tài khoản? <a href="#" onclick="showLogin()">Đăng nhập</a>';
    }

    function showLogin() {
        registerForm.style.display = "none";
        loginForm.style.display = "block";
        formTitle.innerText = "Đăng nhập tài khoản";
        switchText.innerHTML =
            'Chưa có tài khoản? <a href="#" onclick="showRegister()">Tạo tài khoản</a>';
    }
</script>

<c:if test="${showRegister}">
    <script>showRegister();</script>
</c:if>

</body>
</html>
