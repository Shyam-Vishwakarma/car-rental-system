<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add new car</title>
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
                <a href="/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </header>
    <div class="form-container">
        <h2 class="form-heading">Add Car</h2>
        <form:form action="/carAdd" method="post" modelAttribute="carRecord">
            <form:hidden path="available" />

            <label class="label" for="carNumber">Car Registration Number:</label>
            <form:input path="carNumber" id="carNumber" class="input" placeholder="Registration number" required="true"/>
            <br /><br />

            <label class="label" for="carName">Enter Car Name:</label>
            <form:input path="carName" id="carName" class="input" placeholder="Car name" required="true"/>
            <br /><br />

            <label class="label" for="carColor">Enter Car Color:</label>
            <form:input path="carColor" id="carColor" class="input" placeholder="Car color" required="true"/>
            <br /><br />

            <label class="label" for="manufacturer">Enter Car Manufacturer Name:</label>
            <form:input path="manufacturer" id="manufacturer" class="input" placeholder="Manufacturer name" required="true"/>
            <br /><br />

            <label class="label" for="yearOfMfg">Enter Year of manufacturing:</label>
            <form:input path="yearOfMfg" id="yearOfMfg" class="input" placeholder="Year of manufacturing" required="true"/>
            <br /><br />

            <label class="label" for="rentRate">Enter Rent rate per hour:</label>
            <form:input path="rentRate" id="rentRate" class="input" placeholder="Rent rate per hour" required="true"/>
            <br /><br />

            <div class="variantIdContainer">
                <label class="label" for="variantId">Select Variant:</label>
                <form:select path="variantId" class="input variantId" id="carVariantId">
                    <form:option value="" label="Select Variant Id" disabled="true" />
                    <c:forEach items="${variantIdList}" var="vids">
                        <form:option value="${vids}">${vids}</form:option>
                    </c:forEach>
                </form:select>
            </div>

            <button class="submit-button btn" type="submit">Submit</button>
            <button class="reset-button btn" type="reset">Reset</button>
        </form:form>
    </div>
</body>
</html>
