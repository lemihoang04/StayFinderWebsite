<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <header>
            <div class="container">
                <div class="header-top">
                    <div class="logo">
                        <a href="index.jsp">
                            <span class="logo-text">Stay<span class="highlight">Finder</span></span>
                        </a>
                    </div>

                    <div class="header-actions">
                        <div class="contact-info">
                            <span><i class="fas fa-phone"></i> +84 123 456 789</span>
                        </div>
                        <div class="user-actions">
                            <a href="add-room" class="btn btn-post">Đăng tin</a>

                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <div class="user-dropdown">
                                        <button class="btn btn-profile dropdown-toggle">
                                            <i class="fas fa-user-circle"></i> ${sessionScope.user.name}
                                        </button>
                                        <div class="dropdown-menu">
                                            <a href="profile"><i class="fas fa-user"></i> Tài khoản</a>
                                            <a href="my-rooms"><i class="fas fa-list-alt"></i> Tin đã đăng</a>
                                            <a href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <a href="login" class="btn btn-login">Đăng nhập</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <nav class="main-nav">
                    <ul>
                        <li><a href="index.jsp" class="active">Trang chủ</a></li>
                        <li><a href="rooms">Tìm phòng trọ</a></li>
                        <li><a href="#">Liên hệ</a></li>
                    </ul>
                </nav>
            </div>
        </header>