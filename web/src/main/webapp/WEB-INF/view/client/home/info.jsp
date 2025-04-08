<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>User Profile</title>
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
                    rel="stylesheet">
                <link rel="stylesheet" href="/css/client/style.css">
                <!-- Font Awesome for icons -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <style>
                    .user-info-container {
                        max-width: 800px;
                        margin: 20px auto;
                        padding: 20px;
                        border-radius: 10px;
                        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                    }

                    .user-avatar {
                        width: 150px;
                        height: 150px;
                        border-radius: 50%;
                        object-fit: cover;
                        margin-bottom: 20px;
                    }

                    .info-item {
                        margin-bottom: 15px;
                        padding: 10px;
                        border-bottom: 1px solid #eee;
                    }

                    .info-label {
                        font-weight: bold;
                        color: #555;
                        width: 150px;
                        display: inline-block;
                    }

                    .form-control.d-inline-block {
                        width: 300px;
                    }

                    .text-danger {
                        font-size: 0.9rem;
                    }
                </style>
            </head>

            <body>
                <!-- Thêm side bar -->
                <jsp:include page="../layout/sidebar.jsp" />

                <!-- Main Content -->
                <div class="container user-info-container">
                    <div class="text-center">
                        <img src="${user != null && user.avatar != null ? user.avatar : 'https://via.placeholder.com/150'}"
                            alt="User Avatar" class="user-avatar">
                        <h2 class="mb-4">User Profile</h2>
                    </div>

                    <!-- Form chứa các input -->
                    <form id="userProfileForm" action="updateUser" method="POST">
                        <div class="info-section">
                            <div class="info-item">
                                <span class="info-label">User Name:</span>
                                <input type="text" name="userName" class="form-control d-inline-block"
                                    value="${user.userName}">
                                <c:if test="${user != null && empty user.userName}">
                                    <small class="text-danger error-message">Please update your username!</small>
                                </c:if>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Email:</span>
                                <input type="email" name="email" class="form-control d-inline-block"
                                    value="${user != null && user.email != null ? user.email : ''}" readonly>
                                <c:if test="${user != null && empty user.email}">
                                    <small class="text-danger error-message d-block">Please update your email!</small>
                                </c:if>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Phone:</span>
                                <input type="text" name="phoneNumber" class="form-control d-inline-block"
                                    value="${user != null && user.phoneNumber != null ? user.phoneNumber : ''}"
                                    readonly>
                                <c:if test="${user != null && empty user.phoneNumber}">
                                    <small class="text-danger error-message d-block">Please update your phone
                                        number!</small>
                                </c:if>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Birth Date:</span>
                                <input type="text" name="birthDate" class="form-control d-inline-block"
                                    value="${user != null && user.birthDate != null ? user.birthDate : ''}" readonly>
                                <c:if test="${user != null && empty user.birthDate}">
                                    <small class="text-danger error-message d-block">Please update your birth
                                        date!</small>
                                </c:if>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Avatar:</span>
                                <input type="text" name="avatar" class="form-control d-inline-block"
                                    value="${user != null && user.avatar != null ? user.avatar : ''}" readonly>
                                <c:if test="${user != null && empty user.avatar}">
                                    <small class="text-danger error-message d-block">Please update your avatar!</small>
                                </c:if>
                            </div>
                        </div>

                        <div class="mt-4 text-center">
                            <button type="button" id="editButton" class="btn btn-primary me-2"
                                onclick="toggleEditMode()">
                                <i class="fas fa-edit"></i> Edit Profile
                            </button>
                            <button type="submit" id="saveButton" class="btn btn-success me-2" style="display: none;">
                                <i class="fas fa-save"></i> Save
                            </button>
                            <a href="dashboard.jsp" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left"></i> Back
                            </a>
                        </div>
                    </form>

                    <style>
                        .error-message {
                            display: block;
                            margin-left: 160px;
                            /* Can be adjusted to match the width of the input fields */
                            font-size: 0.9rem;
                        }
                    </style>

                </div>

                <!-- JavaScript để xử lý chế độ chỉnh sửa -->
                <script>
                    function toggleEditMode() {
                        const inputs = document.querySelectorAll('#userProfileForm input');
                        const editButton = document.getElementById('editButton');
                        const saveButton = document.getElementById('saveButton');

                        // Kiểm tra trạng thái hiện tại của input
                        const isReadOnly = inputs[0].hasAttribute('readonly');

                        if (isReadOnly) {
                            // Chuyển sang chế độ chỉnh sửa
                            inputs.forEach(input => input.removeAttribute('readonly'));
                            editButton.style.display = 'none';
                            saveButton.style.display = 'inline-block';
                        }
                    }
                </script>

                <!-- Bootstrap Bundle with Popper -->
                <script
                    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>