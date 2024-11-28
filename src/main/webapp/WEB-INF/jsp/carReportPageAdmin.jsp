<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cars</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/table.css">
</head>
<body>
  <header>
      <div class="header-content">
          <div class="navbar">
              <h1 class="logo">rent&drive</h1>
              <a href="/index" class="btn" id="home-btn">Home</a>
          </div>
          </div>
          <div class="navbar navbar-right">
                <a href="/logout" class="logout-btn">Logout</a>
          </div>
      </div>
  </header>
  <div class="main-container" id="carReportMainContainer">
      <h1 class="primary-heading">Car Report</h1>
      <br />
      <div class="table-container">
        <table class="table">
            <tr class="table-header">
                <th>Car Number</th>
                <th>Car Name</th>
                <th>Color</th>
                <th>Manufacturer</th>
                <th>Year Of Mfg</th>
                <th>Rent Rate</th>
                <th>Variant Detail</th>
                <th>Availability</th>
                <th>Actions</th>
            </tr>

            <c:forEach items="${carList}" var="car">
                <tr class="table-row">
                    <td>${car.carNumber}</td>
                    <td>${car.carName}</td>
                    <td>${car.carColor}</td>
                    <td>${car.manufacturer}</td>
                    <td>${car.yearOfMfg}</td>
                    <td>₹${car.rentRate}/day</td>
                    <td>
                        <c:set var="carVariant" value="${variantMap[car.variantId]}" />
                        <c:if test="${carVariant != null}">
                            <table class="inner-table">
                                <tr>
                                    <th>Variant Id</th>
                                    <td>${carVariant.variantId}</td>
                                </tr>
                                <tr>
                                    <th>Variant Name</th>
                                    <td>${carVariant.variantName}</td>
                                </tr>
                                <tr>
                                    <th>No. of Seats</th>
                                    <td>${carVariant.numberOfSeat}</td>
                                </tr>
                                <tr>
                                    <th>Fuel</th>
                                    <td>${carVariant.fuel}</td>
                                </tr>
                            </table>
                        </c:if>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${car.available == true}">Available</c:when>
                            <c:otherwise>Not Available</c:otherwise>
                        </c:choose>
                    </td>
                    <td class="action-cell">
                        <a href="carUpdate/${car.carNumber}" class="action-btn update-btn">Update</a>
                        <a href="/carDelete/${car.carNumber}" class="action-btn delete-btn">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
      </div>
      <br />
      <h3><a class="return-link" href="/index">Return</a></h3>
  </div>
</body>
</html>