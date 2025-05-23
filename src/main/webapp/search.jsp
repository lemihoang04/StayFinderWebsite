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
            <link rel="stylesheet" href="assets/css/header.css?v=1.2">
            <link rel="stylesheet" href="assets/css/footer.css">
            <link rel="stylesheet" href="assets/css/search.css?v=1.1">
        </head>

        <body>
            <jsp:include page="header.jsp" />
            <main class="sf-main">
                <div class="sf-search-container">
                    <div class="sf-search-header">
                        <div class="container">
                            <h1>${pageTitle}</h1>
                            <form class="sf-main-search-form" action="search-rooms" method="get">
                                <div class="sf-search-input-group">
                                    <input type="text" name="searchtxt" placeholder="Nhập từ khóa tìm kiếm..."
                                        value="${searchtxt}" />
                                    <button type="submit"><i class="fas fa-search"></i> Tìm kiếm</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="container">
                        <div class="sf-search-content">
                            <div class="sf-filters-sidebar">
                                <div class="sf-filter-box">
                                    <h3>Bộ lọc tìm kiếm</h3>
                                    <form action="search-rooms" method="get" id="filterForm">
                                        <!-- Hidden field to preserve search text when applying filters -->
                                        <input type="hidden" name="searchtxt" value="${searchtxt}" />
                                        <div class="sf-filter-section">
                                            <h4>Khu vực</h4>
                                            <div class="sf-filter-option">
                                                <select name="city" id="citySelect" class="sf-form-control">
                                                    <option value="">Chọn tỉnh/thành phố</option>
                                                    <c:forEach var="c" items="${cityList}">
                                                        <option value="${c.city_name}" ${city==c.city_name ? 'selected'
                                                            : '' }>${c.city_name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="sf-filter-option">
                                                <select name="district" id="districtSelect" class="sf-form-control"
                                                    ${empty city ? 'disabled' : '' }>
                                                    <option value="">Chọn quận/huyện</option>
                                                    <c:forEach var="c" items="${cityList}">
                                                        <c:if test="${city == c.city_name}">
                                                            <c:forEach var="d" items="${c.district}">
                                                                <option value="${d}" ${district==d ? 'selected' : '' }>
                                                                    ${d}</option>
                                                            </c:forEach>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="sf-filter-section">
                                            <h4>Giá thuê</h4>
                                            <div class="sf-filter-option sf-price-range">
                                                <div class="sf-price-inputs">
                                                    <input type="text" name="minPrice" placeholder="Từ"
                                                        value="${minPrice}" class="sf-form-control">
                                                    <span>-</span>
                                                    <input type="text" name="maxPrice" placeholder="Đến"
                                                        value="${maxPrice}" class="sf-form-control">
                                                </div>
                                                <div class="sf-price-presets">
                                                    <span data-min="0" data-max="1000000" ${minPrice=='0' &&
                                                        maxPrice=='1000000' ? 'class="active"' : '' }>Dưới 1
                                                        triệu</span>
                                                    <span data-min="1000000" data-max="2000000" ${minPrice=='1000000' &&
                                                        maxPrice=='2000000' ? 'class="active"' : '' }>1 - 2 triệu</span>
                                                    <span data-min="2000000" data-max="3000000" ${minPrice=='2000000' &&
                                                        maxPrice=='3000000' ? 'class="active"' : '' }>2 - 3 triệu</span>
                                                    <span data-min="3000000" data-max="5000000" ${minPrice=='3000000' &&
                                                        maxPrice=='5000000' ? 'class="active"' : '' }>3 - 5 triệu</span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="sf-filter-section">
                                            <h4>Diện tích</h4>
                                            <div class="sf-filter-option sf-area-range">
                                                <div class="sf-area-inputs">
                                                    <input type="text" name="minArea" placeholder="Từ"
                                                        value="${minArea}" class="sf-form-control">
                                                    <span>-</span>
                                                    <input type="text" name="maxArea" placeholder="Đến"
                                                        value="${maxArea}" class="sf-form-control">
                                                    <span>m²</span>
                                                </div>
                                                <div class="sf-area-presets">
                                                    <span data-min="0" data-max="20" ${minArea=='0' && maxArea=='20'
                                                        ? 'class="active"' : '' }>Dưới 20m²</span>
                                                    <span data-min="20" data-max="30" ${minArea=='20' && maxArea=='30'
                                                        ? 'class="active"' : '' }>20 - 30m²</span>
                                                    <span data-min="30" data-max="50" ${minArea=='30' && maxArea=='50'
                                                        ? 'class="active"' : '' }>30 - 50m²</span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="sf-filter-actions">
                                            <button type="submit" class="sf-btn-apply-filter">Áp dụng</button>
                                            <button type="button" class="sf-btn-reset-filter">Xóa bộ lọc</button>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <div class="sf-search-results">
                                <div class="sf-results-header">
                                    <div class="sf-results-count">
                                        <h3>Tìm thấy ${totalRooms} phòng trọ</h3>
                                    </div>
                                    <div class="sf-results-sort">
                                        <form id="sortForm" action="search-rooms" method="get">
                                            <!-- Hidden fields to preserve search parameters -->
                                            <input type="hidden" name="searchtxt" value="${searchtxt}" />
                                            <input type="hidden" name="city" value="${city}" />
                                            <input type="hidden" name="district" value="${district}" />
                                            <input type="hidden" name="minPrice" value="${minPrice}" />
                                            <input type="hidden" name="maxPrice" value="${maxPrice}" />
                                            <input type="hidden" name="minArea" value="${minArea}" />
                                            <input type="hidden" name="maxArea" value="${maxArea}" />

                                            <label for="sort-options">Sắp xếp:</label>
                                            <select id="sort-options" name="sortBy" class="sf-form-control">
                                                <option value="newest" ${sortBy=='newest' ? 'selected' : '' }>Mới nhất
                                                </option>
                                                <option value="price-low" ${sortBy=='price-low' ? 'selected' : '' }>Giá
                                                    thấp đến cao</option>
                                                <option value="price-high" ${sortBy=='price-high' ? 'selected' : '' }>
                                                    Giá cao đến thấp</option>
                                                <option value="area-low" ${sortBy=='area-low' ? 'selected' : '' }>Diện
                                                    tích nhỏ đến lớn</option>
                                                <option value="area-high" ${sortBy=='area-high' ? 'selected' : '' }>Diện
                                                    tích lớn đến nhỏ</option>
                                            </select>
                                        </form>
                                    </div>
                                    <div class="sf-view-mode">
                                        <button class="sf-view-mode-btn active" data-mode="grid"><i
                                                class="fas fa-th"></i></button>
                                        <button class="sf-view-mode-btn" data-mode="list"><i
                                                class="fas fa-list"></i></button>
                                    </div>
                                </div>

                                <div class="sf-results-grid">
                                    <c:choose>
                                        <c:when test="${not empty roomList}">
                                            <c:forEach items="${roomList}" var="room">
                                                <div class="sf-property-card">
                                                    <div class="sf-property-image">
                                                        <c:set var="firstImage" value="${room.images.split(',')[0]}" />
                                                        <img src="${not empty firstImage ? firstImage : 'assets/img/no-image.jpg'}"
                                                            alt="${room.title}">
                                                        <c:if test="${room.status == 'hot'}">
                                                            <span class="sf-property-tag">Hot</span>
                                                        </c:if>
                                                        <c:if test="${room.status == 'new'}">
                                                            <span class="sf-property-tag">Mới</span>
                                                        </c:if>
                                                        <button class="sf-btn-favorite"><i
                                                                class="far fa-heart"></i></button>
                                                    </div>
                                                    <div class="sf-property-content">
                                                        <h3><a href="room-info?id=${room.id}">${room.title}</a></h3>
                                                        <p class="sf-location"><i class="fas fa-map-marker-alt"></i>
                                                            ${room.address},
                                                            ${room.district}, ${room.city}</p>
                                                        <p class="sf-price">${String.format("%,.0f", room.price)}
                                                            đ/tháng
                                                        </p>
                                                        <div class="sf-property-features">
                                                            <span><i class="fas fa-ruler-combined"></i>
                                                                ${room.area}m²</span>
                                                            <span><i class="fas fa-door-open"></i>
                                                                ${room.roomType}</span>
                                                            <span><i class="far fa-calendar-alt"></i>
                                                                ${room.createdAt}</span>
                                                        </div>
                                                        <p class="sf-property-description">
                                                            ${room.description.length() > 120 ?
                                                            room.description.substring(0, 120).concat('...') :
                                                            room.description}
                                                        </p>
                                                        <div class="sf-property-footer">
                                                            <a href="room-detail?id=${room.id}"
                                                                class="sf-view-details">Xem
                                                                chi tiết</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="sf-no-results">
                                                <i class="fas fa-search"></i>
                                                <h3>Không tìm thấy kết quả phù hợp</h3>
                                                <p>Vui lòng thử lại với từ khóa khác hoặc mở rộng bộ lọc tìm kiếm</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Pagination section -->
                                <c:if test="${totalRooms > 4}">
                                    <div class="sf-pagination">
                                        <a href="#" class="sf-page-link active">1</a>
                                        <a href="#" class="sf-page-link">2</a>
                                        <a href="#" class="sf-page-link">3</a>
                                        <a href="#" class="sf-page-link next"><i class="fas fa-angle-right"></i></a>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </main>

            <jsp:include page="footer.jsp" />
            <script>
                // Thêm mapping từ city tới danh sách district
                var cityDistrictMap = {};
                <c:forEach var="c" items="${cityList}">
                    cityDistrictMap['${c.city_name}'] = [<c:forEach var="d" items="${c.district}" varStatus="status">'${d}'<c:if test="${!status.last}">, </c:if></c:forEach>];
                </c:forEach>

                // Cập nhật event listener cho select city
                document.getElementById('citySelect').addEventListener('change', function () {
                    var selectedCity = this.value;
                    var districtSelect = document.getElementById('districtSelect');
                    // Xóa tất cả các option hiện có, giữ option mặc định
                    districtSelect.innerHTML = '<option value="">Chọn quận/huyện</option>';
                    if (selectedCity && cityDistrictMap[selectedCity]) {
                        districtSelect.disabled = false;
                        cityDistrictMap[selectedCity].forEach(function (district) {
                            var option = document.createElement('option');
                            option.value = district;
                            option.textContent = district;
                            districtSelect.appendChild(option);
                        });
                    } else {
                        districtSelect.disabled = true;
                    }
                });

                // Price preset selection
                document.querySelectorAll('.sf-price-presets span').forEach(span => {
                    span.addEventListener('click', function () {
                        document.querySelector('input[name="minPrice"]').value = this.dataset.min;
                        document.querySelector('input[name="maxPrice"]').value = this.dataset.max;

                        // Remove active class from all spans
                        document.querySelectorAll('.sf-price-presets span').forEach(s => s.classList.remove('active'));
                        // Add active class to clicked span
                        this.classList.add('active');
                    });
                });

                // Area preset selection
                document.querySelectorAll('.sf-area-presets span').forEach(span => {
                    span.addEventListener('click', function () {
                        document.querySelector('input[name="minArea"]').value = this.dataset.min;
                        document.querySelector('input[name="maxArea"]').value = this.dataset.max;

                        // Remove active class from all spans
                        document.querySelectorAll('.sf-area-presets span').forEach(s => s.classList.remove('active'));
                        // Add active class to clicked span
                        this.classList.add('active');
                    });
                });

                // View mode toggle
                document.querySelectorAll('.sf-view-mode-btn').forEach(btn => {
                    btn.addEventListener('click', function () {
                        const mode = this.dataset.mode;
                        document.querySelectorAll('.sf-view-mode-btn').forEach(b => b.classList.remove('active'));
                        this.classList.add('active');

                        const resultsContainer = document.querySelector('.sf-results-grid');
                        if (mode === 'list') {
                            resultsContainer.classList.add('sf-list-view');
                        } else {
                            resultsContainer.classList.remove('sf-list-view');
                        }
                    });
                });

                // Favorite button toggle
                document.querySelectorAll('.sf-btn-favorite').forEach(btn => {
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
                document.querySelector('.sf-btn-reset-filter').addEventListener('click', function () {
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
                    document.querySelectorAll('.sf-price-presets span, .sf-area-presets span').forEach(span => {
                        span.classList.remove('active');
                    });
                });                // Sorting functionality - Submit form when sort option changes
                document.getElementById('sort-options').addEventListener('change', function () {
                    // Submit the sort form
                    document.getElementById('sortForm').submit();
                });
            </script>
        </body>

        </html>