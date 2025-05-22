<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <header>
            <div class="header-container">
                <div class="header-top">
                    <div class="header-logo">
                        <a href="index.jsp">
                            <span class="header-logo-text">Stay<span class="header-highlight">Finder</span></span>
                        </a>
                    </div>

                    <div class="header-actions">
                        <div class="header-contact-info">
                            <span><i class="fas fa-phone"></i> 0825700246</span>
                        </div>
                        <div class="header-user-actions">
                            <a href="add-room" class="header-btn header-btn-post">Đăng tin</a>

                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <div class="header-user-dropdown">
                                        <button class="header-btn header-dropdown-toggle">
                                            <i class="fas fa-user-circle"></i> ${sessionScope.user.name}
                                        </button>
                                        <div class="header-dropdown-menu">
                                            <a href="profile"><i class="fas fa-user"></i> Tài khoản</a>
                                            <a href="my-rooms"><i class="fas fa-list-alt"></i> Tin đã đăng</a>
                                            <a href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <a href="login" class="header-btn header-btn-login">Đăng nhập</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <nav class="header-main-nav">
                    <ul>
                        <li><a href="home">Trang chủ</a></li>
                        <li><a href="rooms">Tìm phòng trọ</a></li>
                        <!-- <li><a href="#">Liên hệ</a></li> -->
                    </ul>
                </nav>
            </div>
        </header>