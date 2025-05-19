<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Quản lý người dùng - StayFinder Admin</title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="assets/css/admin_sidebar.css">
            <link rel="stylesheet" href="assets/css/users_manager.css?v=1.2">
        </head>

        <body>
            <!-- Include the admin sidebar -->
            <jsp:include page="admin_sidebar.jsp" />

            <div class="um-container">
                <div class="um-content">
                    <div class="um-page-header">
                        <h1 class="um-page-title">Quản lý người dùng</h1>
                        <button class="um-btn um-btn-primary" id="um-add-user-btn">
                            <i class="fas fa-plus"></i> Thêm người dùng mới
                        </button>
                    </div>

                    <!-- Search and Filter -->
                    <div class="um-search-container">
                        <form action="admin_users" method="get" class="um-search-form">
                            <div class="um-search-group">
                                <select name="search_type" class="um-search-select">
                                    <option value="username">Tên đăng nhập</option>
                                    <option value="email">Email</option>
                                    <option value="phone">Số điện thoại</option>
                                    <option value="name">Họ và tên</option>
                                </select>
                                <div class="um-search-input-wrapper">
                                    <i class="fas fa-search um-search-icon"></i>
                                    <input type="text" name="searchtxt" class="um-search-input"
                                        placeholder="Tìm kiếm người dùng...">
                                </div>
                                <button type="submit" class="um-btn um-btn-search">Tìm kiếm</button>
                            </div>
                        </form>
                    </div>

                    <!-- Error/Success Messages -->
                    <c:if test="${not empty successMessage}">
                        <div class="um-message um-message-success">
                            <i class="fas fa-check-circle"></i> ${successMessage}
                            <button class="um-message-close"
                                onclick="this.parentElement.style.display='none'">×</button>
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMessage}">
                        <div class="um-message um-message-error">
                            <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                            <button class="um-message-close"
                                onclick="this.parentElement.style.display='none'">×</button>
                        </div>
                    </c:if>

                    <!-- Users Table -->
                    <div class="um-table-container">
                        <table class="um-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên đăng nhập</th>
                                    <th>Email</th>
                                    <th>Số điện thoại</th>
                                    <th>Họ và tên</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${userList}">
                                    <tr>
                                        <td>${user.id}</td>
                                        <td>${user.username}</td>
                                        <td>${user.email}</td>
                                        <td>${user.phone}</td>
                                        <td>${user.name}</td>
                                        <td class="um-actions">
                                            <button class="um-btn um-btn-view" onclick="viewUser('${user.id}')">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <button class="um-btn um-btn-edit" onclick="editUser('${user.id}')">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="um-btn um-btn-delete"
                                                onclick="confirmDelete('${user.id}', '${user.username}')">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination (if needed) -->
                    <div class="um-pagination">
                        <!-- Pagination content will be here -->
                    </div>
                </div>
            </div>

            <!-- Modal Overlay -->
            <div class="um-modal-overlay" id="um-modal-overlay"></div>

            <!-- Add User Modal -->
            <div class="um-modal" id="um-add-user-modal">
                <div class="um-modal-content">
                    <div class="um-modal-header">
                        <h2 class="um-modal-title">Thêm người dùng mới</h2>
                        <button class="um-modal-close" onclick="closeModals()">×</button>
                    </div>
                    <div class="um-modal-body">
                        <form id="um-add-user-form" action="user" method="post">
                            <input type="hidden" name="operation" value="add">

                            <div class="um-form-group">
                                <label for="add-username">Tên đăng nhập <span class="um-required">*</span></label>
                                <input type="text" id="add-username" name="username" required
                                    placeholder="Nhập tên đăng nhập (5-20 ký tự)">
                                <div class="um-form-hint">Tên đăng nhập từ 5-20 ký tự, không chứa ký tự đặc biệt</div>
                            </div>

                            <div class="um-form-group">
                                <label for="add-email">Email <span class="um-required">*</span></label>
                                <input type="email" id="add-email" name="email" required
                                    placeholder="Nhập địa chỉ email">
                            </div>

                            <div class="um-form-group">
                                <label for="add-name">Họ và tên <span class="um-required">*</span></label>
                                <input type="text" id="add-name" name="name" required placeholder="Nhập họ và tên">
                            </div>

                            <div class="um-form-group">
                                <label for="add-phone">Số điện thoại <span class="um-required">*</span></label>
                                <input type="tel" id="add-phone" name="phone" required placeholder="Nhập số điện thoại">
                            </div>

                            <div class="um-form-group">
                                <label for="add-password">Mật khẩu <span class="um-required">*</span></label>
                                <input type="password" id="add-password" name="password" required
                                    placeholder="Nhập mật khẩu">
                                <div class="um-form-hint">Mật khẩu ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số
                                </div>
                            </div>

                            <div class="um-form-actions">
                                <button type="button" class="um-btn um-btn-cancel" onclick="closeModals()">Hủy</button>
                                <button type="submit" class="um-btn um-btn-submit">Thêm người dùng</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- View User Modal -->
            <div class="um-modal" id="um-view-user-modal">
                <div class="um-modal-content">
                    <div class="um-modal-header">
                        <h2 class="um-modal-title">Thông tin người dùng</h2>
                        <button class="um-modal-close" onclick="closeModals()">×</button>
                    </div>
                    <div class="um-modal-body">
                        <div class="um-user-info">
                            <div class="um-info-group">
                                <span class="um-info-label">ID:</span>
                                <span class="um-info-value" id="view-id"></span>
                            </div>
                            <div class="um-info-group">
                                <span class="um-info-label">Tên đăng nhập:</span>
                                <span class="um-info-value" id="view-username"></span>
                            </div>
                            <div class="um-info-group">
                                <span class="um-info-label">Email:</span>
                                <span class="um-info-value" id="view-email"></span>
                            </div>
                            <div class="um-info-group">
                                <span class="um-info-label">Họ và tên:</span>
                                <span class="um-info-value" id="view-name"></span>
                            </div>
                            <div class="um-info-group">
                                <span class="um-info-label">Số điện thoại:</span>
                                <span class="um-info-value" id="view-phone"></span>
                            </div>
                        </div>
                        <div class="um-form-actions">
                            <button class="um-btn um-btn-primary" onclick="closeModals()">Đóng</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Edit User Modal -->
            <div class="um-modal" id="um-edit-user-modal">
                <div class="um-modal-content">
                    <div class="um-modal-header">
                        <h2 class="um-modal-title">Chỉnh sửa thông tin người dùng</h2>
                        <button class="um-modal-close" onclick="closeModals()">×</button>
                    </div>
                    <div class="um-modal-body">
                        <form id="um-edit-user-form" action="user" method="post">
                            <input type="hidden" name="operation" value="update">
                            <input type="hidden" name="id" id="edit-id">

                            <div class="um-form-group">
                                <label for="edit-username">Tên đăng nhập <span class="um-required">*</span></label>
                                <input type="text" id="edit-username" name="username" required readonly>
                                <div class="um-form-hint">Tên đăng nhập không thể thay đổi</div>
                            </div>

                            <div class="um-form-group">
                                <label for="edit-email">Email <span class="um-required">*</span></label>
                                <input type="email" id="edit-email" name="email" required>
                            </div>

                            <div class="um-form-group">
                                <label for="edit-name">Họ và tên <span class="um-required">*</span></label>
                                <input type="text" id="edit-name" name="name" required>
                            </div>

                            <div class="um-form-group">
                                <label for="edit-phone">Số điện thoại <span class="um-required">*</span></label>
                                <input type="tel" id="edit-phone" name="phone" required>
                            </div>

                            <div class="um-form-group">
                                <label for="edit-password">Mật khẩu mới</label>
                                <input type="password" id="edit-password" name="password"
                                    placeholder="Để trống nếu không thay đổi">
                                <div class="um-form-hint">Mật khẩu ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số
                                </div>
                            </div>

                            <div class="um-form-actions">
                                <button type="button" class="um-btn um-btn-cancel" onclick="closeModals()">Hủy</button>
                                <button type="submit" class="um-btn um-btn-submit">Lưu thay đổi</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Delete Confirmation Modal -->
            <div class="um-modal" id="um-delete-user-modal">
                <div class="um-modal-content">
                    <div class="um-modal-header">
                        <h2 class="um-modal-title">Xác nhận xóa người dùng</h2>
                        <button class="um-modal-close" onclick="closeModals()">×</button>
                    </div>
                    <div class="um-modal-body">
                        <p class="um-confirm-text">Bạn có chắc chắn muốn xóa người dùng <strong
                                id="delete-username"></strong>?</p>
                        <p class="um-confirm-warning">Lưu ý: Hành động này không thể hoàn tác!</p>

                        <form id="um-delete-user-form" action="user" method="get">
                            <input type="hidden" name="operation" value="delete">
                            <input type="hidden" name="id" id="delete-id">

                            <div class="um-form-actions">
                                <button type="button" class="um-btn um-btn-cancel" onclick="closeModals()">Hủy</button>
                                <button type="submit" class="um-btn um-btn-danger">Xóa người dùng</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script>
                // Open modal functions
                document.getElementById('um-add-user-btn').addEventListener('click', function () {
                    document.getElementById('um-modal-overlay').style.display = 'block';
                    document.getElementById('um-add-user-modal').style.display = 'block';
                });

                function viewUser(userId) {
                    // AJAX request to get user data
                    fetch('user?operation=view&id=' + userId)
                        .then(response => response.json())
                        .then(user => {
                            document.getElementById('view-id').textContent = user.id;
                            document.getElementById('view-username').textContent = user.username;
                            document.getElementById('view-email').textContent = user.email;
                            document.getElementById('view-name').textContent = user.name;
                            document.getElementById('view-phone').textContent = user.phone;

                            document.getElementById('um-modal-overlay').style.display = 'block';
                            document.getElementById('um-view-user-modal').style.display = 'block';
                        })
                        .catch(error => console.error('Error fetching user data:', error));
                }

                function editUser(userId) {
                    // AJAX request to get user data
                    fetch('user?operation=view&id=' + userId)
                        .then(response => response.json())
                        .then(user => {
                            document.getElementById('edit-id').value = user.id;
                            document.getElementById('edit-username').value = user.username;
                            document.getElementById('edit-email').value = user.email;
                            document.getElementById('edit-name').value = user.name;
                            document.getElementById('edit-phone').value = user.phone;

                            document.getElementById('um-modal-overlay').style.display = 'block';
                            document.getElementById('um-edit-user-modal').style.display = 'block';
                        })
                        .catch(error => console.error('Error fetching user data:', error));
                }

                function confirmDelete(userId, username) {
                    document.getElementById('delete-id').value = userId;
                    document.getElementById('delete-username').textContent = username;

                    document.getElementById('um-modal-overlay').style.display = 'block';
                    document.getElementById('um-delete-user-modal').style.display = 'block';
                }

                // Close all modals
                function closeModals() {
                    document.getElementById('um-modal-overlay').style.display = 'none';
                    document.getElementById('um-add-user-modal').style.display = 'none';
                    document.getElementById('um-view-user-modal').style.display = 'none';
                    document.getElementById('um-edit-user-modal').style.display = 'none';
                    document.getElementById('um-delete-user-modal').style.display = 'none';
                }

                // Close modal when clicking outside
                document.getElementById('um-modal-overlay').addEventListener('click', closeModals);

                // Form validation
                document.getElementById('um-add-user-form').addEventListener('submit', function (e) {
                    const username = document.getElementById('add-username').value;
                    const password = document.getElementById('add-password').value;

                    if (!username.match(/^[a-zA-Z0-9]{5,20}$/)) {
                        e.preventDefault();
                        alert('Tên đăng nhập phải từ 5-20 ký tự và không chứa ký tự đặc biệt');
                        return;
                    }

                    if (password && !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/)) {
                        e.preventDefault();
                        alert('Mật khẩu cần ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số');
                    }
                });

                document.getElementById('um-edit-user-form').addEventListener('submit', function (e) {
                    const password = document.getElementById('edit-password').value;

                    if (password && !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/)) {
                        e.preventDefault();
                        alert('Mật khẩu cần ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số');
                    }
                });

                // Auto-close messages after 5 seconds
                setTimeout(function () {
                    const messages = document.querySelectorAll('.um-message');
                    messages.forEach(function (message) {
                        message.style.display = 'none';
                    });
                }, 5000);
            </script>
        </body>

        </html>