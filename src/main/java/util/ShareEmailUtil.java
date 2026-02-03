package util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class ShareEmailUtil {

    private static final String FROM_EMAIL = "anh.huynhleduc@gmail.com";
    private static final String PASSWORD = "oslc bvel axgh iunz";

    public static void sendShareMail(
            String toEmail,
            String senderName,
            String restaurantName,
            String link) {

        System.out.println("📨 START SENDING MAIL...");
        System.out.println("TO = " + toEmail);

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
                    }
                });

        session.setDebug(true);

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(FROM_EMAIL, "Owl Review"));
            msg.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));

            msg.setSubject("📤 " + senderName + " đã chia sẻ quán ăn với bạn");

            String html = """
                <h2>%s</h2>
                <p>%s đã chia sẻ quán ăn với bạn</p>
                <a href="%s">Xem chi tiết</a>
                """.formatted(restaurantName, senderName, link);

            msg.setContent(html, "text/html; charset=UTF-8");

            Transport.send(msg);

            System.out.println("✅ MAIL SENT SUCCESS");

        } catch (Exception e) {
            System.out.println("❌ SEND MAIL FAILED");
            e.printStackTrace();
        }
    }
}
