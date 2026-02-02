package controller;

import dao.UsersDAO;
import dao.UsersImpl;
import entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet({"/login", "/Login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("emailip");
        String password = req.getParameter("passwordip");

        UsersDAO usersDAO = new UsersImpl();
        Users user = usersDAO.findByEmail(email);


        if (user == null) {
            req.setAttribute("message", "Email không tồn tại");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }


        if (!password.equals(user.getPassword())) {
            req.setAttribute("message", "Sai mật khẩu");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }


        if (!user.isStatus()) {
            req.setAttribute("message", "Tài khoản đã bị khóa");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }


        HttpSession session = req.getSession();
        session.setAttribute("authUser", user);


        // Sau khi login → ai cũng về HOME
        resp.sendRedirect(req.getContextPath() + "/home");



    }
}


