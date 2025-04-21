<%-- /admin/admin_promotions.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.Staff" %> <%-- Import Staff model --%>
<%@ page import="Model.Promotions" %> <%-- Import Promotions model --%>
<%@ page import="java.util.List" %> <%-- Import List --%>
<%@ page import="java.text.SimpleDateFormat" %> <%-- For date formatting --%>
<%@ page import="java.util.Date" %> <%-- Import Date --%>

<%
    // --- Security Check: Redirect to login if not logged in ---
    Staff loggedInStaff = (Staff) session.getAttribute("loggedInStaff"); // Adjust attribute name if needed
    if (loggedInStaff == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); // Redirect to your login page
        return; // Stop processing the rest of the page
    }
    // Optional: Add role-specific check here if needed for promotion management

    // --- TODO: Fetch promotion list data from backend ---
    // Example: List<Promotions> promotionList = promotionDAO.getAllPromotions();
    List<?> promotionList = List.of("Promo1", "Promo2"); // Placeholder - Replace with actual data list

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    // Set active page for sidebar highlighting
    request.setAttribute("activeAdminPage", "promotions");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Promotion Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/pages/body.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/components/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/components/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/pages/admin/admin_dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/pages/admin/admin_sidebar.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/components/navbar.jsp" />

    <div class="admin-container">
        <jsp:include page="/WEB-INF/views/admin/admin_sidebar.jsp" />

        <div class="admin-content">
            <h2><i class="fas fa-tags"></i> Promotion Management</h2>
            <hr>

            <a href="${pageContext.request.contextPath}/admin/promotions/add" class="btn-add"><i class="fas fa-plus"></i> Add Promotion</a>
            <%-- TODO: Create the corresponding add promotion page/servlet --%>

            <div class="admin-table-container">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Promo Code</th>
                            <th>Discount (%)</th> <%-- Assuming discount is percentage --%>
                            <th>Valid From</th>
                            <th>Valid To</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- === TODO: Replace placeholders with loop for actual promotionList === --%>
                        <%-- Example loop structure:
                        <% if (promotionList == null || promotionList.isEmpty()) { %>
                            <tr><td colspan="6">No promotions found.</td></tr>
                        <% } else { %>
                            <% for (Promotions promo : promotionList) { %>
                                <tr>
                                    <td><%= promo.getId() %></td>
                                    <td><%= promo.getPromoCode() %></td>
                                    <td><%= promo.getDiscount().multiply(java.math.BigDecimal.valueOf(100)) %>%</td> <%-- Display as percentage --%>
                                    <td><%= dateFormat.format(promo.getValidFrom()) %></td>
                                    <td><%= dateFormat.format(promo.getValidTo()) %></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/promotions/edit?id=<%= promo.getId() %>" class="action-btn btn-edit"><i class="fas fa-edit"></i> Edit</a>
                                        <a href="${pageContext.request.contextPath}/admin/promotions/delete?id=<%= promo.getId() %>" class="action-btn btn-delete" onclick="return confirm('Are you sure you want to delete promo code: <%= promo.getPromoCode() %>?');"><i class="fas fa-trash"></i> Delete</a>
                                    </td>
                                </tr>
                            <% } %>
                        <% } %>
                        --%>

                         <%-- Placeholder Rows (Remove when using loop) --%>
                         <tr>
                             <td>1</td>
                             <td>SUMMER20</td>
                             <td>20%</td>
                             <td>2025-06-01</td>
                             <td>2025-08-31</td>
                             <td>
                                 <a href="#" class="action-btn btn-edit"><i class="fas fa-edit"></i> Edit</a>
                                 <a href="#" class="action-btn btn-delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i> Delete</a>
                             </td>
                         </tr>
                         <tr>
                             <td>2</td>
                             <td>FREESHIP</td>
                             <td>0% (+ Free Shipping logic)</td> <%-- Indicate special logic --%>
                             <td>2025-05-01</td>
                             <td>2025-05-31</td>
                             <td>
                                 <a href="#" class="action-btn btn-edit"><i class="fas fa-edit"></i> Edit</a>
                                 <a href="#" class="action-btn btn-delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i> Delete</a>
                             </td>
                         </tr>
                         <%-- === End Placeholder Rows === --%>
                    </tbody>
                </table>
            </div>

            </div>
    </div>

    <jsp:include page="/WEB-INF/views/components/footer.jsp" />

</body>
</html>
