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
import java.util.List;

public class AdminUserController extends HttpServlet {
    
    @PersistenceContext
    EntityManager em;
    
    @Resource
    UserTransaction utx;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("user");
        
        if (currentUser == null || (!currentUser.getRole().equals("manager") && !currentUser.getRole().equals("staff"))) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        
        try {
            List<Users> users = em.createQuery(
                    "SELECT u FROM Users u WHERE u.role = 'customer' AND (u.isArchived = false OR u.isArchived IS NULL)",
                    Users.class)
                    .getResultList();
            
            req.setAttribute("users", users);
            req.getRequestDispatcher("/admin/admin_users.jsp").forward(req, res);
            
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users currentUser = (Users) session.getAttribute("user");
        
        if (currentUser == null || (!currentUser.getRole().equals("manager") && !currentUser.getRole().equals("staff"))) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = req.getParameter("action");
        
        try {
            switch (action) {
                case "delete":
                    deleteUser(req);
                    break;
                case "edit":
                    updateUser(req);
                    break;
            }
            
            res.sendRedirect(req.getContextPath() + "/admin/users");
            
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    private void deleteUser(HttpServletRequest req) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        Users user = em.find(Users.class, id);
        
        if (user != null && user.getRole().equals("customer")) {
            utx.begin();
            user.setIsArchived(true);
            em.merge(user);
            utx.commit();
        }
    }
    
    private void updateUser(HttpServletRequest req) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        String email = req.getParameter("email");
        String name = req.getParameter("name");
        String contact = req.getParameter("contact");
        
        Users user = em.find(Users.class, id);
        
        if (user != null && user.getRole().equals("customer")) {
            utx.begin();
            user.setEmail(email);
            user.setName(name);
            user.setContact(contact);
            em.merge(user);
            utx.commit();
        }
    }
}
