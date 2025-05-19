<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Quản lý phòng trọ - StayFinder Admin</title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="assets/css/admin_sidebar.css">
            <link rel="stylesheet" href="assets/css/rooms_manager.css">
        </head>

        <body>
            <!-- Include the admin sidebar -->
            <jsp:include page="admin_sidebar.jsp" />

            <div class="rm-container">
                <div class="rm-content">
                    <div class="rm-page-header">
                        <h1 class="rm-page-title">Quản lý phòng trọ</h1>
                        <button class="rm-btn rm-btn-primary" id="rm-add-room-btn">
                            <i class="fas fa-plus"></i> Thêm phòng trọ mới
                        </button>
                    </div>

                    <!-- Filter options -->
                    <div class="rm-filter-container">
                        <div class="rm-filter-group">
                            <label class="rm-filter-label" for="statusFilter">Trạng thái:</label>
                            <select id="statusFilter" class="rm-filter-select" onChange="filterRooms()">
                                <option value="all">Tất cả</option>
                                <option value="available">Có sẵn</option>
                                <option value="pending">Đang chờ duyệt</option>
                                <option value="rented">Đã cho thuê</option>
                                <option value="expired">Hết hạn</option>
                            </select>
                        </div>
                        <div class="rm-filter-group">
                            <label class="rm-filter-label" for="cityFilter">Thành phố:</label>
                            <select id="cityFilter" class="rm-filter-select" onChange="filterRooms()">
                                <option value="all">Tất cả</option>
                                <c:forEach var="c" items="${cityList}">
                                    <option value="${c.city_name}">${c.city_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <!-- Search and Filter -->
                    <div class="rm-search-container">
                        <form action="admin_rooms" method="get" class="rm-search-form">
                            <div class="rm-search-group">
                                <select name="search_type" class="rm-search-select">
                                    <option value="title">Tiêu đề</option>
                                    <option value="address">Địa chỉ</option>
                                    <option value="district">Quận/Huyện</option>
                                    <option value="user_id">ID người đăng</option>
                                </select>
                                <div class="rm-search-input-wrapper">
                                    <i class="fas fa-search rm-search-icon"></i>
                                    <input type="text" name="searchtxt" class="rm-search-input"
                                        placeholder="Tìm kiếm phòng trọ...">
                                </div>
                                <button type="submit" class="rm-btn rm-btn-search">Tìm kiếm</button>
                            </div>
                        </form>
                    </div>

                    <!-- Error/Success Messages -->
                    <c:if test="${not empty successMessage}">
                        <div class="rm-message rm-message-success">
                            <i class="fas fa-check-circle"></i> ${successMessage}
                            <button class="rm-message-close"
                                onclick="this.parentElement.style.display='none'">×</button>
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMessage}">
                        <div class="rm-message rm-message-error">
                            <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                            <button class="rm-message-close"
                                onclick="this.parentElement.style.display='none'">×</button>
                        </div>
                    </c:if>

                    <!-- Rooms Table -->
                    <div class="rm-table-container">
                        <table class="rm-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tiêu đề</th>
                                    <th>Địa chỉ</th>
                                    <th class="price-column">Giá</th>
                                    <th class="area-column">Diện tích</th>
                                    <th class="status-column">Trạng thái</th>
                                    <th>Ngày tạo</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="room" items="${roomList}">
                                    <tr data-status="${room.status}" data-city="${room.city}">
                                        <td>${room.id}</td>
                                        <td>${room.title}</td>
                                        <td>${room.address}, ${room.district}, ${room.city}</td>
                                        <td class="price-column">${room.price} đ</td>
                                        <td class="area-column">${room.area} m²</td>
                                        <td class="status-column">
                                            <span class="rm-status-badge rm-status-${room.status}">
                                                <c:choose>
                                                    <c:when test="${room.status == 'available'}">Có sẵn</c:when>
                                                    <c:when test="${room.status == 'pending'}">Chờ duyệt</c:when>
                                                    <c:when test="${room.status == 'rented'}">Đã thuê</c:when>
                                                    <c:when test="${room.status == 'expired'}">Hết hạn</c:when>
                                                    <c:otherwise>${room.status}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>${room.createdAt}</td>
                                        <td class="rm-actions">
                                            <button class="rm-btn rm-btn-view" onclick="viewRoom('${room.id}')">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <button class="rm-btn rm-btn-edit" onclick="editRoom('${room.id}')">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="rm-btn rm-btn-delete"
                                                onclick="confirmDelete('${room.id}', '${room.title}')">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination (if needed) -->
                    <div class="rm-pagination">
                        <!-- Pagination content will be here -->
                    </div>
                </div>
            </div>

            <!-- Modal Overlay -->
            <div class="rm-modal-overlay" id="rm-modal-overlay"></div>

            <!-- View Room Modal -->
            <div class="rm-modal" id="rm-view-room-modal">
                <div class="rm-modal-content">
                    <div class="rm-modal-header">
                        <h2 class="rm-modal-title">Thông tin phòng trọ</h2>
                        <button class="rm-modal-close" onclick="closeModals()">×</button>
                    </div>
                    <div class="rm-modal-body">
                        <div class="rm-room-info">
                            <div class="rm-room-header">
                                <h3 class="rm-room-title" id="view-title"></h3>
                                <p class="rm-room-subtitle" id="view-address"></p>
                            </div>

                            <div class="rm-info-group">
                                <label class="rm-info-label">Trạng thái:</label>
                                <span class="rm-status-badge" id="view-status-badge"></span>
                            </div>

                            <div class="rm-form-row">
                                <div class="rm-info-group">
                                    <label class="rm-info-label">Giá:</label>
                                    <span class="rm-info-value" id="view-price"></span>
                                </div>
                                <div class="rm-info-group">
                                    <label class="rm-info-label">Diện tích:</label>
                                    <span class="rm-info-value" id="view-area"></span>
                                </div>
                            </div>

                            <div class="rm-form-row">
                                <div class="rm-info-group">
                                    <label class="rm-info-label">Ngày đăng:</label>
                                    <span class="rm-info-value" id="view-created"></span>
                                </div>
                                <div class="rm-info-group">
                                    <label class="rm-info-label">Ngày hết hạn:</label>
                                    <span class="rm-info-value" id="view-expiry"></span>
                                </div>
                            </div>

                            <div class="rm-info-group">
                                <label class="rm-info-label">Người đăng:</label>
                                <span class="rm-info-value" id="view-user"></span>
                            </div>

                            <div class="rm-info-group">
                                <label class="rm-info-label">Mô tả:</label>
                                <div class="rm-description" id="view-description"></div>
                            </div>

                            <div class="rm-info-group">
                                <label class="rm-info-label">Hình ảnh:</label>
                                <div class="rm-room-images" id="view-images">
                                    <!-- Images will be added dynamically -->
                                </div>
                            </div>
                        </div>
                        <div class="rm-form-actions">
                            <button class="rm-btn rm-btn-primary" onclick="closeModals()">Đóng</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Edit Room Modal -->
            <div class="rm-modal" id="rm-edit-room-modal">
                <div class="rm-modal-content">
                    <div class="rm-modal-header">
                        <h2 class="rm-modal-title">Chỉnh sửa thông tin phòng trọ</h2>
                        <button class="rm-modal-close" onclick="closeModals()">×</button>
                    </div>
                    <div class="rm-modal-body">
                        <form id="rm-edit-room-form" action="room" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="operation" value="update">
                            <input type="hidden" name="id" id="edit-id">

                            <div class="rm-form-group">
                                <label for="edit-title">Tiêu đề <span class="rm-required">*</span></label>
                                <input type="text" id="edit-title" name="title" required>
                            </div>

                            <div class="rm-form-row">
                                <div class="rm-form-group">
                                    <label for="edit-price">Giá (VNĐ) <span class="rm-required">*</span></label>
                                    <input type="number" id="edit-price" name="price" required min="0">
                                </div>
                                <div class="rm-form-group">
                                    <label for="edit-area">Diện tích (m²) <span class="rm-required">*</span></label>
                                    <input type="number" id="edit-area" name="area" required min="0" step="0.1">
                                </div>
                            </div>

                            <div class="rm-form-group">
                                <label for="edit-address">Địa chỉ <span class="rm-required">*</span></label>
                                <input type="text" id="edit-address" name="address" required>
                            </div>

                            <div class="rm-form-row">
                                <div class="rm-form-group">
                                    <label for="edit-city">Thành phố <span class="rm-required">*</span></label>
                                    <select id="edit-city" name="city" required>
                                        <option value="">Chọn thành phố</option>
                                        <c:forEach var="c" items="${cityList}">
                                            <option value="${c.city_name}" ${room.city==c.city_name ? 'selected' : '' }>
                                                ${c.city_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="rm-form-group">
                                    <label for="edit-district">Quận/Huyện <span class="rm-required">*</span></label>
                                    <!-- Đổi từ input sang select -->
                                    <select id="edit-district" name="district" required disabled>
                                        <option value="">Chọn quận/huyện</option>
                                    </select>
                                </div>
                            </div>

                            <div class="rm-form-group">
                                <label for="edit-description">Mô tả <span class="rm-required">*</span></label>
                                <textarea id="edit-description" name="description" required></textarea>
                            </div>

                            <div class="rm-form-group">
                                <label for="edit-status">Trạng thái <span class="rm-required">*</span></label>
                                <select id="edit-status" name="status" required>
                                    <option value="available">Có sẵn</option>
                                    <option value="pending">Chờ duyệt</option>
                                    <option value="rented">Đã thuê</option>
                                    <option value="expired">Hết hạn</option>
                                </select>
                            </div>

                            <div class="rm-form-group">
                                <label>Hình ảnh hiện tại</label>
                                <div class="rm-image-preview" id="edit-existing-images">
                                    <!-- Existing images will be shown here -->
                                </div>
                                <input type="hidden" name="deletedImages" id="edit-deleted-images">
                            </div>

                            <div class="rm-form-group">
                                <label for="edit-images">Thêm hình ảnh mới</label>
                                <div class="rm-image-upload" onclick="document.getElementById('edit-images').click()">
                                    <i class="fas fa-cloud-upload-alt"></i>
                                    <p>Click để chọn hình hoặc kéo hình vào đây</p>
                                </div>
                                <input type="file" id="edit-images" name="images" style="display: none;" multiple
                                    accept="image/*" onchange="previewImages('edit-images', 'edit-new-images')">
                                <div class="rm-image-preview" id="edit-new-images"></div>
                            </div>

                            <div class="rm-form-actions">
                                <button type="button" class="rm-btn rm-btn-cancel" onclick="closeModals()">Hủy</button>
                                <button type="submit" class="rm-btn rm-btn-submit">Lưu thay đổi</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Add Room Modal -->
            <div class="rm-modal" id="rm-add-room-modal">
                <div class="rm-modal-content">
                    <div class="rm-modal-header">
                        <h2 class="rm-modal-title">Thêm phòng trọ mới</h2>
                        <button class="rm-modal-close" onclick="closeModals()">×</button>
                    </div>
                    <div class="rm-modal-body">
                        <form id="rm-add-room-form" action="room" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="operation" value="add">

                            <div class="rm-form-group">
                                <label for="add-title">Tiêu đề <span class="rm-required">*</span></label>
                                <input type="text" id="add-title" name="title" required>
                            </div>

                            <div class="rm-form-row">
                                <div class="rm-form-group">
                                    <label for="add-price">Giá (VNĐ) <span class="rm-required">*</span></label>
                                    <input type="number" id="add-price" name="price" required min="0">
                                </div>
                                <div class="rm-form-group">
                                    <label for="add-area">Diện tích (m²) <span class="rm-required">*</span></label>
                                    <input type="number" id="add-area" name="area" required min="0" step="0.1">
                                </div>
                            </div>

                            <div class="rm-form-group">
                                <label for="add-address">Địa chỉ <span class="rm-required">*</span></label>
                                <input type="text" id="add-address" name="address" required>
                            </div>

                            <div class="rm-form-row">
                                <div class="rm-form-group">
                                    <label for="add-city">Thành phố <span class="rm-required">*</span></label>
                                    <select id="add-city" name="city" required>
                                        <option value="">Chọn thành phố</option>
                                        <c:forEach var="c" items="${cityList}">
                                            <option value="${c.city_name}">${c.city_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="rm-form-group">
                                    <label for="add-district">Quận/Huyện <span class="rm-required">*</span></label>
                                    <!-- Đổi từ input sang select -->
                                    <select id="add-district" name="district" required disabled>
                                        <option value="">Chọn quận/huyện</option>
                                    </select>
                                </div>
                            </div>

                            <div class="rm-form-group">
                                <label for="add-description">Mô tả <span class="rm-required">*</span></label>
                                <textarea id="add-description" name="description" required></textarea>
                            </div>

                            <div class="rm-form-group">
                                <label for="add-status">Trạng thái <span class="rm-required">*</span></label>
                                <select id="add-status" name="status" required>
                                    <option value="available">Có sẵn</option>
                                    <option value="pending">Chờ duyệt</option>
                                </select>
                            </div>

                            <div class="rm-form-group">
                                <label for="add-user">Người đăng <span class="rm-required">*</span></label>
                                <select id="add-user" name="user_id" required>
                                    <option value="">Chọn người đăng</option>
                                    <c:forEach var="user" items="${userList}">
                                        <option value="${user.id}">${user.username} - ${user.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="rm-form-group">
                                <label for="add-images">Hình ảnh <span class="rm-required">*</span></label>
                                <div class="rm-image-upload" onclick="document.getElementById('add-images').click()">
                                    <i class="fas fa-cloud-upload-alt"></i>
                                    <p>Click để chọn hình hoặc kéo hình vào đây</p>
                                </div>
                                <input type="file" id="add-images" name="images" style="display: none;" multiple
                                    required accept="image/*"
                                    onchange="previewImages('add-images', 'add-image-preview')">
                                <div class="rm-image-preview" id="add-image-preview"></div>
                            </div>

                            <div class="rm-form-actions">
                                <button type="button" class="rm-btn rm-btn-cancel" onclick="closeModals()">Hủy</button>
                                <button type="submit" class="rm-btn rm-btn-submit">Thêm phòng trọ</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Delete Confirmation Modal -->
            <div class="rm-modal" id="rm-delete-room-modal">
                <div class="rm-modal-content">
                    <div class="rm-modal-header">
                        <h2 class="rm-modal-title">Xác nhận xóa phòng trọ</h2>
                        <button class="rm-modal-close" onclick="closeModals()">×</button>
                    </div>
                    <div class="rm-modal-body">
                        <p class="rm-confirm-text">Bạn có chắc chắn muốn xóa phòng trọ <strong
                                id="delete-title"></strong>?</p>
                        <p class="rm-confirm-warning">Lưu ý: Hành động này không thể hoàn tác!</p>

                        <form id="rm-delete-room-form" action="room" method="post">
                            <input type="hidden" name="operation" value="delete">
                            <input type="hidden" name="id" id="delete-id">

                            <div class="rm-form-actions">
                                <button type="button" class="rm-btn rm-btn-cancel" onclick="closeModals()">Hủy</button>
                                <button type="submit" class="rm-btn rm-btn-danger">Xóa phòng trọ</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script>
                // Thêm biến contextPath từ server
                var contextPath = '<%=request.getContextPath()%>';
                
                // Modal functions
                document.getElementById('rm-add-room-btn').addEventListener('click', function () {
                    document.getElementById('rm-modal-overlay').style.display = 'block';
                    document.getElementById('rm-add-room-modal').style.display = 'block';
                });

                function viewRoom(roomId) {
                    // Update fetch URL với contextPath
                    fetch(contextPath + '/room?operation=view&id=' + roomId)
                        .then(response => response.json())
                        .then(room => {
                            document.getElementById('view-title').textContent = room.title;
                            document.getElementById('view-address').textContent =
                                `${room.address}, ${room.district}, ${room.city}`;
                            document.getElementById('view-price').textContent = `${room.price} VNĐ`;
                            document.getElementById('view-area').textContent = `${room.area} m²`;
                            document.getElementById('view-created').textContent = room.createdAt;
                            document.getElementById('view-expiry').textContent = room.expiryDate;
                            document.getElementById('view-user').textContent = room.userName;
                            document.getElementById('view-description').textContent = room.description;

                            // Set status badge
                            const statusBadge = document.getElementById('view-status-badge');
                            statusBadge.className = `rm-status-badge rm-status-${room.status}`;
                            let statusText = '';
                            switch (room.status) {
                                case 'available':
                                    statusText = 'Có sẵn';
                                    break;
                                case 'pending':
                                    statusText = 'Chờ duyệt';
                                    break;
                                case 'rented':
                                    statusText = 'Đã thuê';
                                    break;
                                case 'expired':
                                    statusText = 'Hết hạn';
                                    break;
                                default:
                                    statusText = room.status;
                            }
                            statusBadge.textContent = statusText;

                            // Display images
                            const imagesContainer = document.getElementById('view-images');
                            imagesContainer.innerHTML = '';
                            if (room.images && room.images.length > 0) {
                                const imageUrls = room.images.split(',');
                                imageUrls.forEach(url => {
                                    const img = document.createElement('img');
                                    img.src = url;
                                    img.alt = room.title;
                                    img.className = 'rm-room-image';
                                    imagesContainer.appendChild(img);
                                });
                            } else {
                                imagesContainer.textContent = 'Không có hình ảnh';
                            }

                            document.getElementById('rm-modal-overlay').style.display = 'block';
                            document.getElementById('rm-view-room-modal').style.display = 'block';
                        })
                        .catch(error => console.error('Error fetching room data:', error));
                }

                function editRoom(roomId) {
                    fetch(contextPath + '/room?operation=view&id=' + roomId)
                        .then(response => response.json())
                        .then(room => {
                            document.getElementById('edit-id').value = room.id;
                            document.getElementById('edit-title').value = room.title;
                            document.getElementById('edit-price').value = room.price;
                            document.getElementById('edit-area').value = room.area;
                            document.getElementById('edit-address').value = room.address;
                            document.getElementById('edit-city').value = room.city;
                            loadEditDistrict(room.city, room.district);
                            document.getElementById('edit-description').value = room.description;
                            document.getElementById('edit-status').value = room.status;
                            // ...existing code handling images...
                            document.getElementById('rm-modal-overlay').style.display = 'block';
                            document.getElementById('rm-edit-room-modal').style.display = 'block';
                        })
                        .catch(error => console.error('Error fetching room data:', error));
                }
                
                function confirmDelete(roomId, roomTitle) {
                    document.getElementById('delete-id').value = roomId;
                    document.getElementById('delete-title').textContent = roomTitle;
                    document.getElementById('rm-modal-overlay').style.display = 'block';
                    document.getElementById('rm-delete-room-modal').style.display = 'block';
                }
                
                // Close all modals
                function closeModals() {
                    document.getElementById('rm-modal-overlay').style.display = 'none';
                    document.getElementById('rm-view-room-modal').style.display = 'none';
                    document.getElementById('rm-edit-room-modal').style.display = 'none';
                    document.getElementById('rm-add-room-modal').style.display = 'none';
                    document.getElementById('rm-delete-room-modal').style.display = 'none';
                }

                // Close modal when clicking outside
                document.getElementById('rm-modal-overlay').addEventListener('click', closeModals);

                // Image preview function
                function previewImages(inputId, previewId) {
                    const input = document.getElementById(inputId);
                    const preview = document.getElementById(previewId);
                    preview.innerHTML = '';

                    if (input.files) {
                        Array.from(input.files).forEach(file => {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                const imageWrapper = document.createElement('div');
                                imageWrapper.className = 'rm-preview-item';

                                const img = document.createElement('img');
                                img.src = e.target.result;
                                img.className = 'rm-preview-image';

                                const removeBtn = document.createElement('button');
                                removeBtn.className = 'rm-preview-remove';
                                removeBtn.innerHTML = '×';
                                removeBtn.onclick = function (e) {
                                    e.preventDefault();
                                    imageWrapper.remove();
                                    // Note: Removing from preview only. To actually remove from the file input
                                    // would require a more complex solution with a custom file list
                                };

                                imageWrapper.appendChild(img);
                                imageWrapper.appendChild(removeBtn);
                                preview.appendChild(imageWrapper);
                            };
                            reader.readAsDataURL(file);
                        });
                    }
                }

                // Filter rooms function
                function filterRooms() {
                    const statusFilter = document.getElementById('statusFilter').value;
                    const cityFilter = document.getElementById('cityFilter').value;

                    const rows = document.querySelectorAll('.rm-table tbody tr');
                    rows.forEach(row => {
                        let showRow = true;

                        // Filter by status
                        if (statusFilter !== 'all') {
                            const rowStatus = row.dataset.status;
                            if (rowStatus !== statusFilter) {
                                showRow = false;
                            }
                        }

                        // Filter by city
                        if (cityFilter !== 'all' && showRow) {
                            const rowCity = row.dataset.city;
                            if (rowCity !== cityFilter) {
                                showRow = false;
                            }
                        }

                        row.style.display = showRow ? '' : 'none';
                    });
                }

                // Thêm dynamic City/District cho modal Add và Edit
                var cityDistrictMap = {};
                <c:forEach var="c" items="${cityList}">
                    cityDistrictMap['${c.city_name}'] = [<c:forEach var="d" items="${c.district}" varStatus="status">'${d}'<c:if test="${!status.last}">, </c:if></c:forEach>];
                </c:forEach>

                // Modal Add: cập nhật district khi chọn thành phố
                document.getElementById('add-city').addEventListener('change', function () {
                    var districtSelect = document.getElementById('add-district');
                    districtSelect.innerHTML = '<option value="">Chọn quận/huyện</option>';
                    if (this.value && cityDistrictMap[this.value]) {
                        cityDistrictMap[this.value].forEach(function (district) {
                            var option = document.createElement('option');
                            option.value = district;
                            option.textContent = district;
                            districtSelect.appendChild(option);
                        });
                        districtSelect.disabled = false;
                    } else {
                        districtSelect.disabled = true;
                    }
                });

                // Modal Edit: cập nhật district khi chọn thành phố
                document.getElementById('edit-city').addEventListener('change', function () {
                    loadEditDistrict(this.value, '');
                });

                function loadEditDistrict(selectedCity, selectedDistrict) {
                    var districtSelect = document.getElementById('edit-district');
                    districtSelect.innerHTML = '<option value="">Chọn quận/huyện</option>';
                    if (selectedCity && cityDistrictMap[selectedCity]) {
                        cityDistrictMap[selectedCity].forEach(function (district) {
                            var option = document.createElement('option');
                            option.value = district;
                            option.textContent = district;
                            if (district === selectedDistrict) {
                                option.selected = true;
                            }
                            districtSelect.appendChild(option);
                        });
                        districtSelect.disabled = false;
                    } else {
                        districtSelect.disabled = true;
                    }
                }

                // Trong hàm editRoom, sau khi gán giá trị cho edit-city, gọi loadEditDistrict để tải quận hiện tại
                function editRoom(roomId) {
                    fetch('room?operation=view&id=' + roomId)
                        .then(response => response.json())
                        .then(room => {
                            document.getElementById('edit-id').value = room.id;
                            document.getElementById('edit-title').value = room.title;
                            document.getElementById('edit-price').value = room.price;
                            document.getElementById('edit-area').value = room.area;
                            document.getElementById('edit-address').value = room.address;
                            document.getElementById('edit-city').value = room.city;
                            // Load district based on room.city and set selected = room.district
                            loadEditDistrict(room.city, room.district);
                            document.getElementById('edit-description').value = room.description;
                            document.getElementById('edit-status').value = room.status;
                            // ...existing code for handling images...
                            document.getElementById('rm-modal-overlay').style.display = 'block';
                            document.getElementById('rm-edit-room-modal').style.display = 'block';
                        })
                        .catch(error => console.error('Error fetching room data:', error));
                }

                // Auto-close messages after 5 seconds
                setTimeout(function () {
                    const messages = document.querySelectorAll('.rm-message');
                    messages.forEach(function (message) {
                        message.style.display = 'none';
                    });
                }, 5000);
            </script>
        </body>

        </html>