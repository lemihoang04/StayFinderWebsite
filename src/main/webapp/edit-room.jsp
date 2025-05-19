<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Chỉnh sửa tin đăng - StayFinder</title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="assets/css/header.css?v=1.0">
                <link rel="stylesheet" href="assets/css/footer.css">
                <link rel="stylesheet" href="assets/css/edit-room.css">
            </head>

            <body>
                <jsp:include page="header.jsp" />

                <main>
                    <div class="container">
                        <div class="edit-room-container">
                            <div class="page-header">
                                <h1>Chỉnh sửa tin đăng</h1>
                                <p>Cập nhật thông tin cho tin đăng của bạn</p>
                            </div>

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">
                                    <c:out value="${error}" />
                                </div>
                            </c:if>

                            <form id="editRoomForm" action="edit-room" method="post" enctype="multipart/form-data">
                                <!-- Trường ẩn để lưu ID của phòng -->
                                <input type="hidden" name="id" value="${room.id}">

                                <div class="form-section">
                                    <h2>Thông tin cơ bản</h2>

                                    <div class="form-group">
                                        <label for="title">Tiêu đề <span class="required">*</span></label>
                                        <input type="text" id="title" name="title" value="${room.title}"
                                            placeholder="Nhập tiêu đề tin đăng" required>
                                        <small class="form-text">Tiêu đề ngắn gọn, đầy đủ thông tin quan trọng của phòng
                                            trọ</small>
                                    </div>

                                    <div class="form-group">
                                        <label for="description">Mô tả chi tiết <span class="required">*</span></label>
                                        <textarea id="description" name="description" rows="6" required
                                            placeholder="Mô tả chi tiết về phòng trọ của bạn">${room.description}</textarea>
                                        <small class="form-text">Cung cấp thông tin chi tiết về phòng trọ, tiện ích xung
                                            quanh, điều kiện sống, v.v.</small>
                                    </div>

                                    <div class="form-row">
                                        <div class="form-group">
                                            <label for="price">Giá cho thuê <span class="required">*</span></label>
                                            <div class="input-with-unit">
                                                <input type="number" id="price" name="price" min="0" step="100000"
                                                    value="${room.price}" placeholder="Nhập giá cho thuê" required>
                                                <span class="unit">VNĐ/tháng</span>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="area">Diện tích <span class="required">*</span></label>
                                            <div class="input-with-unit">
                                                <input type="number" id="area" name="area" min="1" step="0.5"
                                                    value="${room.area}" placeholder="Nhập diện tích" required>
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
                                                <option value="${c.city_name}" ${room.city==c.city_name ? 'selected' : '' }>${c.city_name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="district">Quận/Huyện <span class="required">*</span></label>
                                        <select id="district" name="district" required>
                                            <option value="">Chọn Quận/Huyện</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="address">Địa chỉ cụ thể <span class="required">*</span></label>
                                        <input type="text" id="address" name="address" value="${room.address}"
                                            placeholder="Số nhà, tên đường, phường/xã" required>
                                        <small class="form-text">VD: 123 Nguyễn Văn Linh, Phường Tân Thuận Đông</small>
                                    </div>
                                </div>

                                <div class="form-section">
                                    <h2>Hình ảnh & Media</h2>

                                    <div class="form-group">
                                        <label>Hình ảnh hiện tại</label>
                                        <div class="current-images" id="currentImages">
                                            <c:if test="${not empty room.images}">
                                                <c:forEach var="image" items="${room.images.split(',')}"
                                                    varStatus="status">
                                                    <div class="img-container" id="img-${status.index}">
                                                        <img src="${image}" alt="Phòng trọ">
                                                        <button type="button" class="remove-current-image"
                                                            data-image="${image}"
                                                            onclick="removeCurrentImage('${status.index}', '${image}')">
                                                            <i class="fas fa-times"></i>
                                                        </button>
                                                        <input type="hidden" name="keepImages" value="${image}"
                                                            class="keep-image">
                                                    </div>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                        <small class="form-text">Ảnh đã tải lên trước đây. Nhấp vào nút X để xóa ảnh
                                            không muốn giữ lại.</small>
                                        <input type="hidden" name="deletedImages" id="deletedImages" value="">
                                    </div>

                                    <div class="form-group">
                                        <label for="images">Tải ảnh mới (tùy chọn)</label>
                                        <div class="image-uploader">
                                            <div class="upload-placeholder" id="uploadPlaceholder">
                                                <i class="fas fa-cloud-upload-alt"></i>
                                                <p>Kéo thả hình ảnh vào đây hoặc nhấp để chọn</p>
                                                <small>Tối đa 8 hình ảnh, định dạng JPG, PNG. Dung lượng tối đa: 2MB mỗi
                                                    ảnh.</small>
                                            </div>
                                            <input type="file" id="images" name="images" accept="image/*" multiple
                                                hidden>
                                            <div class="image-preview" id="imagePreview"></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-section">
                                    <h2>Thời hạn đăng tin</h2>

                                    <div class="form-group">
                                        <label for="expiryDate">Gia hạn thêm</label>
                                        <select id="expiryDate" name="expiry_date">
                                            <option value="">Giữ nguyên thời hạn</option>
                                            <option value="7">Thêm 7 ngày</option>
                                            <option value="15">Thêm 15 ngày</option>
                                            <option value="30">Thêm 30 ngày</option>
                                            <option value="60">Thêm 60 ngày</option>
                                            <option value="90">Thêm 90 ngày</option>
                                        </select>
                                        <small class="form-text">Ngày hết hạn hiện tại: ${room.expiryDate}</small>
                                    </div>
                                </div>

                                <div class="form-actions">
                                    <button type="submit" class="btn-primary">Lưu thay đổi</button>
                                    <a href="my-rooms" class="btn-outline">Hủy</a>
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
                    const deletedImagesInput = document.getElementById('deletedImages');
                    let deletedImages = [];

                    // Xử lý xóa ảnh cũ - sửa lại để hoạt động chính xác
                    function removeCurrentImage(index, imagePath) {
                        // Tìm đúng img-container chứa ảnh cần xóa dựa vào data-image
                        const containers = document.querySelectorAll('.current-images .img-container');
                        containers.forEach(container => {
                            const btn = container.querySelector('.remove-current-image');
                            if (btn && btn.getAttribute('data-image') === imagePath) {
                                container.remove();
                            }
                        });
                        // Thêm vào mảng xóa và cập nhật input ẩn
                        if (!deletedImages.includes(imagePath)) {
                            deletedImages.push(imagePath);
                            deletedImagesInput.value = deletedImages.join(',');
                        }
                        // Xóa input hidden keepImages tương ứng
                        const keepImageInputs = document.querySelectorAll('input.keep-image[value="' + imagePath + '"]');
                        keepImageInputs.forEach(input => input.remove());

                        // Kiểm tra nếu không còn ảnh nào
                        if (document.querySelectorAll('.current-images .img-container').length === 0) {
                            document.getElementById('currentImages').innerHTML =
                                '<div class="no-images">Chưa có ảnh nào được chọn</div>';
                        }
                    }

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
                    // Xây dựng mapping từ cityList cho district
                    var cityDistrictMap = {};
                    <c:forEach var="c" items="${cityList}">
                        cityDistrictMap['${c.city_name}'] = [<c:forEach var="d" items="${c.district}" varStatus="status">'${d}'<c:if test="${!status.last}">, </c:if></c:forEach>];
                    </c:forEach>
                    
                    const citySelect = document.getElementById('city');
                    const districtSelect = document.getElementById('district');
                    
                    function loadDistricts(city, selectedDistrict) {
                        districtSelect.innerHTML = '<option value="">Chọn Quận/Huyện</option>';
                        if (cityDistrictMap[city]) {
                            cityDistrictMap[city].forEach(function(district) {
                                const option = document.createElement('option');
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
                    
                    // Khi trang load, tải danh sách quận với giá trị đã lưu
                    window.addEventListener('DOMContentLoaded', function () {
                        if (citySelect.value) {
                            loadDistricts(citySelect.value, "${room.district}");
                        }
                    });
                    
                    citySelect.addEventListener('change', function () {
                        loadDistricts(this.value, '');
                    });
                    // Form validation
                    document.getElementById('editRoomForm').addEventListener('submit', function (event) {
                        const title = document.getElementById('title');
                        const description = document.getElementById('description');
                        const price = document.getElementById('price');
                        const area = document.getElementById('area');

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

                        if (!isValid) {
                            event.preventDefault();
                        }
                    });
                </script>
            </body>

            </html>