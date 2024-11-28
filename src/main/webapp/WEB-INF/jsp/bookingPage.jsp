<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>New Booking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/form.css">
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

    <div class="form-container">
        <h2 class="form-heading">New Booking</h2>

        <form:form action="/createBooking" method="post" modelAttribute="carBooking">
            <form:hidden path="bookingId" />
            <form:hidden path="carNumber" />
            <form:hidden path="username" />

            <label class="label" for="bookingId">Booking Id:</label>
            <form:input path="bookingId" id="bookingId" class="input" placeholder="bookingId" disabled="true"/>
            <br /><br />

            <label class="label" for="carNumber">Car Number:</label>
            <form:input path="carNumber" id="carNumber" class="input" placeholder="carNumber" disabled="true"/>
            <br /><br />

            <label class="label" for="username">Username:</label>
            <form:input path="username" id="username" class="input" placeholder="username" disabled="true"/>
            <br /><br />

            <label class="label" for="rentRate">Rent Rate (per day):</label>
            <input type="text" id="rentRate" value="${rentRate}" disabled="true" class="input" />
            <br /><br />

            <label class="label" for="fromDate">Enter fromDate:</label>
            <form:input path="fromDate" id="fromDate" class="input" placeholder="fromDate" />
            <br /><br />

            <label class="label" for="toDate">Enter toDate:</label>
            <form:input path="toDate" id="toDate" class="input" placeholder="toDate" />
            <br /><br />

            <button class="submit-button btn" type="submit">Proceed to Payment</button>
        </form:form>
    </div>

</body>
</html>
