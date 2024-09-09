<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="dao.UserProfileDAO" %>
<%@ page import="bean.UserProfileBean" %>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ page import="java.sql.Date" %>

<%
    HttpSession httpsession = request.getSession(false);

    // Check if the session exists and if the user is logged in
    if (httpsession == null || httpsession.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
        return;
        
        
        
    }

    // Retrieve the email from the session
    String email = (String) httpsession.getAttribute("email");
    
    out.print(email);
   /*  UserProfileDAO userDAO = new UserProfileDAO();
    UserProfileBean user = userDAO.getUserByEmail(email);

    if (user == null) {
        response.sendRedirect("userProfile.jsp?message=User+not+found.");
        return;
    }

    // Retrieve form data from the request
    String fullName = request.getParameter("fullName");
    String dob = request.getParameter("dob");
    String address = request.getParameter("address");
    String mobileNumber = request.getParameter("mobileNumber");

    // Print debug information
    System.out.println("Email: " + email);
    System.out.println("Full Name: " + fullName);
    System.out.println("DOB: " + dob);
    System.out.println("Address: " + address);
    System.out.println("Mobile Number: " + mobileNumber);

    // Validate form data
    if (fullName == null || dob == null || address == null || mobileNumber == null) {
        response.sendRedirect("userProfile.jsp?message=Invalid+form+data.");
        return;
    }

    try {
        // Set updated details in the UserProfileBean
        user.setFullName(fullName);
        user.setDob(Date.valueOf(dob)); // Assuming dob is in yyyy-mm-dd format
        user.setAddress(address);
        user.setMobileNumber(mobileNumber); // Set mobile number

        // Update the user profile in the database
        boolean updated = userDAO.insertOrUpdateUserProfile(user);

        // Provide feedback to the user and redirect accordingly
        if (updated) {
            response.sendRedirect("userProfile.jsp?message=Profile+updated+successfully");
        } else {
            response.sendRedirect("userProfile.jsp?message=Failed+to+update+profile");
        }
    } catch (IllegalArgumentException e) {
        // Handle invalid date format
        response.sendRedirect("userProfile.jsp?message=Invalid+date+format.");
    } */
%>

