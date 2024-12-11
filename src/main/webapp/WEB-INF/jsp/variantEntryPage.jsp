<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>add new variant</title>
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
        <h2 class="form-heading">Add new variant</h2>
        <form:form action="/variantAdd" method="post" modelAttribute="variantRecord">
            <form:hidden path="variantId" />
            <label class="label" for="variantId">Variant Id:</label>
            <form:input path="variantId" id="variantId" class="input" disabled="true" />
            <br /><br />

            <label class="label" for="variantName">Enter Variant Name:</label>
            <form:input path="variantName" id="variantName" class="input" placeholder="Variant name" required="true"/>
            <br /><br />

            <label class="label" for="numberOfSeat">Enter Number of Seats:</label>
            <form:input path="numberOfSeat" id="numberOfSeat" class="input" placeholder="No. of seats" required="true"/>
            <br /><br />

            <label class="label" for="fuel">Enter Type of Fuel:</label>
            <form:input path="fuel" id="fuel" class="input" placeholder="Fuel type" required="true"/>
            <br /><br />

            <button class="submit-button btn" type="submit">Submit</button>
            <button class="reset-button btn" type="reset">Reset</button>
        </form:form>
    </div>
</body>
</html>
