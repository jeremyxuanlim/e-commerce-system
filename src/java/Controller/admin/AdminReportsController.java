package Controller.admin;

import Model.Reports;
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

public class AdminReportsController extends HttpServlet {
    
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
            if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Reports report = em.find(Reports.class, id);
                
                if (report != null) {
                    utx.begin();
                    em.remove(report);
                    utx.commit();
                    
                    session.setAttribute("deleteSuccess", "true");
                }
            }
            
            // Fetch all reports
            List<Reports> reports = em.createQuery(
                    "SELECT r FROM Reports r ORDER BY r.generatedDate DESC",
                    Reports.class)
                    .getResultList();
            
            req.setAttribute("reports", reports);
            req.getRequestDispatcher("/admin/admin_reports.jsp").forward(req, res);
            
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
