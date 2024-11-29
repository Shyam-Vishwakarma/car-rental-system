<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Make Payment</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/form.css">
    <script>
        function validateForm(event) {
            let isValid = true;
            const amountInput = document.getElementById("amount");
            const paymentRefInput = document.getElementById("paymentRefNo");
            const pendingAmount = parseFloat("${pendingPayment}");
            const errorMessages = document.querySelectorAll(".error-message");

            // Clear previous error messages
            errorMessages.forEach(msg => msg.remove());

            // Validate amount
            const amountValue = amountInput.value.trim();
            const amount = parseFloat(amountValue);

            if (amountValue === "") {
                isValid = false;
                amountInput.classList.add("error");

                const errorMsg = document.createElement("div");
                errorMsg.className = "error-message";
                errorMsg.innerText = "Amount paid cannot be empty.";
                amountInput.insertAdjacentElement("afterend", errorMsg);
            } else if (amount > pendingAmount) {
                isValid = false;
                amountInput.classList.add("error");

                const errorMsg = document.createElement("div");
                errorMsg.className = "error-message";
                errorMsg.innerText = "Amount paid cannot be greater than the pending amount.";
                amountInput.insertAdjacentElement("afterend", errorMsg);
            } else {
                amountInput.classList.remove("error");
            }

            // Validate payment reference number
            if (paymentRefInput.value.trim() === "") {
                isValid = false;
                paymentRefInput.classList.add("error");

                const errorMsg = document.createElement("div");
                errorMsg.className = "error-message";
                errorMsg.innerText = "Payment reference number cannot be empty.";
                paymentRefInput.insertAdjacentElement("afterend", errorMsg);
            } else {
                paymentRefInput.classList.remove("error");
            }

            // Prevent form submission if there are validation errors
            if (!isValid) {
                event.preventDefault();
            }
        }

        // Attach validation to form submission
        document.addEventListener("DOMContentLoaded", function () {
            const paymentForm = document.getElementById("paymentForm");
            paymentForm.addEventListener("submit", validateForm);
        });
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
                <a href="/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </header>

    <div class="form-container" id="payment-form-container">
        <h2 class="form-heading">Make Payment</h2>
        <form:form id="paymentForm" action="/makePayment" method="post" modelAttribute="transaction">
            <p class="detail-item"><strong>Booking ID:</strong> <span class="detail-value">${transaction.bookingId}</span></p>
            <p class="detail-item"><strong>Total Payment:</strong> <span class="detail-value">${totalPayment}</span></p>
            <p class="detail-item"><strong>Pending Payment:</strong> <span class="detail-value">${pendingPayment}</span></p>
            <p class="description"><strong>Make a payment on <span>rent&drive@upi</span> using your preferred UPI app and fill the form below!</strong></p>

            <form:hidden path="bookingId"/>
            <form:hidden path="transactionId"/>

            <label class="label" for="transactionId">Transaction Id:</label>
            <form:input path="transactionId" id="transactionId" class="input" disabled="true"/>
            <br /><br />

            <label class="label" for="amount">Amount paid:</label>
            <form:input path="amount" id="amount" class="input" placeholder="Enter payment amount"/>
            <br /><br />

            <label class="label" for="paymentRefNo">Payment Reference Number:</label>
            <form:input path="paymentRefNo" id="paymentRefNo" class="input" placeholder="Enter payment reference number"/>
            <br /><br />

            <button class="submit-button btn" type="submit">Make Payment</button>
            <button class="reset-button btn" type="reset">Reset</button>
        </form:form>
    </div>
</body>
</html>
