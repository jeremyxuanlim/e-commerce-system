/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Model.Categories;
import Model.Products;
import jakarta.annotation.Resource;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import jakarta.transaction.UserTransaction;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.UUID;
import java.math.BigDecimal;

/**
 *
 * @author kyanl
 */

@WebServlet("/AddProducts")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 5,   // 5 MB
    maxRequestSize = 1024 * 1024 * 10 // 10 MB
)

public class AddProducts extends HttpServlet {
    private static final String UPLOAD_DIR = "build/web/assets/products";
    
    @PersistenceContext
    EntityManager em;

    @Resource
    UserTransaction utx;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
            String prodName = req.getParameter("addProductName").trim();
            int prodCategory = Integer. parseInt(req.getParameter("addProductCategory"));
            double prodPrice = Double.valueOf(req.getParameter("addProductPrice"));
            int prodStock = Integer. parseInt(req.getParameter("addProductStock"));
            String prodDesc = req.getParameter("addProductDescription").trim();
            Part prodPic = req.getPart("addProductPicture");

            Boolean hasErrors = false;

            if (prodPic != null && prodPic.getSize() > 0) {
                    try {
                            String contentType = prodPic.getContentType();
                            if (!contentType.startsWith("image/")) {
                                    req.setAttribute("productPicError", "Only images are allowed");
                                    hasErrors = true;
                            } else {
                                    String extension = contentType.split("/")[1];
//                                    String fileName = UUID.randomUUID() + "." + extension;
                                    String fileName = prodName + UUID.randomUUID() + "." + extension;

                                    String webAppPath = getServletContext().getRealPath("/");
                                    File webAppDir = new File(webAppPath);
                                    File projectRootDir = webAppDir.getParentFile().getParentFile();
                                    File uploadDir = new File(projectRootDir, UPLOAD_DIR);

                                    if (!uploadDir.exists()) {
                                            uploadDir.mkdirs();
                                    }

                                    File file = new File(uploadDir, fileName);
                                    try (InputStream input = prodPic.getInputStream()) {
                                            Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                                    }
                            }
                    } catch (Exception e) {
                            req.setAttribute("productPicError", "Upload failed: " + e.getMessage());
                            hasErrors = true;
                    }
            }
            
            try {
                utx.begin();
                
                Categories category = em.find(Categories.class, prodCategory);
                Products newProd = new Products(prodName, prodDesc, BigDecimal.valueOf(prodPrice), prodStock);
                newProd.setCategoryId(category);
                
                em.persist(newProd);
                utx.commit();

                HttpSession session = req.getSession();
                session.setAttribute("addSuccess", "true");

                res.sendRedirect(req.getContextPath() + "/FetchCategories");
            } catch (Exception e) {
                    try {
                            if (utx != null) {
                                    utx.rollback();
                            }
                    } catch (Exception ex) {
                    }

                    req.setAttribute("error", "An error occurred, please try again.");
//                    req.getRequestDispatcher("/user/profile.jsp").forward(req, res);
            }
    }
}
