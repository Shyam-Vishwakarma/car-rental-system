<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Car Rental System Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/form.css">
  </head>
  <body>
    <header>
      <div class="header-content">
        <h1 class="logo">rent&drive</h1>
        <a href="/register" class="register-btn">Register</a>
      </div>
    </header>
    <div class="form-container">
        <h2 class="form-heading">Login</h2>
        <h3 class="tertiary-heading">New user? <span><a class="redirect-link" href="/register">Register here!</a></span></h3>
        <form action="/login" method="post">
            <label class="label" for="username">Enter User Id:</label>
            <input
                class="input"
                type="text"
                name="username"
                id="username"
                placeholder="User id"
                required="true"
            />
            <br /><br />
            <label class="label" for="password">Enter Password:</label>
            <input
                class="input"
                type="password"
                name="password"
                id="password"
                placeholder="Password"
                required="true"
            />
            <br /><br />
            <input class="submit-button btn" type="submit" value="Login" />
        </form>
    </div>
    </div>
  </body>
</html>
