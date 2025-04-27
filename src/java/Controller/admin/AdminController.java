package Controller.admin;

import Model.*;
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
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class AdminController extends HttpServlet {
    
    @PersistenceContext
    EntityManager em;
    
    @Resource
    UserTransaction utx;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users user = (Users) session.getAttribute("user");
        
        // Check if user is logged in and has admin privileges
        if (user == null || (!user.getRole().equals("manager") && !user.getRole().equals("staff"))) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        
        // Load dashboard data
        try {
            // Get counts for dashboard
            Long userCount = em.createQuery("SELECT COUNT(u) FROM Users u WHERE u.role = 'customer'", Long.class)
                    .getSingleResult();
            
            Long productCount = em.createQuery("SELECT COUNT(p) FROM Products p", Long.class)
                    .getSingleResult();
            
            Long orderCount = em.createQuery("SELECT COUNT(o) FROM Orders o", Long.class)
                    .getSingleResult();
            
            // Get recent orders
            List<Orders> recentOrders = em.createQuery("SELECT o FROM Orders o ORDER BY o.orderDate DESC", Orders.class)
                    .setMaxResults(5)
                    .getResultList();
            
            // Set attributes
            req.setAttribute("userCount", userCount);
            req.setAttribute("productCount", productCount);
            req.setAttribute("orderCount", orderCount);
            req.setAttribute("recentOrders", recentOrders);
            
            // Generate monthly sales report if requested
            String action = req.getParameter("action");
            if ("generateReport".equals(action)) {
                try {
                    utx.begin();
                    Reports report = new Reports();
                    report.setReportType("Monthly Sales");
                    report.setGeneratedById(user);
                    report.setGeneratedDate(new Date());
                    
                    // Generate report details (example: total sales for current month)
                    Calendar cal = Calendar.getInstance();
                    cal.set(Calendar.DAY_OF_MONTH, 1);
                    Date startDate = cal.getTime();
                    
                    Double totalSales = em.createQuery(
                            "SELECT SUM(o.totalPrice) FROM Orders o WHERE o.orderDate >= :startDate", 
                            Double.class)
                            .setParameter("startDate", startDate)
                            .getSingleResult();
                    
                    report.setDetails("Total Sales for " + new SimpleDateFormat("MMMM yyyy").format(new Date()) 
                            + ": RM " + (totalSales != null ? String.format("%.2f", totalSales) : "0.00"));
                    
                    em.persist(report);
                    utx.commit();
                    session.setAttribute("reportSuccess", "true");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            
            req.getRequestDispatcher("/admin/admin_dashboard.jsp").forward(req, res);
            
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
