package com.infosys.carRentalSystem.controller;

import com.infosys.carRentalSystem.bean.CarBooking;
import com.infosys.carRentalSystem.bean.Transaction;
import com.infosys.carRentalSystem.dao.CarBookingDao;
import com.infosys.carRentalSystem.dao.TransactionDao;
import com.infosys.carRentalSystem.dao.TransactionRepository;
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
                carBooking.setAdvancePayment(transaction.getAmount());
                // Update car status
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
        carBookingDao.save(carBooking);

        return new ModelAndView("redirect:/bookingReport/" + bookingId);
    }

    @GetMapping("/cancelBooking/{bookingId}")
    public ModelAndView bookingCancel(@PathVariable String bookingId) {
        CarBooking carBooking = carBookingDao.findById(bookingId);
        carBooking.setStatus("C");
        carBookingDao.save(carBooking);

        return new ModelAndView("redirect:/bookingReport/" + bookingId);
    }
}
