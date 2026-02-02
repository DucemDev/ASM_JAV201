package controller;

import dao.RestaurantDAO;
import dao.RestaurantImpl;
import dao.ViewHistoryDAO;
import dao.ViewHistoryImpl;
import entity.Restaurant;
import entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/restaurant/detail")
public class RestaurantDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1️⃣ LẤY ID
        String idParam = req.getParameter("id");
        if (idParam == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        Integer restaurantId;
        try {
            restaurantId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // 2️⃣ LOAD RESTAURANT
        RestaurantDAO dao = new RestaurantImpl();
        Restaurant restaurant = dao.findById(restaurantId); // ✅ SỬA Ở ĐÂY

        if (restaurant == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // 3️⃣ TĂNG VIEW
        restaurant.setViewCount(restaurant.getViewCount() + 1);
        dao.update(restaurant);

        // 4️⃣ LƯU VIEW HISTORY (NẾU ĐÃ LOGIN)
        HttpSession session = req.getSession(false);
        Users authUser = (session != null)
                ? (Users) session.getAttribute("authUser")
                : null;

        if (authUser != null) {
            ViewHistoryDAO historyDAO = new ViewHistoryImpl();
            historyDAO.create(authUser.getUserId(), restaurantId);
        }

        // 5️⃣ GỬI QUA JSP
        req.setAttribute("restaurant", restaurant);
        req.setAttribute("contentPage", "/views/detail.jsp");

        req.getRequestDispatcher("/views/layout.jsp")
                .forward(req, resp);
    }
}
