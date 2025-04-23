/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Book;
import Persistence.BookJpaController;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "BookController", urlPatterns = {"/BookController"})
public class BookController extends HttpServlet {

    BookJpaController bookJPA = new BookJpaController();

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

        switch (action) {
            case "create":

                String title = request.getParameter("title");
                String author = request.getParameter("author");
                int year = Integer.parseInt(request.getParameter("year"));
                String isbn = request.getParameter("isbn");
                String genre = request.getParameter("genre");
                boolean availability = Boolean.parseBoolean(request.getParameter("availability"));

                Book book = new Book();
                book.setTitle(title);
                book.setAuthor(author);
                book.setYear(year);
                book.setIsbn(isbn);
                book.setGenre(genre);
                book.setAvailability(availability);

                try {
                    bookJPA.create(book);
                    response.sendRedirect("AdminPanel.jsp?section=listarLibros");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Error al crear el libro");
                    request.getRequestDispatcher("AdminPanel.jsp?section=crearLibro").forward(request, response);
                }

                break;

            case "edit":

                try {

                    int id = Integer.parseInt(request.getParameter("id"));
                    String titleEdit = request.getParameter("title");
                    String authorEdit = request.getParameter("author");
                    int yearEdit = Integer.parseInt(request.getParameter("year"));
                    String isbnEdit = request.getParameter("isbn");
                    String genreEdit = request.getParameter("genre");
                    boolean availabilityEdit = Boolean.parseBoolean(request.getParameter("availability"));

                    book = bookJPA.findBook(id);

                    book.setTitle(titleEdit);
                    book.setAuthor(authorEdit);
                    book.setYear(yearEdit);
                    book.setIsbn(isbnEdit);
                    book.setGenre(genreEdit);
                    book.setAvailability(availabilityEdit);
                    
                    bookJPA.edit(book);
                    response.sendRedirect("AdminPanel.jsp?section=listarLibros");

                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Error al editar el libro");
                    request.getRequestDispatcher("AdminPanel.jsp?section=listarLibros").forward(request, response);
                }

                break;
            case "delete":
                
                int id = Integer.parseInt(request.getParameter("id"));
                try {
                    bookJPA.destroy(id);
                    response.sendRedirect("AdminPanel.jsp?section=listarLibros");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Error al elimianr el libro");
                    request.getRequestDispatcher("AdminPanel.jsp?section=listarLibros").forward(request, response);
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
