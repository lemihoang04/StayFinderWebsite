<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng tin phòng trọ - StayFinder</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/header.css?v=1.1">
        <link rel="stylesheet" href="assets/css/footer.css">
        <link rel="stylesheet" href="assets/css/addroom.css">
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <main>
            <div class="container">
                <div class="add-room-container">
                    <div class="page-header">
                        <h1>Đăng tin cho thuê phòng trọ</h1>
                        <p>Điền đầy đủ thông tin để đăng tin hiệu quả hơn</p>
                    </div>

                    <!-- Hiển thị thông báo lỗi nếu có -->
                    <% String error=(String) request.getAttribute("error"); if (error !=null && !error.isEmpty()) { %>
                        <div class="alert alert-danger"
                            style="color: #b94a48; background: #f2dede; border: 1px solid #eed3d7; padding: 10px; margin-bottom: 20px;">
                            <%= error %>
                        </div>
                        <% } %>

                            <form id="addRoomForm" action="add-room" method="post" enctype="multipart/form-data">
                                <div class="form-section">
                                    <h2>Thông tin cơ bản</h2>

                                    <div class="form-group">
                                        <label for="title">Tiêu đề <span class="required">*</span></label>
                                        <input type="text" id="title" name="title" placeholder="Nhập tiêu đề tin đăng"
                                            required>
                                        <small class="form-text">Tiêu đề ngắn gọn, đầy đủ thông tin quan trọng của phòng
                                            trọ</small>
                                    </div>

                                    <div class="form-group">
                                        <label for="description">Mô tả chi tiết <span class="required">*</span></label>
                                        <textarea id="description" name="description" rows="6"
                                            placeholder="Mô tả chi tiết về phòng trọ của bạn" required></textarea>
                                        <small class="form-text">Cung cấp thông tin chi tiết về phòng trọ, tiện ích xung
                                            quanh,
                                            điều kiện sống, v.v.</small>
                                    </div>

                                    <div class="form-row">
                                        <div class="form-group">
                                            <label for="price">Giá cho thuê <span class="required">*</span></label>
                                            <div class="input-with-unit">
                                                <input type="number" id="price" name="price" min="0" step="100000"
                                                    placeholder="Nhập giá cho thuê" required>
                                                <span class="unit">VNĐ/tháng</span>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="area">Diện tích <span class="required">*</span></label>
                                            <div class="input-with-unit">
                                                <input type="number" id="area" name="area" min="1" step="0.5"
                                                    placeholder="Nhập diện tích" required>
                                                <span class="unit">m²</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-section">
                                    <h2>Địa chỉ cho thuê</h2>

                                    <div class="form-group">
                                        <label for="city">Tỉnh/Thành phố <span class="required">*</span></label>
                                        <select id="city" name="city" required>
                                            <option value="">Chọn Tỉnh/Thành phố</option>
                                            <c:forEach var="c" items="${cityList}">
                                                <option value="${c.city_name}">${c.city_name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="district">Quận/Huyện <span class="required">*</span></label>
                                        <select id="district" name="district" disabled required>
                                            <option value="">Chọn Quận/Huyện</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="address">Địa chỉ cụ thể <span class="required">*</span></label>
                                        <input type="text" id="address" name="address"
                                            placeholder="Số nhà, tên đường, phường/xã" required>
                                        <small class="form-text">VD: 123 Nguyễn Văn Linh, Phường Tân Thuận Đông</small>
                                    </div>
                                </div>

                                <div class="form-section">
                                    <h2>Hình ảnh & Media</h2>

                                    <div class="form-group">
                                        <label for="images">Hình ảnh <span class="required">*</span></label>
                                        <div class="image-uploader">
                                            <div class="upload-placeholder" id="uploadPlaceholder">
                                                <i class="fas fa-cloud-upload-alt"></i>
                                                <p>Kéo thả hình ảnh vào đây hoặc nhấp để chọn</p>
                                                <small>Tối đa 8 hình ảnh, định dạng JPG, PNG. Dung lượng tối đa: 2MB mỗi
                                                    ảnh.</small>
                                            </div>
                                            <input type="file" id="images" name="images" accept="image/*" multiple
                                                required hidden>
                                            <div class="image-preview" id="imagePreview"></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-section">
                                    <h2>Thông tin liên hệ & Khác</h2>

                                    <div class="form-group">
                                        <label for="expiryDate">Thời hạn đăng tin <span
                                                class="required">*</span></label>
                                        <select id="expiryDate" name="expiry_date" required>
                                            <option value="7">7 ngày</option>
                                            <option value="15">15 ngày</option>
                                            <option value="30" selected>30 ngày</option>
                                            <option value="60">60 ngày</option>
                                            <option value="90">90 ngày</option>
                                        </select>
                                    </div>

                                    <div class="form-group checkbox-group">
                                        <input type="checkbox" id="terms" name="terms" required>
                                        <label for="terms">Tôi đồng ý với <a href="#">Điều khoản dịch vụ</a> và <a
                                                href="#">Quy
                                                định đăng tin</a> của StayFinder</label>
                                    </div>
                                </div>

                                <div class="form-actions">
                                    <button type="submit" class="btn-primary">Đăng tin ngay</button>
                                    <button type="button" class="btn-outline" id="saveAsDraft">Lưu nháp</button>
                                </div>
                            </form>
                </div>
            </div>
        </main>

        <jsp:include page="footer.jsp" />

        <script>
            // Handle image upload preview
            const uploadPlaceholder = document.getElementById('uploadPlaceholder');
            const imageInput = document.getElementById('images');
            const imagePreview = document.getElementById('imagePreview');

            uploadPlaceholder.addEventListener('click', () => {
                imageInput.click();
            });

            imageInput.addEventListener('change', function () {
                if (this.files) {
                    uploadPlaceholder.style.display = 'none';
                    imagePreview.innerHTML = '';

                    if (this.files.length > 8) {
                        alert('Bạn chỉ được phép tải lên tối đa 8 ảnh');
                        this.value = '';
                        uploadPlaceholder.style.display = 'flex';
                        return;
                    }

                    for (let i = 0; i < this.files.length; i++) {
                        const file = this.files[i];
                        if (file.size > 2 * 1024 * 1024) {
                            alert(`Ảnh "${file.name}" vượt quá dung lượng cho phép (2MB)`);
                            continue;
                        }

                        const reader = new FileReader();
                        reader.onload = function (e) {
                            const imgContainer = document.createElement('div');
                            imgContainer.className = 'img-container';

                            const img = document.createElement('img');
                            img.src = e.target.result;
                            img.alt = 'Room Image';

                            const removeBtn = document.createElement('button');
                            removeBtn.type = 'button';
                            removeBtn.className = 'remove-image';
                            removeBtn.innerHTML = '<i class="fas fa-times"></i>';
                            removeBtn.setAttribute('data-index', i);
                            removeBtn.addEventListener('click', function () {
                                imgContainer.remove();
                                if (imagePreview.children.length === 0) {
                                    uploadPlaceholder.style.display = 'flex';
                                    imageInput.value = '';
                                }
                            });

                            imgContainer.appendChild(img);
                            imgContainer.appendChild(removeBtn);
                            imagePreview.appendChild(imgContainer);
                        }
                        reader.readAsDataURL(file);
                    }
                }
            });

            // City/District dynamic dropdown
            var cityDistrictMap = {};
            <c:forEach var="c" items="${cityList}">
                cityDistrictMap['${c.city_name}'] = [<c:forEach var="d" items="${c.district}" varStatus="status">'${d}'<c:if test="${!status.last}">, </c:if></c:forEach>];
            </c:forEach>

            const citySelect = document.getElementById('city');
            const districtSelect = document.getElementById('district');
            citySelect.addEventListener('change', function () {
                districtSelect.disabled = false;
                districtSelect.innerHTML = '<option value="">Chọn Quận/Huyện</option>';
                if (this.value && cityDistrictMap[this.value]) {
                    cityDistrictMap[this.value].forEach(function (district) {
                        let option = document.createElement('option');
                        option.value = district;
                        option.textContent = district;
                        districtSelect.appendChild(option);
                    });
                } else {
                    districtSelect.disabled = true;
                }
            });

            // Form validation
            document.getElementById('addRoomForm').addEventListener('submit', function (event) {
                const title = document.getElementById('title');
                const description = document.getElementById('description');
                const price = document.getElementById('price');
                const area = document.getElementById('area');
                const city = document.getElementById('city');
                const district = document.getElementById('district');
                const address = document.getElementById('address');
                const images = document.getElementById('images');

                let isValid = true;

                // Validate title (min length 10, max length 100)
                if (title.value.trim().length < 10 || title.value.trim().length > 100) {
                    alert('Tiêu đề phải từ 10 đến 100 ký tự');
                    title.focus();
                    isValid = false;
                }

                // Validate description (min length 30)
                else if (description.value.trim().length < 30) {
                    alert('Mô tả phải có ít nhất 30 ký tự');
                    description.focus();
                    isValid = false;
                }

                // Validate price
                else if (price.value <= 0) {
                    alert('Giá cho thuê phải lớn hơn 0');
                    price.focus();
                    isValid = false;
                }

                // Validate area
                else if (area.value <= 0) {
                    alert('Diện tích phải lớn hơn 0');
                    area.focus();
                    isValid = false;
                }

                // Validate images (at least 1 image)
                else if (images.files.length === 0) {
                    alert('Vui lòng tải lên ít nhất 1 hình ảnh');
                    isValid = false;
                }

                if (!isValid) {
                    event.preventDefault();
                }
            });

            // Handle draft saving
            document.getElementById('saveAsDraft').addEventListener('click', function () {
                // Save form data to localStorage or send to server with draft status
                alert('Đã lưu tin đăng dưới dạng bản nháp');
            });
        </script>
    </body>

    </html>