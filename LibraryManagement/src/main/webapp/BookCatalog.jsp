<%-- 
    Document   : BookCatalog
    Created on : 23/04/2025, 9:46:08 a. m.
    Author     : juand
--%>

<%@page import="java.util.List"%>
<%@page import="Model.Book"%>
<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    User user = (User) session.getAttribute("usuario");

    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    List<Book> book = (List<Book>) request.getAttribute("libros"); // Traído desde el Servlet
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Catálogo de Libros</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container-fluid">

                <!-- Izquierda: Icono + Bienvenida -->
                <div class="d-flex align-items-center">
                    <i class="bi bi-person-circle fs-4 me-2"></i> <!-- Icono de usuario -->
                    <span class="text-white">Bienvenido, <%= user.getName()%> <%= user.getLastname()%></span>
                </div>

                <!-- Spacer en medio -->
                <div class="flex-grow-1"></div>

                <!-- Derecha: Botón desplegable -->
                <div class="dropdown">
                    <button class="btn btn-primary dropdown-toggle" type="button" id="menuPerfil" data-bs-toggle="dropdown" aria-expanded="false">
                        Menú
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="menuPerfil">
                        <li><a class="dropdown-item" href="ProfileManagement.jsp">Editar Perfil</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="LogoutController">Cerrar Sesión</a></li>
                    </ul>
                </div>

            </div>
        </nav>

        <div class="container mt-5">
            <h1 class="text-center mb-4">Catálogo de Libros</h1>

            <!-- Buscador -->
            <form action="BookController" method="get" class="mb-4">
                <div class="input-group">
                    <input type="text" class="form-control" name="search" placeholder="Buscar por título, autor o género">
                    <button class="btn btn-primary" type="submit">Buscar</button>
                </div>
            </form>

            <!-- Cards -->
            <div class="row">
                <% if (book != null) {
                        for (int i = 0; i < book.size(); i++) {
                            Book b = book.get(i);
                %>
                <div class="col-md-4 mb-4">
                    <div class="card h-100">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title"><%= b.getTitle()%></h5>
                            <h6 class="card-subtitle mb-2 text-muted"><%= b.getAuthor()%></h6>
                            <p class="card-text">
                                <strong>Género:</strong> <%= b.getGenre()%><br>
                                <strong>Disponibilidad:</strong> 
                                <% if (b.getAvailability()) { %>
                                <span class="badge bg-success">Disponible</span>
                                <% } else { %>
                                <span class="badge bg-danger">No disponible</span>
                                <% }%>
                            </p>
                            <!-- Botón para abrir el modal -->
                            <button type="button" class="btn btn-primary mt-auto" data-bs-toggle="modal" data-bs-target="#modalDetalle<%= b.getId()%>">
                                Ver Detalle
                            </button>
                        </div>
                    </div>
                </div>


                <!-- Modal Detalle -->
                <div class="modal fade" id="modalDetalle<%= b.getId()%>" tabindex="-1" aria-labelledby="detalleModalLabel<%= b.getId()%>" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="detalleModalLabel<%= b.getId()%>"><%= b.getTitle()%></h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                            </div>
                            <div class="modal-body">
                                <p><strong>Autor:</strong> <%= b.getAuthor()%></p>
                                <p><strong>Género:</strong> <%= b.getGenre()%></p>
                                <p><strong>Año de publicación:</strong> <%= b.getYear()%></p>
                                <p><strong>ISBN:</strong> <%= b.getIsbn()%></p>
                                <p><strong>Disponibilidad:</strong> 
                                    <% if (b.getAvailability()) { %>
                                    <span class="badge bg-success">Disponible</span>
                                    <% } else { %>
                                    <span class="badge bg-danger">No disponible</span>
                                    <% } %>
                                </p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>

                <%
                    } // fin del for
                } else { %>
                <div class="col-12">
                    <div class="alert alert-warning text-center">
                        No hay libros disponibles.
                    </div>
                </div>
                <% }%>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
