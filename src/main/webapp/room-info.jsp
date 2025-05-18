<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Chi tiết phòng trọ</title>
                <link rel="stylesheet" href="assets/css/header.css?v=1.1">
                <link rel="stylesheet" href="assets/css/footer.css">
                <link rel="stylesheet" href="assets/css/room-info.css?v=1.1">
                <!-- Font Awesome Icons -->
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
            </head>

            <body>
                <!-- Include Header -->
                <jsp:include page="header.jsp" />

                <div class="ri-container">
                    <div class="ri-row">
                        <!-- Room Images Section -->
                        <div class="ri-col-large">
                            <div class="ri-room-images">
                                <c:if test="${not empty room.images}">
                                    <c:set var="imgArray" value="${room.images.split(',')}" />

                                    <!-- Main Image -->
                                    <div class="ri-main-image">
                                        <img src="${imgArray[0]}" alt="${room.title}" class="ri-img-fluid">
                                    </div>

                                    <!-- Thumbnails -->
                                    <div class="ri-thumbnails">
                                        <c:forEach var="img" items="${imgArray}" varStatus="status">
                                            <div class="ri-thumbnail-item">
                                                <img src="${img}" alt="Thumbnail ${status.index+1}"
                                                    class="ri-thumbnail-img">
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:if>

                                <c:if test="${empty room.images}">
                                    <div class="ri-no-image">
                                        <img src="assets/images/no-image.png" alt="Không có hình ảnh"
                                            class="ri-img-fluid">
                                    </div>
                                </c:if>
                            </div>

                            <!-- Room Details -->
                            <div class="ri-room-details">
                                <h1 class="ri-room-title">${room.title}</h1>

                                <div class="ri-room-price-area">
                                    <div class="ri-room-price">
                                        <span class="ri-price-label">Giá thuê:</span>
                                        <span class="ri-price-value">
                                            <fmt:formatNumber value="${room.price}" pattern="#,###" /> đ/tháng
                                        </span>
                                    </div>
                                    <div class="ri-room-area">
                                        <span class="ri-area-label">Diện tích:</span>
                                        <span class="ri-area-value">${room.area} m²</span>
                                    </div>
                                </div>

                                <div class="ri-room-address">
                                    <i class="fas fa-map-marker-alt ri-text-danger"></i>
                                    <span>${room.address}, ${room.district}, ${room.city}</span>
                                </div>

                                <div class="ri-room-location">
                                    <div class="ri-room-district">
                                        <span class="ri-district-label"><i class="fas fa-map"></i>Quận/Huyện:</span>
                                        <span class="ri-district-value">${room.district}</span>
                                    </div>
                                    <div class="ri-room-city">
                                        <span class="ri-city-label"><i class="fas fa-city"></i>Thành phố/Tỉnh:</span>
                                        <span class="ri-city-value">${room.city}</span>
                                    </div>
                                </div>

                                <div class="ri-room-meta">
                                    <div class="ri-room-created">
                                        <i class="far fa-calendar-alt"></i>
                                        <span>Ngày đăng: ${room.createdAt}</span>
                                    </div>
                                    <div class="ri-room-created">
                                        <i class="far fa-calendar-alt"></i>
                                        <span>Ngày hết hạn: ${room.expiryDate}</span>
                                    </div>
                                    <div class="ri-room-status">
                                        <span class="ri-status-label">Trạng thái:</span>
                                        <c:choose>
                                            <c:when test="${room.status eq 'available'}">
                                                <span class="ri-badge ri-badge-success">Đang hiển thị</span>
                                            </c:when>
                                            <c:when test="${room.status eq 'occupied'}">
                                                <span class="ri-badge ri-badge-warning">Đang chờ duyệt</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="ri-badge ri-badge-secondary">Đã hết hạn</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="ri-room-description">
                                    <h4 class="ri-description-title">Mô tả chi tiết</h4>
                                    <div class="ri-description-content">
                                        <p>${room.description}</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Owner Information & Contact -->
                        <div class="ri-col-small">
                            <div class="ri-owner-info-card">
                                <div class="ri-card-header ri-bg-primary">
                                    <h5>Thông tin người đăng</h5>
                                </div>
                                <div class="ri-card-body">
                                    <div class="ri-owner-details">
                                        <h5 class="ri-owner-name">${owner.name}</h5>

                                        <div class="ri-contact-info">
                                            <p>
                                                <i class="fas fa-envelope"></i>
                                                <a href="mailto:${owner.email}">${owner.email}</a>
                                            </p>
                                            <p>
                                                <i class="fas fa-phone-alt"></i>
                                                <a href="tel:${owner.phone}">${owner.phone}</a>
                                            </p>
                                        </div>

                                        <div class="ri-contact-buttons">
                                            <a href="tel:${owner.phone}" class="ri-btn ri-btn-success">
                                                <i class="fas fa-phone-alt"></i> Gọi ngay
                                            </a>
                                            <a href="mailto:${owner.email}" class="ri-btn ri-btn-outline-primary">
                                                <i class="fas fa-envelope"></i> Gửi email
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Safety Tips -->
                            <div class="ri-safety-tips">
                                <div class="ri-card-header ri-bg-warning">
                                    <h5>Lưu ý an toàn</h5>
                                </div>
                                <div class="ri-card-body">
                                    <ul class="ri-safety-tips-list">
                                        <li>Không chuyển tiền trước khi xem phòng</li>
                                        <li>Cẩn thận với giá thuê quá thấp so với giá thị trường</li>
                                        <li>Cần kiểm tra kỹ hợp đồng trước khi ký</li>
                                        <li>Yêu cầu xem giấy tờ liên quan đến quyền sở hữu hoặc cho thuê</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--  Similar Rooms Section - If needed
                    <div class="ri-similar-rooms">
                        <h3 class="ri-section-title">Phòng tương tự</h3>
                        You can add logic to display similar rooms here
                    </div> -->
                </div>

                <!-- Include Footer -->
                <jsp:include page="footer.jsp" />

                <script>
                    // JavaScript for image gallery functionality
                    document.addEventListener('DOMContentLoaded', function () {
                        const thumbnails = document.querySelectorAll('.ri-thumbnail-img');
                        const mainImage = document.querySelector('.ri-main-image img');

                        if (thumbnails.length > 0 && mainImage) {
                            thumbnails.forEach(thumbnail => {
                                thumbnail.addEventListener('click', function () {
                                    mainImage.src = this.src;
                                });
                            });
                        }
                    });
                </script>
            </body>

            </html>