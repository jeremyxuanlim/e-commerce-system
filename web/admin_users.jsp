<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>

    <link rel="stylesheet" href="styles/pages/body.css"> <link rel="stylesheet" href="styles/components/navbar.css"> <link rel="stylesheet" href="styles/components/footer.css"> <link rel="stylesheet" href="styles/pages/admin/admin_dashboard.css"> <link rel="stylesheet" href="styles/pages/admin/admin_sidebar.css"> <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <%--
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <%@ page import="Model.Staff, Model.Customers, java.util.List" %>
        <%
            // --- IMPORTANT: Security Check ---
            Staff loggedInStaff = (Staff) session.getAttribute("loggedInStaff");
            if (loggedInStaff == null /* || Add role check specific to user management */) {
                // response.sendRedirect(request.getContextPath() + "/login.jsp");
                // return;
            }

            // --- TODO: Fetch user list data from backend ---
            // List<Customers> userList = fetchUsersFromBackend();
            List<?> userList = List.of("User1", "User2"); // Placeholder

            // Set active page for sidebar
            request.setAttribute("activeAdminPage", "users");
        %>
    --%>
</head>
<body>
    <nav class="navbar"> Navbar Content Goes Here... </nav>

    <div class="admin-container">
        <div class="admin-sidebar"> Sidebar Content (from admin_sidebar.html) Goes Here... (Set 'users' link as active) </div>

        <div class="admin-content">
            <h2><i class="fas fa-users-cog"></i> User Management</h2>
            <hr>

            <a href="#" class="btn-add"><i class="fas fa-plus"></i> Add User</a>

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
                        <%-- Example Row 1 --%>
                        <tr>
                            <td>1</td>
                            <td>customerREX</td>
                            <td>customer1@example.com</td>
                            <td>customer</td>
                            <td>
                                <a href="#" class="action-btn btn-edit"><i class="fas fa-edit"></i> Edit</a>
                                <a href="#" class="action-btn btn-delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i> Delete</a>
                            </td>
                        </tr>
                        <%-- Example Row 2 --%>
                         <tr>
                            <td>3</td>
                            <td>staffREX</td>
                            <td>staff1@example.com</td>
                            <td>staff</td>
                            <td>
                                <a href="#" class="action-btn btn-edit"><i class="fas fa-edit"></i> Edit</a>
                                <a href="#" class="action-btn btn-delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i> Delete</a>
                            </td>
                        </tr>
                         <%-- Example Row 3 --%>
                         <tr>
                            <td>5</td>
                            <td>GiantREX</td>
                            <td>GREX@JEEYANG.com</td>
                            <td>manager</td>
                            <td>
                                <a href="#" class="action-btn btn-edit"><i class="fas fa-edit"></i> Edit</a>
                                <a href="#" class="action-btn btn-delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i> Delete</a>
                            </td>
                        </tr>
                        </div>
    </div>

    <footer class="footer"> Footer Content Goes Here... </footer>

</body>
</html>
