package controller;

import dao.UsersDAO;
import dao.UsersImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ✅ LẤY EMAIL TỪ SESSION
        String email = (String) req.getSession().getAttribute("RESET_EMAIL");
        String otp = req.getParameter("otp").trim();
        String newPassword = req.getParameter("password").trim();

        // 🔐 CHẶN TRƯỜNG HỢP TRUY CẬP TRỰC TIẾP
        if (email == null) {
            resp.sendRedirect(req.getContextPath() + "/forgot-password");
            return;
        }

        UsersDAO dao = new UsersImpl();

        // ✅ VERIFY OTP BẰNG QUERY
        if (!dao.verifyOtp(email, otp)) {
            req.setAttribute("message", "OTP không hợp lệ");
            req.getRequestDispatcher("/views/reset-password.jsp")
                    .forward(req, resp);
            return;
        }

        // ✅ RESET PASSWORD
        dao.resetPassword(email, newPassword);

        // 🧹 XOÁ SESSION SAU KHI DÙNG
        req.getSession().removeAttribute("RESET_EMAIL");

        // ✅ QUAY VỀ LOGIN
        resp.sendRedirect(req.getContextPath() + "/login");
    }
}
