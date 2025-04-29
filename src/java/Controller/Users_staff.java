package Controller.admin;

import Model.Users;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import jakarta.annotation.Resource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.UserTransaction;
import java.util.List;

@WebServlet("/admin/Users_staff")
public class Users_staff extends HttpServlet {
    
    @PersistenceContext
    EntityManager em;
    
    @Resource
    UserTransaction utx;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Users> staffList = em.createQuery(
                "SELECT u FROM Users u WHERE u.role IN ('staff', 'manager') AND u.isArchived = false", 
                Users.class)
                .getResultList();
            request.setAttribute("staffList", staffList);
            request.getRequestDispatcher("/admin/admin_staff.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/admin_dashboard.jsp");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("add".equals(action)) {
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String role = request.getParameter("role");
                
                Users newStaff = new Users();
                newStaff.setUsername(username);
                newStaff.setEmail(email);
                newStaff.setPassword(hashPassword(password));
                newStaff.setRole(role);
                newStaff.setIsArchived(false);
                
                utx.begin();
                em.persist(newStaff);
                utx.commit();
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/Users_staff");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/Users_staff");
        }
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