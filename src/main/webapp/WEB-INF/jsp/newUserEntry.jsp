<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script type="text/javascript">
        function validateEntries() {
        var pass1 = document.getElementById("pass1").value;
        var pass2 = document.getElementById("pass2").value;
        var email = document.getElementById("email").value;

        if(pass1.length < 5 || pass1.length > 10) {
            alert("Password length must be between 5 to 10");
        }
        var passwordRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*]).{5,10}$/;
        if (!passwordRegex.test(pass1)) {
            alert("Password must contain at least one uppercase letter, one digit, and one special character.");
            return;
        }

        if (pass1 !== pass2) {
            alert("Passwords do not match.");
            return;
        }

        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            alert("Please enter a valid email address.");
            return;
        }

        document.getElementById("registrationForm").submit();
    }
    </script>
    <title>Register new user</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/form.css">
</head>
<body>
    <header>
        <div class="header-content">
            <h1 class="logo">rent&drive</h1>
            <a href="/loginpage" class="login-btn">Login</a>
        </div>
    </header>
    <div class="form-container">
        <h2 class="form-heading">Register</h2>
        <h3 class="tertiary-heading">Already registered? <span><a class="redirect-link" href="/loginpage">Login here!</a></span></h3>
        <form:form id="registrationForm" method="post" action="/register" modelAttribute="userRecord" class="form-container">
            <label class="label">Enter User Id:</label>
            <form:input path="username" class="input" placeholder="Enter your User ID" required="true"/>

            <label class="label">Enter Password:</label>
            <form:input type="password" path="password" id="pass1" class="input" placeholder="Enter your Password" required="true"/>

            <label class="label">Re-type Password:</label>
            <input type="password" id="pass2" class="input" placeholder="Re-enter your Password" required="true"/>

            <label class="label">Enter Email:</label>
            <form:input path="email" class="input" placeholder="Enter your Email" required="true"/>

            <div class="userTypeContainer">
                <label class="label">Select User Type:</label>
                <form:select path="role" class="input userType">
                    <form:option value="" label="Select User Type" disabled="true"/>
                    <form:option value="Customer" label="Customer"/>
                    <form:option value="Admin" label="Admin"/>
                </form:select>
            </div>

            <button class="submit-button btn" type="button" onclick="validateEntries();">Submit</button>
            <button class="reset-button btn" type="reset">Reset</button>
        </form:form>
    </div>
</body>
</html>
