package controller;

import dao.RestaurantDAO;
import dao.RestaurantImpl;
import entity.Restaurant;
import entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;

@WebServlet("/admin/restaurant")
@MultipartConfig
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

            // 🔍 DEBUG CHUẨN
            System.out.println("====== EDIT RESTAURANT ======");
            System.out.println("ID        = " + id);
            System.out.println("POSTER URL= " + r.getPosterUrl());
            System.out.println("VIDEO URL = " + r.getVideoUrl());
            System.out.println("============================");

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

        Restaurant r;

        if (id != null) {
            r = dao.findById(id);
            if (r == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/restaurant");
                return;
            }
        } else {
            r = new Restaurant();
            r.setViewCount(0);
        }

        r.setName(req.getParameter("name"));

        String uploadRoot = req.getServletContext().getRealPath("/uploads");
        File posterDir = new File(uploadRoot, "posters");
        File videoDir = new File(uploadRoot, "videos");
        posterDir.mkdirs();
        videoDir.mkdirs();

        // ===== POSTER =====
        Part poster = req.getPart("posterFile");
        if (poster != null && poster.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + poster.getSubmittedFileName();
            poster.write(new File(posterDir, fileName).getAbsolutePath());
            r.setPosterUrl("uploads/posters/" + fileName);
        }

        // ===== VIDEO =====
        Part video = req.getPart("videoFile");
        if (video != null && video.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + video.getSubmittedFileName();
            video.write(new File(videoDir, fileName).getAbsolutePath());
            r.setVideoUrl("uploads/videos/" + fileName);
        }

        if (id == null) {
            dao.create(r);
        } else {
            dao.update(r);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/restaurant");
    }
}
