<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Date"%>
<%@ page import="bean.UserProfileBean"%>
<%
    HttpSession httpsession = request.getSession(false);
    String email = null;

    // Retrieve the email from the session
    if (httpsession != null) {
        email = (String) httpsession.getAttribute("email");
    }

    // Redirect to login if session does not exist or email is not found
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection variables
    String jdbcURL = "jdbc:mysql://localhost:3306/velvetvibe"; // Replace with your database URL
    String dbUser = "root"; // Replace with your database username
    String dbPassword = ""; // Replace with your database password

    // Initialize variables
    UserProfileBean user = null;

    try {
        // Load database driver (if necessary, depending on your setup)
        Class.forName("com.mysql.jdbc.Driver");

        // Establish a database connection
        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // SQL query to fetch user profile by email
        String sql = "SELECT ur.fullName, ur.dob, ur.email, ur.address, ur.mobile_number FROM user_profile ur WHERE ur.email = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();

        // Check if the user exists and fetch details
        if (rs.next()) {
            user = new UserProfileBean();
            user.setFullName(rs.getString("fullName"));
            user.setDob(rs.getDate("dob"));
            user.setEmail(rs.getString("email"));
            user.setAddress(rs.getString("address"));
            user.setMobileNumber(rs.getString("mobile_number"));
        }

        // Close resources
        rs.close();
        stmt.close();
        conn.close();

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("userProfile.jsp?message=Error+fetching+user+profile.");
        return;
    }

    // If user is not found, redirect with a message
    if (user == null) {
        response.sendRedirect("userProfile.jsp?message=User+not+found.");
        return;
    }

    // Retrieve form data if the form is submitted
    String fullName = request.getParameter("fullName");
    String dob = request.getParameter("dob");
    String address = request.getParameter("address");
    String mobileNumber = request.getParameter("mobileNumber");

    // If form data is available, update the user profile
    if (fullName != null && dob != null && address != null && mobileNumber != null) {
        // Update user profile in the database
        try {
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // SQL query to update user profile
            String updateQuery = "UPDATE user_profile SET fullName = ?, dob = ?, address = ?, mobile_number = ? WHERE email = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
            updateStmt.setString(1, fullName);
            updateStmt.setDate(2, Date.valueOf(dob)); // Convert dob to SQL Date
            updateStmt.setString(3, address);
            updateStmt.setString(4, mobileNumber);
            updateStmt.setString(5, email);

            int rowsAffected = updateStmt.executeUpdate();
            updateStmt.close();
            conn.close();

            // Provide feedback to the user
            if (rowsAffected > 0) {
                response.sendRedirect("userProfile.jsp?message=Profile+updated+successfully");
            } else {
                response.sendRedirect("userProfile.jsp?message=Failed+to+update+profile");
            }
            return;

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("userProfile.jsp?message=Error+updating+profile.");
            return;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>User Profile</h2>
        <% 
            String message = request.getParameter("message");
            if (message != null) {
        %>
        <div class="alert alert-info">
            <%= message %>
        </div>
        <% 
            }
        %>
        <form action="userProfile.jsp" method="post">
            <div class="mb-3">
                <label for="fullName" class="form-label">Full Name</label>
                <input type="text" id="fullName" name="fullName" class="form-control" value="<%= user.getFullName() %>" required>
            </div>
            <div class="mb-3">
                <label for="dob" class="form-label">Date of Birth</label>
                <input type="date" id="dob" name="dob" class="form-control" value="<%= user.getDob() %>" required>
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <input type="text" id="address" name="address" class="form-control" value="<%= user.getAddress() %>" required>
            </div>
            <div class="mb-3">
                <label for="mobileNumber" class="form-label">Mobile Number</label>
                <input type="text" id="mobileNumber" name="mobileNumber" class="form-control" value="<%= user.getMobileNumber() %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Update Profile</button>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
