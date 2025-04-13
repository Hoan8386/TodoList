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
                                    <h3 class="stat-number">${totalTasks}</h3>
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
                                    <h3 class="stat-number">${completedTasks}</h3>
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
                                    <h3 class="stat-number">${pendingTasks}</h3>
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
                                    <h3 class="stat-number">${urgentTasks}</h3>
                                    <div class="stat-label">Urgent</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Tasks List -->
                    <div class="task-list">


                        <!-- Task Items -->
                        <div class="row">
                            <!-- Bên trái: danh sách task -->
                            <div class="col-md-6 ">
                                <div class="task-header">
                                    <h5>Today Tasks</h5>

                                </div>
                                <div class="task-items" style="height: 470px; overflow-y: scroll;">
                                    <c:forEach var="task" items="${tasks}">
                                        <div class="task-item"
                                            style="border-left: 4px solid ${task.categoryColor}; padding-left: 10px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.15); margin-bottom: 10px;">

                                            <!-- Checkbox đánh dấu completed -->
                                            <div class="task-checkbox">
                                                <form:form action="/checkTask" method="post">
                                                    <input type="hidden" name="taskId" value="${task.taskID}" />
                                                    <input type="checkbox" class="form-check-input" name="completed"
                                                        onchange="this.form.submit()" <c:if
                                                        test="${task.status}">checked</c:if> />
                                                </form:form>
                                            </div>

                                            <!-- Thông tin chi tiết task -->
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
                                    </c:forEach>

                                </div>
                            </div>

                            <!-- Bên phải: biểu đồ tròn -->
                            <div class="col-md-6">
                                <div class="task-header">
                                    <h5>Process</h5>

                                </div>
                                <div style="max-width: 400px; margin: auto;">
                                    <canvas id="taskChart"></canvas>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <!-- Bootstrap Bundle with Popper -->
                <script src="https://cdn.jsdelivr.net/npm/chart.js">
                    src = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" ></script>
                <script>
                const completed = ${ completedToday };
                    const pending = ${ pendingToday };

                    const ctx = document.getElementById('taskChart').getContext('2d');
                    const taskChart = new Chart(ctx, {
                        type: 'pie',
                        data: {
                            labels: ['Completed', 'Pending'],
                            datasets: [{
                                data: [completed, pending],
                                backgroundColor: ['#F1600D', '#ffc107'],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            responsive: true,
                            plugins: {
                                legend: {
                                    position: 'bottom'
                                },
                                title: {
                                    display: true,
                                    text: 'Task Completion Today'
                                }
                            }
                        }
                    });
                </script>


            </body>

            </html>