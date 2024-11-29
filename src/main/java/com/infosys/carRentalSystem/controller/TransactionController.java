package com.infosys.carRentalSystem.controller;

import com.infosys.carRentalSystem.bean.Car;
import com.infosys.carRentalSystem.bean.CarBooking;
import com.infosys.carRentalSystem.bean.Customer;
import com.infosys.carRentalSystem.bean.Transaction;
import com.infosys.carRentalSystem.dao.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
public class TransactionController {
    @Autowired
    private CarBookingDao carBookingDao;
    @Autowired
    TransactionDao transactionDao;
    @Autowired
    private TransactionRepository transactionRepository;
    @Autowired
    private CarDao carDao;
    @Autowired
    private CustomerDao customerDao;
    @GetMapping("/makePayment/{bookingId}")
    public ModelAndView showPaymentPage(@PathVariable String bookingId) {
        Transaction transaction = new Transaction();
        CarBooking carBooking = carBookingDao.findById(bookingId);
        Double totalPayment = carBooking.getTotalPayment();
        Double pendingPayment = carBooking.getPendingPayment();

        transaction.setTransactionId(transactionDao.generateTransactionId());
        transaction.setBookingId(bookingId);

        ModelAndView mv = new ModelAndView("paymentPage");
        mv.addObject("transaction", transaction);
        mv.addObject("totalPayment", totalPayment);
        mv.addObject("pendingPayment", pendingPayment);
        return mv;
    }

    @PostMapping("/makePayment")
    public ModelAndView makePayment(@ModelAttribute("transaction") Transaction transaction) {
        transaction.setApproved(null);
        transactionRepository.save(transaction);
        System.out.println("after save");
        return new ModelAndView("redirect:/bookingReport/" + transaction.getBookingId());
    }

    @GetMapping("/updatePaymentStatus/{txnId}/{status}")
    public ModelAndView updatePaymentStatus(@PathVariable String txnId, @PathVariable String status) {
        Transaction transaction = transactionDao.findById(txnId);
        transaction.setApproved(status.equalsIgnoreCase("approve"));
        transactionRepository.save(transaction);

        if(status.equalsIgnoreCase("approve")) {
            CarBooking carBooking = carBookingDao.findById(transaction.getBookingId());
            carBooking.setPendingPayment(carBooking.getPendingPayment() - transaction.getAmount());
            if(carBooking.getAdvancePayment() == 0.0) {
                // First payment
                carBooking.setAdvancePayment(transaction.getAmount());
                updateCarStatus(carBooking.getCarNumber(), false);
                updateCustomerStatus(carBooking.getUsername(), false);
            }

            carBooking.setStatus("CNF");
            carBookingDao.save(carBooking);
        }

        return new ModelAndView("redirect:/bookingPayments");
    }

    @GetMapping("/bookingPayments")
    public ModelAndView showBookingPayments() {
        ModelAndView mv = new ModelAndView("bookingPayments");
        List<Transaction> transactions = transactionRepository.findAll();
        mv.addObject("transactions", transactions);
        return mv;
    }

    @GetMapping("/returnBooking/{bookingId}")
    public ModelAndView bookingReturn(@PathVariable String bookingId) {
        CarBooking carBooking = carBookingDao.findById(bookingId);
        carBooking.setStatus("R");

        updateCarStatus(carBooking.getCarNumber(), true);
        updateCustomerStatus(carBooking.getUsername(), true);

        carBookingDao.save(carBooking);

        return new ModelAndView("redirect:/bookingReport/" + bookingId);
    }

    @GetMapping("/cancelBooking/{bookingId}")
    public ModelAndView bookingCancel(@PathVariable String bookingId) {
        CarBooking carBooking = carBookingDao.findById(bookingId);
        carBooking.setStatus("C");
        carBookingDao.save(carBooking);

        updateCarStatus(carBooking.getCarNumber(), true);
        updateCustomerStatus(carBooking.getUsername(), true);

        return new ModelAndView("redirect:/bookingReport/" + bookingId);
    }
    private void updateCarStatus(String carNumber, Boolean status) {
        Car car = carDao.findById(carNumber);
        car.setAvailable(status);
        carDao.save(car);
    }

    private void updateCustomerStatus(String username, Boolean status) {
        Customer customer = customerDao.findById(username);
        customer.setStatus(status);
        customerDao.save(customer);
    }
}
