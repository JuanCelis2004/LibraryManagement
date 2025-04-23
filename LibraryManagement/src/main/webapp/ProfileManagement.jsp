<%-- 
    Document   : profileManagement
    Created on : 23/04/2025, 9:47:31 a. m.
    Author     : juand
--%>

<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    User user = (User) session.getAttribute("usuario");

    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Perfil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <div class="container mt-5">
        <h1 class="text-center mb-4">Editar Perfil</h1>

        <div class="row justify-content-center">
            <div class="col-md-6">

                <form action="UserController" method="POST">
                    <input type="hidden" name="id" value="<%= user.getId() %>">

                    <div class="mb-3">
                        <label for="name" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() %>" required>
                    </div>

                    <div class="mb-3">
                        <label for="lastname" class="form-label">Apellido</label>
                        <input type="text" class="form-control" id="lastname" name="lastname" value="<%= user.getLastname() %>" required>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Correo Electrónico</label>
                        <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" required>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Nueva Contraseña</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Deja vacío si no deseas cambiarla">
                    </div>

                    <div class="d-grid">
                        <button type="submit" name="action" value="edit" class="btn btn-primary">Guardar Cambios</button>
                    </div>
                    <div class="d-grid">
                        <a href="BookCatalog.jsp" class="btn btn-secondary">Regresar</a>
                    </div>
                </form>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
