package controller;

import dao.UsersDAO;
import dao.UsersImpl;
import entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.EmailUtil;

import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/views/forgot_password.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");

        UsersDAO dao = new UsersImpl();
        Users user = dao.findByEmail(email);

        if (user == null) {
            req.setAttribute("message", "Email không tồn tại");
            req.getRequestDispatcher("/views/forgot_password.jsp")
                    .forward(req, resp);
            return;
        }

        // ✅ TẠO OTP
        String otp = String.valueOf((int)(Math.random() * 900000 + 100000));

        // ✅ LƯU OTP DB
        dao.updateOtp(email, otp);

        // ✅ GỬI MAIL
        EmailUtil.sendOtp(email, otp);

        // 🔥🔥🔥 DÒNG QUAN TRỌNG NHẤT (TRƯỚC ĐÂY BỊ THIẾU)
        req.getSession().setAttribute("RESET_EMAIL", email);

        System.out.println("OTP SAVED = " + otp);

        // 👉 CHUYỂN SANG FORM RESET
        req.getRequestDispatcher("/views/reset-password.jsp")
                .forward(req, resp);
    }
}
