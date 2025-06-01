<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!-- CSS/JS dependencies -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
                rel="stylesheet">
            <link rel="stylesheet" href="/css/client/style.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <script src="https://cdn.jsdelivr.net/npm/@simonwep/pickr"></script>

            <!-- Sidebar -->
            <div class="sidebar">
                <div class="sidebar-header">
                    <h2>TaskFlow</h2>
                </div>

                <div class="menu-section">
                    <h6>MENU</h6>
                    <a href="/" class="menu-item"><i class="fas fa-home"></i> Overview</a>
                    <a href="/today" class="menu-item"><i class="fas fa-calendar-day"></i> Today</a>
                    <a href="/upComing" class="menu-item"><i class="fas fa-clock"></i> Upcoming</a>
                    <a href="/analyst" class="menu-item"><i class="fa-solid fa-chart-simple"></i> Analyst</a>
                </div>

                <div class="menu-section category">
                    <h6>CATEGORIES</h6>
                    <div style="height: 280px; overflow-y: scroll;">
                        <c:forEach var="category" items="${categoryList}">
                            <div class="d-flex justify-content-between align-items-center menu-item-wrapper">
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
                    <button id="add-category" type="button" class="btn btn-sm mt-2" data-bs-toggle="modal"
                        data-bs-target="#addCategoryModal">
                        <i class="fas fa-plus"></i> Add Category
                    </button>
                </div>

                <a href="/addTask" class="add-task-btn">Add New Task</a>
            </div>

            <!-- Modal: Add Category -->
            <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <form method="post" action="/category" id="categoryForm">
                            <input type="hidden" name="action" value="add" />
                            <div class="modal-header">
                                <h1 class="modal-title fs-5">Add new category</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label for="categoryName" class="form-label">Name category</label>
                                    <input type="text" class="form-control" id="categoryName" name="name"
                                        placeholder="Enter category name..." required>
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

            <!-- Modal: Confirm Delete -->
            <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <form method="post" action="/category">
                            <input type="hidden" name="action" value="delete" />
                            <input type="hidden" name="categoryId" id="categoryToDeleteId" />
                            <div class="modal-header">
                                <h5 class="modal-title">Confirm Delete</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                Are you sure you want to delete category: <strong id="categoryToDeleteName"></strong>?
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-danger">Delete</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const currentPath = window.location.pathname;
                    const menuItems = document.querySelectorAll('.menu-item');

                    menuItems.forEach(function (item) {
                        const itemPath = item.getAttribute('href');
                        if (itemPath === currentPath) {
                            item.classList.add('active');
                        } else {
                            item.classList.remove('active');
                        }
                    });

                    // Apply color to category dots
                    document.querySelectorAll('.category-dot').forEach(function (dot) {
                        const color = dot.getAttribute('data-color');
                        if (color) dot.style.backgroundColor = color;
                    });

                    // Handle delete button click
                    document.querySelectorAll('.delete-category-btn').forEach(function (btn) {
                        btn.addEventListener('click', function () {
                            const categoryId = this.getAttribute('data-category-id');
                            const categoryName = this.getAttribute('data-category-name');
                            document.getElementById('categoryToDeleteId').value = categoryId;
                            document.getElementById('categoryToDeleteName').innerText = categoryName;
                            new bootstrap.Modal(document.getElementById('confirmDeleteModal')).show();
                        });
                    });
                });
            </script>