<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <div class="search-container mb-4 d-flex justify-content-between align-items-start">
            <div class="slogan" style="max-width: 700px;">
                <p style="font-size: 20px; font-weight: 600; color: #343a40;">
                    Lên kế hoạch hôm nay – Thành công ngày mai!
                </p>
                <!-- Thông báo chúc mừng sinh nhật -->
                <c:if test="${not empty birthdayMessage}">
                    <div class="alert alert-warning alert-dismissible fade show mt-2" role="alert"
                        style="font-size: 0.95rem; padding: 8px 12px;">
                        <i class="fas fa-birthday-cake me-2"></i>
                        ${birthdayMessage}
                        <!-- <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button> -->
                    </div>
                </c:if>
            </div>
            <div class="d-flex align-items-center">
                <i class="fas fa-bell me-3 text-secondary" style="font-size: 1.2rem; cursor: pointer;"></i>
                <div class="dropdown">
                    <div class="d-flex align-items-center" id="userDropdown" data-bs-toggle="dropdown"
                        aria-expanded="false" style="cursor: pointer;">
                        <span class="user-info me-2">
                            <a href="/info" class="text-decoration-none text-dark fw-medium">
                                <!-- ${user != null && user.userName != null ? user.userName : 'Guest'} -->
                                ${user != null && user.userName != null ? user.userName : ''}
                            </a>
                        </span>
                        <div class="user-avatar"
                            style="width: 32px; height: 32px; border-radius: 50%; background-color: #4e73df; color: #fff; display: flex; align-items: center; justify-content: center; font-size: 0.9rem; font-weight: 500;">
                            <!-- ${user != null && user.userName != null && !user.userName.isEmpty() ?
                            user.userName.substring(0, 2).toUpperCase() : 'UD'} -->

                            ${user != null && user.userName != null && !user.userName.isEmpty() ?
                            user.userName.substring(0, 2).toUpperCase() : 'UD'}
                        </div>
                    </div>
                    <ul class="dropdown-menu dropdown-menu-end shadow-sm" aria-labelledby="userDropdown"
                        style="min-width: 150px;">
                        <li><a class="dropdown-item" href="/info"><i class="fas fa-user me-2"></i> Profile</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item text-danger" href="/logout"><i class="fas fa-sign-out-alt me-2"></i>
                                Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <style>
            .user-info a:hover {
                color: #4e73df !important;
            }

            .user-avatar {
                transition: transform 0.2s ease;
            }

            .user-avatar:hover {
                transform: scale(1.1);
            }

            .dropdown-item {
                font-size: 0.95rem;
                padding: 8px 15px;
            }

            .dropdown-item:hover {
                background-color: #f8f9fa;
            }

            .dropdown-menu {
                border-radius: 8px;
                border: none;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }
        </style>