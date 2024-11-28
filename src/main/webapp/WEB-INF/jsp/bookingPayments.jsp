<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Payments - Admin</title>
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

  <div class="main-container" id="bookingPaymentsMainContainer">
      <h1 class="primary-heading">Booking Payments - Admin</h1>
      <br />
      <div class="table-container">
        <table class="table">
            <tr class="table-header">
                <th>Transaction ID</th>
                <th>Payment Reference No.</th>
                <th>Booking ID</th>
                <th>Amount</th>
                <th>Status</th>
                <th>Action</th>
            </tr>

            <c:forEach items="${transactions}" var="transaction">
                <tr class="table-row">
                    <td>${transaction.transactionId}</td>
                    <td>${transaction.paymentRefNo}</td>
                    <td>${transaction.bookingId}</td>
                    <td>₹${transaction.amount}</td>
                    <td>
                        <c:choose>
                            <c:when test="${transaction.approved == null}"><span id = "pending">Pending</span></c:when>
                            <c:when test="${transaction.approved == false}"><span id = "cancelled">Rejected</span></c:when>
                            <c:when test="${transaction.approved == true}"><span id = "confirmed">Approved</span></c:when>
                        </c:choose>
                    </td>
                    <td class="action-cell">
                        <c:choose>
                            <c:when test="${transaction.approved == null}">
                                <a href="/updatePaymentStatus/${transaction.transactionId}/approve" class="action-btn approve-btn">Approve</a>
                                <a href="/updatePaymentStatus/${transaction.transactionId}/reject" class="action-btn reject-btn">Reject</a>
                            </c:when>
                            <c:otherwise>
                                N/A
                            </c:otherwise>
                        </c:choose>
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
