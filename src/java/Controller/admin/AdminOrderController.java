package Controller.admin;

import Model.Orders;
import Model.Users;
import jakarta.annotation.Resource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.UserTransaction;
import java.io.IOException;
import java.util.List;

public class AdminOrderController extends HttpServlet {
    
    @PersistenceContext
    EntityManager em;
    
    @Resource
    UserTransaction utx;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users user = (Users) session.getAttribute("user");
        
        if (user == null || (!user.getRole().equals("manager") && !user.getRole().equals("staff"))) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = req.getParameter("action");
        
        try {
            if ("view".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Orders order = em.find(Orders.class, id);
                req.setAttribute("viewOrder", order);
            }
            
            List<Orders> orders = em.createQuery(
                    "SELECT o FROM Orders o ORDER BY o.orderDate DESC", 
                    Orders.class)
                    .getResultList();
            
            req.setAttribute("orders", orders);
            req.getRequestDispatcher("/admin/admin_orders.jsp").forward(req, res);
            
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users user = (Users) session.getAttribute("user");
        
        if (user == null || (!user.getRole().equals("manager") && !user.getRole().equals("staff"))) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = req.getParameter("action");
        
        try {
            if ("updateStatus".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                String status = req.getParameter("status");
                
                Orders order = em.find(Orders.class, id);
                if (order != null) {
                    utx.begin();
                    // Assuming you have a status field in your Orders entity
                    // order.setStatus(status);
                    em.merge(order);
                    utx.commit();
                }
            }
            
            res.sendRedirect(req.getContextPath() + "/admin/orders");
            
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
