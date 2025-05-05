<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <script src="https://cdn.jsdelivr.net/npm/@simonwep/pickr"></script>
            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
                rel="stylesheet">
            <link rel="stylesheet" href="/css/client/style.css">
            <!-- Font Awesome for icons -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">


            <!-- Sidebar -->
            <!-- Sidebar -->
            <div class="sidebar">
                <div class="sidebar-header">
                    <h2>TaskFlow</h2>
                </div>

                <div class="menu-section">
                    <h6>MENU</h6>
                    <a href="/" class="menu-item active">
                        <i class="fas fa-home"></i> Overview
                    </a>
                    <a href="/today" class="menu-item">
                        <i class="fas fa-calendar-day"></i> Today
                    </a>
                    <a href="/upComing" class="menu-item">
                        <i class="fas fa-clock"></i> Upcoming
                    </a>
                    <a href="/analyst" class="menu-item">
                        <i class="fa-solid fa-chart-simple"></i> Analyst
                    </a>
                </div>

                <div class="menu-section category">
                    <h6>CATEGORIES</h6>
                    <div style="height: 280px; overflow-y: scroll;">

                        <!-- Lặp qua danh sách Category -->
                        <c:forEach var="category" items="${categoryList}">
                            <div class="d-flex justify-content-between align-items-center menu-item-wrapper ">
                                <a href="#" class="menu-item d-flex align-items-center flex-grow-1">
                                    <span class="category-dot me-2" data-color="${category.color}"></span>
                                    ${category.name}
                                </a>
                                <i class="fas fa-times text-danger delete-category-btn"
                                    data-category-id="${category.categoryID}" data-category-name="${category.name}"
                                    style="cursor: pointer; margin-right: 20px;"></i>
                            </div>
                        </c:forEach>

                    </div>
                    <!-- Button trigger modal -->
                    <button id="add-category" type="button" class="btn btn-sm mt-2" data-bs-toggle="modal"
                        data-bs-target="#exampleModal">
                        <i class="fas fa-plus"></i> Add Category
                    </button>
                </div>

                <a style="text-decoration: none;" href="/addTask" class="add-task-btn">Add New Task</a>
            </div>

            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <form method="post" action="/category" id="categoryForm">
                            <input type="hidden" name="action" value="add" />
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">Add new category</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label for="categoryName" class="form-label">Name category</label>
                                    <input type="text" class="form-control" id="categoryName" name="name"
                                        placeholder="Nhập tên danh mục..." required>
                                </div>
                                <div class="mb-3">
                                    <label for="categoryColor" class="form-label">Pick color</label>
                                    <input type="color" class="form-control form-control-color" id="categoryColor"
                                        name="color" value="#ff0000" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Save category</button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>


            <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <form method="post" action="/deleteCategory">
                            <div class="modal-header">
                                <h5 class="modal-title">Confirm Delete</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                Are you sure you want to delete category: <strong id="categoryToDeleteName"></strong>?
                                <input type="hidden" name="categoryId" id="categoryToDeleteId">
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-danger">Delete</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>


            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const categoryDot = document.querySelectorAll('.category-dot');
                    categoryDot.forEach(function (dot) {
                        const color = dot.getAttribute('data-color');
                        if (color) {
                            dot.style.backgroundColor = color;
                        }
                    });
                });
                document.addEventListener('DOMContentLoaded', function () {
                    // Áp màu cho các dot category
                    const categoryDot = document.querySelectorAll('.category-dot');
                    categoryDot.forEach(function (dot) {
                        const color = dot.getAttribute('data-color');
                        if (color) {
                            dot.style.backgroundColor = color;
                        }
                    });




                });


                // Xử lý class active khi click menu-item
                document.addEventListener('DOMContentLoaded', function () {
                    const currentPath = window.location.pathname;
                    const menuItems = document.querySelectorAll('.menu-item');

                    menuItems.forEach(function (item) {
                        const itemPath = item.getAttribute('href');

                        // So sánh pathname để thêm hoặc xóa class 'active'
                        if (itemPath === currentPath) {
                            item.classList.add('active');
                        } else {
                            item.classList.remove('active');
                        }
                    });

                    // Gán màu cho category dot
                    const categoryDots = document.querySelectorAll('.category-dot');
                    categoryDots.forEach(function (dot) {
                        const color = dot.getAttribute('data-color');
                        if (color) {
                            dot.style.backgroundColor = color;
                        }
                    });
                });


                document.addEventListener('DOMContentLoaded', function () {
                    // Khi bấm nút X xoá category
                    const deleteButtons = document.querySelectorAll('.delete-category-btn');

                    deleteButtons.forEach(function (btn) {
                        btn.addEventListener('click', function () {
                            const categoryId = this.getAttribute('data-category-id');
                            const categoryName = this.getAttribute('data-category-name');

                            // Gán dữ liệu vào modal
                            document.getElementById('categoryToDeleteId').value = categoryId;
                            document.getElementById('categoryToDeleteName').innerText = categoryName;

                            // Mở modal
                            const deleteModal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
                            deleteModal.show();
                        });
                    });
                });


            </script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>