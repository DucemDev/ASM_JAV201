package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/page/*")
public class IndexAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.endsWith("/reports")) {
            req.getRequestDispatcher("/views/admin/reports.jsp").forward(req, resp);

        } else if (uri.endsWith("/restaurant")) {
            req.getRequestDispatcher("/views/admin/restaurant-manager.jsp").forward(req, resp);

        } else if (uri.endsWith("/user")) {
            req.getRequestDispatcher("/views/admin/user-manager.jsp").forward(req, resp);

        } else {
            // fallback: vào /page → index admin
            req.getRequestDispatcher("/views/admin/index_admin.jsp").forward(req, resp);
        }
    }
}


