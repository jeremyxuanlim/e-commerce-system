/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Model.Categories;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author kyanl
 */
@WebServlet("/FetchCategories")
public class FetchCategories extends HttpServlet {
    @PersistenceContext
    private EntityManager em;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Categories> categories = em.createNamedQuery("Categories.findAll", Categories.class)
                    .getResultList();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/admin/admin_products.jsp").forward(request, response);
        } catch (Exception e) {
        }
    }
}
