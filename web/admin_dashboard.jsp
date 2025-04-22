<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - Bootstrap Tabs (Static)</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <link rel="stylesheet" href="admin_dashboard_styles.css"> <%--
    <%
        // --- Security Check: Redirect to login if not logged in ---
        // Staff loggedInStaff = (Staff) session.getAttribute("loggedInStaff"); // Adjust attribute name if needed
        String adminUsername = "Admin User"; // Default placeholder
        boolean isManager = false; // Default placeholder

        // if (loggedInStaff == null) {
        //     // Ensure the path is correct for your deployment context
        //     String loginPage = request.getContextPath() + "/login.jsp";
        //     response.sendRedirect(loginPage);
        //     return; // Stop processing the rest of the page
        // } else {
        //     adminUsername = loggedInStaff.getUsername();
        //     // isManager = loggedInStaff.getIsManager(); // Uncomment and use your actual method/field
        // }

        // --- TODO: Fetch data for ALL sections OR handle via AJAX later ---
        // For this example, we use placeholders within each section's HTML below.

        // Currency/Date Formatters (Example) - Commented out as requested
        // NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("ms", "MY"));
        // SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        // SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    %>
    --%>
</head>
<body>
    <nav class="navbar p-4 navbar-expand-lg bg-body-tertiary mb-4 shadow-sm"> <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <i class="fas fa-shield-alt me-2"></i>Admin Panel
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar" aria-controls="adminNavbar" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="adminNavbar">
          <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center"> <li class="nav-item me-3">
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox" role="switch" id="darkModeSwitch">
                    <label class="form-check-label" for="darkModeSwitch"><i id="darkModeIcon" class="fas fa-moon"></i></label>
                </div>
            </li>
            <li class="nav-item">
              <span class="navbar-text me-3">
                Welcome, Admin User! </span>
            </li>
            <li class="nav-item">
              <a class="btn btn-outline-secondary btn-sm" href="#">Logout</a> </li>
          </ul>
        </div>
      </div>
    </nav>
    <div class="container-fluid px-5">
        <ul class="nav nav-tabs mb-3" id="adminTab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="dashboard-tab" data-bs-toggle="tab" data-bs-target="#dashboard-tab-pane" type="button" role="tab" aria-controls="dashboard-tab-pane" aria-selected="true">
                    <i class="fas fa-chart-line me-1"></i> Dashboard
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="users-tab" data-bs-toggle="tab" data-bs-target="#users-tab-pane" type="button" role="tab" aria-controls="users-tab-pane" aria-selected="false">
                    <i class="fas fa-users-cog me-1"></i> Users
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="products-tab" data-bs-toggle="tab" data-bs-target="#products-tab-pane" type="button" role="tab" aria-controls="products-tab-pane" aria-selected="false">
                    <i class="fas fa-box-open me-1"></i> Products
                </button>
            </li>
             <li class="nav-item" role="presentation">
                <button class="nav-link" id="promotions-tab" data-bs-toggle="tab" data-bs-target="#promotions-tab-pane" type="button" role="tab" aria-controls="promotions-tab-pane" aria-selected="false">
                    <i class="fas fa-tags me-1"></i> Promotions
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="orders-tab" data-bs-toggle="tab" data-bs-target="#orders-tab-pane" type="button" role="tab" aria-controls="orders-tab-pane" aria-selected="false">
                    <i class="fas fa-receipt me-1"></i> Orders
                </button>
            </li>
             <li class="nav-item" role="presentation">
                <button class="nav-link" id="reports-tab" data-bs-toggle="tab" data-bs-target="#reports-tab-pane" type="button" role="tab" aria-controls="reports-tab-pane" aria-selected="false">
                    <i class="fas fa-file-alt me-1"></i> Reports
                </button>
            </li>
            <%-- <% if (isManager) { %> --%>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="staff-tab" data-bs-toggle="tab" data-bs-target="#staff-tab-pane" type="button" role="tab" aria-controls="staff-tab-pane" aria-selected="false">
                        <i class="fas fa-user-shield me-1"></i> Staff
                    </button>
                </li>
            <%-- <% } %> --%>
        </ul>
        <div class="tab-content bg-body-tertiary p-4 rounded shadow-sm mb-4" id="adminTabContent">

            <div class="tab-pane fade show active" id="dashboard-tab-pane" role="tabpanel" aria-labelledby="dashboard-tab" tabindex="0">
                <h2 class="mb-3 border-bottom pb-2 text-body"><i class="fas fa-tachometer-alt"></i> Admin Dashboard</h2>
                <p class="text-body-secondary">Overview of the system.</p> <div class="row g-3 mb-4">
                    <div class="col-xl-3 col-md-6">
                         <div class="card bg-body border-start border-primary border-4 h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h5 class="card-title text-body-secondary fw-normal mb-1">Total Users</h5>
                                        <p class="card-text fs-4 fw-bold mb-0 text-body" id="total-users">Loading...</p>
                                    </div>
                                    <i class="fas fa-users card-icon text-primary"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                     <div class="col-xl-3 col-md-6">
                        <div class="card bg-body border-start border-success border-4 h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h5 class="card-title text-body-secondary fw-normal mb-1">Total Products</h5>
                                        <p class="card-text fs-4 fw-bold mb-0 text-body" id="total-products">Loading...</p>
                                    </div>
                                    <i class="fas fa-box-open card-icon text-success"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                     <div class="col-xl-3 col-md-6">
                        <div class="card bg-body border-start border-info border-4 h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h5 class="card-title text-body-secondary fw-normal mb-1">Total Orders</h5>
                                        <p class="card-text fs-4 fw-bold mb-0 text-body" id="total-orders">Loading...</p>
                                    </div>
                                    <i class="fas fa-receipt card-icon text-info"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                     <div class="col-xl-3 col-md-6">
                        <div class="card bg-body border-start border-warning border-4 h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h5 class="card-title text-body-secondary fw-normal mb-1">Sales (Month)</h5>
                                        <p class="card-text fs-4 fw-bold mb-0 text-body" id="total-sales">Loading...</p>
                                    </div>
                                    <i class="fas fa-dollar-sign card-icon text-warning"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><h3 class="mt-4 mb-3 text-body">Sales Statistics (Last 7 Days)</h3>
                 <div class="chart-container bg-body-secondary p-3 rounded">
                    <canvas id="salesChart"></canvas>
                </div>
            </div> <div class="tab-pane fade" id="users-tab-pane" role="tabpanel" aria-labelledby="users-tab" tabindex="0">
                 <h2 class="mb-3 border-bottom pb-2 text-body"><i class="fas fa-users-cog"></i> User Management</h2>
                 <a href="#" class="btn btn-primary mb-3 btn-add"><i class="fas fa-plus"></i> Add User</a>
                 <div class="table-responsive">
                     <table class="table table-striped table-hover table-bordered align-middle">
                         <thead class="table-light"> <tr>
                                 <th>ID</th>
                                 <th>Username</th>
                                 <th>Email</th>
                                 <th>Role</th>
                                 <th>Actions</th>
                             </tr>
                         </thead>
                         <tbody>
                              <tr>
                                 <td>1</td>
                                 <td>customerREX</td>
                                 <td>customer1@example.com</td>
                                 <td>Customer</td>
                                 <td>
                                     <a href="#" class="btn btn-sm btn-info action-btn" title="Edit"><i class="fas fa-edit"></i></a>
                                     <a href="#" class="btn btn-sm btn-danger action-btn" title="Delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i></a>
                                 </td>
                             </tr>
                             <tr>
                                 <td>2</td>
                                 <td>customer2</td>
                                 <td>customer2@example.com</td>
                                 <td>Customer</td>
                                 <td>
                                     <a href="#" class="btn btn-sm btn-info action-btn" title="Edit"><i class="fas fa-edit"></i></a>
                                     <a href="#" class="btn btn-sm btn-danger action-btn" title="Delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i></a>
                                 </td>
                             </tr>
                             </tbody>
                     </table>
                 </div>
            </div> <div class="tab-pane fade" id="products-tab-pane" role="tabpanel" aria-labelledby="products-tab" tabindex="0">
                <h2 class="mb-3 border-bottom pb-2 text-body"><i class="fas fa-box-open"></i> Product Management</h2>
                <a href="#" class="btn btn-primary mb-3 btn-add"><i class="fas fa-plus"></i> Add Product</a>
                <div class="table-responsive">
                    <table class="table table-striped table-hover table-bordered align-middle">
                        <thead class="table-light">
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
                            <tr>
                                <td>1</td>
                                <td>IEM</td>
                                <td>Audio</td>
                                <td>RM 1,200.50</td> <td>50</td>
                                <td>
                                    <a href="#" class="btn btn-sm btn-info action-btn" title="Edit"><i class="fas fa-edit"></i></a>
                                    <a href="#" class="btn btn-sm btn-danger action-btn" title="Delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i></a>
                                </td>
                            </tr>
                             <tr>
                                <td>2</td>
                                <td>Mouse</td>
                                <td>Computer Accessories</td>
                                 <td>RM 25.99</td> <td>100</td>
                                <td>
                                    <a href="#" class="btn btn-sm btn-info action-btn" title="Edit"><i class="fas fa-edit"></i></a>
                                    <a href="#" class="btn btn-sm btn-danger action-btn" title="Delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i></a>
                                </td>
                            </tr>
                             </tbody>
                    </table>
                </div>
            </div> <div class="tab-pane fade" id="promotions-tab-pane" role="tabpanel" aria-labelledby="promotions-tab" tabindex="0">
                <h2 class="mb-3 border-bottom pb-2 text-body"><i class="fas fa-tags"></i> Promotion Management</h2>
                <a href="#" class="btn btn-primary mb-3 btn-add"><i class="fas fa-plus"></i> Add Promotion</a>
                <div class="table-responsive">
                    <table class="table table-striped table-hover table-bordered align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Promo Code</th>
                                <th>Discount (%)</th>
                                <th>Valid From</th>
                                <th>Valid To</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                             <tr>
                                 <td>1</td>
                                 <td>SUMMER20</td>
                                 <td>20%</td>
                                 <td>2025-06-01</td>
                                 <td>2025-08-31</td>
                                 <td>
                                     <a href="#" class="btn btn-sm btn-info action-btn" title="Edit"><i class="fas fa-edit"></i></a>
                                     <a href="#" class="btn btn-sm btn-danger action-btn" title="Delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i></a>
                                 </td>
                             </tr>
                             <tr>
                                 <td>2</td>
                                 <td>FREESHIP</td>
                                 <td>0% (+ Free Shipping)</td>
                                 <td>2025-05-01</td>
                                 <td>2025-05-31</td>
                                 <td>
                                     <a href="#" class="btn btn-sm btn-info action-btn" title="Edit"><i class="fas fa-edit"></i></a>
                                     <a href="#" class="btn btn-sm btn-danger action-btn" title="Delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i></a>
                                 </td>
                             </tr>
                              </tbody>
                    </table>
                </div>
            </div> <div class="tab-pane fade" id="orders-tab-pane" role="tabpanel" aria-labelledby="orders-tab" tabindex="0">
                 <h2 class="mb-3 border-bottom pb-2 text-body"><i class="fas fa-receipt"></i> Order Management</h2>
                 <div class="table-responsive">
                     <table class="table table-striped table-hover table-bordered align-middle">
                         <thead class="table-light">
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Order Date</th>
                                <th>Total Price</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                         <tbody>
                             <tr>
                                 <td>101</td>
                                 <td>customerREX</td>
                                 <td>2025-04-20 10:30</td>
                                 <td>RM 125.49</td> <td><span class="badge bg-warning text-dark">Processing</span></td>
                                 <td>
                                     <a href="#" class="btn btn-sm btn-success action-btn" title="View Details"><i class="fas fa-eye"></i></a>
                                     <a href="#" class="btn btn-sm btn-info action-btn" title="Update Status"><i class="fas fa-edit"></i></a>
                                     <a href="#" class="btn btn-sm btn-danger action-btn" title="Cancel Order" onclick="return confirm('Are you sure?');"><i class="fas fa-times-circle"></i></a>
                                 </td>
                             </tr>
                              <tr>
                                 <td>102</td>
                                 <td>customer2</td>
                                 <td>2025-04-21 09:15</td>
                                 <td>RM 75.00</td> <td><span class="badge bg-info">Shipped</span></td>
                                 <td>
                                     <a href="#" class="btn btn-sm btn-success action-btn" title="View Details"><i class="fas fa-eye"></i></a>
                                     <a href="#" class="btn btn-sm btn-info action-btn" title="Update Status"><i class="fas fa-edit"></i></a>
                                     <a href="#" class="btn btn-sm btn-danger action-btn" title="Cancel Order" onclick="return confirm('Are you sure?');"><i class="fas fa-times-circle"></i></a>
                                 </td>
                             </tr>
                              </tbody>
                     </table>
                 </div>
            </div> <div class="tab-pane fade" id="reports-tab-pane" role="tabpanel" aria-labelledby="reports-tab" tabindex="0">
                 <h2 class="mb-3 border-bottom pb-2 text-body"><i class="fas fa-file-alt"></i> View Reports</h2>
                 <a href="#" class="btn btn-primary mb-3 btn-add"><i class="fas fa-cogs"></i> Generate Report</a>
                 <div class="table-responsive">
                     <table class="table table-striped table-hover table-bordered align-middle">
                         <thead class="table-light">
                            <tr>
                                <th>Report ID</th>
                                <th>Report Type</th>
                                <th>Generated Date</th>
                                <th>Generated By</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                         <tbody>
                             <tr>
                                 <td>1</td>
                                 <td>Monthly Sales Summary</td>
                                 <td>2025-04-01 08:00:00</td>
                                 <td>GiantREX</td>
                                  <td>
                                     <a href="#" class="btn btn-sm btn-success action-btn" title="View Details"><i class="fas fa-eye"></i></a>
                                     <a href="#" class="btn btn-sm btn-danger action-btn" title="Delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i></a>
                                 </td>
                             </tr>
                              <tr>
                                 <td>2</td>
                                 <td>User Activity Report</td>
                                 <td>2025-04-20 14:00:00</td>
                                 <td>staffREX</td>
                                  <td>
                                     <a href="#" class="btn btn-sm btn-success action-btn" title="View Details"><i class="fas fa-eye"></i></a>
                                     <a href="#" class="btn btn-sm btn-danger action-btn" title="Delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i></a>
                                 </td>
                             </tr>
                              </tbody>
                     </table>
                 </div>
            </div> <div class="tab-pane fade" id="staff-tab-pane" role="tabpanel" aria-labelledby="staff-tab" tabindex="0">
                 <h2 class="mb-3 border-bottom pb-2 text-body"><i class="fas fa-user-shield"></i> Staff Management</h2>
                 <a href="#" class="btn btn-primary mb-3 btn-add"><i class="fas fa-plus"></i> Add Staff</a>
                 <div class="table-responsive">
                     <table class="table table-striped table-hover table-bordered align-middle">
                         <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                         <tbody>
                             <tr>
                                 <td>3</td>
                                 <td>staffREX</td>
                                 <td>staff1@example.com</td>
                                 <td>Staff</td>
                                 <td>
                                     <a href="#" class="btn btn-sm btn-info action-btn" title="Edit"><i class="fas fa-edit"></i></a>
                                     <a href="#" class="btn btn-sm btn-danger action-btn" title="Delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i></a>
                                 </td>
                             </tr>
                              <tr>
                                 <td>4</td>
                                 <td>staff2</td>
                                 <td>staff2@example.com</td>
                                 <td>Staff</td>
                                 <td>
                                     <a href="#" class="btn btn-sm btn-info action-btn" title="Edit"><i class="fas fa-edit"></i></a>
                                     <a href="#" class="btn btn-sm btn-danger action-btn" title="Delete" onclick="return confirm('Are you sure?');"><i class="fas fa-trash"></i></a>
                                 </td>
                             </tr>
                              </tbody>
                     </table>
                 </div>
                 </div> </div> </div> <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script src="dashboard_data.js"></script> </body>
</html>
