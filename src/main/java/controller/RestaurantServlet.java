package controller;

import dao.RestaurantDAO;
import dao.RestaurantImpl;
import entity.Restaurant;
import entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/restaurant")
public class RestaurantServlet extends HttpServlet {

    private final RestaurantDAO dao = new RestaurantImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Users admin = (Users) req.getSession().getAttribute("authUser");
        if (admin == null || !admin.isRole()) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // ===== DELETE =====
        if (req.getParameter("delete") != null) {
            Integer id = Integer.parseInt(req.getParameter("delete"));
            dao.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/restaurant");
            return;
        }

        // ===== EDIT =====
        if (req.getParameter("id") != null) {
            Integer id = Integer.parseInt(req.getParameter("id"));
            Restaurant r = dao.findById(id);

            System.out.println("=== EDIT RESTAURANT ===");
            System.out.println("ID    = " + r.getRestaurantId());
            System.out.println("NAME  = " + r.getName());
            System.out.println("POSTER= " + r.getPosterUrl());
            System.out.println("VIDEO = " + r.getVideoUrl());
            System.out.println("======================");

            req.setAttribute("form", r);
        } else {
            req.setAttribute("form", new Restaurant());
        }

        req.setAttribute("items", dao.findAll());
        req.getRequestDispatcher("/views/admin/restaurant-manager.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Integer id = (req.getParameter("id") != null && !req.getParameter("id").isEmpty())
                ? Integer.parseInt(req.getParameter("id"))
                : null;

        Restaurant r = (id != null) ? dao.findById(id) : new Restaurant();
        if (r == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/restaurant");
            return;
        }

        if (id == null) r.setViewCount(0);

        r.setName(req.getParameter("name"));
        r.setPosterUrl(req.getParameter("posterUrl"));
        r.setVideoUrl(req.getParameter("videoUrl"));

        System.out.println("=== SAVE RESTAURANT ===");
        System.out.println("NAME  = " + r.getName());
        System.out.println("POSTER= " + r.getPosterUrl());
        System.out.println("VIDEO = " + r.getVideoUrl());
        System.out.println("======================");

        if (id == null) dao.create(r);
        else dao.update(r);

        resp.sendRedirect(req.getContextPath() + "/admin/restaurant");
    }
}
