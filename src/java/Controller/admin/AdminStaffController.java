package Controller.admin;

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
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

public class AdminStaffController extends HttpServlet {
    
    @PersistenceContext
    EntityManager em;
    
    @Resource
    UserTransaction utx;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("user");
        
        // Check if user is manager
        if (currentUser == null || !currentUser.getRole().equals("manager")) {
            res.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }
        
        String action = req.getParameter("action");
        
        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Users staff = em.find(Users.class, id);
                if (staff != null && (staff.getRole().equals("staff") || staff.getRole().equals("manager"))) {
                    req.setAttribute("editStaff", staff);
                }
            }
            
            List<Users> staffList = em.createQuery(
                    "SELECT u FROM Users u WHERE u.role IN ('staff', 'manager') AND (u.isArchived = false OR u.isArchived IS NULL)",
                    Users.class)
                    .getResultList();
            
            req.setAttribute("staffList", staffList);
            req.getRequestDispatcher("/admin/admin_staff.jsp").forward(req, res);
            
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("user");
        
        // Check if user is manager
        if (currentUser == null || !currentUser.getRole().equals("manager")) {
            res.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }
        
        String action = req.getParameter("action");
        
        try {
            switch (action) {
                case "add":
                    addStaff(req);
                    break;
                case "edit":
                    updateStaff(req);
                    break;
                case "delete":
                    deleteStaff(req);
                    break;
            }
            
            res.sendRedirect(req.getContextPath() + "/admin/staff");
            
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    private void addStaff(HttpServletRequest req) throws Exception {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");
        
        String hashedPassword = hashPassword(password);
        
        utx.begin();
        Users staff = new Users(username, email, hashedPassword, role);
        em.persist(staff);
        utx.commit();
    }
    
    private void updateStaff(HttpServletRequest req) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");
        
        Users staff = em.find(Users.class, id);
        
        utx.begin();
        staff.setUsername(username);
        staff.setEmail(email);
        if (password != null && !password.isEmpty()) {
            staff.setPassword(hashPassword(password));
        }
        staff.setRole(role);
        em.merge(staff);
        utx.commit();
    }
    
    private void deleteStaff(HttpServletRequest req) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        Users staff = em.find(Users.class, id);
        
        utx.begin();
        staff.setIsArchived(true);
        em.merge(staff);
        utx.commit();
    }
    
    private String hashPassword(String password) throws ServletException {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new ServletException("Error hashing password", e);
        }
    }
}
