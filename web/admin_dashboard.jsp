<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>

    <link rel="stylesheet" href="styles/pages/body.css"> <link rel="stylesheet" href="styles/components/navbar.css"> <link rel="stylesheet" href="styles/components/footer.css"> <link rel="stylesheet" href="styles/pages/admin/admin_dashboard.css"> <link rel="stylesheet" href="styles/pages/admin/admin_sidebar.css"> <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <%--
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <%@ page import="Model.Staff" %>
        <%
            // --- IMPORTANT: Security Check ---
            Staff loggedInStaff = (Staff) session.getAttribute("loggedInStaff"); // Adjust attribute name
            boolean isAdmin = false;
            if (loggedInStaff == null /* || !loggedInStaff.getIsManager() -- Add role check */ ) {
                // response.sendRedirect(request.getContextPath() + "/login.jsp");
                // return;
            } else {
               // isAdmin = loggedInStaff.getIsManager();
               // adminUsername = loggedInStaff.getUsername();
            }
            String adminUsername = (loggedInStaff != null) ? loggedInStaff.getUsername() : "Admin User";

            // Set active page for sidebar highlighting
            request.setAttribute("activeAdminPage", "dashboard");
        %>
    --%>

</head>
<body>
    <nav class="navbar"> Navbar Content Goes Here... </nav>
    <div class="admin-container">
        <div class="admin-sidebar"> Sidebar Content (from admin_sidebar.html) Goes Here... </div>
        <div class="admin-content">
            <h2><i class="fas fa-tachometer-alt"></i> Admin Dashboard</h2>
            <p>Welcome, Admin User!</p> <hr>

            <div class="summary-cards">
                 <div class="card">
                    <h4>Total Users</h4>
                    <p id="total-users">Loading...</p>
                 </div>
                 <div class="card">
                    <h4>Total Products</h4>
                    <p id="total-products">Loading...</p>
                 </div>
                 <div class="card">
                    <h4>Total Orders</h4>
                    <p id="total-orders">Loading...</p>
                 </div>
                 <div class="card">
                    <h4>Total Sales (Month)</h4>
                    <p id="total-sales">Loading...</p>
                 </div>
            </div>

            <h3>Sales Statistics (Last 7 Days)</h3>
            <div class="chart-container">
                <canvas id="salesChart"></canvas>
            </div>

            </div>
    </div>

    <footer class="footer"> Footer Content Goes Here... </footer>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script src="js/admin/dashboard_data.js"></script> </body>
</html>
