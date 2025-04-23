<%-- 
    Document   : index.jsp
    Created on : 23/04/2025, 8:54:58 a. m.
    Author     : juand
--%>

<%@page import="Persistence.UserJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <title>Catálogo de Libros</title>
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    
    <% 
       UserJpaController userjpa = new UserJpaController(); 
    %>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Biblioteca Virtual</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <div class="ms-auto d-flex">
                    <a href="Login.jsp" class="btn btn-light me-2">Iniciar Sesión</a>
                    <a href="Signup.jsp" class="btn btn-success">Registrarse</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Catálogo - Carrusel de Cards -->
    <div class="container my-5">
        <h2 class="text-center mb-4">Catálogo de Libros</h2>

        <div id="carouselLibros" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">

                <!-- Primera Card -->
                <div class="carousel-item active">
                    <div class="d-flex justify-content-center">
                        <div class="card" style="width: 18rem;">
                            <img src="imagenes/libro1.jpg" class="card-img-top" alt="Libro 1">
                            <div class="card-body text-center">
                                <h5 class="card-title">El Principito</h5>
                                <p class="card-text">Un clásico de Antoine de Saint-Exupéry.</p>
                                <a href="Login.jsp" class="btn btn-primary">Ver más</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Segunda Card -->
                <div class="carousel-item">
                    <div class="d-flex justify-content-center">
                        <div class="card" style="width: 18rem;">
                            <img src="imagenes/libro2.jpg" class="card-img-top" alt="Libro 2">
                            <div class="card-body text-center">
                                <h5 class="card-title">Cien Años de Soledad</h5>
                                <p class="card-text">Obra maestra de Gabriel García Márquez.</p>
                                <a href="Login.jsp" class="btn btn-primary">Ver más</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tercera Card -->
                <div class="carousel-item">
                    <div class="d-flex justify-content-center">
                        <div class="card" style="width: 18rem;">
                            <img src="imagenes/libro3.jpg" class="card-img-top" alt="Libro 3">
                            <div class="card-body text-center">
                                <h5 class="card-title">1984</h5>
                                <p class="card-text">La distopía de George Orwell.</p>
                                <a href="Login.jsp" class="btn btn-primary">Ver más</a>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Controles del Carrusel -->
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselLibros" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselLibros" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>

        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-light text-center py-4 mt-5">
        <div class="container">
            <p class="mb-0">&copy; 2025 Biblioteca Virtual. Todos los derechos reservados.</p>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
