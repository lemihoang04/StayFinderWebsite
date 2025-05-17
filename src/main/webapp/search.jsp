<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${pageTitle} - StayFinder</title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="assets/css/header.css">
            <link rel="stylesheet" href="assets/css/footer.css">
            <link rel="stylesheet" href="assets/css/search.css">
        </head>

        <body>
            <jsp:include page="header.jsp" />

            <main>
                <div class="search-container">
                    <div class="search-header">
                        <div class="container">
                            <h1>${pageTitle}</h1>
                            <form class="main-search-form" action="search-rooms" method="get">
                                <div class="search-input-group">
                                    <select name="searchType" class="search-type">
                                        <option value="title" ${searchType=='title' ? 'selected' : '' }>Tiêu đề</option>
                                        <option value="address" ${searchType=='address' ? 'selected' : '' }>Địa chỉ
                                        </option>
                                        <option value="district" ${searchType=='district' ? 'selected' : '' }>Quận/Huyện
                                        </option>
                                        <option value="city" ${searchType=='city' ? 'selected' : '' }>Tỉnh/Thành phố
                                        </option>
                                    </select>
                                    <input type="text" name="searchText" value="${searchText}"
                                        placeholder="Nhập từ khóa tìm kiếm...">
                                    <button type="submit"><i class="fas fa-search"></i> Tìm kiếm</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="container">
                        <div class="search-content">
                            <div class="filters-sidebar">
                                <div class="filter-box">
                                    <h3>Bộ lọc tìm kiếm</h3>
                                    <form action="search-rooms" method="get" id="filterForm">
                                        <!-- Keep any existing search parameters when filtering -->
                                        <input type="hidden" name="searchType" value="${searchType}">
                                        <input type="hidden" name="searchText" value="${searchText}">

                                        <div class="filter-section">
                                            <h4>Khu vực</h4>
                                            <div class="filter-option">
                                                <select name="district" class="form-control">
                                                    <option value="">Tất cả quận/huyện</option>
                                                    <option value="quan1">Quận 1</option>
                                                    <option value="quan2">Quận 2</option>
                                                    <option value="quan3">Quận 3</option>
                                                    <option value="quan10">Quận 10</option>
                                                    <option value="thuduc">Thủ Đức</option>
                                                    <option value="binhthanh">Bình Thạnh</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="filter-section">
                                            <h4>Giá thuê</h4>
                                            <div class="filter-option price-range">
                                                <div class="price-inputs">
                                                    <input type="text" name="minPrice" placeholder="Từ"
                                                        class="form-control">
                                                    <span>-</span>
                                                    <input type="text" name="maxPrice" placeholder="Đến"
                                                        class="form-control">
                                                </div>
                                                <div class="price-presets">
                                                    <span data-min="0" data-max="1000000">Dưới 1 triệu</span>
                                                    <span data-min="1000000" data-max="2000000">1 - 2 triệu</span>
                                                    <span data-min="2000000" data-max="3000000">2 - 3 triệu</span>
                                                    <span data-min="3000000" data-max="5000000">3 - 5 triệu</span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="filter-section">
                                            <h4>Diện tích</h4>
                                            <div class="filter-option area-range">
                                                <div class="area-inputs">
                                                    <input type="text" name="minArea" placeholder="Từ"
                                                        class="form-control">
                                                    <span>-</span>
                                                    <input type="text" name="maxArea" placeholder="Đến"
                                                        class="form-control">
                                                    <span>m²</span>
                                                </div>
                                                <div class="area-presets">
                                                    <span data-min="0" data-max="20">Dưới 20m²</span>
                                                    <span data-min="20" data-max="30">20 - 30m²</span>
                                                    <span data-min="30" data-max="50">30 - 50m²</span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="filter-section">
                                            <h4>Tiện ích</h4>
                                            <div class="filter-option amenities">
                                                <div class="amenity-checkbox">
                                                    <input type="checkbox" id="wifi" name="amenities" value="wifi">
                                                    <label for="wifi">Wi-Fi</label>
                                                </div>
                                                <div class="amenity-checkbox">
                                                    <input type="checkbox" id="ac" name="amenities" value="ac">
                                                    <label for="ac">Điều hòa</label>
                                                </div>
                                                <div class="amenity-checkbox">
                                                    <input type="checkbox" id="bathroom" name="amenities"
                                                        value="bathroom">
                                                    <label for="bathroom">WC riêng</label>
                                                </div>
                                                <div class="amenity-checkbox">
                                                    <input type="checkbox" id="kitchen" name="amenities"
                                                        value="kitchen">
                                                    <label for="kitchen">Nhà bếp</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="filter-actions">
                                            <button type="submit" class="btn-apply-filter">Áp dụng</button>
                                            <button type="button" class="btn-reset-filter">Xóa bộ lọc</button>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <div class="search-results">
                                <div class="results-header">
                                    <div class="results-count">
                                        <h3>Tìm thấy ${totalRooms} phòng trọ</h3>
                                    </div>
                                    <div class="results-sort">
                                        <label for="sort-options">Sắp xếp:</label>
                                        <select id="sort-options" class="form-control">
                                            <option value="newest">Mới nhất</option>
                                            <option value="price-low">Giá thấp đến cao</option>
                                            <option value="price-high">Giá cao đến thấp</option>
                                            <option value="area-low">Diện tích nhỏ đến lớn</option>
                                            <option value="area-high">Diện tích lớn đến nhỏ</option>
                                        </select>
                                    </div>
                                    <div class="view-mode">
                                        <button class="view-mode-btn active" data-mode="grid"><i
                                                class="fas fa-th"></i></button>
                                        <button class="view-mode-btn" data-mode="list"><i
                                                class="fas fa-list"></i></button>
                                    </div>
                                </div>

                                <div class="results-grid">
                                    <c:choose>
                                        <c:when test="${not empty roomList}">
                                            <c:forEach items="${roomList}" var="room">
                                                <div class="property-card">
                                                    <div class="property-image">
                                                        <c:set var="firstImage" value="${room.images.split(',')[0]}" />
                                                        <img src="${not empty firstImage ? firstImage : 'assets/img/no-image.jpg'}"
                                                            alt="${room.title}">
                                                        <c:if test="${room.status == 'hot'}">
                                                            <span class="property-tag">Hot</span>
                                                        </c:if>
                                                        <c:if test="${room.status == 'new'}">
                                                            <span class="property-tag">Mới</span>
                                                        </c:if>
                                                        <button class="btn-favorite"><i
                                                                class="far fa-heart"></i></button>
                                                    </div>
                                                    <div class="property-content">
                                                        <h3><a href="room-detail?id=${room.id}">${room.title}</a></h3>
                                                        <p class="location"><i class="fas fa-map-marker-alt"></i>
                                                            ${room.address},
                                                            ${room.district}, ${room.city}</p>
                                                        <p class="price">${String.format("%,.0f", room.price)} đ/tháng
                                                        </p>
                                                        <div class="property-features">
                                                            <span><i class="fas fa-ruler-combined"></i>
                                                                ${room.area}m²</span>
                                                            <span><i class="fas fa-door-open"></i>
                                                                ${room.roomType}</span>
                                                            <span><i class="far fa-calendar-alt"></i>
                                                                ${room.createdAt}</span>
                                                        </div>
                                                        <p class="property-description">
                                                            ${room.description.length() > 120 ?
                                                            room.description.substring(0, 120).concat('...') :
                                                            room.description}
                                                        </p>
                                                        <div class="property-footer">
                                                            <a href="room-detail?id=${room.id}" class="view-details">Xem
                                                                chi tiết</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="no-results">
                                                <i class="fas fa-search"></i>
                                                <h3>Không tìm thấy kết quả phù hợp</h3>
                                                <p>Vui lòng thử lại với từ khóa khác hoặc mở rộng bộ lọc tìm kiếm</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Pagination section -->
                                <c:if test="${totalRooms > 10}">
                                    <div class="pagination">
                                        <a href="#" class="page-link active">1</a>
                                        <a href="#" class="page-link">2</a>
                                        <a href="#" class="page-link">3</a>
                                        <a href="#" class="page-link next"><i class="fas fa-angle-right"></i></a>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </main>

            <jsp:include page="footer.jsp" />

            <script>
                // Price preset selection
                document.querySelectorAll('.price-presets span').forEach(span => {
                    span.addEventListener('click', function () {
                        document.querySelector('input[name="minPrice"]').value = this.dataset.min;
                        document.querySelector('input[name="maxPrice"]').value = this.dataset.max;

                        // Remove active class from all spans
                        document.querySelectorAll('.price-presets span').forEach(s => s.classList.remove('active'));
                        // Add active class to clicked span
                        this.classList.add('active');
                    });
                });

                // Area preset selection
                document.querySelectorAll('.area-presets span').forEach(span => {
                    span.addEventListener('click', function () {
                        document.querySelector('input[name="minArea"]').value = this.dataset.min;
                        document.querySelector('input[name="maxArea"]').value = this.dataset.max;

                        // Remove active class from all spans
                        document.querySelectorAll('.area-presets span').forEach(s => s.classList.remove('active'));
                        // Add active class to clicked span
                        this.classList.add('active');
                    });
                });

                // View mode toggle
                document.querySelectorAll('.view-mode-btn').forEach(btn => {
                    btn.addEventListener('click', function () {
                        const mode = this.dataset.mode;
                        document.querySelectorAll('.view-mode-btn').forEach(b => b.classList.remove('active'));
                        this.classList.add('active');

                        const resultsContainer = document.querySelector('.results-grid');
                        if (mode === 'list') {
                            resultsContainer.classList.add('list-view');
                        } else {
                            resultsContainer.classList.remove('list-view');
                        }
                    });
                });

                // Favorite button toggle
                document.querySelectorAll('.btn-favorite').forEach(btn => {
                    btn.addEventListener('click', function () {
                        const icon = this.querySelector('i');
                        if (icon.classList.contains('far')) {
                            icon.classList.remove('far');
                            icon.classList.add('fas');
                            this.classList.add('active');
                        } else {
                            icon.classList.remove('fas');
                            icon.classList.add('far');
                            this.classList.remove('active');
                        }
                    });
                });

                // Reset filter form
                document.querySelector('.btn-reset-filter').addEventListener('click', function () {
                    // Reset all form inputs except hidden fields
                    const form = document.getElementById('filterForm');
                    const inputs = form.querySelectorAll('input:not([type="hidden"]), select:not([name="searchType"])');

                    inputs.forEach(input => {
                        if (input.type === 'checkbox') {
                            input.checked = false;
                        } else {
                            input.value = '';
                        }
                    });

                    // Remove active class from all preset spans
                    document.querySelectorAll('.price-presets span, .area-presets span').forEach(span => {
                        span.classList.remove('active');
                    });
                });

                // Sorting functionality
                document.getElementById('sort-options').addEventListener('change', function () {
                    const sortValue = this.value;
                    const propertyCards = Array.from(document.querySelectorAll('.property-card'));
                    const resultsGrid = document.querySelector('.results-grid');

                    propertyCards.sort((a, b) => {
                        if (sortValue === 'price-low') {
                            const priceA = parseFloat(a.querySelector('.price').textContent.replace(/[^\d]/g, ''));
                            const priceB = parseFloat(b.querySelector('.price').textContent.replace(/[^\d]/g, ''));
                            return priceA - priceB;
                        } else if (sortValue === 'price-high') {
                            const priceA = parseFloat(a.querySelector('.price').textContent.replace(/[^\d]/g, ''));
                            const priceB = parseFloat(b.querySelector('.price').textContent.replace(/[^\d]/g, ''));
                            return priceB - priceA;
                        } else if (sortValue === 'area-low') {
                            const areaA = parseFloat(a.querySelector('.property-features span:first-child').textContent.match(/\d+\.*\d*/)[0]);
                            const areaB = parseFloat(b.querySelector('.property-features span:first-child').textContent.match(/\d+\.*\d*/)[0]);
                            return areaA - areaB;
                        } else if (sortValue === 'area-high') {
                            const areaA = parseFloat(a.querySelector('.property-features span:first-child').textContent.match(/\d+\.*\d*/)[0]);
                            const areaB = parseFloat(b.querySelector('.property-features span:first-child').textContent.match(/\d+\.*\d*/)[0]);
                            return areaB - areaA;
                        }
                        // Default: newest first (assuming the DOM order is already by newest)
                        return 0;
                    });

                    // Remove all current cards
                    while (resultsGrid.firstChild) {
                        resultsGrid.removeChild(resultsGrid.firstChild);
                    }

                    // Append sorted cards
                    propertyCards.forEach(card => {
                        resultsGrid.appendChild(card);
                    });
                });
            </script>
        </body>

        </html>