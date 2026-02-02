package controller;

import dao.UsersDAO;
import dao.UsersImpl;
import entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("usernameip");
        String password = req.getParameter("passwordip");
        String email = req.getParameter("emailip");

        UsersDAO usersDAO = new UsersImpl();

        if (username == null || username.trim().isEmpty()) {
            req.setAttribute("message", "Vui lòng nhập tên tài khoản");
            req.setAttribute("showRegister", true);
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        if (password == null || password.trim().isEmpty()) {
            req.setAttribute("message", "Vui lòng nhập mật khẩu");
            req.setAttribute("showRegister", true);
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("message", "Vui lòng nhập email");
            req.setAttribute("showRegister", true);
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        if (usersDAO.findByEmail(email) != null) {
            req.setAttribute("message", "Email đã tồn tại");
            req.setAttribute("showRegister", true);
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        Users user = new Users();

        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setRole(false);
        user.setStatus(true);

        usersDAO.create(user);

        resp.sendRedirect(req.getContextPath() + "/login");
    }
}
