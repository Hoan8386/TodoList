<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>TodoList - Quản Lý Công Việc Hiệu Quả</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

        <style>
            :root {
                --primary-color: #F1600D;
                --primary-dark: #D14400;
                --primary-light: #FF8046;
            }

            body {
                font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
                overflow-x: hidden;
                position: relative;
            }

            .navbar {
                padding: 15px 0;
                background-color: white;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            }

            .navbar-brand {
                font-weight: 700;
                font-size: 1.8rem;
                color: var(--primary-color);
            }

            .login-btn {
                background-color: white;
                color: var(--primary-color);
                border: 2px solid var(--primary-color);
                padding: 8px 25px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .login-btn:hover {
                background-color: var(--primary-color);
                color: white;
            }

            section {
                padding: 80px 0;
            }

            h1,
            h2,
            h3,
            h4,
            h5,
            h6 {
                color: #333;
            }

            .section-title {
                margin-bottom: 50px;
                font-weight: 700;
                color: var(--primary-color);
                position: relative;
                padding-bottom: 15px;
            }

            .section-title:after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 60px;
                height: 3px;
                background-color: var(--primary-color);
            }

            .center-title:after {
                left: 50%;
                transform: translateX(-50%);
            }

            .hero {
                background: linear-gradient(135deg, rgba(241, 96, 13, 0.1) 0%, rgba(255, 255, 255, 1) 100%);
                padding: 120px 0 80px;
            }

            .hero h1 {
                font-size: 2.8rem;
                font-weight: 700;
                margin-bottom: 25px;
            }

            .hero p {
                font-size: 1.1rem;
                margin-bottom: 30px;
                color: #555;
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                padding: 12px 30px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(241, 96, 13, 0.3);
            }

            .hero-image {
                max-width: 90%;
                border-radius: 10px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            }

            .feature-box {
                padding: 30px;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                height: 100%;
                transition: all 0.3s ease;
            }

            .feature-box:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            }

            .feature-icon {
                width: 70px;
                height: 70px;
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: rgba(241, 96, 13, 0.1);
                color: var(--primary-color);
                border-radius: 50%;
                font-size: 30px;
                margin-bottom: 25px;
            }

            .feature-box h3 {
                font-weight: 600;
                margin-bottom: 15px;
            }

            .testimonial {
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
                margin-bottom: 30px;
            }

            .testimonial-text {
                font-style: italic;
                margin-bottom: 20px;
                color: #555;
            }

            .testimonial-author {
                display: flex;
                align-items: center;
            }

            .testimonial-avatar {
                width: 50px;
                height: 50px;
                background-color: #eee;
                border-radius: 50%;
                margin-right: 15px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 700;
                color: #777;
            }

            .cta-section {
                background-color: var(--primary-color);
                color: white;
                padding: 60px 0;
            }

            .cta-section h2 {
                color: white;
                margin-bottom: 20px;
            }

            .cta-section .btn {
                background-color: white;
                color: var(--primary-color);
                border: none;
                font-weight: 600;
                padding: 12px 30px;
            }

            .cta-section .btn:hover {
                background-color: rgba(255, 255, 255, 0.9);
                transform: translateY(-3px);
            }

            footer {
                background-color: #333;
                color: #aaa;
                padding: 40px 0 20px;
            }

            footer h5 {
                color: white;
                margin-bottom: 20px;
                font-weight: 600;
            }

            footer ul {
                list-style: none;
                padding-left: 0;
            }

            footer ul li {
                margin-bottom: 10px;
            }

            footer ul li a {
                color: #aaa;
                text-decoration: none;
                transition: all 0.3s;
            }

            footer ul li a:hover {
                color: white;
                text-decoration: none;
            }

            .social-icons a {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 40px;
                height: 40px;
                background-color: rgba(255, 255, 255, 0.1);
                color: white;
                border-radius: 50%;
                margin-right: 10px;
                transition: all 0.3s;
            }

            .social-icons a:hover {
                background-color: var(--primary-color);
                transform: translateY(-3px);
            }

            .copyright {
                border-top: 1px solid rgba(255, 255, 255, 0.1);
                padding-top: 20px;
                margin-top: 40px;
                text-align: center;
            }
        </style>
    </head>

    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg sticky-top">
            <div class="container">
                <a class="navbar-brand" href="#">TodoList</a>
                <form action="/login" method="get" class="ms-auto">
                    <button type="submit" class="btn login-btn">Đăng Nhập</button>
                </form>
            </div>
        </nav>

        <!-- Hero Section -->
        <section class="hero">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <h1>Quản Lý Công Việc Dễ Dàng Và Hiệu Quả</h1>
                        <p class="lead">TodoList giúp bạn sắp xếp công việc, theo dõi tiến độ và hoàn thành mục tiêu
                            nhanh chóng. Trải nghiệm ngay công cụ quản lý công việc đơn giản nhưng mạnh mẽ.</p>
                        <a href="register.jsp" class="btn btn-primary btn-lg">Bắt Đầu Miễn Phí</a>
                    </div>
                    <div class="col-lg-6 text-center">
                        <img src="/api/placeholder/600/400" alt="TodoList Preview" class="img-fluid hero-image">
                    </div>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section id="features">
            <div class="container">
                <h2 class="section-title center-title text-center">Tính Năng Nổi Bật</h2>
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="feature-box">
                            <div class="feature-icon">
                                <i class="bi bi-list-check"></i>
                            </div>
                            <h3>Quản Lý Công Việc</h3>
                            <p>Tạo và quản lý danh sách công việc một cách dễ dàng. Sắp xếp theo mức độ ưu tiên và thời
                                hạn.</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="feature-box">
                            <div class="feature-icon">
                                <i class="bi bi-bell"></i>
                            </div>
                            <h3>Nhắc Nhở Thông Minh</h3>
                            <p>Nhận thông báo nhắc nhở trước thời hạn để không bỏ lỡ bất kỳ công việc quan trọng nào.
                            </p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="feature-box">
                            <div class="feature-icon">
                                <i class="bi bi-graph-up"></i>
                            </div>
                            <h3>Thống Kê & Báo Cáo</h3>
                            <p>Theo dõi hiệu suất làm việc của bạn qua các biểu đồ và báo cáo trực quan.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- How It Works -->
        <section id="how-it-works" class="bg-light">
            <div class="container">
                <h2 class="section-title center-title text-center">Cách Thức Hoạt Động</h2>
                <div class="row text-center">
                    <div class="col-md-4 mb-4">
                        <div class="p-4">
                            <div class="mb-4">
                                <i class="bi bi-person-plus-fill text-primary"
                                    style="font-size: 48px; color: var(--primary-color)"></i>
                            </div>
                            <h3>Đăng Ký</h3>
                            <p>Tạo tài khoản miễn phí chỉ với email và mật khẩu của bạn.</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="p-4">
                            <div class="mb-4">
                                <i class="bi bi-plus-circle-fill"
                                    style="font-size: 48px; color: var(--primary-color)"></i>
                            </div>
                            <h3>Tạo Công Việc</h3>
                            <p>Thêm công việc cần làm, đặt thời hạn và mức độ ưu tiên.</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="p-4">
                            <div class="mb-4">
                                <i class="bi bi-check-circle-fill"
                                    style="font-size: 48px; color: var(--primary-color)"></i>
                            </div>
                            <h3>Hoàn Thành</h3>
                            <p>Theo dõi tiến độ và đánh dấu công việc đã hoàn thành.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Testimonials -->
        <section id="testimonials">
            <div class="container">
                <h2 class="section-title center-title text-center">Người Dùng Nói Gì Về Chúng Tôi</h2>
                <div class="row">
                    <div class="col-md-6 mb-4">
                        <div class="testimonial">
                            <p class="testimonial-text">"TodoList đã giúp tôi tổ chức công việc hiệu quả hơn rất nhiều.
                                Giao diện đơn giản, dễ sử dụng nhưng đầy đủ tính năng cần thiết."</p>
                            <div class="testimonial-author">
                                <div class="testimonial-avatar">NVA</div>
                                <div>
                                    <h5 class="mb-0">Nguyễn Văn A</h5>
                                    <p class="mb-0">Quản lý dự án</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4">
                        <div class="testimonial">
                            <p class="testimonial-text">"Là một người làm nhiều công việc cùng lúc, TodoList giúp tôi
                                không bị quên bất kỳ nhiệm vụ nào. Tính năng đồng bộ giữa điện thoại và máy tính thật
                                tuyệt vời."</p>
                            <div class="testimonial-author">
                                <div class="testimonial-avatar">TML</div>
                                <div>
                                    <h5 class="mb-0">Trần Minh L</h5>
                                    <p class="mb-0">Nhà thiết kế tự do</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Call to Action -->
        <section class="cta-section">
            <div class="container text-center">
                <h2>Sẵn Sàng Tăng Năng Suất Của Bạn?</h2>
                <p class="lead mb-4">Đăng ký miễn phí ngay hôm nay và trải nghiệm sự khác biệt với TodoList.</p>
                <a href="register.jsp" class="btn btn-lg">Bắt Đầu Ngay - Miễn Phí</a>
            </div>
        </section>

        <!-- Footer -->
        <footer>
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 mb-4">
                        <h5>TodoList</h5>
                        <p>Giải pháp quản lý công việc hiệu quả dành cho cá nhân và doanh nghiệp.</p>
                        <div class="social-icons">
                            <a href="#"><i class="bi bi-facebook"></i></a>
                            <a href="#"><i class="bi bi-twitter"></i></a>
                            <a href="#"><i class="bi bi-instagram"></i></a>
                            <a href="#"><i class="bi bi-linkedin"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-6 mb-4">
                        <h5>Liên Kết</h5>
                        <ul>
                            <li><a href="#">Trang Chủ</a></li>
                            <li><a href="#features">Tính Năng</a></li>
                            <li><a href="#testimonials">Nhận Xét</a></li>
                            <li><a href="#">Hỗ Trợ</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <h5>Liên Hệ</h5>
                        <ul>
                            <li><i class="bi bi-envelope me-2"></i> support@todolist.com</li>
                            <li><i class="bi bi-telephone me-2"></i> (84) 123 456 789</li>
                            <li><i class="bi bi-geo-alt me-2"></i> 123 Đường ABC, Quận XYZ, TP.HCM</li>
                        </ul>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <h5>Đăng Ký Nhận Tin</h5>
                        <p>Nhận thông tin về các tính năng mới và mẹo sử dụng</p>
                        <div class="input-group mb-3">
                            <input type="email" class="form-control" placeholder="Email của bạn">
                            <button class="btn btn-outline-light" type="button">Đăng Ký</button>
                        </div>
                    </div>
                </div>
                <div class="copyright">
                    <p>&copy; <%= new java.util.Date().getYear() + 1900 %> TodoList. Tất cả các quyền được bảo lưu.</p>
                </div>
            </div>
        </footer>

        <!-- Bootstrap JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>