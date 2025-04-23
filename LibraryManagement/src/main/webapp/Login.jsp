<%-- 
    Document   : Login
    Created on : 23/04/2025, 9:43:45 a. m.
    Author     : juand
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iniciar Sesión</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <% if (request.getParameter("emailChanged") != null) { %>
        <div class="alert alert-info text-center" role="alert">
            Tu correo fue actualizado. Por favor inicia sesión de nuevo.
        </div>
        <% }%>
        <div class="container mt-5">
            <h2 class="text-center mb-4">Iniciar Sesión</h2>

            <form action="UserController" method="POST" class="mx-auto" style="max-width: 500px;">

                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Ingresa tu correo" required>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Ingresa tu contraseña" required>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" name="action" value="login" class="btn btn-primary">Iniciar Sesión</button>
                    <a href="index.jsp" class="btn btn-secondary">Regresar</a>
                </div>
            </form>

            <div class="text-center mt-3">
                ¿No tienes cuenta? <a href="Signup.jsp">Regístrate aquí</a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
