<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint Status Dashboard | Complaint Management System</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">
    
    <style>
        :root {
            --status-pending: #ffc107;
            --status-inprogress: #17a2b8;
            --status-resolved: #28a745;
            --status-rejected: #dc3545;
            --status-archived: #6c757d;
        }
        
        body {
            background: #f8fafc;
            min-height: 100vh;
        }
        
        .navbar {
            background: linear-gradient(135deg, var(--primary-color) 0%, #1a2530 100%);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .dashboard-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease;
            border-left: 4px solid;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-card.pending { border-left-color: var(--status-pending); }
        .stat-card.inprogress { border-left-color: var(--status-inprogress); }
        .stat-card.resolved { border-left-color: var(--status-resolved); }
        .stat-card.rejected { border-left-color: var(--status-rejected); }
        
        .stat-icon {
            font-size: 2.5rem;
            opacity: 0.8;
            margin-bottom: 1rem;
        }
        
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .badge-pending { background-color: rgba(255, 193, 7, 0.15); color: var(--status-pending); }
        .badge-inprogress { background-color: rgba(23, 162, 184, 0.15); color: var(--status-inprogress); }
        .badge-resolved { background-color: rgba(40, 167, 69, 0.15); color: var(--status-resolved); }
        .badge-rejected { background-color: rgba(220, 53, 69, 0.15); color: var(--status-rejected); }
        .badge-archived { background-color: rgba(108, 117, 125, 0.15); color: var(--status-archived); }
        
        .complaint-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            border-left: 4px solid var(--status-pending);
            transition: all 0.3s ease;
        }
        
        .complaint-card:hover {
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
        }
        
        .complaint-card.resolved { border-left-color: var(--status-resolved); }
        .complaint-card.inprogress { border-left-color: var(--status-inprogress); }
        .complaint-card.rejected { border-left-color: var(--status-rejected); }
        
        .complaint-id {
            font-weight: 700;
            color: var(--primary-color);
            font-size: 0.9rem;
        }
        
        .complaint-title {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }
        
        .complaint-description {
            color: #666;
            font-size: 0.9rem;
            line-height: 1.5;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1rem;
        }
        
        .filter-buttons .btn {
            border-radius: 20px;
            padding: 0.5rem 1.5rem;
            margin-right: 0.5rem;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        
        .action-btn {
            padding: 0.25rem 0.75rem;
            border-radius: 4px;
            font-size: 0.85rem;
            margin-right: 0.5rem;
        }
        
        .search-box {
            position: relative;
        }
        
        .search-box i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }
        
        .search-box input {
            padding-left: 3rem;
            border-radius: 20px;
        }
        
        .pagination .page-link {
            border-radius: 5px;
            margin: 0 2px;
            color: var(--primary-color);
        }
        
        .pagination .page-item.active .page-link {
            background: var(--secondary-color);
            border-color: var(--secondary-color);
        }
        
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #6c757d;
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.3;
        }
        
        .timeline {
            position: relative;
            padding-left: 20px;
            margin-top: 1rem;
        }
        
        .timeline::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 2px;
            background: #dee2e6;
        }
        
        .timeline-item {
            position: relative;
            margin-bottom: 1rem;
            padding-left: 20px;
        }
        
        .timeline-item::before {
            content: '';
            position: absolute;
            left: -20px;
            top: 5px;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: var(--secondary-color);
        }
        
        .timeline-date {
            font-size: 0.8rem;
            color: #6c757d;
        }
    </style>
</head>
<body>
<%
    // Database connection
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;
    
    // Statistics variables
    int totalComplaints = 0;
    int pendingCount = 0;
    int inProgressCount = 0;
    int resolvedCount = 0;
    int rejectedCount = 0;
    
    // Date formatter
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy hh:mm a");
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/complaintdb", "root", "root");
        
        // Get all complaints
        st = con.createStatement();
        rs = st.executeQuery("SELECT * FROM complaints ORDER BY created_at DESC");
        
        // Create list to store complaints
        List<Map<String, Object>> complaints = new ArrayList<>();
        while (rs.next()) {
            Map<String, Object> complaint = new HashMap<>();
            complaint.put("id", rs.getInt("id"));
            complaint.put("name", rs.getString("name"));
            complaint.put("complaint", rs.getString("complaint"));
            complaint.put("status", rs.getString("status"));
            complaint.put("created_at", rs.getTimestamp("created_at"));
            complaint.put("email", rs.getString("email"));
            complaint.put("category", rs.getString("category"));
            complaint.put("priority", rs.getString("priority"));
            
            complaints.add(complaint);
            
            // Update statistics
            totalComplaints++;
            String status = rs.getString("status");
            if (status != null) {
                switch (status.toLowerCase()) {
                    case "pending": pendingCount++; break;
                    case "in progress": inProgressCount++; break;
                    case "resolved": resolvedCount++; break;
                    case "rejected": rejectedCount++; break;
                }
            }
        }
        
        // Store in request scope for JSP use
        request.setAttribute("complaints", complaints);
        request.setAttribute("stats", new int[]{totalComplaints, pendingCount, inProgressCount, resolvedCount, rejectedCount});
        
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Error loading complaints: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (st != null) try { st.close(); } catch (SQLException e) {}
        if (con != null) try { con.close(); } catch (SQLException e) {}
    }
%>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="fas fa-comments me-2"></i>
            Complaint Management System
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="complaint.jsp">
                        <i class="fas fa-plus-circle me-1"></i> New Complaint
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="viewStatus.jsp">
                        <i class="fas fa-list-alt me-1"></i> View Status
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="fas fa-chart-bar me-1"></i> Analytics
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="fas fa-user-circle me-1"></i> Profile
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container-fluid mt-4">
    <div class="container">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2><i class="fas fa-clipboard-list me-2"></i> Complaint Status Dashboard</h2>
                    <p class="mb-0">Monitor and track all submitted complaints in real-time</p>
                </div>
                <div class="col-md-4 text-end">
                    <button class="btn btn-light" onclick="window.print()">
                        <i class="fas fa-print me-1"></i> Print Report
                    </button>
                    <button class="btn btn-outline-light ms-2" onclick="exportToExcel()">
                        <i class="fas fa-download me-1"></i> Export
                    </button>
                </div>
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-2 col-6">
                <div class="stat-card">
                    <div class="stat-icon text-primary">
                        <i class="fas fa-file-alt"></i>
                    </div>
                    <h3 class="mb-1"><%= totalComplaints %></h3>
                    <p class="text-muted mb-0">Total Complaints</p>
                </div>
            </div>
            <div class="col-md-2 col-6">
                <div class="stat-card pending">
                    <div class="stat-icon" style="color: var(--status-pending);">
                        <i class="fas fa-clock"></i>
                    </div>
                    <h3 class="mb-1"><%= pendingCount %></h3>
                    <p class="text-muted mb-0">Pending</p>
                </div>
            </div>
            <div class="col-md-2 col-6">
                <div class="stat-card inprogress">
                    <div class="stat-icon" style="color: var(--status-inprogress);">
                        <i class="fas fa-sync-alt"></i>
                    </div>
                    <h3 class="mb-1"><%= inProgressCount %></h3>
                    <p class="text-muted mb-0">In Progress</p>
                </div>
            </div>
            <div class="col-md-2 col-6">
                <div class="stat-card resolved">
                    <div class="stat-icon" style="color: var(--status-resolved);">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <h3 class="mb-1"><%= resolvedCount %></h3>
                    <p class="text-muted mb-0">Resolved</p>
                </div>
            </div>
            <div class="col-md-2 col-6">
                <div class="stat-card rejected">
                    <div class="stat-icon" style="color: var(--status-rejected);">
                        <i class="fas fa-times-circle"></i>
                    </div>
                    <h3 class="mb-1"><%= rejectedCount %></h3>
                    <p class="text-muted mb-0">Rejected</p>
                </div>
            </div>
            <div class="col-md-2 col-6">
                <div class="stat-card">
                    <div class="stat-icon text-info">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h3 class="mb-1">
                        <%= totalComplaints > 0 ? 
                            String.format("%.0f%%", (resolvedCount * 100.0) / totalComplaints) : "0%" %>
                    </h3>
                    <p class="text-muted mb-0">Resolved Rate</p>
                </div>
            </div>
        </div>

        <!-- Filters and Search -->
        <div class="row mb-4">
            <div class="col-md-8">
                <div class="filter-buttons">
                    <button class="btn btn-outline-primary active" onclick="filterComplaints('all')">
                        All Complaints
                    </button>
                    <button class="btn btn-outline-warning" onclick="filterComplaints('pending')">
                        Pending
                    </button>
                    <button class="btn btn-outline-info" onclick="filterComplaints('inprogress')">
                        In Progress
                    </button>
                    <button class="btn btn-outline-success" onclick="filterComplaints('resolved')">
                        Resolved
                    </button>
                    <button class="btn btn-outline-danger" onclick="filterComplaints('rejected')">
                        Rejected
                    </button>
                </div>
            </div>
            <div class="col-md-4">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" class="form-control" id="searchInput" 
                           placeholder="Search complaints...">
                </div>
            </div>
        </div>

        <!-- Complaints List -->
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white border-0 py-3">
                <h5 class="mb-0"><i class="fas fa-list me-2"></i> Recent Complaints</h5>
            </div>
            <div class="card-body p-0">
                <% 
                    List<Map<String, Object>> complaintsList = (List<Map<String, Object>>) request.getAttribute("complaints");
                    if (complaintsList != null && !complaintsList.isEmpty()) {
                %>
                <div class="table-responsive">
                    <table class="table table-hover mb-0" id="complaintsTable">
                        <thead>
                            <tr class="bg-light">
                                <th style="width: 5%">ID</th>
                                <th style="width: 15%">Submitted By</th>
                                <th style="width: 30%">Complaint Details</th>
                                <th style="width: 10%">Category</th>
                                <th style="width: 10%">Priority</th>
                                <th style="width: 10%">Status</th>
                                <th style="width: 15%">Date</th>
                                <th style="width: 5%">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Map<String, Object> complaint : complaintsList) { 
                                String status = (String) complaint.get("status");
                                String statusClass = "badge-warning";
                                if (status != null) {
                                    switch (status.toLowerCase()) {
                                        case "pending": statusClass = "badge-pending"; break;
                                        case "in progress": statusClass = "badge-inprogress"; break;
                                        case "resolved": statusClass = "badge-resolved"; break;
                                        case "rejected": statusClass = "badge-rejected"; break;
                                    }
                                }
                                
                                String priority = (String) complaint.get("priority");
                                String priorityClass = "bg-secondary";
                                if (priority != null) {
                                    switch (priority.toLowerCase()) {
                                        case "low": priorityClass = "bg-success"; break;
                                        case "medium": priorityClass = "bg-warning"; break;
                                        case "high": priorityClass = "bg-danger"; break;
                                    }
                                }
                                
                                String userInitials = ((String) complaint.get("name")).substring(0, 1).toUpperCase();
                            %>
                            <tr class="complaint-row" data-status="<%= status != null ? status.toLowerCase() : "" %>">
                                <td class="complaint-id">#<%= complaint.get("id") %></td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="user-avatar me-2">
                                            <%= userInitials %>
                                        </div>
                                        <div>
                                            <div class="fw-bold"><%= complaint.get("name") %></div>
                                            <small class="text-muted"><%= complaint.get("email") %></small>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="complaint-title">
                                        <%= ((String) complaint.get("complaint")).length() > 80 ? 
                                            ((String) complaint.get("complaint")).substring(0, 80) + "..." : 
                                            complaint.get("complaint") %>
                                    </div>
                                    <div class="complaint-description">
                                        <% if (((String) complaint.get("complaint")).length() > 80) { %>
                                        <a href="#" class="text-decoration-none" 
                                           onclick="viewFullComplaint(<%= complaint.get("id") %>)">
                                            Read more
                                        </a>
                                        <% } %>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge bg-light text-dark">
                                        <%= complaint.get("category") != null ? complaint.get("category") : "General" %>
                                    </span>
                                </td>
                                <td>
                                    <span class="badge <%= priorityClass %>">
                                        <%= priority != null ? priority : "Medium" %>
                                    </span>
                                </td>
                                <td>
                                    <span class="status-badge <%= statusClass %>">
                                        <i class="fas fa-circle me-1" style="font-size: 0.5rem;"></i>
                                        <%= status != null ? status : "Pending" %>
                                    </span>
                                </td>
                                <td>
                                    <div class="timeline-date">
                                        <%= dateFormat.format((java.sql.Timestamp) complaint.get("created_at")) %>
                                    </div>
                                </td>
                                <td>
                                    <div class="btn-group">
                                        <button class="btn btn-sm btn-outline-primary action-btn"
                                                onclick="viewComplaint(<%= complaint.get("id") %>)"
                                                title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-success action-btn"
                                                onclick="updateStatus(<%= complaint.get("id") %>, 'resolved')"
                                                title="Mark as Resolved">
                                            <i class="fas fa-check"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger action-btn"
                                                onclick="updateStatus(<%= complaint.get("id") %>, 'rejected')"
                                                title="Reject">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <div class="d-flex justify-content-between align-items-center p-3 border-top">
                    <div class="text-muted">
                        Showing <%= complaintsList.size() %> of <%= totalComplaints %> complaints
                    </div>
                    <nav>
                        <ul class="pagination mb-0">
                            <li class="page-item disabled">
                                <a class="page-link" href="#">Previous</a>
                            </li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
                
                <% } else { %>
                <div class="empty-state">
                    <i class="fas fa-inbox"></i>
                    <h4>No complaints found</h4>
                    <p>There are no complaints in the system yet.</p>
                    <a href="complaint.jsp" class="btn btn-primary mt-2">
                        <i class="fas fa-plus me-1"></i> Submit First Complaint
                    </a>
                </div>
                <% } %>
                
                <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger m-3">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>
            </div>
        </div>
        
        <!-- Recent Activity -->
        <div class="row mt-4">
            <div class="col-md-6">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white border-0">
                        <h5 class="mb-0"><i class="fas fa-history me-2"></i> Recent Activity</h5>
                    </div>
                    <div class="card-body">
                        <div class="timeline">
                            <div class="timeline-item">
                                <div class="fw-bold">New complaint submitted</div>
                                <div class="timeline-date">Just now</div>
                                <small>John Doe submitted a new complaint</small>
                            </div>
                            <div class="timeline-item">
                                <div class="fw-bold">Status updated</div>
                                <div class="timeline-date">2 hours ago</div>
                                <small>Complaint #123 marked as resolved</small>
                            </div>
                            <div class="timeline-item">
                                <div class="fw-bold">Priority changed</div>
                                <div class="timeline-date">Yesterday, 3:45 PM</div>
                                <small>Complaint #122 priority set to High</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white border-0">
                        <h5 class="mb-0"><i class="fas fa-chart-pie me-2"></i> Status Distribution</h5>
                    </div>
                    <div class="card-body">
                        <canvas id="statusChart" height="200"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <p class="mb-0">&copy; 2024 Complaint Management System. All rights reserved.</p>
            </div>
            <div class="col-md-6 text-end">
                <p class="mb-0">
                    <span class="me-3"><i class="fas fa-phone me-1"></i> 1-800-COMPLAINT</span>
                    <span><i class="fas fa-envelope me-1"></i> support@complaintsystem.com</span>
                </p>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Chart.js for status distribution -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    // Filter complaints by status
    function filterComplaints(status) {
        const rows = document.querySelectorAll('.complaint-row');
        const filterButtons = document.querySelectorAll('.filter-buttons .btn');
        
        // Update active filter button
        filterButtons.forEach(btn => {
            btn.classList.remove('active');
            if (btn.textContent.toLowerCase().includes(status)) {
                btn.classList.add('active');
            }
        });
        
        // Show/hide rows based on status
        rows.forEach(row => {
            if (status === 'all' || row.dataset.status === status) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }
    
    // Search functionality
    document.getElementById('searchInput').addEventListener('input', function(e) {
        const searchTerm = e.target.value.toLowerCase();
        const rows = document.querySelectorAll('.complaint-row');
        
        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(searchTerm) ? '' : 'none';
        });
    });
    
    // View full complaint
    function viewFullComplaint(id) {
        alert('Viewing full complaint #' + id);
        // In real implementation, this would open a modal or redirect to detail page
    }
    
    // View complaint details
    function viewComplaint(id) {
        window.location.href = 'complaintDetails.jsp?id=' + id;
    }
    
    // Update complaint status
    function updateStatus(id, status) {
        if (confirm('Are you sure you want to update the status of complaint #' + id + '?')) {
            // AJAX call to update status
            fetch('UpdateStatusServlet?id=' + id + '&status=' + status, {
                method: 'POST'
            })
            .then(response => {
                if (response.ok) {
                    location.reload(); // Refresh page to show updated status
                } else {
                    alert('Error updating status');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error updating status');
            });
        }
    }
    
    // Export to Excel
    function exportToExcel() {
        // Create a simple CSV export
        let csv = 'ID,Name,Email,Complaint,Category,Priority,Status,Date\n';
        
        document.querySelectorAll('.complaint-row').forEach(row => {
            const cells = row.querySelectorAll('td');
            const rowData = [];
            
            cells.forEach((cell, index) => {
                if (index !== 7) { // Skip actions column
                    rowData.push(`"${cell.textContent.trim()}"`);
                }
            });
            
            csv += rowData.join(',') + '\n';
        });
        
        // Create download link
        const blob = new Blob([csv], { type: 'text/csv' });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'complaints_export_' + new Date().toISOString().split('T')[0] + '.csv';
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
    }
    
    // Initialize status chart
    document.addEventListener('DOMContentLoaded', function() {
        const ctx = document.getElementById('statusChart').getContext('2d');
        const statusChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Pending', 'In Progress', 'Resolved', 'Rejected'],
                datasets: [{
                    data: [<%= pendingCount %>, <%= inProgressCount %>, <%= resolvedCount %>, <%= rejectedCount %>],
                    backgroundColor: [
                        'rgba(255, 193, 7, 0.8)',
                        'rgba(23, 162, 184, 0.8)',
                        'rgba(40, 167, 69, 0.8)',
                        'rgba(220, 53, 69, 0.8)'
                    ],
                    borderColor: [
                        '#ffc107',
                        '#17a2b8',
                        '#28a745',
                        '#dc3545'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
    });
</script>
</body>
</html>