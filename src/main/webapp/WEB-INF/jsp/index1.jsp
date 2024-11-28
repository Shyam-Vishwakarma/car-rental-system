<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dropdown.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <header>
        <div class="header-content">
            <div class="navbar">
                <h1 class="logo">rent&drive</h1>
                <div class="dropdown">
                    <button class="dropbtn">Customer</button>
                    <div class="dropdown-content">
                        <a href="/customerReport">Customer Reports</a>
                    </div>
                </div>
                <div class="dropdown">
                    <button class="dropbtn">Variant</button>
                    <div class="dropdown-content">
                        <a href="/variantAdd">Variant Addition</a>
                        <a href="/variantReport">Variant Reports</a>
                    </div>
                </div>
                <div class="dropdown">
                    <button class="dropbtn">Car</button>
                    <div class="dropdown-content">
                        <a href="/carAdd">Car Addition</a>
                        <a href="/carReport">Car Report</a>
                    </div>
                </div>
                <div class="dropdown">
                    <button class="dropbtn">Booking</button>
                    <div class="dropdown-content">
                        <a href="/bookingPayments">Booking Payments</a>
                        <a href="/bookingReport">Booking Reports</a>
                    </div>
                </div>
            </div>
            <div class="navbar navbar-right">
                <a href="/logout" class="logout-btn">Logout</a>
            </div>
        </div>
    </header>
    <div class="headline">
        <h1 id="headline">Miles of Smiles Await – Book Your Car Today!</h1>
    </div>
</body>
</html>
