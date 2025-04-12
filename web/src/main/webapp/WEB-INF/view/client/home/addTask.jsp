<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>TaskFlow - Add New Task</title>
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
                    rel="stylesheet">
                <!-- Font Awesome for icons -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="/css/client/style.css">
                <style>
                    .main-content {
                        padding: 20px;
                    }

                    .top-bar {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 30px;
                        padding-bottom: 20px;
                        border-bottom: 1px solid #f1f1f1;
                    }

                    .page-title {
                        font-size: 1.5rem;
                        font-weight: 600;
                        color: #333;
                    }

                    .form-container {
                        background-color: #f8f9fa;
                        border-radius: 10px;
                        padding: 30px;
                    }

                    .form-label {
                        font-weight: 500;
                        color: #495057;
                        margin-bottom: 10px;
                    }

                    .category-selector {
                        display: flex;
                        gap: 10px;
                        flex-wrap: wrap;
                    }

                    .category-option {
                        flex: 1;
                        min-width: 120px;
                        border: 1px solid #dee2e6;
                        border-radius: 8px;
                        padding: 12px;
                        display: flex;
                        align-items: center;
                        cursor: pointer;
                        background-color: white;
                    }

                    .category-option.selected {
                        border-color: #6610f2;
                        background-color: #f3f0ff;
                    }

                    .priority-selector {
                        display: flex;
                        gap: 10px;
                        flex-wrap: wrap;
                    }

                    .priority-option {
                        flex: 1;
                        min-width: 120px;
                        border: 1px solid #dee2e6;
                        border-radius: 8px;
                        padding: 12px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        cursor: pointer;
                        background-color: white;
                    }

                    .priority-option.selected {
                        border-color: #6610f2;
                        background-color: #f3f0ff;
                    }

                    .subtask-input {
                        display: flex;
                        gap: 10px;
                    }

                    .btn-primary {
                        background-color: #6610f2;
                        border-color: #6610f2;
                    }

                    .btn-light {
                        background-color: #f8f9fa;
                        border-color: #dee2e6;
                    }
                </style>
            </head>

            <body>
                <!-- thêm sidebar -->
                <jsp:include page="../layout/sidebar.jsp" />

                <!-- Main Content -->

                <div class="main-content">
                    <!-- Top Bar -->
                    <div class="top-bar">
                        <div class="page-title">Add New Task</div>

                    </div>

                    <!-- Form Container -->
                    <!-- Form Container -->
                    <div class="form-container">
                        <!-- Task Title -->
                        <form method="POST" action="/addTask">
                            <div class="mb-4">
                                <label for="taskTitle" class="form-label">Task Title</label>
                                <input type="text" class="form-control" id="taskTitle" name="name"
                                    placeholder="Enter task title" required>
                            </div>

                            <!-- Description -->
                            <div class="mb-4">
                                <label for="taskDescription" class="form-label">Description</label>
                                <textarea class="form-control" id="taskDescription" name="description" rows="3"
                                    required></textarea>
                            </div>

                            <div class="row">
                                <!-- Category -->
                                <div class="col-md-6">
                                    <div class="mb-4">
                                        <label for="category" class="form-label">Category</label>
                                        <select class="form-control" id="category" name="categoryID" required>
                                            <c:forEach var="category" items="${categories}">
                                                <option value="${category.categoryID}">
                                                    ${category.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <!-- Due Date -->
                                <div class="col-md-6">
                                    <div class="mb-4">
                                        <label for="Date" class="form-label">Date</label>
                                        <input type="date" class="form-control" id="Date" name="Date" required>
                                    </div>
                                </div>
                            </div>

                            <!-- Priority -->
                            <div class="mb-4">
                                <label class="form-label">Priority</label>
                                <div class="priority-selector">
                                    <div class="priority-option" data-id="1" onclick="setPriority(1, this)">
                                        <i class="fas fa-star text-warning me-2"></i>
                                        Low Priority
                                    </div>
                                    <div class="priority-option selected" data-id="2" onclick="setPriority(2, this)">
                                        <i class="fas fa-star text-warning me-1"></i>
                                        <i class="fas fa-star text-warning me-2"></i>
                                        Normal Priority
                                    </div>
                                    <div class="priority-option" data-id="3" onclick="setPriority(3, this)">
                                        <i class="fas fa-star text-warning me-1"></i>
                                        <i class="fas fa-star text-warning me-1"></i>
                                        <i class="fas fa-star text-warning me-2"></i>
                                        High Priority
                                    </div>
                                    <div class="priority-option" data-id="4" onclick="setPriority(4, this)">
                                        <i class="fas fa-fire text-danger me-2"></i>
                                        Urgent
                                    </div>
                                </div>

                                <!-- Hidden input to store selected priority ID -->
                                <input type="hidden" id="priorityID" name="priorityID" value="2">
                                <!-- Default là Normal -->
                            </div>


                            <div class="actions">
                                <button type="submit" class="btn btn-primary">Create Task</button>
                                <button type="button" class="btn btn-light me-2">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Bootstrap Bundle with Popper -->
                <script
                    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

                <script>
                    // Function to handle priority selection
                    function setPriority(id, element) {
                        // Gán giá trị vào input ẩn
                        document.getElementById('priorityID').value = id;

                        // Xóa class 'selected' khỏi tất cả các tùy chọn
                        const options = document.querySelectorAll('.priority-option');
                        options.forEach(opt => opt.classList.remove('selected'));

                        // Thêm class 'selected' vào cái đang chọn
                        element.classList.add('selected');
                    }

                </script>
            </body>

            </html>