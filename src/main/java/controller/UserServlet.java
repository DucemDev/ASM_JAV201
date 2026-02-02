package controller;

import dao.UsersDAO;
import dao.UsersImpl;
import entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.apache.commons.beanutils.BeanUtils;

import java.io.IOException;
import java.util.List;

@WebServlet({
        "/admin/users/index",
        "/admin/users/edit/*",
        "/admin/users/create",
        "/admin/users/update",
        "/admin/users/delete/*",
        "/admin/users/reset"
})
public class UserServlet extends HttpServlet {

    private final UsersDAO dao = new UsersImpl();

    // ================= GET =================
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        // 🔐 CHECK ADMIN
        Users admin = (Users) req.getSession().getAttribute("authUser");
        if (admin == null || !admin.isRole()) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // ===== EDIT =====
        if (uri.contains("/edit/")) {
            Integer id = Integer.valueOf(req.getPathInfo().substring(1));
            Users user = dao.findById(id);
            req.setAttribute("form", user);
        }

        // ===== DELETE =====
        else if (uri.contains("/delete/")) {
            Integer id = Integer.valueOf(req.getPathInfo().substring(1));
            dao.delete(id);
            req.setAttribute("message", "Xóa người dùng thành công!");
        }

        // ===== RESET FORM =====
        else if (uri.contains("/reset")) {
            req.setAttribute("form", new Users());
        }

        // 🔥 LUÔN LOAD DATA
        List<Users> list = dao.findAll();
        req.setAttribute("items", list);

        req.getRequestDispatcher("/views/admin/user-manager.jsp")
                .forward(req, resp);
    }

    // ================= POST =================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Users admin = (Users) req.getSession().getAttribute("authUser");
        if (admin == null || !admin.isRole()) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String uri = req.getRequestURI();
        Users user = new Users();

        try {
            BeanUtils.populate(user, req.getParameterMap());

            if (uri.contains("/create")) {
                dao.create(user);
                req.setAttribute("message", "Thêm người dùng thành công!");
            }

            else if (uri.contains("/update")) {
                dao.update(user);
                req.setAttribute("message", "Cập nhật người dùng thành công!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi xử lý dữ liệu!");
        }

        List<Users> list = dao.findAll();
        req.setAttribute("items", list);

        req.getRequestDispatcher("/views/admin/user-manager.jsp")
                .forward(req, resp);
    }
}
