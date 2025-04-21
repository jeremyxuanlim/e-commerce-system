<%-- /admin/admin_staff.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.Staff" %> <%-- Import Staff model --%>
<%@ page import="java.util.List" %> <%-- Import List --%>

<%
    // --- Security Check: Redirect to login if not logged in ---
    Staff loggedInStaff = (Staff) session.getAttribute("loggedInStaff"); // Adjust attribute name if needed
    if (loggedInStaff == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); // Redirect to your login page
        return; // Stop processing the rest of the page
    }
    // IMPORTANT: Add role check - Only managers should access this page
    boolean isManager = loggedInStaff.getIsManager(); // Assuming getIsManager() exists and is correct
    if (!isManager) {
         // Redirect non-managers away (e.g., to dashboard or access denied page)
         response.sendRedirect(request.getContextPath() + "/admin/dashboard");
         return;
    }

    // --- TODO: Fetch staff list data from backend (excluding maybe the current manager?) ---
    // Example: List<Staff> staffList = staffDAO.getAllStaff();
    List<?> staffList = List.of("Staff1", "Staff2"); // Placeholder - Replace with actual data list

    // Set active page for sidebar highlighting
    request.setAttribute("activeAdminPage", "staff");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Management</title>
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
            <h2><i class="fas fa-user-shield"></i> Staff Management</h2>
            <hr>

            <a href="${pageContext.request.contextPath}/admin/staff/add" class="btn-add"><i class="fas fa-plus"></i> Add Staff</a>
            <%-- TODO: Create the corresponding add staff page/servlet --%>

            <div class="admin-table-container">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- === TODO: Replace placeholders with loop for actual staffList === --%>
                        <%-- Example loop structure:
                        <% if (staffList == null || staffList.isEmpty()) { %>
                            <tr><td colspan="5">No staff members found.</td></tr>
                        <% } else { %>
                            <% for (Staff staff : staffList) { %>
                                <%-- Optionally skip the current logged-in manager from the list --%>
                                <%-- if (staff.getId().equals(loggedInStaff.getId())) continue; --%>
                                <tr>
                                    <td><%= staff.getId() %></td>
                                    <td><%= staff.getUsername() %></td>
                                    <td><%= staff.getEmail() %></td>
                                    <td><%= staff.getIsManager() ? "Manager" : "Staff" %></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/staff/edit?id=<%= staff.getId() %>" class="action-btn btn-edit"><i class="fas fa-edit"></i> Edit</a>
                                        <%-- Prevent deleting the main manager or add confirmation --%>
                                        <a href="${pageContext.request.contextPath}/admin/staff/delete?id=<%= staff.getId() %>" class="action-btn btn-delete" onclick="return confirm('Are you sure you want to delete staff member: <%= staff.getUsername() %>?');"><i class="fas fa-trash"></i> Delete</a>
                                    </td>
                                </tr>
                            <% } %>
                        <% } %>
                        --%>

                         <%-- Placeholder Rows (Remove when using loop) --%>
                         <tr>
                             <td>3</td>
                             <td>staffREX</td>
                             <td>staff1@example.com</td>
                             <td>Staff</td>
                             <td>
                                 <a href="#" class="action-btn btn-edit"><i class="fas fa-edit"></i> Edit</a>
                                 <a href="#" class="action-btn btn-delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i> Delete</a>
                             </td>
                         </tr>
                          <tr>
                             <td>4</td>
                             <td>staff2</td>
                             <td>staff2@example.com</td>
                             <td>Staff</td>
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
