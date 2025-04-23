/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Book;
import Model.Loan;
import Model.User;
import Persistence.BookJpaController;
import Persistence.LoanJpaController;
import Persistence.UserJpaController;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author juand
 */
@WebServlet(name = "LoanController", urlPatterns = {"/LoanController"})
public class LoanController extends HttpServlet {

    UserJpaController userJPA = new UserJpaController();
    BookJpaController bookJPA = new BookJpaController();
    LoanJpaController loanJPA = new LoanJpaController();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        

        String action = request.getParameter("action");

        switch (action) {
            case "create":

                try {
                    int userId = Integer.parseInt(request.getParameter("id_user"));
                    int bookId = Integer.parseInt(request.getParameter("id_book"));
                    LocalDate loanDate = LocalDate.parse(request.getParameter("loanDate"));
                    LocalDate returnDate = LocalDate.parse(request.getParameter("returnDate"));
                    String status = request.getParameter("status");

                    User user = new UserJpaController().findUser(userId);
                    Book book = new BookJpaController().findBook(bookId);

                    if (book != null && book.getAvailability()) {
                        // Crear el préstamo
                        Loan loan = new Loan();
                        loan.setUser(user);
                        loan.setBook(book);
                        loan.setLoanDate(loanDate);
                        loan.setReturnDate(returnDate);
                        loan.setStatus(status);

                        // Guardar el préstamo
                        loanJPA.create(loan);

                        // Marcar el libro como no disponible
                        book.setAvailability(false);
                        bookJPA.edit(book);

                        response.sendRedirect("AdminPanel.jsp?section=listarPrestamos");
                    } else {
                        request.setAttribute("error", "El libro no está disponible.");
                        request.getRequestDispatcher("AdminPanel.jsp?section=crearPrestamo").forward(request, response);
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Error al crear el préstamo.");
                    request.getRequestDispatcher("AdminPanel.jsp?section=crearPrestamo").forward(request, response);
                }
                break;

            case "edit":

                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    int userId = Integer.parseInt(request.getParameter("id_user"));
                    int bookId = Integer.parseInt(request.getParameter("id_book"));
                    LocalDate loanDate = LocalDate.parse(request.getParameter("loanDate"));
                    LocalDate returnDate = LocalDate.parse(request.getParameter("returnDate"));
                    String status = request.getParameter("status");

                    Loan loan = new Loan();
                    loan = loanJPA.findLoan(id);

                    List<User> allUsers = userJPA.findUserEntities();
                    List<User> filteredUsers = new ArrayList<>();
                    for (User user : allUsers) {
                        if (user.getRol() == 1) { // Suponiendo que "role" es el campo que indica el rol del usuario
                            filteredUsers.add(user);
                        }
                    }

                    Book book = new Book();
                    book = bookJPA.findBook(bookId);

                    loan.setUser(new UserJpaController().findUser(userId));
                    loan.setBook(book);
                    loan.setLoanDate(loanDate);
                    loan.setReturnDate(returnDate);
                    loan.setStatus(status);

                    loanJPA.edit(loan);
                    request.setAttribute("usuarios", filteredUsers);
                    response.sendRedirect("AdminPanel.jsp?section=listarPrestamos");

                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Error al editar el préstamo.");
                    request.getRequestDispatcher("AdminPanel.jsp?section=listarPrestamos").forward(request, response);
                }
                break;

            case "delete":

                int id = Integer.parseInt(request.getParameter("id"));

                try {
                    loanJPA.destroy(id);
                    response.sendRedirect("AdminPanel.jsp?section=listarPrestamos");

                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Error al editar el préstamo.");
                    request.getRequestDispatcher("AdminPanel.jsp?section=listarPrestamos").forward(request, response);
                }
                break;
            case "userLoan":
                try {
                    int userId = Integer.parseInt(request.getParameter("id_user"));
                    int bookId = Integer.parseInt(request.getParameter("id_book"));

                    LocalDate loanDate = LocalDate.now();
                    LocalDate returnDate = loanDate.plusDays(14);

                    User user = userJPA.findUser(userId);
                    Book book = bookJPA.findBook(bookId);

                    if (book != null && book.getAvailability()) {
                        Loan loan = new Loan();
                        loan.setUser(user);
                        loan.setBook(book);
                        loan.setLoanDate(loanDate);
                        loan.setReturnDate(returnDate);
                        loan.setStatus("activo");

                        loanJPA.create(loan);

                        // Deshabilitar el libro
                        book.setAvailability(false);
                        bookJPA.edit(book);

                        response.sendRedirect("BookCatalog.jsp?success=1");
                    } else {
                        response.sendRedirect("BookCatalog.jsp?error=1");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("BookCatalog.jsp?error=1");
                }
                break;

            case "returnLoan":
                try {
                    int loanId = Integer.parseInt(request.getParameter("id_loan"));

                    Loan loan = loanJPA.findLoan(loanId);
                    Book book = loan.getBook();

                    // 1. Habilita nuevamente el libro
                    book.setAvailability(true);
                    bookJPA.edit(book);

                    // 2. Elimina el préstamo
                    loanJPA.destroy(loanId);

                    response.sendRedirect("BookCatalog.jsp?returned=1");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("BookCatalog.jsp?errorReturn=1");
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
