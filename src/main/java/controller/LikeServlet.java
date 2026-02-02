package controller;

import dao.FavoriteDAO;
import dao.FavoriteImpl;
import entity.Users;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;

@WebServlet("/like")
public class LikeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Users user = (Users) req.getSession().getAttribute("authUser");
        Integer userId = user.getUserId();

        Integer restaurantId =
                Integer.parseInt(req.getParameter("id"));

        FavoriteDAO dao = new FavoriteImpl();
        dao.like(userId, restaurantId);

        resp.sendRedirect(req.getHeader("Referer"));
    }
}




