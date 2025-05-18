<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>StayFinder - Tìm phòng trọ của bạn</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/header.css?v=5">
        <link rel="stylesheet" href="assets/css/footer.css?v=3">
        <link rel="stylesheet" href="assets/css/index.css?v=1.2">
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <main>
            <!-- Hero Section -->
            <section class="hero">
                <div class="hero-content">
                    <h1>Tìm kiếm phòng trọ dễ dàng với StayFinder</h1>
                    <p>Khám phá hàng ngàn phòng trọ chất lượng phù hợp với nhu cầu của bạn</p>
                    <div class="search-box">
                        <input type="text" placeholder="Nhập địa điểm, quận, đường...">
                        <button>Tìm kiếm</button>
                    </div>
                </div>
            </section>

            <!-- Featured Properties -->
            <section class="featured">
                <div class="container">
                    <h2>Phòng trọ nổi bật</h2>
                    <div class="property-grid">
                        <!-- Property Card 1 -->
                        <div class="property-card">
                            <div class="property-image">
                                <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-4.0.3"
                                    alt="Phòng trọ">
                                <span class="property-tag">Hot</span>
                            </div>
                            <div class="property-content">
                                <h3>Phòng trọ cao cấp Quận 1</h3>
                                <p class="location"><i class="fas fa-map-marker-alt"></i> Quận 1, TP. HCM</p>
                                <p class="price">3.500.000 đ/tháng</p>
                                <div class="property-features">
                                    <span><i class="fas fa-ruler-combined"></i> 25m²</span>
                                    <span><i class="fas fa-bath"></i> 1</span>
                                    <span><i class="fas fa-bolt"></i> Riêng</span>
                                </div>
                                <a href="#" class="view-details">Xem chi tiết</a>
                            </div>
                        </div>

                        <!-- Property Card 2 -->
                        <div class="property-card">
                            <div class="property-image">
                                <img src="https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?ixlib=rb-4.0.3"
                                    alt="Phòng trọ">
                            </div>
                            <div class="property-content">
                                <h3>Phòng trọ gần ĐH Bách Khoa</h3>
                                <p class="location"><i class="fas fa-map-marker-alt"></i> Quận 10, TP. HCM</p>
                                <p class="price">2.800.000 đ/tháng</p>
                                <div class="property-features">
                                    <span><i class="fas fa-ruler-combined"></i> 20m²</span>
                                    <span><i class="fas fa-bath"></i> 1</span>
                                    <span><i class="fas fa-bolt"></i> Riêng</span>
                                </div>
                                <a href="#" class="view-details">Xem chi tiết</a>
                            </div>
                        </div>

                        <!-- Property Card 3 -->
                        <div class="property-card">
                            <div class="property-image">
                                <img src="https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?ixlib=rb-4.0.3"
                                    alt="Phòng trọ">
                                <span class="property-tag">Mới</span>
                            </div>
                            <div class="property-content">
                                <h3>Phòng trọ sinh viên Thủ Đức</h3>
                                <p class="location"><i class="fas fa-map-marker-alt"></i> Thủ Đức, TP. HCM</p>
                                <p class="price">2.200.000 đ/tháng</p>
                                <div class="property-features">
                                    <span><i class="fas fa-ruler-combined"></i> 18m²</span>
                                    <span><i class="fas fa-bath"></i> 1</span>
                                    <span><i class="fas fa-bolt"></i> Chung</span>
                                </div>
                                <a href="#" class="view-details">Xem chi tiết</a>
                            </div>
                        </div>

                        <!-- Property Card 4 -->
                        <div class="property-card">
                            <div class="property-image">
                                <img src="https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3"
                                    alt="Phòng trọ">
                            </div>
                            <div class="property-content">
                                <h3>Căn hộ mini Bình Thạnh</h3>
                                <p class="location"><i class="fas fa-map-marker-alt"></i> Bình Thạnh, TP. HCM</p>
                                <p class="price">4.200.000 đ/tháng</p>
                                <div class="property-features">
                                    <span><i class="fas fa-ruler-combined"></i> 30m²</span>
                                    <span><i class="fas fa-bath"></i> 1</span>
                                    <span><i class="fas fa-bolt"></i> Riêng</span>
                                </div>
                                <a href="#" class="view-details">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                    <div class="view-all">
                        <a href="#" class="btn-view-all">Xem tất cả phòng trọ</a>
                    </div>
                </div>
            </section>

            <!-- Areas Section -->
            <section class="areas">
                <div class="container">
                    <h2>Khu vực phổ biến</h2>
                    <div class="area-grid">
                        <a href="#" class="area-card"
                            style="background-image: url('https://images.unsplash.com/photo-1583417319070-4a69db38a482?ixlib=rb-4.0.3')">
                            <div class="area-content">
                                <h3>Quận 1</h3>
                                <span>124 phòng trọ</span>
                            </div>
                        </a>
                        <a href="#" class="area-card"
                            style="background-image: url('https://images.unsplash.com/photo-1576941089067-2de3c901e126?ixlib=rb-4.0.3')">
                            <div class="area-content">
                                <h3>Quận 10</h3>
                                <span>98 phòng trọ</span>
                            </div>
                        </a>
                        <a href="#" class="area-card"
                            style="background-image: url('https://images.unsplash.com/photo-1571055107559-3e67626fa8be?ixlib=rb-4.0.3')">
                            <div class="area-content">
                                <h3>Thủ Đức</h3>
                                <span>215 phòng trọ</span>
                            </div>
                        </a>
                        <a href="#" class="area-card"
                            style="background-image: url('https://images.unsplash.com/photo-1574691250077-03139a4edcb9?ixlib=rb-4.0.3')">
                            <div class="area-content">
                                <h3>Bình Thạnh</h3>
                                <span>176 phòng trọ</span>
                            </div>
                        </a>
                    </div>
                </div>
            </section>

            <!-- Why Choose Us -->
            <section class="why-us">
                <div class="container">
                    <h2>Tại sao chọn StayFinder?</h2>
                    <div class="features-grid">
                        <div class="feature">
                            <div class="feature-icon">
                                <i class="fas fa-search"></i>
                            </div>
                            <h3>Tìm kiếm dễ dàng</h3>
                            <p>Công cụ tìm kiếm thông minh giúp bạn nhanh chóng tìm được phòng trọ phù hợp</p>
                        </div>
                        <div class="feature">
                            <div class="feature-icon">
                                <i class="fas fa-shield-alt"></i>
                            </div>
                            <h3>Đảm bảo an toàn</h3>
                            <p>Thông tin phòng trọ được xác thực, đảm bảo quyền lợi người thuê</p>
                        </div>
                        <div class="feature">
                            <div class="feature-icon">
                                <i class="fas fa-hand-holding-dollar"></i>
                            </div>
                            <h3>Giá cả hợp lý</h3>
                            <p>Đa dạng mức giá phù hợp với khả năng tài chính của người thuê</p>
                        </div>
                        <div class="feature">
                            <div class="feature-icon">
                                <i class="fas fa-headset"></i>
                            </div>
                            <h3>Hỗ trợ 24/7</h3>
                            <p>Đội ngũ hỗ trợ luôn sẵn sàng giải đáp mọi thắc mắc của bạn</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Testimonial Section -->
            <section class="testimonials">
                <div class="container">
                    <h2>Người dùng nói gì về chúng tôi</h2>
                    <div class="testimonial-slider">
                        <div class="testimonial">
                            <div class="testimonial-content">
                                <p>"Tôi đã tìm được phòng trọ lý tưởng chỉ sau 2 ngày sử dụng StayFinder. Giao diện dễ
                                    sử dụng và thông tin chính xác giúp tôi tiết kiệm rất nhiều thời gian."</p>
                            </div>
                            <div class="testimonial-author">
                                <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Khách hàng">
                                <div class="author-info">
                                    <h4>Nguyễn Văn A</h4>
                                    <p>Sinh viên</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- CTA Section -->
            <section class="cta">
                <div class="container">
                    <div class="cta-content">
                        <h2>Bạn có phòng trọ cho thuê?</h2>
                        <p>Đăng tin ngay trên StayFinder để tiếp cận hàng ngàn khách hàng tiềm năng</p>
                        <a href="#" class="btn-primary">Đăng tin ngay</a>
                    </div>
                </div>
            </section>
        </main>

        <jsp:include page="footer.jsp" />

        <script>
            // Add any JavaScript functionality here
        </script>
    </body>

    </html>