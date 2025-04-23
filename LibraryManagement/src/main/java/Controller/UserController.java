/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.User;
import Persistence.UserJpaController;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author juand
 */
@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

    UserJpaController userJpa = new UserJpaController();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String email = request.getParameter("email");

        switch (action) {
            case "signup":

                String name = request.getParameter("name");
                String lastname = request.getParameter("lastname");
                String password = request.getParameter("password");
                int rol = Integer.parseInt(request.getParameter("rol"));

                User user = new User();
                user.setName(name);
                user.setLastname(lastname);
                user.setEmail(email);
                user.setPassword(password);
                user.setRol(rol);

                try {
                    userJpa.create(user);

                    response.sendRedirect("Login.jsp");

                } catch (Exception e) {
                    // Si hay error, enviar a registro con mensaje
                    request.setAttribute("error", "Error al registrar usuario: " + e.getMessage());
                    request.getRequestDispatcher("Singup.jsp").forward(request, response);
                }
                break;

            case "login":

                String emailLogin = request.getParameter("email");
                String passwordLogin = request.getParameter("password");

                try {
                    user = userJpa.findUserByEmail(emailLogin);

                    if (user != null && user.getPassword().equals(passwordLogin)) {

                        request.getSession().setAttribute("usuario", user);

                        // Verificar el rol
                        if (user.getRol() == 1) {
                            // Usuario normal
                            response.sendRedirect("BookCatalog.jsp");
                        } else if (user.getRol() == 2) {
                            // Administrador
                            response.sendRedirect("AdminPanel.jsp");
                        } else {
                            request.setAttribute("error", "Rol no válido.");
                            request.getRequestDispatcher("Login.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("error", "Correo o contraseña incorrectos.");
                        request.getRequestDispatcher("Login.jsp").forward(request, response);
                    }
                } catch (Exception e) {
                    request.setAttribute("error", "Error al iniciar sesión: " + e.getMessage());
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                }
                break;

            case "edit":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String nameEdit = request.getParameter("name");
                    String lastnameEdit = request.getParameter("lastname");
                    String emailEdit = request.getParameter("email");
                    String passwordEdit = request.getParameter("password");

                    user = userJpa.findUser(id);

                    String oldEmail = user.getEmail();

                    user.setName(nameEdit);
                    user.setLastname(lastnameEdit);
                    user.setEmail(emailEdit);

                    if (passwordEdit != null && !passwordEdit.isEmpty()) {
                        user.setPassword(passwordEdit);
                    }
                    userJpa.edit(user);

                    if (!oldEmail.equals(email)) {
                        // Si cambió, invalidar sesión
                        request.getSession().invalidate();
                        response.sendRedirect("Login.jsp?emailChanged=1");
                    } else {
                        // Si no cambió, actualizar la sesión y seguir normal
                        request.getSession().setAttribute("usuario", user);
                        response.sendRedirect("BookCatalog.jsp?success=1");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("ProfileManagement.jsp?error=1");
                }
                break;
                
            case "create":
                String nameNew = request.getParameter("name");
                String lastnameNew = request.getParameter("lastname");
                String emailNew = request.getParameter("email");
                String passwordNew = request.getParameter("password");
                int rolNew = Integer.parseInt(request.getParameter("rol"));

                user = new User();
                user.setName(nameNew);
                user.setLastname(lastnameNew);
                user.setEmail(emailNew);
                user.setPassword(passwordNew);
                user.setRol(rolNew);

                try {
                    userJpa.create(user);

                    response.sendRedirect("Login.jsp");

                } catch (Exception e) {
                    // Si hay error, enviar a registro con mensaje
                    request.setAttribute("error", "Error al registrar usuario: " + e.getMessage());
                    request.getRequestDispatcher("Singup.jsp").forward(request, response);
                }
                break;
            default:
                throw new AssertionError();
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
