<%@ page import="java.util.List" %>
<%@ page import="Model.Users" %>

<h2 class="mb-3 border-bottom pb-2 text-body"><i class="fas fa-user-shield"></i> Staff Management</h2>

<button type="button" class="btn btn-primary mb-3 btn-add" data-bs-toggle="modal" data-bs-target="#addStaffModal">
   <i class="fas fa-plus"></i> Add Staff
</button>

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
            <% 
            List<Users> staffList = (List<Users>)request.getAttribute("staffList");
            if(staffList != null) {
                for(Users staff : staffList) { 
            %>
            <tr>
                <td><%= staff.getId() %></td>
                <td><%= staff.getUsername() %></td>
                <td><%= staff.getEmail() %></td>
                <td><%= staff.getRole() %></td>
                <td>
                    <button class="btn btn-sm btn-info action-btn" 
                            onclick="editStaff('<%= staff.getId() %>', '<%= staff.getUsername() %>', '<%= staff.getEmail() %>')"
                            data-bs-toggle="modal" data-bs-target="#editStaffModal">
                        <i class="fas fa-edit"></i>
                    </button>
                    <form action="${pageContext.request.contextPath}/admin/Users_staff" method="POST" style="display: inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= staff.getId() %>">
                        <button type="submit" class="btn btn-sm btn-danger action-btn" 
                                onclick="return confirm('Are you sure you want to delete this staff member?')">
                            <i class="fas fa-trash"></i>
                        </button>
                    </form>
                </td>
            </tr>
            <% 
                }
            } 
            %>
        </tbody>
    </table>
</div>

<!-- Add Staff Modal -->
<div class="modal fade" id="addStaffModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add New Staff</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/Users_staff" method="POST">
                <div class="modal-body">
                    <input type="hidden" name="action" value="add">
                    
                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <input type="text" class="form-control" name="username" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Role</label>
                        <select class="form-select" name="role" required>
                            <option value="staff">Staff</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Add Staff</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
// Add any JavaScript needed for form validation or dynamic behavior
document.addEventListener('DOMContentLoaded', function() {
    // Add form submission handler if needed
});
</script>
