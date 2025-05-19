<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Admin Login - Room Finder</title>
            <!-- Font Awesome -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
            <!-- Custom CSS -->
            <link rel="stylesheet" href="assets/css/login_admin.css">
        </head>

        <body>
            <div class="login-container">
                <div class="login-card">
                    <div class="login-header">
                        <h2>Admin Login</h2>
                        <p>Enter your credentials to access admin dashboard</p>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="error-message">
                            <i class="fas fa-exclamation-circle"></i>
                            <span>${errorMessage}</span>
                        </div>
                    </c:if>

                    <form action="admin_login" method="post" class="login-form">
                        <div class="form-group">
                            <label for="username"><i class="fas fa-user"></i> Username</label>
                            <input type="text" id="username" name="username" placeholder="Enter your username" required>
                        </div>

                        <div class="form-group">
                            <label for="password"><i class="fas fa-lock"></i> Password</label>
                            <input type="password" id="password" name="password" placeholder="Enter your password"
                                required>
                        </div>

                        <div class="form-group">
                            <button type="submit" class="login-btn">
                                <i class="fas fa-sign-in-alt"></i> Login
                            </button>
                        </div>
                    </form>

                    <div class="back-to-home">
                        <a href="index.jsp"><i class="fas fa-home"></i> Back to Home</a>
                    </div>
                </div>
            </div>
        </body>

        </html>