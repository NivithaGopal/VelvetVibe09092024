<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="dao.ServiceDAO"%>
<%@ page import="bean.addServiceBean"%>
<%@ page import="java.util.List"%>
<%@ page import="dao.ServiceCategoryDAO"%>
<%@ page import="bean.ServiceCategoryBean"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.io.IOException"%>

<%
	String serviceId = request.getParameter("service_id");
	ServiceCategoryDAO serviceCategoryDAO = new ServiceCategoryDAO();
	ServiceCategoryBean serviceCategory = null;

	if ("POST".equalsIgnoreCase(request.getMethod())) {
		// Retrieve form data from the request
		String categoryId = request.getParameter("categoryId");
		String categoryName = request.getParameter("categoryName");
		String serviceCategoryValue = request.getParameter("serviceCategory");
		String servicePrice = request.getParameter("servicePrice");
		String serviceDescription = request.getParameter("serviceDescription");

		// Update the service category
		serviceCategory = new ServiceCategoryBean();
		serviceCategory.setCategoryId(Integer.parseInt(categoryId));
		serviceCategory.setCategoryName(categoryName);
		serviceCategory.setServiceCategory(Integer.parseInt(serviceCategoryValue));
		serviceCategory.setServicePrice(Integer.parseInt(servicePrice));
		serviceCategory.setServiceDescription(serviceDescription);

		boolean isUpdated = false;
		try {
			isUpdated = serviceCategoryDAO.updateCategory(serviceCategory);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		if (isUpdated) {
			out.print("<script type='text/javascript'>");
			out.print("alert('Service category updated successfully.');");
			out.print("window.location.href = 'viewServiceCategory.jsp';");
			out.print("</script>");
		} else {
			out.print("<script type='text/javascript'>");
			out.print("alert('Failed to update service category.');");
			out.print("window.location.href = 'editServiceCategory.jsp?service_id=" + serviceId + "';");
			out.print("</script>");
		}

		return;
	} else {
		try {
			// Fetch the service category details based on the service ID
			serviceCategory = serviceCategoryDAO.getCategoryById(Integer.parseInt(serviceId));
		} catch (SQLException e) {
			e.printStackTrace();
			throw new IOException("Database error: " + e.getMessage());
		}

		if (serviceCategory == null) {
			out.print("<script type='text/javascript'>");
			out.print("alert('Service category not found.');");
			out.print("window.location.href = 'viewServiceCategory.jsp';");
			out.print("</script>");
			return;
		}
	}
%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>Edit Service Category - VELVETVIBE</title>
<style>
body {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	background-color: #e9ecef;
	font-family: 'Arial', sans-serif;
	color: #333;
}

.container {
	max-width: 600px;
	width: 100%;
	padding: 2rem;
	background-color: #ffffff;
	border-radius: 15px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.btn-custom {
	background-color: #343a40;
	border-color: #343a40;
	color: #fff;
}

.btn-custom:hover {
	background-color: #495057;
	border-color: #495057;
}

h3 {
	font-size: 2rem;
	font-weight: bold;
	color: #212529;
	text-align: center;
}
</style>
</head>
<body>
	<div class="container">
		<h3>Edit Service Category</h3>
		<form action="editServiceCategory.jsp?service_id=<%=serviceId%>"
			method="post">
			<div class="mb-3">
				<label for="categoryId" class="form-label">Category ID</label> <input
					type="text" class="form-control" id="categoryId" name="categoryId"
					value="<%=serviceCategory.getCategoryId()%>" readonly>
			</div>
			<div class="mb-3">
				<label for="categoryName" class="form-label">Category Name</label> <input
					type="text" class="form-control" id="categoryName"
					name="categoryName" value="<%=serviceCategory.getCategoryName()%>"
					required>
			</div>
			<div class="mb-3">
				<label for="serviceCategory" class="form-label">Services</label> <select
					class="form-select" id="serviceCategory" name="serviceCategory"
					required>
					<%
						ServiceDAO dao = new ServiceDAO();
						List<addServiceBean> services = dao.getAllServices();
						if (services != null && !services.isEmpty()) {
							for (addServiceBean service : services) {
					%>
					<option value="<%=service.getService_id()%>"
						<%=service.getService_id() == serviceCategory.getServiceCategory() ? "selected" : ""%>><%=service.getServiceName()%></option>
					<%
						}
						} else {
					%>
					<option value="">No services available</option>
					<%
						}
					%>
				</select>
			</div>
			<div class="mb-3">
				<label for="servicePrice" class="form-label">Price (&#x20b9)</label>
				<input type="number" class="form-control" id="servicePrice"
					name="servicePrice" value="<%=serviceCategory.getServicePrice()%>"
					required>
			</div>
			<div class="mb-3">
				<label for="serviceDescription" class="form-label">Description</label>
				<textarea class="form-control" id="serviceDescription"
					name="serviceDescription" rows="4" required><%=serviceCategory.getServiceDescription()%></textarea>
			</div>
			<div class="d-flex justify-content-center mt-3">
				<button type="submit" class="btn btn-custom me-2">Update
					Category</button>
				<a href="viewServiceCategory.jsp" class="btn btn-secondary">Cancel</a>
			</div>

		</form>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
