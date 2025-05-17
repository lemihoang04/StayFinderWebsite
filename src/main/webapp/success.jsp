<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thành công - StayFinder</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/header.css">
        <link rel="stylesheet" href="assets/css/footer.css">
        <style>
            .success-container {
                max-width: 600px;
                margin: 80px auto;
                padding: 40px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .success-icon {
                font-size: 80px;
                color: #3498db;
                margin-bottom: 20px;
            }

            .success-message {
                font-size: 24px;
                color: #333;
                margin-bottom: 20px;
            }

            .success-description {
                color: #666;
                margin-bottom: 30px;
            }

            .btn-group {
                display: flex;
                justify-content: center;
                gap: 15px;
            }

            .btn {
                padding: 12px 25px;
                border-radius: 4px;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s;
            }

            .btn-primary {
                background-color: #3498db;
                color: #fff;
            }

            .btn-primary:hover {
                background-color: #2980b9;
            }

            .btn-outline {
                border: 1px solid #3498db;
                color: #3498db;
            }

            .btn-outline:hover {
                background-color: #f1f9fe;
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <main>
            <div class="success-container">
                <div class="success-icon">
                    <i class="fas fa-check-circle"></i>
                </div>

                <h1 class="success-message">Thành công!</h1>

                <p class="success-description">
                    ${message}
                </p>

                <div class="btn-group">
                    <a href="my-rooms" class="btn btn-primary">Xem tin đã đăng</a>
                    <a href="index.jsp" class="btn btn-outline">Quay về trang chủ</a>
                </div>
            </div>
        </main>

        <jsp:include page="footer.jsp" />
    </body>

    </html>