<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng ký - StayFinder</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/header.css">
        <link rel="stylesheet" href="assets/css/footer.css">
        <link rel="stylesheet" href="assets/css/register.css">
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <main>
            <div class="register-container">
                <div class="register-card">
                    <div class="register-header">
                        <h2>Đăng ký tài khoản</h2>
                        <p>Tạo tài khoản để sử dụng đầy đủ tính năng của StayFinder</p>
                    </div>

                    <form class="register-form" action="register" method="post" id="registrationForm">
                        <div class="form-group">
                            <label for="username"><i class="fas fa-user"></i> Tên đăng nhập <span
                                    class="required">*</span></label>
                            <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập" required>
                            <small class="form-text">Tên đăng nhập từ 5-20 ký tự, không chứa ký tự đặc biệt</small>
                        </div>

                        <div class="form-group">
                            <label for="email"><i class="fas fa-envelope"></i> Email <span
                                    class="required">*</span></label>
                            <input type="email" id="email" name="email" placeholder="Nhập địa chỉ email" required>
                        </div>

                        <div class="form-group">
                            <label for="phone"><i class="fas fa-phone"></i> Số điện thoại <span
                                    class="required">*</span></label>
                            <input type="tel" id="phone" name="phone" placeholder="Nhập số điện thoại" required>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="password"><i class="fas fa-lock"></i> Mật khẩu <span
                                        class="required">*</span></label>
                                <input type="password" id="password" name="password" placeholder="Nhập mật khẩu"
                                    required>
                                <span class="password-toggle" onclick="togglePassword('password')">
                                    <i class="far fa-eye"></i>
                                </span>
                                <small class="form-text">Mật khẩu ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và
                                    số</small>
                            </div>

                            <div class="form-group">
                                <label for="confirmPassword"><i class="fas fa-lock"></i> Nhập lại mật khẩu <span
                                        class="required">*</span></label>
                                <input type="password" id="confirmPassword" name="confirmPassword"
                                    placeholder="Nhập lại mật khẩu" required>
                                <span class="password-toggle" onclick="togglePassword('confirmPassword')">
                                    <i class="far fa-eye"></i>
                                </span>
                            </div>
                        </div>

                        <div class="form-group terms">
                            <input type="checkbox" id="agree" name="agree" required>
                            <label for="agree">Tôi đồng ý với <a href="#">Điều khoản dịch vụ</a> và <a href="#">Chính
                                    sách bảo mật</a></label>
                        </div>

                        <button type="submit" class="btn-register">Đăng ký</button>

                        <div class="social-register">
                            <p>Hoặc đăng ký với</p>
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

                    <div class="login-link">
                        <p>Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a></p>
                    </div>
                </div>
            </div>
        </main>

        <jsp:include page="footer.jsp" />

        <script>
            function togglePassword(fieldId) {
                const passwordField = document.getElementById(fieldId);
                const icon = document.querySelector(`#${fieldId} + .password-toggle i`);

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

            document.getElementById('registrationForm').addEventListener('submit', function (e) {
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;

                if (password !== confirmPassword) {
                    e.preventDefault();
                    alert('Mật khẩu và xác nhận mật khẩu không khớp!');
                }
            });
        </script>
    </body>

    </html>