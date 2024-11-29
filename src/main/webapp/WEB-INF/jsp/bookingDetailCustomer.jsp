<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
        <script>
            function handleAction(actionType, isActive, bookingId) {
                if (isActive) {
                    switch (actionType) {
                        case "payDues":
                            window.location.href = `/makePayment/${bookingId}`;
                            break;
                        case "returnBooking":
                            window.location.href = `/returnBooking/${bookingId}`;
                            break;
                        case "cancelBooking":
                            window.location.href = `/cancelBooking/${bookingId}`;
                            break;
                        default:
                            alert("Invalid action.");
                    }
                }
            }
        </script>
</head>
<body>
    <header>
        <div class="header-content">
            <div class="navbar">
                <h1 class="logo">rent&drive</h1>
                <a href="/index" class="btn" id="home-btn">Home</a>
            </div>
            <div class="navbar navbar-right">
                <a href="/myaccount" class="myaccount-btn">My Account</a>
                <a href="/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </header>

    <div class="booking-detail-container">
        <h3 class="booking-heading">Booking Report</h3>
        <div class="booking-main-container">
            <div class="section booking-details" id="bk-section">
                <h2 class="section-heading">Booking Information:</h2>
                <p class="detail-item" id="bk-detail-item"><strong>Booking ID:</strong> <span class="detail-value">${booking.bookingId}</span></p>
                <p class="detail-item" id="bk-detail-item"><strong>Start Date:</strong> <span class="detail-value">${booking.fromDate}</span></p>
                <p class="detail-item" id="bk-detail-item"><strong>End Date:</strong> <span class="detail-value">${booking.toDate}</span></p>
                <p class="detail-item" id="bk-detail-item"><strong>Status:</strong>
                    <span class="detail-value">
                        <c:choose>
                            <c:when test="${booking.status == 'CNF'}"><span id = "confirmed">Confirmed</span></c:when>
                            <c:when test="${booking.status == 'P'}"><span id = "pending">Pending</span></c:when>
                            <c:when test="${booking.status == 'C'}"><span id = "cancelled">Cancelled</span></c:when>
                            <c:when test="${booking.status == 'R'}"><span id ="returned">Returned</span></c:when>
                            <c:otherwise>Unknown Status</c:otherwise>
                        </c:choose>
                    </span>
                </p>
            </div>

            <div class="section car-details" id="bk-section">
                <h2 class="section-heading">Car Detail:</h2>
                <p class="detail-item"><strong>Car Number:</strong> <span class="detail-value">${car.carNumber}</span></p>
                <p class="detail-item"><strong>Car Name:</strong> <span class="detail-value">${car.carName}</span></p>
                <p class="detail-item"><strong>Car Color:</strong> <span class="detail-value">${car.carColor}</span></p>
                <p class="detail-item"><strong>Manufacturer:</strong> <span class="detail-value">${car.manufacturer}</span></p>
                <p class="detail-item"><strong>Rent Rate (per day):</strong> <span class="detail-value">₹${car.rentRate}</span></p>
                <p class="detail-item"><strong>Variant Name:</strong> <span class="detail-value">${variant.variantName}</span></p>
                <p class="detail-item"><strong>Number of Seats:</strong> <span class="detail-value">${variant.numberOfSeat}</span></p>
                <p class="detail-item"><strong>Fuel Type:</strong> <span class="detail-value">${variant.fuel}</span></p>
            </div>

            <div class="section payment-info" id="bk-section">
                <h2 class="section-heading">Payment Information:</h2>
                <p class="detail-item" id="bk-detail-item"><strong>Total Payment:</strong> <span class="detail-value">₹${booking.totalPayment}</span></p>
                <p class="detail-item"><strong>Advance Payments:</strong> <span class="detail-value">₹${booking.advancePayment}</span></p>
                <p class="detail-item"><strong>Pending Payments:</strong> <span class="detail-value">₹${booking.pendingPayment}</span></p>
                <h3 class="detail-item payment-history-heading">Payment History:</h3>
                <div id="transaction-list">
                    <c:forEach items="${transactions}" var="transaction">
                        <div class="transaction-item">
                            <p class="transaction-id">${transaction.transactionId}</p>
                            <p class="transaction-amount">₹${transaction.amount}</p>
                            <p class="transaction-status">
                                <c:choose>
                                    <c:when test="${transaction.approved == null}">
                                        <span class="status pending">In Review</span>
                                    </c:when>
                                    <c:when test="${transaction.approved == false}">
                                        <span class="status cancelled">Failed</span>
                                    </c:when>
                                    <c:when test="${transaction.approved == true}">
                                        <span class="status confirmed">Success</span>
                                    </c:when>
                                </c:choose>
                            </p>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>


        <div class="section action" id="bk-action">
            <div class="action-links">
                <button
                    class="btn action-link ${booking.pendingPayment > 0 && booking.status != 'C' && booking.status != 'R' ? '' : 'disabled'}"
                    data-tooltip="There is no pending payments."
                    onclick="handleAction('payDues', ${booking.pendingPayment > 0 && booking.status != 'C' && booking.status != 'R'}, '${booking.bookingId}')">
                    Pay dues
                </button>

                <button
                    class="btn action-link ${booking.status == 'CNF' && booking.pendingPayment == 0 ? '' : 'disabled'}"
                    data-tooltip="You can return booking only if there is no pending payment."
                    onclick="handleAction('returnBooking', ${booking.status == 'CNF' && booking.pendingPayment == 0}, '${booking.bookingId}')">
                    Return
                </button>

                <button
                    class="btn action-link ${booking.status == 'P' || (booking.advancePayment == 0 && booking.status != 'C') ? '' : 'disabled'}"
                    data-tooltip="You can cancel booking only if it's Pending or no advance payment has been made."
                    onclick="handleAction('cancelBooking', ${booking.status == 'P' || (booking.advancePayment == 0 && booking.status != 'C')}, '${booking.bookingId}')">
                    Cancel
                </button>
            </div>
        </div>
    </div>
</body>
</html>
