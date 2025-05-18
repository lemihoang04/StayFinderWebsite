<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Quản lý phòng trọ - StayFinder</title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="assets/css/header.css">
                <link rel="stylesheet" href="assets/css/footer.css">
                <link rel="stylesheet" href="assets/css/my-rooms.css">
            </head>

            <body>
                <jsp:include page="header.jsp" />

                <main>
                    <div class="container">
                        <div class="dashboard-header">
                            <h1>Quản lý tin đăng</h1>
                            <a href="add-room" class="btn-add-room">
                                <i class="fas fa-plus-circle"></i> Đăng tin mới
                            </a>
                        </div>

                        <c:if test="${not empty message}">
                            <div class="alert alert-success">
                                <c:out value="${message}" />
                            </div>
                        </c:if>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">
                                <c:out value="${error}" />
                            </div>
                        </c:if>

                        <div class="room-filters">
                            <select id="statusFilter">
                                <option value="all">Tất cả trạng thái</option>
                                <option value="available">Đang hiển thị</option>
                                <option value="pending">Đang chờ duyệt</option>
                                <option value="expired">Hết hạn</option>
                            </select>

                            <div class="search-box">
                                <input type="text" id="searchMyRooms" placeholder="Tìm kiếm tin đăng...">
                                <button type="button">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>

                        <!-- Thiết lập locale để định dạng tiền tệ -->
                        <fmt:setLocale value="vi_VN" />

                        <!-- Kiểm tra và lọc phòng của người dùng -->
                        <c:set var="hasRooms" value="false" />
                        <c:if test="${not empty roomList}">
                            <c:set var="myRooms" value="[]" />
                            <c:forEach var="room" items="${roomList}">
                                <c:if test="${not empty room.user_id && room.user_id eq user.id}">
                                    <c:set var="hasRooms" value="true" />
                                </c:if>
                            </c:forEach>
                        </c:if>

                        <c:choose>
                            <c:when test="${hasRooms}">
                                <div class="my-rooms-container">
                                    <table class="my-rooms-table">
                                        <thead>
                                            <tr>
                                                <th>Ảnh</th>
                                                <th>Tiêu đề</th>
                                                <th>Giá</th>
                                                <th>Ngày đăng</th>
                                                <th>Trạng thái</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="room" items="${roomList}">
                                                <c:if test="${not empty room.user_id && room.user_id eq user.id}">
                                                    <tr class="room-row" data-status="${room.status}">
                                                        <td class="room-img">
                                                            <c:set var="firstImage"
                                                                value="assets/images/default-room.jpg" />
                                                            <c:if test="${not empty room.images}">
                                                                <c:set var="imageArray"
                                                                    value="${room.images.split(',')}" />
                                                                <c:if test="${not empty imageArray[0]}">
                                                                    <c:set var="firstImage" value="${imageArray[0]}" />
                                                                </c:if>
                                                            </c:if>
                                                            <img src="${firstImage}" alt="${room.title}">
                                                        </td>
                                                        <td class="room-title">
                                                            <a href="room-info?id=${room.id}">${room.title}</a>
                                                            <p class="room-address"><i
                                                                    class="fas fa-map-marker-alt"></i> ${room.address},
                                                                ${room.district}, ${room.city}</p>
                                                        </td>
                                                        <td class="room-price">
                                                            <fmt:formatNumber value="${room.price}" type="currency" />
                                                            /tháng
                                                        </td>
                                                        <td class="room-date">
                                                            ${room.createdAt}<br>Hết hạn: ${room.expiryDate}
                                                        </td>
                                                        <td class="room-status">
                                                            <c:choose>
                                                                <c:when test="${room.status eq 'available'}">
                                                                    <span class="status-badge status-active">Đang hiển
                                                                        thị</span>
                                                                </c:when>
                                                                <c:when test="${room.status eq 'pending'}">
                                                                    <span class="status-badge status-pending">Đang chờ
                                                                        duyệt</span>
                                                                </c:when>
                                                                <c:when test="${room.status eq 'expired'}">
                                                                    <span class="status-badge status-expired">Hết
                                                                        hạn</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="status-badge">${room.status}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="room-actions">
                                                            <a href="room-detail?id=${room.id}" class="btn-view"
                                                                title="Xem chi tiết">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <a href="edit-room?id=${room.id}" class="btn-edit"
                                                                title="Sửa tin">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <a href="#" class="btn-delete" title="Xóa tin"
                                                                onclick="confirmDelete('${room.id}', '${room.title}')">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </a>
                                                            <c:if test="${room.status eq 'expired'}">
                                                                <a href="#" class="btn-renew" title="Gia hạn"
                                                                    onclick="renewListing('${room.id}')">
                                                                    <i class="fas fa-sync-alt"></i>
                                                                </a>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <img src="assets/images/empty-rooms.svg" alt="Không có phòng trọ">
                                    <h2>Bạn chưa có tin đăng nào</h2>
                                    <p>Hãy đăng tin cho thuê phòng trọ để tiếp cận hàng ngàn người tìm phòng mỗi ngày.
                                    </p>
                                    <a href="add-room" class="btn-primary">Đăng tin ngay</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </main>

                <jsp:include page="footer.jsp" />

                <!-- Confirm Delete Modal -->
                <div id="deleteModal" class="modal">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <h2>Xác nhận xóa</h2>
                        <p>Bạn có chắc chắn muốn xóa tin đăng "<span id="deleteRoomTitle"></span>"?</p>
                        <p class="warning">Lưu ý: Hành động này không thể hoàn tác.</p>
                        <div class="modal-actions">
                            <button id="confirmDelete" class="btn-danger">Xóa tin</button>
                            <button id="cancelDelete" class="btn-outline">Hủy</button>
                        </div>
                    </div>
                </div>

                <script>
                    // Filter rooms by status
                    document.getElementById('statusFilter').addEventListener('change', function () {
                        const status = this.value;
                        const rows = document.querySelectorAll('.room-row');

                        rows.forEach(row => {
                            if (status === 'all' || row.getAttribute('data-status') === status) {
                                row.style.display = 'table-row';
                            } else {
                                row.style.display = 'none';
                            }
                        });
                    });

                    // Search in my rooms
                    document.getElementById('searchMyRooms').addEventListener('input', function () {
                        const searchText = this.value.toLowerCase();
                        const rows = document.querySelectorAll('.room-row');

                        rows.forEach(row => {
                            const title = row.querySelector('.room-title a').textContent.toLowerCase();
                            const address = row.querySelector('.room-address').textContent.toLowerCase();

                            if (title.includes(searchText) || address.includes(searchText)) {
                                row.style.display = 'table-row';
                            } else {
                                row.style.display = 'none';
                            }
                        });
                    });

                    // Modal handling
                    const modal = document.getElementById('deleteModal');
                    const span = document.getElementsByClassName('close')[0];
                    let roomIdToDelete = '';

                    function confirmDelete(roomId, roomTitle) {
                        roomIdToDelete = roomId;
                        document.getElementById('deleteRoomTitle').textContent = roomTitle;
                        modal.style.display = 'block';
                    }

                    // Close modal when clicking X
                    span.onclick = function () {
                        modal.style.display = 'none';
                    }

                    // Close modal when clicking outside
                    window.onclick = function (event) {
                        if (event.target === modal) {
                            modal.style.display = 'none';
                        }
                    }

                    // Handle confirm delete button
                    document.getElementById('confirmDelete').onclick = function () {
                        if (roomIdToDelete) {
                            window.location.href = 'delete-room?id=' + roomIdToDelete;
                        }
                    }

                    // Handle cancel button
                    document.getElementById('cancelDelete').onclick = function () {
                        modal.style.display = 'none';
                    }

                    // Renew listing functionality
                    function renewListing(roomId) {
                        // Có thể thực hiện gia hạn trực tiếp hoặc chuyển đến trang gia hạn
                        if (confirm('Bạn có muốn gia hạn tin đăng này?')) {
                            // Có thể gửi request để gia hạn tin đăng
                            alert('Chức năng gia hạn sẽ được cập nhật sau!');
                        }
                    }
                </script>
            </body>

            </html>