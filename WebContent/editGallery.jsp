<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="dao.GalleryDAO"%>
<%@ page import="bean.GalleryBean"%>
<%@ page import="java.sql.SQLException"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Edit Gallery - VELVETVIBE</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
	color: #333;
	font-family: 'Arial', sans-serif;
}

.container {
	max-width: 600px;
	margin-top: 50px;
	background-color: #ffffff;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.form-group label {
	font-weight: bold;
}

.btn-primary {
	background-color: #007bff;
	border-color: #007bff;
}

.btn-primary:hover {
	background-color: #0056b3;
	border-color: #004085;
}
</style>
</head>
<body>
	<div class="container">
		<h2 class="text-center">Edit Gallery</h2>
		<%
			String galleryId = request.getParameter("galleryId");
			if (galleryId == null || galleryId.isEmpty()) {
				out.println("<p class='text-danger'>Invalid gallery ID.</p>");
			} else {
				try {
					GalleryDAO galleryDAO = new GalleryDAO();
					GalleryBean gallery = galleryDAO.getGalleryById(Integer.parseInt(galleryId));

					if (gallery != null) {
		%>
		<form action="galleryAction.jsp" method="post">
			<input type="hidden" name="action" value="update"> <input
				type="hidden" name="galleryId" value="<%=gallery.getGalleryId()%>">
			<div class="form-group mb-3">
				<label for="image1">Image 1 Name:</label> <input type="text"
					class="form-control" id="image1" name="image1"
					value="<%=gallery.getImage1()%>" >
			</div>
			<div class="form-group mb-3">
				<label for="image2">Image 2 Name:</label> <input type="text"
					class="form-control" id="image2" name="image2"
					value="<%=gallery.getImage2()%>" >
			</div>
			<div class="text-center">
				<button type="submit" class="btn btn-primary">Update
					Gallery</button>
				<a href="viewGallery.jsp" class="btn btn-secondary">Cancel</a>
			</div>
		</form>

		<%
			} else {
						out.println("<p class='text-danger'>Gallery not found.</p>");
					}
				} catch (SQLException e) {
					e.printStackTrace();
					out.println("<p class='text-danger'>Error fetching gallery details. Please try again later.</p>");
				}
			}
		%>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
