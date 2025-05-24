# Car Rental System

A Java-based Car Rental System to manage vehicles, customers, and bookings. This application streamlines the car rental process with a user-friendly interface and efficient backend logic.

![Java](https://img.shields.io/badge/Java-blue) ![JSP](https://img.shields.io/badge/JSP-green) ![HTML](https://img.shields.io/badge/HTML-cyan) ![CSS](https://img.shields.io/badge/CSS-yellow)

## Features

- **User Registration & Authentication**
  - Secure registration, login, and session management using Spring Security.
  - Multiple user roles: Admin and Customer.

- **Car Management**
  - Admins can add, update, or delete car records.
  - Track car availability and details (model, variant, rent rate, etc.).
  - Car variants and IDs are auto-generated for inventory management.

- **Booking Management**
  - Customers can book available cars for a specified date range.
  - Booking IDs are auto-generated.
  - Admins and users can view booking reports.
  - User booking history and status tracking.

- **Payment Handling**
  - Booking pages support advance and pending payment calculation.
  - Payment records are associated with each booking.
  - Transaction management for each booking.

- **Customer Management**
  - Store and manage customer profiles and driving license details.
  - Validate license expiry and customer status before processing bookings.

- **Responsive Frontend**
  - User-friendly UI using JSP and CSS.
  - Navigation for car, booking, and customer management.

- **Role-Based Dashboards**
  - Separate admin and customer dashboards for relevant views and actions.
  - Admins can access all booking data; customers see only their own.

## Getting Started

### Prerequisites

- Java 8 or above
- Maven (for dependency management and build)
- MySQL or other supported database (ensure configuration matches your setup)
- (Optional) Tomcat or similar servlet container if running outside Spring Boot’s embedded server

### Setup Instructions

1. **Clone the Repository**
    ```bash
    git clone https://github.com/Shyam-Vishwakarma/car-rental-system.git
    cd car-rental-system
    ```

2. **Database Setup**
    - Create a MySQL database for the project.
    - Update your database connection settings in `src/main/resources/application.properties` (if available) with your DB credentials.

3. **Build the Project**
    ```bash
    mvn clean install
    ```

4. **Run the Application**
    ```bash
    mvn spring-boot:run
    ```
    or, if you prefer:
    ```bash
    java -jar target/car-rental-system-*.jar
    ```

5. **Access the Application**
    - Open your browser and go to: `http://localhost:8080/`

---

## Usage

### 1. Access the Application
- After starting the application, open your web browser and navigate to: `http://localhost:8080/`

### 2. Login
- Use one of the default user credentials (see "Getting Started") or register a new user.
- Roles supported: Admin and Customer.

### 3. Functionality Overview

#### As a Customer:
- **Register/Login:** Create a new account or log in.
- **Browse Cars:** View available cars and their details.
- **Book a Car:** Select a car, choose your rental dates, and submit a booking. Payment details (advance, pending) are shown.
- **View Bookings:** Access your booking history and check the status of your current and past rentals.

#### As an Admin:
- **Login:** Use admin credentials.
- **Manage Cars:** Add new cars, update existing car details, or remove cars from inventory.
- **Manage Customers:** View or manage customer records and their license statuses.
- **View All Bookings:** Access all customer bookings, payment statuses, and generate reports.

### 4. Logout
- Click the "Logout" button on the navigation bar to securely log out.

**Note:**  
- The UI is accessible via a web browser and is styled with custom CSS under `src/main/webapp/resources/css/`.
- Ensure your database is running and matches the configuration in `application.properties`.
- For any issues or further customization, refer to the code in the `controller` and `service` packages.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
