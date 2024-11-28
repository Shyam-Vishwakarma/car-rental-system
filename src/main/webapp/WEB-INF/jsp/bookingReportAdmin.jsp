<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Report - Admin</title>
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
  <div class="main-container" id="bookingReportMainContainer">
      <h1 class="primary-heading">Booking Report - Admin</h1>
      <br />
      <div class="table-container">
        <table class="table">
            <tr class="table-header">
                <th>Booking ID</th>
                <th>Car Number</th>
                <th>Username</th>
                <th>From Date</th>
                <th>To Date</th>
                <th>Status</th>
                <th>Pending Payment</th>
                <th>Action</th>
            </tr>

            <c:forEach items="${bookings}" var="booking">
                <tr class="table-row">
                    <td>${booking.bookingId}</td>
                    <td>${booking.carNumber}</td>
                    <td>${booking.username}</td>
                    <td>${booking.fromDate}</td>
                    <td>${booking.toDate}</td>
                    <td>
                        <c:choose>
                            <c:when test="${booking.status == 'CNF'}"><span id = "confirmed">Confirmed</span></c:when>
                            <c:when test="${booking.status == 'P'}"><span id = "pending">Pending</span></c:when>
                            <c:when test="${booking.status == 'C'}"><span id = "cancelled">Cancelled</span></c:when>
                            <c:when test="${booking.status == 'R'}"><span id ="returned">Returned</span></c:when>
                        </c:choose>
                    </td>
                    <td>₹${booking.pendingPayment}</td>
                    <td class="action-cell">
                        <a href="/bookingReport/${booking.bookingId}" class="action-btn details-btn">Details</a>
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
