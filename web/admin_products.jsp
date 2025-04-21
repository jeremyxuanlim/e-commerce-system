<%-- /admin/admin_products.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.Staff" %> <%-- Import Staff model --%>
<%@ page import="Model.Products" %> <%-- Import Products model --%>
<%@ page import="java.util.List" %> <%-- Import List --%>
<%@ page import="java.text.NumberFormat" %> <%-- For currency formatting --%>
<%@ page import="java.util.Locale" %> <%-- For currency formatting --%>

<%
    // --- Security Check: Redirect to login if not logged in ---
    Staff loggedInStaff = (Staff) session.getAttribute("loggedInStaff"); // Adjust attribute name if needed
    if (loggedInStaff == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); // Redirect to your login page
        return; // Stop processing the rest of the page
    }
    // Optional: Add role-specific check here if needed for product management

    // --- TODO: Fetch product list data from backend ---
    // Example: List<Products> productList = productDAO.getAllProducts();
    List<?> productList = List.of("Product1", "Product2"); // Placeholder - Replace with actual data list

    // Currency Formatter (Example for Malaysia)
    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("ms", "MY"));


    // Set active page for sidebar highlighting
    request.setAttribute("activeAdminPage", "products");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management</title>
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
            <h2><i class="fas fa-box-open"></i> Product Management</h2>
            <hr>

            <a href="${pageContext.request.contextPath}/admin/products/add" class="btn-add"><i class="fas fa-plus"></i> Add Product</a>
            <%-- TODO: Create the corresponding add product page/servlet --%>

            <div class="admin-table-container">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- === TODO: Replace placeholders with loop for actual productList === --%>
                        <%-- Example loop structure:
                        <% if (productList == null || productList.isEmpty()) { %>
                            <tr><td colspan="6">No products found.</td></tr>
                        <% } else { %>
                            <% for (Products product : productList) { %>
                                <tr>
                                    <td><%= product.getId() %></td>
                                    <td><%= product.getName() %></td>
                                    <td><%= product.getCategory() != null ? product.getCategory() : "N/A" %></td>
                                    <td><%= currencyFormatter.format(product.getPrice()) %></td>
                                    <td><%= product.getStock() %></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/products/edit?id=<%= product.getId() %>" class="action-btn btn-edit"><i class="fas fa-edit"></i> Edit</a>
                                        <a href="${pageContext.request.contextPath}/admin/products/delete?id=<%= product.getId() %>" class="action-btn btn-delete" onclick="return confirm('Are you sure you want to delete product: <%= product.getName() %>?');"><i class="fas fa-trash"></i> Delete</a>
                                    </td>
                                </tr>
                            <% } %>
                        <% } %>
                        --%>

                        <%-- Placeholder Rows (Remove when using loop) --%>
                        <tr>
                            <td>1</td>
                            <td>IEM</td>
                            <td>Audio</td>
                            <td><%= currencyFormatter.format(1200.50) %></td>
                            <td>50</td>
                            <td>
                                <a href="#" class="action-btn btn-edit"><i class="fas fa-edit"></i> Edit</a>
                                <a href="#" class="action-btn btn-delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i> Delete</a>
                            </td>
                        </tr>
                         <tr>
                            <td>2</td>
                            <td>Mouse</td>
                            <td>Computer Accessories</td>
                             <td><%= currencyFormatter.format(25.99) %></td>
                            <td>100</td>
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
