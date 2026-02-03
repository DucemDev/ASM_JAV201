package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.ShareEmailUtil;

@WebServlet("/test-mail")
public class TestMailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {
        System.out.println("=== TEST MAIL SERVLET HIT ===");

        ShareEmailUtil.sendShareMail(
                "your_email@gmail.com",
                "TEST USER",
                "TEST RESTAURANT",
                "https://google.com"
        );
    }
}
