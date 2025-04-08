<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>TaskFlow</title>
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
                    rel="stylesheet">
                <link rel="stylesheet" href="/css/client/style.css">
                <!-- Font Awesome for icons -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

            </head>

            <body>

                <!-- thêm side bar  -->
                <jsp:include page="../layout/sidebar.jsp" />



                <!-- Main Content -->
                <div class="main-content">

                    <!-- thêm header -->
                    <jsp:include page="../layout/header.jsp" />

                    <!-- Stats Cards -->
                    <div class="row mb-4">
                        <div class="col-md-3">
                            <div class="stat-card">
                                <div class="stat-icon bg-purple">
                                    <i class="fas fa-clipboard-list"></i>
                                </div>
                                <div class="stat-card-body">
                                    <h3 class="stat-number">24</h3>
                                    <div class="stat-label">Total Tasks</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stat-card">
                                <div class="stat-icon bg-green">
                                    <i class="fas fa-check"></i>
                                </div>
                                <div class="stat-card-body">
                                    <h3 class="stat-number">18</h3>
                                    <div class="stat-label">Completed</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stat-card">
                                <div class="stat-icon bg-orange">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div class="stat-card-body">
                                    <h3 class="stat-number">6</h3>
                                    <div class="stat-label">Pending</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stat-card">
                                <div class="stat-icon bg-red">
                                    <i class="fas fa-exclamation-triangle"></i>
                                </div>
                                <div class="stat-card-body">
                                    <h3 class="stat-number">3</h3>
                                    <div class="stat-label">Urgent</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Tasks List -->
                    <div class="task-list">
                        <div class="task-header">
                            <h5>Recent Tasks</h5>
                            <div class="task-filters">
                                <button class="btn active">All</button>
                                <button class="btn">Active</button>
                                <button class="btn">Completed</button>
                            </div>
                        </div>

                        <!-- Task Items -->
                        <div class="task-items">
                            <div class="task-item">
                                <div class="task-checkbox">
                                    <input type="checkbox" class="form-check-input">
                                </div>
                                <div class="task-details">
                                    <div class="task-name">Design new dashboard layout</div>
                                    <div class="task-due">Due Today <span class="dot"></span></div>
                                </div>
                            </div>

                            <div class="task-item">
                                <div class="task-checkbox">
                                    <input type="checkbox" class="form-check-input">
                                </div>
                                <div class="task-details">
                                    <div class="task-name">Design new dashboard layout</div>
                                    <div class="task-due">Due Today <span class="dot"></span></div>
                                </div>
                            </div>

                            <div class="task-item">
                                <div class="task-checkbox">
                                    <input type="checkbox" class="form-check-input">
                                </div>
                                <div class="task-details">
                                    <div class="task-name">Design new dashboard layout</div>
                                    <div class="task-due">Due Today <span class="dot"></span></div>
                                </div>
                            </div>

                            <div class="task-item">
                                <div class="task-checkbox">
                                    <input type="checkbox" class="form-check-input">
                                </div>
                                <div class="task-details">
                                    <div class="task-name">Design new dashboard layout</div>
                                    <div class="task-due">Due Today <span class="dot"></span></div>
                                </div>
                            </div>

                            <div class="task-item">
                                <div class="task-checkbox">
                                    <input type="checkbox" class="form-check-input">
                                </div>
                                <div class="task-details">
                                    <div class="task-name">Design new dashboard layout</div>
                                    <div class="task-due">Due Today <span class="dot"></span></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Bootstrap Bundle with Popper -->
                <script
                    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>