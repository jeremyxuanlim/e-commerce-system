package Controller.admin;

import Model.Products;
import Model.Categories;
import jakarta.annotation.Resource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.UserTransaction;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

public class AdminProductController extends HttpServlet {
    
    @PersistenceContext
    EntityManager em;
    
    @Resource
    UserTransaction utx;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        
        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Products product = em.find(Products.class, id);
                req.setAttribute("editProduct", product);
            }
            
            List<Products> products = em.createQuery("SELECT p FROM Products p", Products.class)
                    .getResultList();
            List<Categories> categories = em.createQuery("SELECT c FROM Categories c", Categories.class)
                    .getResultList();
            
            req.setAttribute("products", products);
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/admin/admin_products.jsp").forward(req, res);
            
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        
        try {
            switch (action) {
                case "add":
                    addProduct(req);
                    break;
                case "edit":
                    updateProduct(req);
                    break;
                case "delete":
                    deleteProduct(req);
                    break;
            }
            
            res.sendRedirect(req.getContextPath() + "/admin/products");
            
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    private void addProduct(HttpServletRequest req) throws Exception {
        String name = req.getParameter("name");
        BigDecimal price = new BigDecimal(req.getParameter("price"));
        int stock = Integer.parseInt(req.getParameter("stock"));
        String description = req.getParameter("description");
        int categoryId = Integer.parseInt(req.getParameter("category"));
        
        Categories category = em.find(Categories.class, categoryId);
        
        utx.begin();
        Products product = new Products();
        product.setName(name);
        product.setPrice(price);
        product.setStock(stock);
        product.setDescription(description);
        product.setCategoryId(category);
        em.persist(product);
        utx.commit();
    }
    
    private void updateProduct(HttpServletRequest req) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        BigDecimal price = new BigDecimal(req.getParameter("price"));
        int stock = Integer.parseInt(req.getParameter("stock"));
        String description = req.getParameter("description");
        int categoryId = Integer.parseInt(req.getParameter("category"));
        
        Categories category = em.find(Categories.class, categoryId);
        Products product = em.find(Products.class, id);
        
        utx.begin();
        product.setName(name);
        product.setPrice(price);
        product.setStock(stock);
        product.setDescription(description);
        product.setCategoryId(category);
        em.merge(product);
        utx.commit();
    }
    
    private void deleteProduct(HttpServletRequest req) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        Products product = em.find(Products.class, id);
        
        utx.begin();
        em.remove(product);
        utx.commit();
    }
}
