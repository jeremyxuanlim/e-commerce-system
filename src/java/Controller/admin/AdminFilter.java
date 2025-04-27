package Controller.admin;

import Model.Users;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        
        String requestURI = req.getRequestURI();
        
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        boolean isAdminResource = requestURI.contains("/admin/");
        boolean isStaffPage = requestURI.contains("/admin/admin_staff.jsp");
        
        if (isAdminResource) {
            if (!isLoggedIn) {
                res.sendRedirect(req.getContextPath() + "/login.jsp");
                return;
            }
            
            Users user = (Users) session.getAttribute("user");
            // Only allow manager and staff to access admin pages
            boolean isAdmin = "manager".equals(user.getRole()) || "staff".equals(user.getRole());
            
            if (!isAdmin) {
                res.sendRedirect(req.getContextPath() + "/index.jsp");
                return;
            }
            
            // Restrict staff management page to managers only
            if (isStaffPage && !"manager".equals(user.getRole())) {
                res.sendRedirect(req.getContextPath() + "/admin/admin_dashboard.jsp");
                return;
            }
        }
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
    }
}
