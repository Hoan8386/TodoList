<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    </head>

                    <body>
                        <!-- Sidebar -->
                        <jsp:include page="../layout/sidebar.jsp" />

                        <!-- Main Content -->
                        <div class="main-content">
                            <!-- Header -->
                            <jsp:include page="../layout/header.jsp" />

                            <!-- Tasks List -->
                            <div class="task-list">
                                <div class="task-header mt-3">
                                    <h5>Task today</h5>
                                    <div class="task-filters d-flex gap-2">
                                        <!-- All Button -->
                                        <form action="/status" method="get">
                                            <input type="hidden" name="status" value="all" />
                                            <c:choose>
                                                <c:when test="${status == 'all'}">
                                                    <button type="submit" class="btn btn-primary">All</button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="submit" class="btn btn-outline-primary">All</button>
                                                </c:otherwise>
                                            </c:choose>
                                        </form>

                                        <!-- Completed Button -->
                                        <form action="/status" method="get">
                                            <input type="hidden" name="status" value="1" />
                                            <c:choose>
                                                <c:when test="${status == '1'}">
                                                    <button type="submit" class="btn btn-primary">Completed</button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="submit"
                                                        class="btn btn-outline-primary">Completed</button>
                                                </c:otherwise>
                                            </c:choose>
                                        </form>

                                        <!-- Pending Button -->
                                        <form action="/status" method="get">
                                            <input type="hidden" name="status" value="0" />
                                            <c:choose>
                                                <c:when test="${status == '0'}">
                                                    <button type="submit" class="btn btn-primary">Pending</button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="submit"
                                                        class="btn btn-outline-primary">Pending</button>
                                                </c:otherwise>
                                            </c:choose>
                                        </form>
                                    </div>
                                </div>

                                <form action="/filterTasks" method="get"
                                    class="d-flex flex-row flex-nowrap align-items-center gap-2 overflow-auto">
                                    <input type="text" class="form-control" name="keyword" value="${param.keyword}"
                                        placeholder="Search tasks..." style="max-width: 200px;">
                                    <select class="form-control" name="categoryId" style="max-width: 180px;">
                                        <option value="" ${empty param.categoryId ? 'selected' : '' }>All Categories
                                        </option>
                                        <c:forEach var="cat" items="${categories}">
                                            <option value="${cat.categoryID}" ${param.categoryId==cat.categoryID
                                                ? 'selected' : '' }>
                                                <span class="category-dot me-2" data-color="${cat.color}"></span>
                                                ${cat.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <select class="form-control" name="priorityId" style="max-width: 180px;">
                                        <option value="" ${empty param.priorityId ? 'selected' : '' }>All Priorities
                                        </option>
                                        <c:forEach var="pri" items="${priorities}">
                                            <option value="${pri.priorityID}" ${param.priorityId==pri.priorityID
                                                ? 'selected' : '' }>${pri.name}</option>
                                        </c:forEach>
                                    </select>
                                    <button type="submit" class="btn btn-outline-primary">
                                        <i class="fas fa-filter"></i> Filter
                                    </button>
                                </form>

                                <!-- Task Items -->
                                <div class="task-items">
                                    <c:if test="${not empty tasks}">
                                        <c:forEach var="task" items="${tasks}">
                                            <div class="task-item"
                                                style="border-left: 4px solid ${task.categoryColor}; padding-left: 10px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.15);">
                                                <div class="task-details-container">
                                                    <div class="task-checkbox">
                                                        <form:form action="/checkTask" method="post">
                                                            <input type="hidden" name="taskId" value="${task.taskID}" />
                                                            <input type="checkbox" class="form-check-input"
                                                                name="completed" onchange="this.form.submit()" <c:if
                                                                test="${task.status}">checked
                                    </c:if> />
                                    </form:form>
                                </div>
                                <div class="task-details" style="padding-left: 10px;">
                                    <div class="task-name">${task.name}</div>
                                    <div class="task-priority">
                                        <c:choose>
                                            <c:when test="${task.priorityID == 1}">Low</c:when>
                                            <c:when test="${task.priorityID == 2}">Medium</c:when>
                                            <c:when test="${task.priorityID == 3}">High</c:when>
                                            <c:otherwise>Urgent</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <div class="task-actions"
                                style="display: flex; align-items: center; gap: 10px; margin-top: 10px;">
                                <!-- View Details Icon -->
                                <a href="javascript:void(0);" class="task-view-details"
                                    onclick="showTaskDetail('${task.taskID}', '${task.name}', '${task.description}', '${task.date}', '${task.categoryID}', '${task.categoryColor}', '${task.priorityID}')">
                                    <i class="fas fa-eye" style="color: #F1600D;"></i>
                                </a>

                                <!-- Edit Icon -->
                                <a href="javascript:void(0);" class="task-edit"
                                    onclick="showEditTask('${task.taskID}', '${task.name}', '${task.description}', '${task.date}', '${task.categoryID}', '${task.priorityID}')">
                                    <i class="fas fa-edit" style="color: #F1600D;"></i>
                                </a>

                                <!-- Delete Icon -->
                                <form action="/deleteTask" method="post" style="display: inline;">
                                    <input type="hidden" name="taskId" value="${task.taskID}" />
                                    <button type="button" style="border: none; background: none; padding: 0;"
                                        onclick="confirmDelete(${task.taskID})">
                                        <i class="fas fa-trash" style="color: #dc3545;"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                        </c:forEach>
                        </c:if>
                        <c:if test="${empty tasks}">
                            <div class="alert alert-info text-center mt-4" role="alert">
                                Không có task nào vui cả 😢 Bạn có thể thêm task mới <a href="/addTask">tại đây</a>.
                            </div>
                        </c:if>
                        </div>
                        </div>
                        </div> <!-- Closing main-content -->

                        <!-- Task Details Modal -->
                        <div class="modal fade" id="taskDetailModal" tabindex="-1" aria-labelledby="taskDetailLabel"
                            aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content shadow-lg border-0 rounded-4">
                                    <!-- Modal Header -->
                                    <div class="modal-header"
                                        style="background-color: #F1600D; color: #fff; border-top-left-radius: 1rem; border-top-right-radius: 1rem;">
                                        <h5 class="modal-title" id="taskDetailLabel">
                                            <i class="fas fa-info-circle me-2"></i>Task Details
                                        </h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                    </div>
                                    <!-- Modal Body -->
                                    <div class="modal-body px-4">
                                        <div class="mb-3" hidden>
                                            <input type="text" id="modalTaskID"
                                                class="form-control fw-semibold text-dark" disabled>
                                        </div>
                                        <div class="mb-3">
                                            <strong class="text-muted">Name:</strong>
                                            <input type="text" id="modalTaskName"
                                                class="form-control fw-semibold text-dark" disabled>
                                        </div>
                                        <div class="mb-3">
                                            <strong class="text-muted">Description:</strong>
                                            <textarea id="modalTaskDescription"
                                                class="form-control text-muted fst-italic" disabled></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <strong class="text-muted">Date:</strong>
                                            <input type="date" id="modalTaskDate" class="form-control text-dark"
                                                disabled>
                                        </div>
                                        <div class="mb-3">
                                            <strong class="text-muted">Category:</strong>
                                            <select id="modalTaskCategory" class="form-select" disabled>
                                                <c:forEach var="category" items="${categories}">
                                                    <option value="${category.categoryID}" style="color: black;">
                                                        ${category.name}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <strong class="text-muted">Priority:</strong>
                                            <select id="modalTaskPriority" class="form-select" disabled>
                                                <option value="1">Low Priority</option>
                                                <option value="2">Normal Priority</option>
                                                <option value="3">High Priority</option>
                                                <option value="4">Urgent</option>
                                            </select>
                                        </div>
                                    </div>
                                    <!-- Modal Footer -->
                                    <div class="modal-footer bg-light rounded-bottom-4">
                                        <button type="button" class="btn"
                                            style="border: 1px solid #F1600D; color: #F1600D;" data-bs-dismiss="modal">
                                            <i class="fas fa-times-circle me-1"></i>Close
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Edit Task Modal -->
                        <div class="modal fade" id="editTaskModal" tabindex="-1" aria-labelledby="editTaskLabel"
                            aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content shadow-lg border-0 rounded-4">
                                    <!-- Modal Header -->
                                    <div class="modal-header"
                                        style="background-color: #F1600D; color: #fff; border-top-left-radius: 1rem; border-top-right-radius: 1rem;">
                                        <h5 class="modal-title" id="editTaskLabel">
                                            <i class="fas fa-edit me-2"></i>Edit Task
                                        </h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                    </div>
                                    <!-- Modal Body -->
                                    <div class="modal-body px-4">
                                        <form id="editTaskForm" action="/updateTask" method="post">
                                            <div class="mb-3" hidden>
                                                <input type="text" id="editTaskID" name="taskID"
                                                    class="form-control fw-semibold text-dark">
                                            </div>
                                            <div class="mb-3">
                                                <strong class="text-muted">Name:</strong>
                                                <input type="text" id="editTaskName" name="name"
                                                    class="form-control fw-semibold text-dark" required>
                                            </div>
                                            <div class="mb-3">
                                                <strong class="text-muted">Description:</strong>
                                                <textarea id="editTaskDescription" name="description"
                                                    class="form-control text-muted fst-italic"></textarea>
                                            </div>
                                            <div class="mb-3">
                                                <strong class="text-muted">Date:</strong>
                                                <input type="date" id="editTaskDate" name="date"
                                                    class="form-control text-dark" required>
                                            </div>
                                            <div class="mb-3">
                                                <strong class="text-muted">Category:</strong>
                                                <select id="editTaskCategory" name="categoryID" class="form-select"
                                                    required>
                                                    <c:forEach var="category" items="${categories}">
                                                        <option value="${category.categoryID}" style="color: black;">
                                                            ${category.name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="mb-3">
                                                <strong class="text-muted">Priority:</strong>
                                                <select id="editTaskPriority" name="priorityID" class="form-select"
                                                    required>
                                                    <option value="1">Low Priority</option>
                                                    <option value="2">Normal Priority</option>
                                                    <option value="3">High Priority</option>
                                                    <option value="4">Urgent</option>
                                                </select>
                                            </div>
                                            <div class="modal-footer bg-light rounded-bottom-4">
                                                <button type="button" class="btn"
                                                    style="border: 1px solid #F1600D; color: #F1600D;"
                                                    data-bs-dismiss="modal">
                                                    <i class="fas fa-times-circle me-1"></i>Close
                                                </button>
                                                <button type="submit" class="btn btn-success">
                                                    <i class="fas fa-check me-1"></i>Update
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Delete Confirmation Modal -->
                        <div class="modal fade" id="deleteConfirmModal" tabindex="-1"
                            aria-labelledby="deleteConfirmLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="deleteConfirmLabel">Xác nhận xoá task</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Đóng"></button>
                                    </div>
                                    <div class="modal-body">
                                        Bạn có chắc chắn muốn xóa task này không?
                                    </div>
                                    <div class="modal-footer">
                                        <form id="confirmDeleteForm" action="/deleteTask" method="post">
                                            <input type="hidden" name="taskId" id="deleteTaskId" />
                                            <button type="button" class="btn btn-secondary"
                                                data-bs-dismiss="modal">Huỷ</button>
                                            <button type="submit" class="btn btn-danger">Xoá</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Bootstrap Bundle with Popper -->
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

                        <script>
                            function showTaskDetail(taskID, name, description, date, categoryID, categoryColor, priorityID) {
                                document.getElementById("modalTaskName").value = name;
                                document.getElementById("modalTaskDescription").value = description;
                                document.getElementById("modalTaskDate").value = date;
                                document.getElementById("modalTaskID").value = taskID;
                                document.getElementById("modalTaskCategory").value = categoryID;
                                document.getElementById("modalTaskCategory").style.color = 'black';
                                document.getElementById("modalTaskPriority").value = priorityID;

                                const modal = new bootstrap.Modal(document.getElementById('taskDetailModal'));
                                modal.show();
                            }

                            function showEditTask(taskID, name, description, date, categoryID, priorityID) {
                                document.getElementById("editTaskID").value = taskID;
                                document.getElementById("editTaskName").value = name;
                                document.getElementById("editTaskDescription").value = description;
                                document.getElementById("editTaskDate").value = date;
                                document.getElementById("editTaskCategory").value = categoryID;
                                document.getElementById("editTaskPriority").value = priorityID;

                                const modal = new bootstrap.Modal(document.getElementById('editTaskModal'));
                                modal.show();
                            }

                            function confirmDelete(taskId) {
                                document.getElementById("deleteTaskId").value = taskId;
                                var deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
                                deleteModal.show();
                            }
                        </script>
                    </body>

                    </html>