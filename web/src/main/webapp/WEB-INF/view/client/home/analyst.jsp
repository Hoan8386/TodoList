<%@ page contentType="text/html;charset=UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>TaskFlow - Analytics</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link rel="stylesheet" href="/css/client/style.css">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            .chart-container {
                padding: 20px;
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            }

            .equal-height {
                padding: 20px 20px 60px 20px;
                height: 400px;
                /* hoặc 100% nếu container cha cố định */
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .equal-height h5 {
                margin-bottom: 16px;
            }

            .equal-height canvas {
                flex-grow: 1;
            }
        </style>

    </head>

    <body>
        <!-- Sidebar -->
        <jsp:include page="../layout/sidebar.jsp" />

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <jsp:include page="../layout/header.jsp" />

            <div class="container">
                <h2 class="mb-3">Task Analytics</h2>

                <div class="row">
                    <!-- 7 recent day -->
                    <div class="col-md-6">
                        <div class="chart-container equal-height">
                            <h5>7 recent day</h5>
                            <canvas id="weeklyChart"></canvas>
                        </div>
                    </div>

                    <!-- Completion Pie Chart -->
                    <div class="col-md-6">
                        <div class="chart-container equal-height">
                            <h5>Completion Ratio</h5>
                            <canvas id="completionChart"></canvas>
                        </div>
                    </div>
                </div>


                <div class="row" style="margin-top: 32px;">
                    <!-- Monthly Chart -->
                    <div class="col-md-12">
                        <div class="chart-container">
                            <h5>Tasks by Month</h5>
                            <canvas id="monthlyChart" height="120"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Chart JS - Dummy Data -->
        <script>
            const weeklyChart = new Chart(document.getElementById('weeklyChart'), {
                type: 'bar',
                data: {
                    labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                    datasets: [{
                        label: 'Tasks',
                        data: [3, 5, 2, 6, 4, 1, 2],
                        backgroundColor: '#4e73df'
                    }]
                }
            });

            const completionChart = new Chart(document.getElementById('completionChart'), {
                type: 'doughnut',
                data: {
                    labels: ['Completed', 'Pending'],
                    datasets: [{
                        data: [12, 8],
                        backgroundColor: ['#28a745', '#ffc107']
                    }]
                }
            });

            const monthlyChart = new Chart(document.getElementById('monthlyChart'), {
                type: 'line',
                data: {
                    labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"],
                    datasets: [{
                        label: 'Tasks',
                        data: [12, 19, 7, 11, 15, 10, 20],
                        borderColor: '#36A2EB',
                        fill: true,
                        backgroundColor: 'rgba(54, 162, 235, 0.2)'
                    }]
                }
            });
        </script>
    </body>

    </html>