package controller;

import dao.ViewHistoryDAO;
import dao.ViewHistoryImpl;
import entity.Users;
import entity.ViewHistory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/history")
public class HistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ===== 1. CHECK LOGIN =====
        HttpSession session = req.getSession(false);
        Users user = (session != null)
                ? (Users) session.getAttribute("authUser")
                : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // ===== 2. LẤY HISTORY =====
        ViewHistoryDAO dao = new ViewHistoryImpl();

        // ⚠️ DAO NHẬN STRING → PHẢI toString()
        List<ViewHistory> list =
                dao.findByUser(user.getUserId());


        // ===== 3. FORMAT THỜI GIAN =====
        DateTimeFormatter fmt =
                DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

        list.forEach(v -> {
            if (v.getViewedAt() != null) {
                v.setViewedAtFormatted(
                        v.getViewedAt().format(fmt)
                );
            }
        });

        // ===== 4. GỬI QUA JSP =====
        req.setAttribute("list", list);
        req.setAttribute("contentPage", "/views/history.jsp");

        req.getRequestDispatcher("/views/layout.jsp")
                .forward(req, resp);
    }
}
