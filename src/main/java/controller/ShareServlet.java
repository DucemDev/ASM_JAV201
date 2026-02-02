package controller;

import dao.RestaurantDAO;
import dao.RestaurantImpl;
import dao.SharesDAO;
import dao.SharesImpl;
import entity.Restaurant;
import entity.Users;
import util.ShareEmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/share")
public class ShareServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");
        if (idParam == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }


        req.setAttribute("restaurantId", idParam);
        req.setAttribute("contentPage", "/views/share.jsp");

        req.getRequestDispatcher("/views/layout.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Users user = (Users) req.getSession().getAttribute("authUser");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // ===== LẤY DATA =====
        String idParam = req.getParameter("restaurantId");
        String email = req.getParameter("email");

        if (idParam == null || email == null) {
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

        // ===== LOAD RESTAURANT =====
        RestaurantDAO restaurantDAO = new RestaurantImpl();
        Restaurant restaurant = restaurantDAO.findById(restaurantId);
        if (restaurant == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // ===== LƯU DB =====
        SharesDAO dao = new SharesImpl();
        dao.share(user.getUserId(), restaurantId, email);

        // ===== BUILD LINK =====
        String link =
                req.getScheme() + "://" +
                        req.getServerName() + ":" +
                        req.getServerPort() +
                        req.getContextPath() +
                        "/restaurant/detail?id=" + restaurantId;

        // ===== GỬI MAIL 🔥🔥🔥 =====
        ShareEmailUtil.sendShareMail(
                email,
                user.getUsername(),
                restaurant.getName(),
                link
        );

        System.out.println("✅ SHARE MAIL SENT TO: " + email);

        resp.sendRedirect(req.getContextPath() + "/home");
    }
}
