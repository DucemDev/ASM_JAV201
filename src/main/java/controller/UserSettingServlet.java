package controller;

import dao.UsersImpl;
import entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/setting")
public class UserSettingServlet extends HttpServlet {

    private final UsersImpl userDao = new UsersImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        Users authUser = (session != null)
                ? (Users) session.getAttribute("authUser")
                : null;

        // 🔐 CHƯA LOGIN → ĐẨY QUA LOGIN
        if (authUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");

        // 🚪 LOGOUT
        if ("logout".equals(action)) {
            session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // ✅ HIỂN THỊ SETTING QUA LAYOUT
        req.setAttribute("contentPage", "/views/user-setting.jsp");
        req.getRequestDispatcher("/views/layout.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        Users authUser = (session != null)
                ? (Users) session.getAttribute("authUser")
                : null;

        if (authUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");

        // 🔑 ĐỔI MẬT KHẨU
        if ("changePassword".equals(action)) {

            String oldPass = req.getParameter("oldPassword");
            String newPass = req.getParameter("newPassword");

            if (!authUser.getPassword().equals(oldPass)) {
                req.setAttribute("error", "Mật khẩu cũ không đúng");
            } else {
                userDao.resetPassword(authUser.getEmail(), newPass);

                authUser.setPassword(newPass);
                session.setAttribute("authUser", authUser);

                req.setAttribute("message", "Đổi mật khẩu thành công");
            }
        }

        // ✏️ CẬP NHẬT THÔNG TIN
        if ("updateInfo".equals(action)) {
            String username = req.getParameter("username");

            authUser.setUsername(username);
            userDao.update(authUser);

            session.setAttribute("authUser", authUser);
            req.setAttribute("message", "Cập nhật thông tin thành công");
        }

        // ✅ LUÔN QUAY LẠI LAYOUT
        req.setAttribute("contentPage", "/views/user-setting.jsp");
        req.getRequestDispatcher("/views/layout.jsp")
                .forward(req, resp);
    }
}
