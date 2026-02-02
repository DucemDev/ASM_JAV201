package controller;

import dao.RestaurantDAO;
import dao.RestaurantImpl;
import entity.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet({"/", "/home"})
public class HomeServlet extends HttpServlet {

    private final RestaurantDAO dao = new RestaurantImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int page = 1;
        int size = 6;

        // ===== LẤY PAGE TỪ URL =====
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException ignored) {}
        }

        // ===== LOAD TOÀN BỘ NHÀ HÀNG =====
        List<Restaurant> all = dao.findAll(); // ✅ SỬA Ở ĐÂY

        int totalItems = all.size();
        int totalPages = (int) Math.ceil((double) totalItems / size);

        // ===== CẮT LIST THEO PAGE =====
        int fromIndex = (page - 1) * size;
        int toIndex = Math.min(fromIndex + size, totalItems);

        List<Restaurant> list = totalItems > 0
                ? all.subList(fromIndex, toIndex)
                : all;

        // ===== GỬI SANG JSP =====
        req.setAttribute("list", list);
        req.setAttribute("page", page);
        req.setAttribute("totalPages", totalPages);

        req.setAttribute("contentPage", "home-content.jsp");
        req.getRequestDispatcher("/views/layout.jsp")
                .forward(req, resp);
    }
}
