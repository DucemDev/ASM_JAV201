package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
@WebServlet("/share/form")
public class ShareFormServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");
        if (idParam == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        int restaurantId = Integer.parseInt(idParam);

        // 🔥 BẮT BUỘC
        req.setAttribute("restaurantId", restaurantId);

        // 🔥 DEBUG
        System.out.println("FORM restaurantId = " + restaurantId);

        req.setAttribute("contentPage", "/views/share.jsp");
        req.getRequestDispatcher("/views/layout.jsp").forward(req, resp);
    }
}

