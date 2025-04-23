<%-- 
    Document   : AdminPanel
    Created on : 23/04/2025, 9:48:11 a. m.
    Author     : juand
--%>

<%@page import="Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    User admin = (User) session.getAttribute("usuario");

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
            <h2>Bienvenido, <%= admin.getName()%> <%= admin.getLastname()%></h2>

            <!-- Secciones dinámicas -->
            <div id="crearUsuario" style="display: none;">
                <h3>Crear Usuario</h3>

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
                <h3>Lista de Usuarios</h3>
                <table id="tablaUsuarios" class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Email</th>
                            <th>Rol</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- Aquí harías un for para listar usuarios --%>
                    </tbody>
                </table>
            </div>

            <div id="crearLibro" style="display: none;">
                <h3>Crear Libro</h3>
                <!-- Aquí va tu formulario para crear libro -->
            </div>

            <div id="listarLibros" style="display: none;">
                <h3>Lista de Libros</h3>
                <table id="tablaLibros" class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Título</th>
                            <th>Autor</th>
                            <th>Disponibilidad</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- Aquí harías un for para listar libros --%>
                    </tbody>
                </table>
            </div>

            <div id="crearPrestamo" style="display: none;">
                <h3>Crear Préstamo</h3>
                <!-- Aquí va tu formulario para crear préstamo -->
            </div>

            <div id="listarPrestamos" style="display: none;">
                <h3>Lista de Préstamos</h3>
                <table id="tablaPrestamos" class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Usuario</th>
                            <th>Libro</th>
                            <th>Fecha Préstamo</th>
                            <th>Fecha Devolución</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- Aquí harías un for para listar préstamos --%>
                    </tbody>
                </table>
            </div>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

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
                            // Si el parámetro 'section' es 'listarUsuarios', mostramos la lista de usuarios
                            const urlParams = new URLSearchParams(window.location.search);
                            const section = urlParams.get('section') || 'crearUsuario'; // Default: 'crearUsuario'
                            mostrarSeccion(section);
                        };
        </script>

    </body>
</html>
