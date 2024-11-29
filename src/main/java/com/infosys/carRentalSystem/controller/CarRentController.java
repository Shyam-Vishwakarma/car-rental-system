package com.infosys.carRentalSystem.controller;

import com.infosys.carRentalSystem.bean.*;
import com.infosys.carRentalSystem.dao.*;
import com.infosys.carRentalSystem.exception.CustomerLicenceException;
import com.infosys.carRentalSystem.exception.CustomerStatusException;
import com.infosys.carRentalSystem.service.CarUserService;
import com.infosys.carRentalSystem.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@ControllerAdvice
public class CarRentController {
    @Autowired
    private CarVariantDao carVariantDao;
    @Autowired
    private CarDao carDao;
    @Autowired
    private CarUserService carUserService;
    @Autowired
    private CustomerDao customerDao;
    @Autowired
    private CustomerService customerService;

    @Autowired
    private CarBookingDao carBookingDao;
    @Autowired
    private TransactionDao transactionDao;

    @GetMapping("/variantAdd")
    public ModelAndView showVariantEntryPage() {
        String newId = carVariantDao.generateVariantId();
        CarVariant carVariant = new CarVariant(newId);
        ModelAndView mv =  new ModelAndView("variantEntryPage");
        mv.addObject("variantRecord", carVariant);
        return mv;
    }
    @PostMapping("/variantAdd")
    public ModelAndView saveVariant(@ModelAttribute("variantRecord") CarVariant carVariant) {
        carVariantDao.save(carVariant);
        return new ModelAndView("redirect:/index");
    }

    @GetMapping("/variantReport")
    public ModelAndView showVariantReportPage() {
        List<CarVariant> variantList = carVariantDao.findAll();
        ModelAndView mv = new ModelAndView("variantReportPage");
        mv.addObject("variantList", variantList);
        return mv;
    }
    @GetMapping("/variantDeletion/{id}")
    public ModelAndView deleteVariant(@PathVariable String id) {
        carVariantDao.deleteVariantById(id);
        return new ModelAndView("redirect:/variantReport");
    }

    @GetMapping("/carAdd")
    public ModelAndView showCarEntryPage() {
        Car car = new Car();
        List<String> variantIdList = carVariantDao.getAllVariantIds();
        ModelAndView mv = new ModelAndView("carEntryPage");
        mv.addObject("carRecord", car);
        mv.addObject("variantIdList", variantIdList);
        return mv;
    }

    @PostMapping("/carAdd")
    public ModelAndView saveCar(@ModelAttribute("carRecord") Car car) {
        carDao.save(car);
        return new ModelAndView("redirect:/index");
    }

    @GetMapping("/customerCarReport")
    public ModelAndView showCustomerCarReportPage() {
        String username = carUserService.getUsername();

        List<Car> carList = carDao.getAvailableCars();
        List<CarVariant> variantList = carVariantDao.findAll();

        Map<String, CarVariant> variantMap = new HashMap<>();
        variantList.forEach(variant -> {
            variantMap.put(variant.getVariantId(), variant);
        });

        ModelAndView mv = new ModelAndView("carReportPageCustomer");

        mv.addObject("carList", carList);
        mv.addObject("variantMap", variantMap);

        return mv;
    }

    @GetMapping("/carReport")
    public ModelAndView showCarReportPage() {
        List<Car> carList = carDao.findAll();
        List<CarVariant> variantList = carVariantDao.findAll();

        Map<String, CarVariant> variantMap = new HashMap<>();
        variantList.forEach(variant -> {
            variantMap.put(variant.getVariantId(), variant);
        });

        ModelAndView mv = new ModelAndView("carReportPageAdmin");

        mv.addObject("carList", carList);
        mv.addObject("variantMap", variantMap);

        return mv;
    }

    @GetMapping("/carDelete/{id}")
    public ModelAndView deleteCar(@PathVariable String id) {
        carVariantDao.deleteVariantById(id);
        return new ModelAndView("redirect:/carReport");
    }

    @GetMapping("/carUpdate/{id}")
    public ModelAndView showCarUpdatePage(@PathVariable String id) {
        Car car = carDao.findById(id);
        ModelAndView mv = new ModelAndView("carUpdatePage");
        mv.addObject("carRecord", car);
        return mv;
    }

    @PostMapping("/carUpdate")
    public ModelAndView saveCarUpdatePage(@ModelAttribute("carRecord") Car car) {
        carDao.save(car);
        return new ModelAndView("redirect:/carReport");
    }

    @GetMapping("/newBooking/{carNumber}")
    public ModelAndView showNewBookingPage(@PathVariable String carNumber) {
        // Validate status of the customer before proceeding for booking
        String username = carUserService.getUsername();

        boolean status = customerDao.getCustomerStatusByUsername(username);
        if(!status) throw new CustomerStatusException();

        String licenceExpiryDate = customerDao.getLicenceExpiryDate(username);
        if(!customerService.validateCustomerLicenceDate(licenceExpiryDate))
            throw new CustomerLicenceException();

        // Booking
        CarBooking carBooking = new CarBooking();
        carBooking.setBookingId(carBookingDao.generateBookingId());
        carBooking.setCarNumber(carNumber);
        Double rentRate = carDao.findById(carNumber).getRentRate();
        carBooking.setUsername(carUserService.getUsername());

        ModelAndView mv = new ModelAndView("bookingPage");
        mv.addObject("carBooking", carBooking);
        mv.addObject("rentRate", rentRate);
        return mv;
    }
    @PostMapping("/createBooking")
    public ModelAndView createBookingAndRedirectToPaymentPage(@ModelAttribute("carBooking") CarBooking carBooking) {
        System.out.println(carBooking.getBookingId());
        System.out.println(carBooking.getCarNumber());
        System.out.println("1");

        Double rentRate = carDao.findById(carBooking.getCarNumber()).getRentRate();
        System.out.println("2");

        long days = calculateDaysBetween(carBooking.getFromDate(), carBooking.getToDate());
        System.out.println("3");

        carBooking.setTotalPayment(rentRate * days);
        System.out.println("4");

        carBooking.setStatus("P");
        carBooking.setAdvancePayment(0.0);
        carBooking.setPendingPayment(carBooking.getTotalPayment());

        Customer customer = customerDao.findById(carUserService.getUsername());
        carBooking.setLicense(customer.getLicense());
        carBooking.setVariantId(carDao.findById(carBooking.getCarNumber()).getVariantId());

        carBookingDao.save(carBooking);
        return new ModelAndView("redirect:/makePayment/" + carBooking.getBookingId());
    }
    @GetMapping("/bookingReport")
    public ModelAndView showBookingReport() {
        String username = carUserService.getUsername();
        String role = carUserService.getRole();
        String page = role.equalsIgnoreCase("ADMIN")
                ? "bookingReportAdmin" : "bookingReportCustomer";
        ModelAndView mv = new ModelAndView(page);

        if (role.equalsIgnoreCase("ADMIN")) {
            List<CarBooking> allBookings = carBookingDao.findAll();
            mv.addObject("bookings", allBookings);
        } else {
            List<CarBooking> userBookings = carBookingDao.findAllByUsername(username);
            mv.addObject("bookings", userBookings);
        }
        return mv;
    }
    @GetMapping("/bookingReport/{bookingId}")
    public ModelAndView showBookingDetails(@PathVariable String bookingId) {
        String role = carUserService.getRole();
        CarBooking carBooking = carBookingDao.findById(bookingId);

        String page = role.equalsIgnoreCase("ADMIN")
                ? "bookingDetailAdmin" : "bookingDetailCustomer";
        ModelAndView mv = new ModelAndView(page);

        CarVariant variant = carVariantDao.findById(carBooking.getVariantId());
        Car car = carDao.findById(carBooking.getCarNumber());
        List<Transaction> transactions = transactionDao.findAllByBookingId(bookingId);

        mv.addObject("booking", carBooking);
        mv.addObject("variant", variant);
        mv.addObject("car", car);
        mv.addObject("transactions", transactions);

        return mv;
    }


    private long calculateDaysBetween(String fromDate, String toDate) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate start = LocalDate.parse(fromDate, formatter);
        LocalDate end = LocalDate.parse(toDate, formatter);
        return ChronoUnit.DAYS.between(start, end);
    }

    @ExceptionHandler(CustomerStatusException.class)
    public ModelAndView handleCustomerStatusException(CustomerStatusException exception) {
        String message="Sorry Dear Customer! Need to complete last booking";
        ModelAndView mv = new ModelAndView("errorPage");

        mv.addObject("linkText", "Show Bookings");
        mv.addObject("redirectLink", "/bookingReport");

        mv.addObject("errorMessage",message);
        return mv;
    }
    @ExceptionHandler(CustomerLicenceException.class)
    public ModelAndView handleCustomerLicenceException(CustomerLicenceException exception) {
        String message = "Sorry Dear Customer! Need to renew your License";
        ModelAndView mv = new ModelAndView("errorPage");

        mv.addObject("linkText", "Update License");
        mv.addObject("redirectLink", "//myaccount");

        mv.addObject("errorMessage",message);
        return mv;
    }
}
