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

@WebServlet("/share-send")
public class ShareSendServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("🔥 SHARE SEND SERVLET HIT 🔥");

        Users user = (Users) req.getSession().getAttribute("authUser");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String idParam = req.getParameter("restaurantId");
        String email = req.getParameter("email");

        System.out.println("DEBUG idParam = " + idParam);
        System.out.println("DEBUG email = " + email);

        if (idParam == null || email == null || idParam.isBlank()) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        int restaurantId;
        try {
            restaurantId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        RestaurantDAO restaurantDAO = new RestaurantImpl();
        Restaurant restaurant = restaurantDAO.findById(restaurantId);
        if (restaurant == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // ===== SAVE SHARE LOG =====
        SharesDAO sharesDAO = new SharesImpl();
        sharesDAO.share(user.getUserId(), restaurantId, email);

        // ===== BUILD LINK =====
        String link =
                req.getScheme() + "://" +
                        req.getServerName() + ":" +
                        req.getServerPort() +
                        req.getContextPath() +
                        "/restaurant/detail?id=" + restaurantId;

        System.out.println("=== BEFORE SEND MAIL ===");

        // ===== SEND MAIL =====
        ShareEmailUtil.sendShareMail(
                email,
                user.getUsername(),
                restaurant.getName(),
                link
        );

        System.out.println("=== AFTER SEND MAIL ===");

        resp.sendRedirect(req.getContextPath() + "/home");
    }
}
