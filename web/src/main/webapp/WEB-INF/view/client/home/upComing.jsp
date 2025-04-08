<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>TaskFlow - Upcoming</title>
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
                    rel="stylesheet">
                <link rel="stylesheet" href="/css/client/style.css">
                <!-- Font Awesome for icons -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            </head>

            <body>
                <!-- Thêm sidebar -->
                <jsp:include page="../layout/sidebar.jsp" />

                <!-- Main Content -->
                <div class="main-content">
                    <!-- Thêm header -->
                    <jsp:include page="../layout/header.jsp" />

                    <!-- Tasks List -->
                    <div class="task-list">
                        <div class="task-header mt-3">
                            <h5>Upcoming Tasks</h5>
                            <div class="task-filters">
                                <button class="btn active">All</button>
                                <button class="btn">Completed</button>
                                <button class="btn">Pending</button>
                            </div>
                        </div>

                        <div class="filter d-flex">
                            <div class="input-group" style="max-width: 300px; margin-right: 10px;">
                                <input type="text" class="form-control" placeholder="Search tasks..."
                                    aria-label="Search tasks">
                            </div>
                            <div class="input-group" style="max-width: 300px; margin-right: 10px;">
                                <select class="form-control" aria-label="Select category">
                                    <option value="" disabled selected>Filter by Category</option>
                                    <option value="personal">Personal</option>
                                    <option value="work">Work</option>
                                    <option value="shopping">Shopping</option>
                                    <option value="health">Health</option>
                                </select>
                            </div>
                            <div class="input-group" style="max-width: 300px; margin-right: 10px;">
                                <select class="form-control" aria-label="Select priority">
                                    <option value="" disabled selected>Filter by Priority</option>
                                    <option value="high">High</option>
                                    <option value="medium">Medium</option>
                                    <option value="low">Low</option>
                                </select>
                            </div>
                            <div class="input-group" style="max-width: 300px; margin-right: 10px;">
                                <input type="date" class="form-control" aria-label="Filter by date">
                            </div>
                            <div class="input-group" style="margin-right: 10px;">
                                <button class="btn btn-outline-secondary" id="sort-priority"
                                    aria-label="Sort by priority">
                                    <i class="fas fa-sort"></i> Sort by Priority
                                </button>
                            </div>
                        </div>

                        <div class="task-items">
                            <div class="task-item personal">
                                <div class="task-details-container">
                                    <div class="task-checkbox">
                                        <input type="checkbox" class="form-check-input">
                                    </div>
                                    <div class="task-details">
                                        <div class="task-name">Design new dashboard layout</div>
                                        <div class="task-priority">High</div>
                                        <div class="task-due">Apr 02, 2025</div>
                                    </div>
                                </div>
                                <a href="#" class="task-view-details">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </div>

                            <div class="task-item work">
                                <div class="task-details-container">
                                    <div class="task-checkbox">
                                        <input type="checkbox" class="form-check-input">
                                    </div>
                                    <div class="task-details">
                                        <div class="task-name">Prepare project report</div>
                                        <div class="task-priority">Medium</div>
                                        <div class="task-due">Apr 03, 2025</div>
                                    </div>
                                </div>
                                <a href="#" class="task-view-details">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </div>

                            <div class="task-item shopping">
                                <div class="task-details-container">
                                    <div class="task-checkbox">
                                        <input type="checkbox" class="form-check-input">
                                    </div>
                                    <div class="task-details">
                                        <div class="task-name">Buy groceries</div>
                                        <div class="task-priority">Low</div>
                                        <div class="task-due">Apr 04, 2025</div>
                                    </div>
                                </div>
                                <a href="#" class="task-view-details">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </div>

                            <div class="task-item health">
                                <div class="task-details-container">
                                    <div class="task-checkbox">
                                        <input type="checkbox" class="form-check-input">
                                    </div>
                                    <div class="task-details">
                                        <div class="task-name">Go for a run</div>
                                        <div class="task-priority">High</div>
                                        <div class="task-due">Apr 05, 2025</div>
                                    </div>
                                </div>
                                <a href="#" class="task-view-details">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </div>

                            <div class="task-item personal">
                                <div class="task-details-container">
                                    <div class="task-checkbox">
                                        <input type="checkbox" class="form-check-input">
                                    </div>
                                    <div class="task-details">
                                        <div class="task-name">Plan weekend trip</div>
                                        <div class="task-priority">Medium</div>
                                        <div class="task-due">Apr 06, 2025</div>
                                    </div>
                                </div>
                                <a href="#" class="task-view-details">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </div>

                            <div class="task-item personal">
                                <div class="task-details-container">
                                    <div class="task-checkbox">
                                        <input type="checkbox" class="form-check-input">
                                    </div>
                                    <div class="task-details">
                                        <div class="task-name">Design new dashboard layout</div>
                                        <div class="task-priority">High</div>
                                        <div class="task-due">Apr 07, 2025</div>
                                    </div>
                                </div>
                                <a href="#" class="task-view-details">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </div>

                            <div class="task-item work">
                                <div class="task-details-container">
                                    <div class="task-checkbox">
                                        <input type="checkbox" class="form-check-input">
                                    </div>
                                    <div class="task-details">
                                        <div class="task-name">Prepare project report</div>
                                        <div class="task-priority">Medium</div>
                                        <div class="task-due">Apr 08, 2025</div>
                                    </div>
                                </div>
                                <a href="#" class="task-view-details">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </div>

                            <div class="task-item shopping">
                                <div class="task-details-container">
                                    <div class="task-checkbox">
                                        <input type="checkbox" class="form-check-input">
                                    </div>
                                    <div class="task-details">
                                        <div class="task-name">Buy groceries</div>
                                        <div class="task-priority">Low</div>
                                        <div class="task-due">Apr 09, 2025</div>
                                    </div>
                                </div>
                                <a href="#" class="task-view-details">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </div>

                            <div class="task-item health">
                                <div class="task-details-container">
                                    <div class="task-checkbox">
                                        <input type="checkbox" class="form-check-input">
                                    </div>
                                    <div class="task-details">
                                        <div class="task-name">Go for a run</div>
                                        <div class="task-priority">High</div>
                                        <div class="task-due">Apr 10, 2025</div>
                                    </div>
                                </div>
                                <a href="#" class="task-view-details">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </div>

                            <div class="task-item personal">
                                <div class="task-details-container">
                                    <div class="task-checkbox">
                                        <input type="checkbox" class="form-check-input">
                                    </div>
                                    <div class="task-details">
                                        <div class="task-name">Plan weekend trip</div>
                                        <div class="task-priority">Medium</div>
                                        <div class="task-due">Apr 11, 2025</div>
                                    </div>
                                </div>
                                <a href="#" class="task-view-details">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bootstrap Bundle with Popper -->
                <script
                    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>