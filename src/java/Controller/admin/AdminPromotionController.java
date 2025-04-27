package Controller.admin;

import Model.Promotions;
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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class AdminPromotionController extends HttpServlet {
    
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
                Promotions promotion = em.find(Promotions.class, id);
                req.setAttribute("editPromotion", promotion);
            }
            
            List<Promotions> promotions = em.createQuery("SELECT p FROM Promotions p", Promotions.class)
                    .getResultList();
            
            req.setAttribute("promotions", promotions);
            req.getRequestDispatcher("/admin/admin_promotions.jsp").forward(req, res);
            
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
                    addPromotion(req);
                    break;
                case "edit":
                    updatePromotion(req);
                    break;
                case "delete":
                    deletePromotion(req);
                    break;
            }
            
            res.sendRedirect(req.getContextPath() + "/admin/promotions");
            
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    private void addPromotion(HttpServletRequest req) throws Exception {
        String promoCode = req.getParameter("promoCode");
        BigDecimal discount = new BigDecimal(req.getParameter("discount"));
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date validFrom = dateFormat.parse(req.getParameter("validFrom"));
        Date validTo = dateFormat.parse(req.getParameter("validTo"));
        
        utx.begin();
        Promotions promotion = new Promotions();
        promotion.setPromoCode(promoCode);
        promotion.setDiscount(discount);
        promotion.setValidFrom(validFrom);
        promotion.setValidTo(validTo);
        promotion.setIsActive(true);
        em.persist(promotion);
        utx.commit();
    }
    
    private void updatePromotion(HttpServletRequest req) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        String promoCode = req.getParameter("promoCode");
        BigDecimal discount = new BigDecimal(req.getParameter("discount"));
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date validFrom = dateFormat.parse(req.getParameter("validFrom"));
        Date validTo = dateFormat.parse(req.getParameter("validTo"));
        
        Promotions promotion = em.find(Promotions.class, id);
        
        utx.begin();
        promotion.setPromoCode(promoCode);
        promotion.setDiscount(discount);
        promotion.setValidFrom(validFrom);
        promotion.setValidTo(validTo);
        em.merge(promotion);
        utx.commit();
    }
    
    private void deletePromotion(HttpServletRequest req) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        Promotions promotion = em.find(Promotions.class, id);
        
        utx.begin();
        promotion.setIsActive(false);
        em.merge(promotion);
        utx.commit();
    }
}
