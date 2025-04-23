<%-- 
    Document   : Signup
    Created on : 23/04/2025, 9:43:34 a. m.
    Author     : juand
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Registro de Usuario</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center mb-4">Registro de Usuario</h2>

            <!-- Mensaje de error opcional -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger text-center">${error}</div>
            </c:if>

            <form action="UserController" method="POST" class="mx-auto" style="max-width: 500px;">
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="name" required>
                </div>

                <div class="mb-3">
                    <label for="apellido" class="form-label">Apellido</label>
                    <input type="text" class="form-control" id="apellido" name="lastname" required>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Correo Electrónico</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Contraseña</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                
                <input type="hidden" name="rol" value="1">

                <div class="d-grid gap-2">
                    <button type="submit" name="action" value="signup" class="btn btn-success">Registrarse</button>
                    <a href="index.jsp" class="btn btn-secondary">Regresar</a>
                </div>
            </form>

            <div class="text-center mt-3">
                ¿Ya tienes cuenta? <a href="Login.jsp">Inicia sesión</a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
