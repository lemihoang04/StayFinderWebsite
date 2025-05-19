<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <div class="sidebar">
            <div class="logo-container">
                <h2>Admin Panel</h2>
            </div>
            <div class="divider"></div>
            <nav class="sidebar-menu">
                <ul>
                    <li class="menu-item">
                        <a href="admin_dashboard">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="menu-item">
                        <a href="admin_users">
                            <i class="fas fa-users"></i>
                            <span>User Manager</span>
                        </a>
                    </li>
                    <li class="menu-item">
                        <a href="admin_rooms">
                            <i class="fas fa-home"></i>
                            <span>Room Manager</span>
                        </a>
                    </li>
                    <li class="divider"></li>
                    <li class="menu-item">
                        <a href="admin_logout">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>