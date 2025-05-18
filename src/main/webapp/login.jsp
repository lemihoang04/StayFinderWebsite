<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng nhập - StayFinder</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/header.css?v=1.0">
        <link rel="stylesheet" href="assets/css/footer.css">
        <link rel="stylesheet" href="assets/css/login.css">
        <style>
            .message {
                padding: 10px;
                margin-bottom: 15px;
                border-radius: 4px;
            }

            .error-message {
                background-color: #ffdddd;
                border-left: 6px solid #f44336;
                color: #8B0000;
            }

            .success-message {
                background-color: #ddffdd;
                border-left: 6px solid #4CAF50;
                color: #006400;
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <main>
            <div class="login-container">
                <div class="login-card">
                    <div class="login-header">
                        <h2>Đăng nhập</h2>
                        <p>Chào mừng bạn quay trở lại với StayFinder</p>
                    </div>

                    <!-- Display error or success messages if available -->
                    <% if(request.getAttribute("errorMessage") !=null) { %>
                        <div class="message error-message">
                            <i class="fas fa-exclamation-circle"></i>
                            <%= request.getAttribute("errorMessage") %>
                        </div>
                        <% } %>

                            <% if(request.getAttribute("successMessage") !=null) { %>
                                <div class="message success-message">
                                    <i class="fas fa-check-circle"></i>
                                    <%= request.getAttribute("successMessage") %>
                                </div>
                                <% } %>

                                    <form class="login-form" action="login" method="post">
                                        <div class="form-group">
                                            <label for="username"><i class="fas fa-user"></i> Tên đăng nhập</label>
                                            <input type="text" id="username" name="username"
                                                placeholder="Nhập tên đăng nhập" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="password"><i class="fas fa-lock"></i> Mật khẩu</label>
                                            <input type="password" id="password" name="password"
                                                placeholder="Nhập mật khẩu" required>
                                            <span class="password-toggle" onclick="togglePassword()">
                                                <i class="far fa-eye"></i>
                                            </span>
                                        </div>

                                        <div class="form-options">
                                            <div class="remember-me">
                                                <input type="checkbox" id="remember" name="remember">
                                                <label for="remember">Ghi nhớ đăng nhập</label>
                                            </div>
                                            <a href="#" class="forgot-password">Quên mật khẩu?</a>
                                        </div>

                                        <button type="submit" class="btn-login">Đăng nhập</button>

                                        <div class="social-login">
                                            <p>Hoặc đăng nhập với</p>
                                            <div class="social-buttons">
                                                <a href="#" class="social-btn facebook">
                                                    <i class="fab fa-facebook-f"></i>
                                                </a>
                                                <a href="#" class="social-btn google">
                                                    <i class="fab fa-google"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </form>

                                    <div class="register-link">
                                        <p>Bạn chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a></p>
                                    </div>
                </div>
            </div>
        </main>

        <jsp:include page="footer.jsp" />

        <script>
            function togglePassword() {
                const passwordField = document.getElementById("password");
                const icon = document.querySelector(".password-toggle i");

                if (passwordField.type === "password") {
                    passwordField.type = "text";
                    icon.classList.remove("fa-eye");
                    icon.classList.add("fa-eye-slash");
                } else {
                    passwordField.type = "password";
                    icon.classList.remove("fa-eye-slash");
                    icon.classList.add("fa-eye");
                }
            }
        </script>
    </body>

    </html>