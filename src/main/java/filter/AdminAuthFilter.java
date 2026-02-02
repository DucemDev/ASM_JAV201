package filter;

import entity.Users;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;
@WebFilter("/views/admin/*")
public class AdminAuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        Users authUser = (session != null)
                ? (Users) session.getAttribute("authUser")
                : null;

        // ❌ CHƯA LOGIN
        if (authUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // ❌ KHÔNG PHẢI ADMIN
        if (!authUser.isRole()) {
            resp.sendRedirect(req.getContextPath() + "/403.jsp");
            return;
        }

        // ✅ OK
        chain.doFilter(request, response);
    }
}

