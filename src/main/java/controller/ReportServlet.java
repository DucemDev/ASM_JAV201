package controller;

import dao.ReportDAO;
import dao.ReportImpl;
import dao.RestaurantDAO;
import dao.RestaurantImpl;
import entity.Restaurant;
import entity.Users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/reports")
public class ReportServlet extends HttpServlet {

    private final ReportDAO reportDao = new ReportImpl();
    private final RestaurantDAO restDao = new RestaurantImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ===== AUTH ADMIN =====
        Users admin = (Users) req.getSession().getAttribute("authUser");
        if (admin == null || !admin.isRole()) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // ===== 1. LOAD TẤT CẢ NHÀ HÀNG =====
        List<Restaurant> allRestaurants = restDao.findAll();
        req.setAttribute("allRestaurants",
                allRestaurants != null ? allRestaurants : new ArrayList<>());

        // ===== 2. LẤY restaurantId =====
        String restaurantIdParam = req.getParameter("restaurantId");

        if (restaurantIdParam != null && !restaurantIdParam.isBlank()) {
            try {
                Integer restaurantId = Integer.parseInt(restaurantIdParam);

                // ===== 3. LOAD RESTAURANT =====
                Restaurant selected = restDao.findById(restaurantId);
                if (selected != null) {
                    req.setAttribute("selectedRest", selected);

                    // ===== 4. LOAD REPORT DATA =====
                    List<?> likedUsers =
                            reportDao.findUsersByLikedRestaurant(restaurantIdParam);

                    List<?> sharedEmails =
                            reportDao.findEmailsBySharedRestaurant(restaurantIdParam);

                    List<?> comments =
                            reportDao.findCommentsByRestaurant(restaurantIdParam);

                    // ===== 5. SET DATA =====
                    req.setAttribute("likedUsers",
                            likedUsers != null ? likedUsers : new ArrayList<>());

                    req.setAttribute("sharedEmails",
                            sharedEmails != null ? sharedEmails : new ArrayList<>());

                    req.setAttribute("comments",
                            comments != null ? comments : new ArrayList<>());

                    // ===== 6. COUNT =====
                    req.setAttribute("countLikes",
                            likedUsers != null ? likedUsers.size() : 0);

                    req.setAttribute("countShares",
                            sharedEmails != null ? sharedEmails.size() : 0);

                    req.setAttribute("countComms",
                            comments != null ? comments.size() : 0);
                }

            } catch (NumberFormatException e) {
                // id không phải số → bỏ qua
                resp.sendRedirect(req.getContextPath() + "/admin/reports");
                return;
            }
        }

        // ===== 7. FORWARD =====
        req.getRequestDispatcher("/views/admin/reports.jsp")
                .forward(req, resp);
    }
}
