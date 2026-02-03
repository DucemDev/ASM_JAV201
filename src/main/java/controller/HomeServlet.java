package controller;

import dao.RestaurantDAO;
import dao.RestaurantImpl;
import dao.FavoriteDAO;
import dao.FavoriteImpl;
import entity.Restaurant;
import entity.Users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet({"/", "/home"})
public class HomeServlet extends HttpServlet {

    private final RestaurantDAO dao = new RestaurantImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int page = 1;
        int size = 6;

        // ===== PAGE =====
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException ignored) {}
        }

        // ===== PARAM =====
        String keyword = req.getParameter("keyword");
        String sort = req.getParameter("sort");

        List<Restaurant> all;

        // ===== 1️⃣ SEARCH ƯU TIÊN =====
        if (keyword != null && !keyword.trim().isEmpty()) {
            all = dao.searchByName(keyword.trim());
            req.setAttribute("keyword", keyword);
        }

        // ===== 2️⃣ SORT =====
        else if (sort != null && !sort.isBlank()) {
            switch (sort) {
                case "view-desc":
                    all = dao.findTop6ByView(); // view cao → thấp
                    break;

                case "view-asc":
                    all = dao.findAll()
                            .stream()
                            .sorted((a, b) -> a.getViewCount() - b.getViewCount())
                            .toList();
                    break;

                case "random":
                    all = dao.findAll();
                    java.util.Collections.shuffle(all);
                    break;

                default:
                    all = dao.findAll();
            }
            req.setAttribute("sort", sort);
        }

        // ===== 3️⃣ DEFAULT =====
        else {
            all = dao.findAll();
        }

        // ===== PAGINATION =====
        int totalItems = all.size();
        int totalPages = (int) Math.ceil((double) totalItems / size);

        int fromIndex = (page - 1) * size;
        int toIndex = Math.min(fromIndex + size, totalItems);

        List<Restaurant> list = totalItems > 0
                ? all.subList(fromIndex, toIndex)
                : all;

        // ===== LIKE MAP (TIM ❤️) =====
        HttpSession session = req.getSession(false);
        Users user = (session != null)
                ? (Users) session.getAttribute("authUser")
                : null;

        Map<Integer, Boolean> likedMap = new HashMap<>();

        if (user != null) {
            FavoriteDAO favDao = new FavoriteImpl();
            for (Restaurant r : list) {
                boolean liked =
                        favDao.isLiked(user.getUserId(), r.getRestaurantId());
                likedMap.put(r.getRestaurantId(), liked);
            }
        }

        // ===== SEND TO JSP =====
        req.setAttribute("list", list);
        req.setAttribute("likedMap", likedMap);
        req.setAttribute("page", page);
        req.setAttribute("totalPages", totalPages);

        req.setAttribute("contentPage", "home-content.jsp");
        req.getRequestDispatcher("/views/layout.jsp")
                .forward(req, resp);
    }
}
