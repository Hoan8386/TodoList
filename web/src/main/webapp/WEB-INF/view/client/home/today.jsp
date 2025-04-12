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

                        <!-- thêm side bar  -->
                        <jsp:include page="../layout/sidebar.jsp" />



                        <!-- Main Content -->
                        <div class="main-content">

                            <!-- thêm header -->
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

                                    <div class="input-group" style="margin-right: 10px;">
                                        <button class="btn btn-outline-secondary" id="sort-priority"
                                            aria-label="Sort by priority">
                                            <i class="fas fa-sort"></i> Sort by Priority
                                        </button>
                                    </div>
                                </div>




                                <!-- Task Items -->
                                <div class="task-items">
                                    <c:forEach var="task" items="${tasks}">
                                        <div class="task-item"
                                            style="border-left: 4px solid ${task.categoryColor}; padding-left: 10px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.15);">
                                            <div class="task-details-container">
                                                <div class="task-checkbox">
                                                    <form:form action="/checkTask" method="post">
                                                        <!-- Hidden input to always send taskId -->
                                                        <input type="hidden" name="taskId" value="${task.taskID}" />

                                                        <!-- Checkbox for toggling -->
                                                        <input type="checkbox" class="form-check-input" name="completed"
                                                            onchange="this.form.submit()" <c:if
                                                            test="${task.status}">checked</c:if> />
                                                    </form:form>




                                                </div>
                                                <div class="task-details" style=" padding-left: 10px;">
                                                    <div class="task-name">${task.name}</div>
                                                    <div class="task-priority">
                                                        <c:choose>
                                                            <c:when test="${task.priorityID == 1}">High</c:when>
                                                            <c:when test="${task.priorityID == 2}">Medium</c:when>
                                                            <c:otherwise>Low</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Button to show modal -->
                                            <a href="javascript:void(0);" class="task-view-details"
                                                onclick="showTaskDetail('${task.name}', '${task.description}', '${task.date}', '${task.categoryName}', '${task.categoryColor}', '${task.priorityID}')">
                                                <i class="fas fa-eye" style="color: #F1600D;"></i>
                                            </a>

                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <!-- Bootstrap Bundle with Popper -->
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
                    </body>

                    <!-- Task Details Modal -->

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
                                    <div class="mb-3">
                                        <strong class="text-muted">Name:</strong>
                                        <div id="modalTaskName" class="fw-semibold text-dark"></div>
                                    </div>
                                    <div class="mb-3">
                                        <strong class="text-muted">Description:</strong>
                                        <div id="modalTaskDescription" class="text-muted fst-italic"></div>
                                    </div>
                                    <div class="mb-3">
                                        <strong class="text-muted">Date:</strong>
                                        <div id="modalTaskDate" class="text-dark"></div>
                                    </div>
                                    <div class="mb-3">
                                        <strong class="text-muted">Category:</strong>
                                        <div id="modalTaskCategory" class="badge px-3 py-2" style="color: #fff;"></div>

                                    </div>
                                    <div class="mb-3">
                                        <strong class="text-muted">Priority:</strong>
                                        <div id="modalTaskPriority" class="d-flex align-items-center gap-2"></div>
                                    </div>
                                </div>

                                <!-- Modal Footer -->
                                <div class="modal-footer bg-light rounded-bottom-4">
                                    <button type="button" class="btn" style="border: 1px solid #F1600D; color: #F1600D;"
                                        data-bs-dismiss="modal">
                                        <i class="fas fa-times-circle me-1"></i>Close
                                    </button>
                                </div>

                            </div>
                        </div>
                    </div>


                    <script>
                        function showTaskDetail(name, description, date, categoryName, categoryColor, priorityID) {
                            document.getElementById("modalTaskName").innerText = name;
                            document.getElementById("modalTaskDescription").innerText = description;
                            document.getElementById("modalTaskDate").innerText = date;

                            const categoryElement = document.getElementById("modalTaskCategory");
                            categoryElement.innerText = categoryName;
                            categoryElement.style.backgroundColor = categoryColor;

                            const priorityElement = document.getElementById("modalTaskPriority");
                            priorityElement.innerHTML = ''; // Reset

                            // Build priority display with text first
                            switch (priorityID) {
                                case '1': // Low Priority
                                    priorityElement.innerHTML = `
                <span>Low Priority</span>
                <i class="fas fa-star text-warning ms-2"></i>
            `;
                                    break;
                                case '2': // Normal Priority
                                    priorityElement.innerHTML = `
                <span>Normal Priority</span>
                <i class="fas fa-star text-warning ms-1"></i>
                <i class="fas fa-star text-warning ms-2"></i>
            `;
                                    break;
                                case '3': // High Priority
                                    priorityElement.innerHTML = `
                <span>High Priority</span>
                <i class="fas fa-star text-warning ms-1"></i>
                <i class="fas fa-star text-warning ms-1"></i>
                <i class="fas fa-star text-warning ms-2"></i>
            `;
                                    break;
                                case '4': // Urgent
                                    priorityElement.innerHTML = `
                <span class="text-danger fw-bold">Urgent</span>
                <i class="fas fa-fire text-danger ms-2"></i>
            `;
                                    break;
                                default:
                                    priorityElement.innerText = 'No Priority';
                            }

                            const modal = new bootstrap.Modal(document.getElementById('taskDetailModal'));
                            modal.show();
                        }

                    </script>




                    </html>