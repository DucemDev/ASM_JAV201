package controller;

import dao.RestaurantDAO;
import dao.RestaurantImpl;
import entity.Restaurant;
import entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet({
        "/admin/restaurants",
        "/admin/restaurants/edit/*",
        "/admin/restaurants/delete/*",
        "/admin/restaurants/reset"
})
public class AdminRestaurantServlet extends HttpServlet {

    private final RestaurantDAO dao = new RestaurantImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 🔐 CHECK ADMIN
        Users admin = (Users) req.getSession().getAttribute("authUser");
        if (admin == null || !admin.isRole()) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String uri = req.getRequestURI();

        // ===== EDIT =====
        if (uri.contains("/edit/")) {
            Integer id = Integer.parseInt(req.getPathInfo().substring(1));
            req.setAttribute("form", dao.findById(id));
        }

        // ===== DELETE =====
        else if (uri.contains("/delete/")) {
            Integer id = Integer.parseInt(req.getPathInfo().substring(1));
            dao.delete(id);
        }

        // ===== RESET =====
        else if (uri.contains("/reset")) {
            req.setAttribute("form", new Restaurant());
        }

        // 🔥 LOAD DATA
        req.setAttribute("items", dao.findAll());

        // 🔥 QUAN TRỌNG NHẤT
        req.getRequestDispatcher("/views/admin/restaurant-manager.jsp")
                .forward(req, resp);

    }
}

