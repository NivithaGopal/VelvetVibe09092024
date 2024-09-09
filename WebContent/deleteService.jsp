<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="dao.ServiceDAO" %>

<%
	// Retrieve the service ID from the request
    String serviceId = request.getParameter("service_id");

    // Create an instance of AddServiceDAO
    ServiceDAO serviceDAO = new ServiceDAO();

    // Delete the service from the database
    boolean isDeleted = serviceDAO.deleteService(Integer.parseInt(serviceId));

    // Show alert and redirect based on the result
    if (isDeleted) {
        out.print("<script type='text/javascript'>");
        out.print("alert('Service deleted successfully!');");
        out.print("window.location.href = 'viewService.jsp';");
        out.print("</script>");
    } else {
        out.print("<script type='text/javascript'>");
        out.print("alert('Failed to delete service. Please try again.');");
        out.print("</script>");
    }
%>
