<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="dao.ServiceDAO"%>
<%@ page import="dao.ServiceVelvetvibeDAO"%>
<%@ page import="bean.addServiceBean"%>
<%@ page import="bean.ServiceVelvetvibeBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.io.IOException"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Service Details</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<style>
    /* Background with a gradient of dark and light grays */
   body {
    background-color: #f5f5f5; /* Light gray background color */
    font-family: 'Arial', sans-serif;
    color: #333;
    padding-top: 5rem;
}

    /* Card styles */
    .card {
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        border: none;
        overflow: hidden;
        background: #f8f9fa;
    }

    .card-header {
        background: linear-gradient(135deg, #6c757d 0%, #343a40 100%);
        color: #fff;
        text-align: center;
        padding: 20px;
        font-size: 1.5rem;
        font-weight: bold;
    }

    .img-thumbnail {
        margin-bottom: 15px;
        max-height: 200px;
        object-fit: cover;
        border-radius: .25rem;
    }

    .service-card {
        border: none;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        background: #f8f9fa;
    }

    .btn-success {
        border-radius: 30px;
        padding: 10px 20px;
        font-size: 1.2rem;
        font-weight: bold;
        text-transform: uppercase;
        letter-spacing: 1px;
        transition: all 0.3s ease;
        color: #fff;
        background-color: #343a40;
        border-color: #343a40;
    }

    .btn-success:hover {
        background-color: #495057;
        border-color: #495057;
    }

    .alert {
        border-radius: 10px;
    }

    h3 {
        font-size: 2rem;
        font-weight: bold;
        color: #212529;
        text-align: center;
        margin-bottom: 2rem;
    }

    .text-center {
        text-align: center;
    }
</style>
</head>
<body>

    <div class="container d-flex justify-content-center">
        <div class="card service-card mt-4">
            <div class="card-header">
              VELVETVIBE
            </div>
            <div class="card-body text-center">
                <%
                    String serviceIdStr = request.getParameter("serviceId");

                    if (serviceIdStr != null) {
                        try {
                            int serviceId = Integer.parseInt(serviceIdStr);

                            // Fetch the service details from ServiceDAO
                            ServiceDAO serviceDao = new ServiceDAO();
                            addServiceBean service = serviceDao.getServiceById(serviceId);

                            if (service != null) {
                                String serviceName = service.getServiceName(); // Fetching the service name
                %>

                <div>
                    <p><strong>Service Name:</strong> <%=serviceName%></p>

                    <%
                        if (serviceName != null && !serviceName.isEmpty()) {
                            // Fetch details from ServiceVelvetvibeDAO using serviceId and serviceName
                            ServiceVelvetvibeDAO velvetvibeDao = new ServiceVelvetvibeDAO();
                            List<ServiceVelvetvibeBean> services = velvetvibeDao.getServiceByIdAndName(serviceId, serviceName);

                            if (services != null && !services.isEmpty()) {
                    %>

                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <%
                                for (ServiceVelvetvibeBean velvetService : services) {
                            %>
                            <div class="mb-4">
                                <p><strong>Category Name:</strong> <%=velvetService.getCategoryName()%></p>
                                <p><strong>Description:</strong> <%=velvetService.getDescription()%></p>
                                <p><strong>Amount From:</strong> &#x20B9 <%=velvetService.getAmount_from()%></p>
                                <p><strong>Amount To:</strong> &#x20B9 <%=velvetService.getAmount_to()%></p>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <img src="<%=velvetService.getImage1()%>" class="img-thumbnail" alt="Service Image 1">
                                </div>
                                <div class="col-md-4">
                                    <img src="<%=velvetService.getImage2()%>" class="img-thumbnail" alt="Service Image 2">
                                </div>
                                <div class="col-md-4">
                                    <img src="<%=velvetService.getImage3()%>" class="img-thumbnail" alt="Service Image 3">
                                </div>
                                <div class="mt-3">
                                    <button class="btn btn-success" id="favButton">Add to Favourite</button>
                                    <button class="btn btn-success" id="bookNowButton">Book Now</button>
                                </div>
                            </div>
                            <hr>
                            <%
                                }
                            } else {
                    %>
                            <div class="alert alert-warning" role="alert">No service found in ServiceVelvetvibeDAO for the given ID and name.</div>
                    <%
                            }
                        } else {
                    %>
                        <div class="alert alert-danger" role="alert">Service Name not provided for ServiceVelvetvibeDAO lookup.</div>
                    <%
                        }
                    } else {
                %>
                <div class="alert alert-danger" role="alert">No service found in ServiceDAO for the given ID.</div>
                <%
                }
                } catch (NumberFormatException e) {
                %>
                <div class="alert alert-danger" role="alert">Invalid service ID format.</div>
                <%
                } catch (Exception e) {
                %>
                <div class="alert alert-danger" role="alert">Error retrieving service details: <%=e.getMessage()%></div>
                <%
                }
            } else {
            %>
            <div class="alert alert-danger" role="alert">No service ID provided.</div>
            <%
            }
            %>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var favButton = document.getElementById('favButton');

            favButton.addEventListener('click', function() {
                favButton.classList.toggle('selected');
            });
        });
    </script>

</body>
</html>
