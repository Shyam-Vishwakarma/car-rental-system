<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Error</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
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
    <div class="error-container">
        <h1 class="error-message">${errorMessage}</h1>
        <br>
        <div class="section action" id="bk-action">
            <div class="action-links">
                <a href="/index" class="link-button action-link">Return to Home</a>
                <br><br>
                <a href="${redirectLink}" class="link-button action-link">${linkText}</a>
            </div>
        </div>
    </div>
</body>
</html>
