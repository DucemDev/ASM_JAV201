package controller;

import dao.FavoriteDAO;
import dao.FavoriteImpl;
import entity.Favorite;
import entity.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/favorite")
public class FavoriteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Users user = (Users) req.getSession().getAttribute("authUser");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        FavoriteDAO dao = new FavoriteImpl();
        List<Favorite> list = dao.findLikedByUser(user.getUserId());

        req.setAttribute("list", list);
        req.setAttribute("contentPage", "/views/favorite.jsp");

        req.getRequestDispatcher("/views/layout.jsp")
                .forward(req, resp);
    }
}
