<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>Login - Laptopshop</title>
                <link rel="stylesheet" href="/css/client/style.css">
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
                    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
                    crossorigin="anonymous">
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
                    crossorigin="anonymous"></script>
            </head>

            <body>
                <div class="container" style="height: 100vh;">
                    <div class="row d-flex justify-content-center  align-items-center" style="height: 100% ">
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
                                            Organize your day, achieve more
                                        </p>
                                    </div>
                                </div>
                                <form:form method="post" action="user/login" modelAttribute="user">
                                    <label for="exampleInputEmail1" class="form-label text-color">Email</label>
                                    <div class="mb-3 border rounded">
                                        <form:input type="text" class="form-control border-0"
                                            aria-describedby="emailHelp" path="Email" />
                                    </div>

                                    <label for="exampleInputEmail1" class="form-label text-color">Password</label>
                                    <div class="input-group mb-3 border rounded">
                                        <form:input path="passwordHash" type="text" class="form-control " placeholder=""
                                            aria-describedby="button-addon2" style="border: none;" />
                                        <button class="btn text-color " type="button" id="button-addon2">Show</button>
                                    </div>

                                    <div class="d-flex justify-content-between ">
                                        <div class=" mb-3 form-check">
                                            <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                            <label class="form-check-label text-color" for="exampleCheck1">Remember
                                                me</label>
                                        </div>

                                        <div>
                                            <a class="primary-color" href="">forgot password?</a>
                                        </div>
                                    </div>


                                    <button type="submit" class="btn-sign-in btn text-white w-100 mt-2 ">Sign
                                        in</button>
                                </form:form>

                                <div class="text-center mt-3">
                                    <p class="text-color">Don't have an account? <a class="primary-color mx-2" href="">
                                            Sign
                                            up now</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>