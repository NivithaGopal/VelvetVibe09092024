<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="bean.ServiceVelvetvibeBean" %>
<%@ page import="dao.ServiceVelvetvibeDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.ServiceCategoryBean" %>
<%@ page import="dao.ServiceCategoryDAO" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <title>Edit Service - VELVETVIBE</title>
    <style>
        body {
            background-color: #e9ecef;
            font-family: 'Arial', sans-serif;
        }

        .container {
            margin-top: 2rem;
        }

        .form-container {
            width: 100%;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 1rem;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <%-- Fetch the service details --%>
            <%
                String idParam = request.getParameter("id");
                int servicevv_id = (idParam != null && !idParam.isEmpty()) ? Integer.parseInt(idParam) : 0;
                
                ServiceVelvetvibeDAO serviceDAO = new ServiceVelvetvibeDAO();
                ServiceVelvetvibeBean service = serviceDAO.getServiceById(servicevv_id);

                ServiceCategoryDAO categoryDAO = new ServiceCategoryDAO();
                List<ServiceCategoryBean> categories = categoryDAO.getAllCategories();
            %>
            <h2 class="text-center mb-4">Edit Service</h2>
            <form action="addServiceVelvetvibeAction.jsp" method="post" enctype="multipart/form-data">
                <input type="hidden" name="servicevv_id" value="<%= service.getServicevv_id() %>">
                <div class="mb-3">
                    <label for="service_id" class="form-label">Service ID</label>
                    <input type="number" class="form-control" id="service_id" name="service_id" value="<%= service.getService_id() %>" required>
                </div>
                <div class="mb-3">
                    <label for="service_name" class="form-label">Service Name</label>
                    <input type="text" class="form-control" id="service_name" name="service_name" value="<%= service.getService_name() %>" required>
                </div>
                <div class="mb-3">
                    <label for="categoryId" class="form-label">Category</label>
                    <select id="categoryId" name="categoryId" class="form-select" required>
                        <%
                            for (ServiceCategoryBean category : categories) {
                        %>
                            <option value="<%= category.getCategoryId() %>" <%= (service.getCategoryId() == category.getCategoryId()) ? "selected" : "" %>>
                                <%= category.getCategoryName() %>
                            </option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea class="form-control" id="description" name="description" rows="4" required><%= service.getDescription() %></textarea>
                </div>
                <div class="mb-3">
                    <label for="image1" class="form-label">Image 1 (URL)</label>
                    <input type="text" class="form-control" id="image1" name="image1" value="<%= service.getImage1() %>">
                </div>
                <div class="mb-3">
                    <label for="image2" class="form-label">Image 2 (URL)</label>
                    <input type="text" class="form-control" id="image2" name="image2" value="<%= service.getImage2() %>">
                </div>
                <div class="mb-3">
                    <label for="image3" class="form-label">Image 3 (URL)</label>
                    <input type="text" class="form-control" id="image3" name="image3" value="<%= service.getImage3() %>">
                </div>
                <div class="mb-3">
                    <label for="amount_from" class="form-label">Amount From</label>
                    <input type="number" step="0.01" class="form-control" id="amount_from" name="amount_from" value="<%= service.getAmount_from() %>" required>
                </div>
                <div class="mb-3">
                    <label for="amount_to" class="form-label">Amount To</label>
                    <input type="number" step="0.01" class="form-control" id="amount_to" name="amount_to" value="<%= service.getAmount_to() %>" required>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-custom">Save Changes</button>
                    <a href="viewServiceVelvetvibe.jsp" class="btn btn-secondary ms-2">Cancel</a>
                </div>
            </form>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
