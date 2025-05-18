<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>User Profile</title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="assets/css/profile.css?v=1.1">
            <link rel="stylesheet" href="assets/css/header.css?v=5.1">
            <link rel="stylesheet" href="assets/css/footer.css?v=3">
        </head>

        <body>
            <jsp:include page="header.jsp" />
            <div class="container">
                <div class="profile-card">
                    <h2 class="title">Edit Profile</h2>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-error">
                            <c:out value="${errorMessage}" />
                        </div>
                    </c:if>

                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success">
                            <c:out value="${successMessage}" />
                        </div>
                    </c:if>

                    <form action="profile" method="post">
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" id="username" name="username" value="<c:out value=" ${user.username}" />"
                            readonly>
                            <small class="form-text">Username cannot be changed</small>
                        </div>

                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password"
                                placeholder="Leave blank to keep current password">
                            <small class="form-text">Enter new password or leave blank to keep current</small>
                        </div>

                        <div class="form-group">
                            <label for="name">Full Name</label>
                            <input type="text" id="name" name="name" value="<c:out value=" ${user.name}" />" required>
                        </div>

                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" value="<c:out value=" ${user.email}" />"
                            required>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <input type="text" id="phone" name="phone" value="<c:out value=" ${user.phone}" />"
                            required>
                        </div>

                        <div class="button-group">
                            <button type="submit" class="btn primary-btn">Update Profile</button>
                            <a href="profile" class="btn secondary-btn">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
            <jsp:include page="footer.jsp" />
        </body>

        </html>