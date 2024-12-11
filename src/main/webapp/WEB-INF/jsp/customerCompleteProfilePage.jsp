<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Complete profile</title>
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
            </div>
            <div class="navbar navbar-right">
                <a href="/myaccount" class="myaccount-btn">My Account</a>
                <a href="/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </header>
    <div class="form-container">
        <h2 class="form-heading">Update profile details</h2>
        <form:form action="/myaccount/update" method="post" modelAttribute="customer">
            <form:hidden path="username" />
            <form:hidden path="email" />
            <form:hidden path="status"/>

            <label class="label" for="username">Username:</label>
            <form:input path="username" id="username" class="input" disabled="true" />

            <label class="label" for="email">Email:</label>
            <form:input path="email" id="email" class="input" disabled="true" />

            <label class="label" for="firstName">Enter First Name:</label>
            <form:input path="firstName" id="firstName" class="input" placeholder="First Name" required="true"/>

            <label class="label" for="lastName">Enter Last Name:</label>
            <form:input path="lastName" id="lastName" class="input" placeholder="Last Name" required="true"/>

            <label class="label" for="address">Enter Address:</label>
            <form:input path="address" id="address" class="input" placeholder="Address" required="true"/>

            <label class="label" for="mobile">Enter Mobile Number:</label>
            <form:input path="mobile" id="mobile" class="input" placeholder="Mobile Number" required="true"/>

            <label class="label" for="license">Enter Driving License Number:</label>
            <form:input path="license" id="license" class="input" placeholder="License Driving Number" required="true"/>

            <label class="label" for="expiryDate">Enter Expiry Date:</label>
            <form:input path="expiryDate" id="expiryDate" class="input" placeholder="Expiry Date" required="true"/>

            <button class="submit-button btn" type="submit">Submit</button>
            <button class="reset-button btn" type="reset">Reset</button>
        </form:form>
    </div>
</body>
</html>
