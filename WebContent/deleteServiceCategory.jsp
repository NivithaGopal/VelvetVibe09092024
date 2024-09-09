<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="dao.ServiceCategoryDAO" %>
<%@ page import="bean.ServiceCategoryBean" %>
<%@ page import="java.sql.SQLException" %>

<%
    // Retrieve the service category ID from the request
    String categoryIdStr = request.getParameter("service_id");
    int categoryId = 0;

    if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
        categoryId = Integer.parseInt(categoryIdStr);
    }

    boolean isDeleted = false;

    if (categoryId > 0) {
        ServiceCategoryDAO serviceCategoryDAO = new ServiceCategoryDAO();

        try {
            // Delete the service category
            isDeleted = serviceCategoryDAO.deleteCategoryById(categoryId);
        } catch (SQLException e) {
            e.printStackTrace();
            out.print("<script type='text/javascript'>");
            out.print("alert('An error occurred while deleting the service category.');");
            out.print("window.location.href = 'viewServiceCategory.jsp';");
            out.print("</script>");
        }
    }

    // Redirect or forward based on the result
    if (isDeleted) {
        out.print("<script type='text/javascript'>");
        out.print("alert('Service category deleted successfully.');");
        out.print("window.location.href = 'viewServiceCategory.jsp';");
        out.print("</script>");
    } else {
        out.print("<script type='text/javascript'>");
        out.print("alert('Failed to delete service category.');");
        out.print("window.location.href = 'viewServiceCategory.jsp';");
        out.print("</script>");
    }
%>
