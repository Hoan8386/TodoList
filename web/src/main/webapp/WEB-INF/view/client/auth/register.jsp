<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>


                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <title>Register - Task Manager</title>
                    <link rel="stylesheet" href="/css/client/style.css">
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <style>
                        .btn-invalid {
                            border: 1px solid #dc3545 !important;
                            /* Màu đỏ giống Bootstrap lỗi */
                            border-left: none !important;
                            /* Tránh trùng viền giữa input và button */
                        }
                    </style>
                </head>

                <body>
                    <div class="container" style="height: 100vh;">
                        <div class="row d-flex justify-content-center align-items-center" style="height: 100%">
                            <div class="col-12">
                                <div class="form-container mx-auto p-5" style="width: 500px;">
                                    <div class="row mb-3">
                                        <div class="col-3">
                                            <div style="width: 100%; height: 60px; object-fit:cover; overflow: hidden;">
                                                <img src="/images/client/logo2.png" alt="" style="width: 100%;">
                                            </div>
                                        </div>
                                        <div class="col-9 p-0">
                                            <h4 class="m-0">Task Manager</h4>
                                            <p class="text-color">
                                                Create your account today
                                            </p>
                                        </div>
                                    </div>
                                    <form:form method="post" action="/register" modelAttribute="newUser">

                                        <c:set var="errorEmail">
                                            <form:errors path="email" />
                                        </c:set>
                                        <c:set var="errorUserName">
                                            <form:errors path="userName" />
                                        </c:set>
                                        <c:set var="errorPassword">
                                            <form:errors path="passwordHash" />
                                        </c:set>

                                        <c:set var="errorConfirmPassword">
                                            <form:errors path="confirmPassword" />
                                        </c:set>




                                        <label for="email" class="form-label text-color">Email</label>
                                        <div class="mb-3">
                                            <form:input path="email" type="email"
                                                class="form-control ${not empty errorEmail? 'is-invalid':''}"
                                                id="email" />
                                            <form:errors path="email" cssClass="text-danger" />
                                        </div>

                                        <label for="username" class="form-label text-color">Username</label>
                                        <div class="mb-3 ">
                                            <form:input path="userName" type="text" class=" form-control  
                                                ${not empty errorUserName? 'is-invalid':''}" id="username" />
                                            <form:errors path="userName" cssClass="invalid-feedback" />
                                        </div>


                                        <!-- Hiển thị lỗi toàn cục (ví dụ: @AssertTrue) -->
                                        <div class="form-group mb-3">
                                            <label for="password"
                                                class="form-label fw-semibold text-muted">Password</label>
                                            <div class="input-group has-validation">
                                                <form:input path="passwordHash" type="password"
                                                    cssClass="form-control rounded-start border-end-0 ${not empty errorPassword? 'is-invalid':''}"
                                                    id="password" placeholder="" autocomplete="new-password" />
                                                <c:set var="hasError" value="${not empty errorPassword}" />

                                                <button
                                                    class="btn btn-outline-secondary rounded-end ${hasError ? 'btn-invalid' : ''}"
                                                    type="button" onclick="togglePassword(this)"
                                                    aria-label="Hiển thị/Ẩn mật khẩu">
                                                    Show
                                                </button>

                                                <form:errors path="passwordHash"
                                                    cssClass="invalid-feedback d-block mt-1" />
                                            </div>
                                        </div>

                                        <div class="form-group mb-3">
                                            <label for="confirmPassword"
                                                class="form-label fw-semibold text-muted">Confirm Password</label>
                                            <div class="input-group has-validation">
                                                <form:input path="confirmPassword" type="password"
                                                    class="form-control rounded-start border-end-0 ${not empty errorConfirmPassword ? 'is-invalid' : ''}"
                                                    id="confirmPassword" placeholder="" autocomplete="new-password" />

                                                <c:set var="hasError" value="${confirmPassword}" />
                                                <button
                                                    class="btn btn-outline-secondary rounded-end ${hasError ? 'btn-invalid' : ''}"
                                                    type="button" onclick="togglePassword(this)"
                                                    aria-label="Hiển thị/Ẩn mật khẩu">
                                                    Show
                                                </button>

                                                <form:errors path="confirmPassword"
                                                    cssClass="invalid-feedback d-block mt-1" />
                                            </div>
                                        </div>


                                        <div class=" mb-3 form-check">
                                            <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                            <label class="form-check-label text-color" for="exampleCheck1">I agree to
                                                the
                                                Terms of Service and Privacy Policy</label>
                                        </div>

                                        <button type="submit" class="btn-sign-in btn text-white w-100 mt-2">Create
                                            Account</button>
                                    </form:form>

                                    <div class="text-center mt-3">
                                        <p class="text-color">Already have an account? <a class="primary-color mx-2"
                                                href="/login">Sign in</a></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script>
                        function togglePassword(e) {
                            var inputField = e.previousElementSibling; // Lấy input ngay trước button
                            if (inputField.type === "password") {
                                inputField.type = "text";
                            } else {
                                inputField.type = "password";
                            }
                        }

                        function validatePasswords() {
                            var password = document.getElementById("password").value;
                            var confirmPassword = document.getElementById("confirmPassword").value;
                            var errorMessage = document.getElementById("password-error");
                            var confirmPasswordField = document.getElementById("confirmPassword");

                            if (password !== confirmPassword) {
                                errorMessage.innerText = "Mật khẩu và xác nhận mật khẩu không khớp.";
                                confirmPasswordField.classList.add("is-invalid");
                            } else {
                                errorMessage.innerText = "";
                                confirmPasswordField.classList.remove("is-invalid");
                            }
                        }

                        // Gắn sự kiện vào các trường nhập mật khẩu
                        document.getElementById("password").oninput = validatePasswords;
                        document.getElementById("confirmPassword").oninput = validatePasswords;


                    </script>
                </body>

                </html>