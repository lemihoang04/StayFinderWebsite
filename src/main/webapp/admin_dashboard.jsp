<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Admin Dashboard - Room Finder</title>
            <!-- Font Awesome -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
            <!-- Custom CSS -->
            <link rel="stylesheet" href="assets/css/admin_sidebar.css">
            <link rel="stylesheet" href="assets/css/admin_dashboard.css">
        </head>

        <body>
            <div class="admin-container">
                <!-- Include Sidebar -->
                <jsp:include page="admin_sidebar.jsp" />

                <!-- Main Content -->
                <main class="main-content">
                    <div class="header">
                        <h1>Dashboard</h1>
                        <div class="user-info">
                            <span>Welcome, ${admin.username}</span>
                        </div>
                    </div>

                    <div class="dashboard-stats">
                        <div class="stat-grid">
                            <div class="stat-card primary">
                                <div class="stat-card-body">
                                    <i class="fas fa-users stat-icon"></i>
                                    <div class="stat-content">
                                        <h5>Total Users</h5>
                                        <h2>${userCount}</h2>
                                    </div>
                                </div>
                            </div>

                            <div class="stat-card success">
                                <div class="stat-card-body">
                                    <i class="fas fa-home stat-icon"></i>
                                    <div class="stat-content">
                                        <h5>Total Rooms</h5>
                                        <h2>${roomCount}</h2>
                                    </div>
                                </div>
                            </div>

<%--                             <div class="stat-card warning">
                                <div class="stat-card-body">
                                    <i class="fas fa-check-circle stat-icon"></i>
                                    <div class="stat-content">
                                        <h5>Active Listings</h5>
                                        <h2>${activeRoomCount}</h2>
                                    </div>
                                </div>
                            </div>

                            <div class="stat-card info">
                                <div class="stat-card-body">
                                    <i class="fas fa-eye stat-icon"></i>
                                    <div class="stat-content">
                                        <h5>Total Views</h5>
                                        <h2>${totalViews}</h2>
                                    </div>
                                </div>
                            </div> --%>
                        </div>
                    </div>

                    <div class="dashboard-recent">
                        <div class="card-grid">
                            <div class="dashboard-card">
                                <div class="card-header">
                                    <h5>Recent Users</h5>
                                </div>
                                <div class="card-body">
                                    <c:if test="${empty recentUsers}">
                                        <p>No recent users found.</p>
                                    </c:if>
                                    <c:if test="${not empty recentUsers}">
                                        <div class="table-container">
                                            <table class="data-table">
                                                <thead>
                                                    <tr>
                                                        <th>Username</th>
                                                        <th>Name</th>
                                                        <th>Email</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${recentUsers}" var="user">
                                                        <tr>
                                                            <td>${user.username}</td>
                                                            <td>${user.name}</td>
                                                            <td>${user.email}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                            <div class="dashboard-card">
                                <div class="card-header">
                                    <h5>Recent Rooms</h5>
                                </div>
                                <div class="card-body">
                                    <c:if test="${empty recentRooms}">
                                        <p>No recent rooms found.</p>
                                    </c:if>
                                    <c:if test="${not empty recentRooms}">
                                        <div class="table-container">
                                            <table class="data-table">
                                                <thead>
                                                    <tr>
                                                        <th>Title</th>
                                                        <th>Address</th>
                                                        <th>Price</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${recentRooms}" var="room">
                                                        <tr>
                                                            <td>${room.title}</td>
                                                            <td>${room.address}</td>
                                                            <td>${room.price}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </body>

        </html>