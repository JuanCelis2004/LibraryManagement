<%-- 
    Document   : AdminPanel
    Created on : 23/04/2025, 9:48:11 a. m.
    Author     : juand
--%>

<%@page import="Persistence.LoanJpaController"%>
<%@page import="Model.Loan"%>
<%@page import="Persistence.BookJpaController"%>
<%@page import="Model.Book"%>
<%@page import="Persistence.UserJpaController"%>
<%@page import="java.util.List"%>
<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%

    UserJpaController userJPA = new UserJpaController();
    BookJpaController bookJPA = new BookJpaController();
    LoanJpaController loanJPA = new LoanJpaController();

    User admin = (User) session.getAttribute("usuario");

    Book book = (Book) session.getAttribute("books");

    if (admin == null || admin.getRol() != 2) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Panel de Administración</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                min-height: 100vh;
                display: flex;
                flex-direction: row;
            }
            .sidebar {
                width: 250px;
                background-color: #343a40;
                padding-top: 1rem;
            }
            .sidebar a, .sidebar .dropdown-toggle {
                color: black;
                text-decoration: none;
                padding: 10px 20px;
                display: block;
            }
            #dropdown-toggle {
                color: white;
                text-decoration: none;
                padding: 10px 20px;
                display: block;
            }

            .sidebar a:hover, .sidebar .dropdown-toggle:hover {
                background-color: #495057;
                color: white;
            }
            .content {
                flex-grow: 1;
                padding: 2rem;
                background-color: #f8f9fa;
            }
        </style>
    </head>

    <body>

        <!-- Sidebar -->
        <div class="sidebar d-flex flex-column">
            <h4 class="text-white text-center">Admin Panel</h4>

            <!-- Usuarios -->
            <div class="dropdown">
                <a class="dropdown-toggle" id="dropdown-toggle" href="#" data-bs-toggle="dropdown">Usuarios</a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#" onclick="mostrarSeccion('crearUsuario')">Crear Usuario</a></li>
                    <li><a class="dropdown-item" href="#" onclick="mostrarSeccion('listarUsuarios')">Listar Usuarios</a></li>
                </ul>
            </div>

            <!-- Libros -->
            <div class="dropdown">
                <a class="dropdown-toggle" id="dropdown-toggle" href="#" data-bs-toggle="dropdown">Libros</a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#" onclick="mostrarSeccion('crearLibro')">Crear Libro</a></li>
                    <li><a class="dropdown-item" href="#" onclick="mostrarSeccion('listarLibros')">Listar Libros</a></li>
                </ul>
            </div>

            <!-- Préstamos -->
            <div class="dropdown">
                <a class="dropdown-toggle" id="dropdown-toggle" href="#" data-bs-toggle="dropdown">Préstamos</a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#" onclick="mostrarSeccion('crearPrestamo')">Crear Préstamo</a></li>
                    <li><a class="dropdown-item" href="#" onclick="mostrarSeccion('listarPrestamos')">Listar Préstamos</a></li>
                </ul>
            </div>

        </div>



        <!-- Main Content -->
        <div class="content">
            <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
                <div class="container-fluid">

                    <!-- Izquierda: Icono + Bienvenida -->
                    <div class="d-flex align-items-center">
                        <i class="bi bi-person-circle fs-4 me-2"></i> <!-- Icono de usuario -->
                        <span class="text-white">Bienvenido, <%= admin.getName()%> <%= admin.getLastname()%></span>
                    </div>

                    <!-- Spacer en medio -->
                    <div class="flex-grow-1"></div>

                    <!-- Derecha: Botón desplegable -->
                    <div class="dropdown">
                        <button class="btn btn-primary dropdown-toggle" type="button" id="menuPerfil" data-bs-toggle="dropdown" aria-expanded="false">
                            Menú
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="menuPerfil">
                            <li><a class="dropdown-item" href="LogoutController">Cerrar Sesión</a></li>
                        </ul>
                    </div>

                </div>
            </nav>

            <!-- Secciones dinámicas -->
            <div id="crearUsuario" style="display: none;">
                <h3 class="text-center mb-4">Crear Usuario</h3>

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

                    <div class="mb-3">
                        <label for="rol" class="form-label">Rol</label>
                        <select id="id" name="rol" class="form-control">
                            <option value="1">User</option>
                            <option value="2">Admin</option>
                        </select>
                    </div>


                    <div class="d-grid gap-2">
                        <button type="submit" name="action" value="create" class="btn btn-success">Create</button>
                    </div>
                </form>

            </div>

            <div id="listarUsuarios" style="display: none;">
                <h3 class="text-center mb-4">Lista de Usuarios</h3>
                <table id="tablaUsuarios" class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Last Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Obtén los usuarios desde la base de datos
                            List<User> usuarios = userJPA.findUserEntities(); // Suponiendo que tienes este método
                            int cont = 1;
                            for (User u : usuarios) {
                        %>
                        <tr>
                            <td><%=cont%></td>
                            <td><%= u.getName()%> </td>
                            <td><%= u.getLastname()%></td>
                            <td><%= u.getEmail()%></td>
                            <td><%= u.getRol() == 1 ? "User" : "Admin"%></td>
                            <td>
                                <div class="d-flex justify-content-between gap-2">
                                    <!-- Botón de Editar (abre el modal) -->
                                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editarModal<%= u.getId()%>">
                                        <i class="bi bi-pencil-fill"></i> Editar
                                    </button>

                                    <!-- Botón de Eliminar (abre el modal) -->
                                    <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#eliminarModal<%= u.getId()%>">
                                        <i class="bi bi-trash-fill"></i> Eliminar
                                    </button>
                                </div>
                            </td>
                        </tr>

                        <!-- Modal Editar Usuario -->
                    <div class="modal fade" id="editarModal<%= u.getId()%>" tabindex="-1" aria-labelledby="editarModalLabel<%= u.getId()%>" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editarModalLabel<%= u.getId()%>">Editar Usuario</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <!-- Formulario para editar usuario -->
                                    <form action="UserController" method="POST">
                                        <input type="hidden" name="id" value="<%= u.getId()%>">
                                        <div class="mb-3">
                                            <label for="nombre" class="form-label">Nombre</label>
                                            <input type="text" class="form-control" id="nombre" name="name" value="<%= u.getName()%>" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="apellido" class="form-label">Apellido</label>
                                            <input type="text" class="form-control" id="apellido" name="lastname" value="<%= u.getLastname()%>" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="email" class="form-label">Correo Electrónico</label>
                                            <input type="email" class="form-control" id="email" name="email" value="<%= u.getEmail()%>" required>
                                        </div>

                                        <div class="mb-3">
                                            <label for="password" class="form-label">Nueva Contraseña</label>
                                            <input type="password" class="form-control" id="password" name="password" placeholder="Deja vacío si no deseas cambiarla">
                                        </div>

                                        <div class="mb-3">
                                            <label for="rol" class="form-label">Rol</label>
                                            <select name="rol" class="form-control">
                                                <option value="1" <%= u.getRol() == 1 ? "selected" : ""%>>User</option>
                                                <option value="2" <%= u.getRol() == 2 ? "selected" : ""%>>Admin</option>
                                            </select>
                                        </div>
                                        <div class="d-grid gap-2">
                                            <button type="submit" name="action" value="Adminedit" class="btn btn-success">Guardar cambios</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal Eliminar Usuario -->
                    <div class="modal fade" id="eliminarModal<%= u.getId()%>" tabindex="-1" aria-labelledby="eliminarModalLabel<%= u.getId()%>" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="eliminarModalLabel<%= u.getId()%>">Eliminar Usuario</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <p>¿Estás seguro de que deseas eliminar al usuario <%= u.getName()%> <%= u.getLastname()%>? Esta acción no se puede deshacer.</p>
                                </div>
                                <div class="modal-footer">
                                    <form action="UserController" method="POST">
                                        <input type="hidden" name="id" value="<%= u.getId()%>">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                        <button type="submit" name="action" value="delete" class="btn btn-danger">Eliminar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% cont++;
                        } %>
                    </tbody>
                </table>
            </div>


            <div id="crearLibro" style="display: none;">
                <h3 class="text-center mb-4">Crear Libro</h3>

                <form action="BookController" method="POST" class="row g-3">
                    <div class="col-md-6">
                        <label for="title" class="form-label">Título</label>
                        <input type="text" class="form-control" id="title" name="title" required>
                    </div>

                    <div class="col-md-6">
                        <label for="author" class="form-label">Autor</label>
                        <input type="text" class="form-control" id="author" name="author" required>
                    </div>

                    <div class="col-md-6">
                        <label for="year" class="form-label">Año</label>
                        <input type="number" class="form-control" id="year" name="year" required>
                    </div>

                    <div class="col-md-6">
                        <label for="isbn" class="form-label">ISBN</label>
                        <input type="text" class="form-control" id="isbn" name="isbn" required>
                    </div>

                    <div class="col-md-6">
                        <label for="genre" class="form-label">Género</label>
                        <input type="text" class="form-control" id="genre" name="genre" required>
                    </div>

                    <div class="col-md-6">
                        <label for="availability" class="form-label">Disponibilidad</label>
                        <select class="form-control" id="availability" name="availability" required>
                            <option value="true">Disponible</option>
                            <option value="false">No disponible</option>
                        </select>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" name="action" value="create" class="btn btn-success">Crear Libro</button>
                    </div>
                </form>

            </div>

            <div id="listarLibros" style="display: none;">
                <h3 class="text-center mb-4">Lista de Libros</h3>
                <table id="tablaLibros" class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Year</th>
                            <th>ISBN</th>
                            <th>Genre</th>
                            <th>Availability</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%

                            List<Book> books = bookJPA.findBookEntities();
                            int contB = 1;
                            for (Book b : books) {
                        %>
                        <tr>
                            <td><%=contB%></td>
                            <td><%= b.getTitle()%> </td>
                            <td><%= b.getAuthor()%></td>
                            <td><%= b.getYear()%></td>
                            <td><%= b.getIsbn()%></td>
                            <td><%= b.getGenre()%></td>
                            <td><%= b.getAvailability() ? "Available" : "Disavailable"%></td>
                            <td>
                                <div class="d-flex justify-content-between gap-2">
                                    <!-- Botón de Editar (abre el modal) -->
                                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editarModalB<%= b.getId()%>">
                                        <i class="bi bi-pencil-fill"></i> Edit
                                    </button>

                                    <!-- Botón de Eliminar (abre el modal) -->
                                    <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#eliminarModalB<%= b.getId()%>">
                                        <i class="bi bi-trash-fill"></i> Delete
                                    </button>
                                </div>
                            </td>
                        </tr>


                    <div class="modal fade" id="editarModalB<%= b.getId()%>" tabindex="-1" aria-labelledby="editarModalLabel<%= b.getId()%>" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editarModalLabel<%= b.getId()%>">Editar Usuario</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="BookController" method="POST">
                                        <input type="hidden" name="id" value="<%= b.getId()%>">

                                        <div class="mb-3">
                                            <label for="title" class="form-label">Título</label>
                                            <input type="text" class="form-control" id="title" name="title" value="<%= b.getTitle()%>" required>
                                        </div>

                                        <div class="mb-3">
                                            <label for="author" class="form-label">Autor</label>
                                            <input type="text" class="form-control" id="author" name="author" value="<%= b.getAuthor()%>" required>
                                        </div>

                                        <div class="mb-3">
                                            <label for="year" class="form-label">Año</label>
                                            <input type="number" class="form-control" id="year" name="year" value="<%= b.getYear()%>" required>
                                        </div>

                                        <div class="mb-3">
                                            <label for="isbn" class="form-label">ISBN</label>
                                            <input type="text" class="form-control" id="isbn" name="isbn" value="<%= b.getIsbn()%>" required>
                                        </div>

                                        <div class="mb-3">
                                            <label for="genre" class="form-label">Género</label>
                                            <input type="text" class="form-control" id="genre" name="genre" value="<%= b.getGenre()%>" required>
                                        </div>

                                        <div class="mb-3">
                                            <label for="availability" class="form-label">Disponibilidad</label>
                                            <select class="form-control" id="availability" name="availability" required>
                                                <option value="true" <%= b.getAvailability() ? "selected" : ""%>>Available</option>
                                                <option value="false" <%= !b.getAvailability() ? "selected" : ""%>>Disavailable</option>
                                            </select>
                                        </div>

                                        <div class="d-grid gap-2">
                                            <button type="submit" name="action" value="edit" class="btn btn-primary">Edit</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="eliminarModalB<%= b.getId()%>" tabindex="-1" aria-labelledby="eliminarModalLabel<%= b.getId()%>" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="eliminarModalLabel<%= b.getId()%>">Eliminar Usuario</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <p>¿Estás seguro de que deseas eliminar el libro <%= b.getTitle()%> de <%= b.getAuthor()%>? Esta acción no se puede deshacer.</p>
                                </div>
                                <div class="modal-footer">
                                    <form action="BookController" method="POST">
                                        <input type="hidden" name="id" value="<%= b.getId()%>">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                        <button type="submit" name="action" value="delete" class="btn btn-danger">Eliminar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% contB++;
                        } %>
                    </tbody>
                </table>
            </div>

            <div id="crearPrestamo" style="display: none;">
                <h3 class="text-center mb-4">Crear Préstamo</h3>

                <form action="LoanController" method="POST" class="row g-3">

                    <!-- Seleccionar Usuario -->
                    <div class="col-md-6">
                        <label for="id_user" class="form-label">Usuario</label>
                        <select class="form-select" id="id_user" name="id_user" required>
                            <option value="" disabled selected>Seleccione un usuario</option>
                            <%

                                for (User u : usuarios) {
                            %>
                            <option value="<%= u.getId()%>"><%= u.getName()%> <%= u.getLastname()%></option>
                            <% } %>
                        </select>
                    </div>

                    <!-- Seleccionar Libro -->
                    <div class="col-md-6">
                        <label for="id_book" class="form-label">Libro</label>
                        <select class="form-select" id="id_book" name="id_book" required>
                            <option value="" disabled selected>Seleccione un libro disponible</option>
                            <% for (Book b : books) {
                                    if (b.getAvailability()) {%>
                            <option value="<%= b.getId()%>"><%= b.getTitle()%> - <%= b.getAuthor()%></option>
                            <% }
                                } %>
                        </select>
                    </div>

                    <!-- Fecha de Préstamo -->
                    <div class="col-md-6">
                        <label for="loanDate" class="form-label">Fecha de Préstamo</label>
                        <input type="date" class="form-control" id="loanDate" name="loanDate" required>
                    </div>

                    <!-- Fecha de Devolución -->
                    <div class="col-md-6">
                        <label for="returnDate" class="form-label">Fecha de Devolución</label>
                        <input type="date" class="form-control" id="returnDate" name="returnDate" readonly required>
                    </div>

                    <!-- Estado del préstamo -->
                    <div class="col-md-12">
                        <label for="status" class="form-label">Estado</label>
                        <select class="form-select" id="status" name="status" required>
                            <option value="activo">Activo</option>
                            <option value="devuelto">Devuelto</option>
                            <option value="vencido">Vencido</option>
                        </select>
                    </div>

                    <!-- Botón -->
                    <div class="col-12 d-grid">
                        <button type="submit" class="btn btn-success" name="action" value="create">Guardar Préstamo</button>
                    </div>
                </form>

            </div>

            <div id="listarPrestamos" style="display: none;">
                <h3>Lista de Préstamos</h3>
                <table id="tablaPrestamos" class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>User</th>
                            <th>Book</th>
                            <th>Loan Date</th>
                            <th>Return Date</th>
                            <th>Status</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%

                            List<Loan> loans = loanJPA.findLoanEntities();
                            int contL = 1;
                            for (Loan l : loans) {
                        %>
                        <tr>
                            <td><%=contL%></td>
                            <td><%= l.getUser().getName()%> <%= l.getUser().getLastname()%> </td>
                            <td><%= l.getBook().getTitle()%></td>
                            <td><%= l.getLoanDate()%></td>
                            <td><%= l.getReturnDate()%></td>
                            <td><%= l.getStatus()%></td>
                            <td>
                                <div class="d-flex justify-content-between gap-2">
                                    <!-- Botón de Editar (abre el modal) -->
                                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editarModalL<%= l.getId()%>">
                                        <i class="bi bi-pencil-fill"></i> Edit
                                    </button>

                                    <!-- Botón de Eliminar (abre el modal) -->
                                    <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#eliminarModalL<%= l.getId()%>">
                                        <i class="bi bi-trash-fill"></i> Delete
                                    </button>
                                </div>
                            </td>
                        </tr>


                    <div class="modal fade" id="editarModalL<%= l.getId()%>" tabindex="-1" aria-labelledby="editarModalLabel<%= l.getId()%>" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editarModalLabel<%= l.getId()%>">Editar Prestamo</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="LoanController" method="POST" class="modal-content">

                                        <input type="hidden" name="id" value="<%= l.getId()%>">

                                        <div class="mb-3">
                                            <label for="id_user" class="form-label">Usuario</label>
                                            <select class="form-select" id="id_user" name="id_user" required>
                                                <option value="" disabled>Seleccione un usuario</option>
                                                <% if (usuarios == null || usuarios.isEmpty()) {
                                                        out.println("No se encontraron usuarios con rol 1.");
                                                    } else {
                                                        for (User u : usuarios) {%>
                                                <option value="<%= u.getId()%>" <%= (u.getId() == l.getUser().getId()) ? "selected" : ""%>>
                                                    <%= u.getName()%> <%= u.getLastname()%>
                                                </option>
                                                <% }
                                                    }%>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label for="id_book" class="form-label">Libro</label>
                                            <select class="form-select" id="id_book" name="id_book" required>
                                                <option value="" disabled>Seleccione un libro disponible</option>
                                                <% for (Book b : books) {
                                                        if (b.getAvailability() || b.getId() == l.getBook().getId()) {%>
                                                <option value="<%= b.getId()%>" <%= (b.getId() == l.getBook().getId()) ? "selected" : ""%>>
                                                    <%= b.getTitle()%>
                                                </option>
                                                <% }
                                                    }%>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label for="loanDate2" class="form-label">Fecha de préstamo</label>
                                            <input type="date" class="form-control" id="loanDate2" name="loanDate" value="<%= l.getLoanDate()%>" required>
                                        </div>

                                        <!-- Campo Fecha de Devolución -->
                                        <div class="mb-3">
                                            <label for="returnDate2" class="form-label">Fecha de devolución</label>
                                            <input type="date" class="form-control" id="returnDate2" name="returnDate" value="<%= l.getReturnDate()%>" required readonly>
                                        </div>



                                        <div class="mb-3">
                                            <label for="status<%= l.getId()%>" class="form-label">Estado</label>
                                            <select class="form-select" id="status<%= l.getId()%>" name="status" required>
                                                <option value="activo" <%= "activo".equals(l.getStatus()) ? "selected" : ""%>>Activo</option>
                                                <option value="devuelto" <%= "devuelto".equals(l.getStatus()) ? "selected" : ""%>>Devuelto</option>
                                                <option value="vencido" <%= "vencido".equals(l.getStatus()) ? "selected" : ""%>>Vencido</option>
                                            </select>
                                        </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" name="action" value="edit" class="btn btn-primary">Edit</button>
                                </div>
                                </form>
                            </div>
                        </div>
                    </div>
            </div>



            <div class="modal fade" id="eliminarModalL<%= l.getId()%>" tabindex="-1" aria-labelledby="eliminarModalLabel<%= l.getId()%>" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="eliminarModalLabel<%= l.getId()%>">Eliminar Prestamo</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>¿Estás seguro de que deseas eliminar este prestamo de <%= l.getUser().getName()%> <%= l.getUser().getLastname()%> sobre el libro "<%= l.getBook().getTitle()%>"? Esta acción no se puede deshacer.</p>
                        </div>
                        <div class="modal-footer">
                            <form action="LoanController" method="POST">
                                <input type="hidden" name="id" value="<%= l.getId()%>">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" name="action" value="delete" class="btn btn-danger">Eliminar</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <% contL++;
                } %>
        </tbody>
    </table>
</div>

</div>

<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>


<%
    String section = request.getParameter("section");
    if (section == null || section.isEmpty()) {
        section = ""; // Si no se pasa parámetro, muestra la sección de listar usuarios por defecto
    }
%>
<script>
                        // Inicializar DataTables
                        $(document).ready(function () {
                            $('#tablaUsuarios').DataTable();
                            $('#tablaLibros').DataTable();
                            $('#tablaPrestamos').DataTable();
                        });

                        // Mostrar la sección correspondiente
                        function mostrarSeccion(id) {
                            const secciones = document.querySelectorAll('.content > div');
                            secciones.forEach(sec => sec.style.display = 'none');
                            document.getElementById(id).style.display = 'block';
                        }
                        window.onload = function () {
                            const urlParams = new URLSearchParams(window.location.search);
                            const section = urlParams.get('section') || '<%= section%>'; // Usa el valor de 'section' de JSP si no hay parámetro
                            mostrarSeccion(section);
                        };

                        // Mostrar la sección correspondiente
                        function mostrarSeccion(id) {
                            const secciones = document.querySelectorAll('.content > div');
                            secciones.forEach(sec => sec.style.display = 'none');
                            document.getElementById(id).style.display = 'block';
                        }
                        document.getElementById("loanDate").addEventListener("change", function () {
                            const loanDate = new Date(this.value);
                            if (!isNaN(loanDate.getTime())) {
                                loanDate.setDate(loanDate.getDate() + 14);
                                const returnDate = loanDate.toISOString().split('T')[0];
                                document.getElementById("returnDate").value = returnDate;
                            }
                        });
                        document.getElementById("loanDate2").addEventListener("change", function () {
                            const loanDate2 = new Date(this.value);
                            if (!isNaN(loanDate2.getTime())) {
                                loanDate2.setDate(loanDate2.getDate() + 14);
                                const returnDate2 = loanDate2.toISOString().split('T')[0];
                                document.getElementById("returnDate2").value = returnDate2;
                            }
                        });

</script>

</body>
</html>
