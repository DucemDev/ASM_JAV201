package util;

import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.util.Properties;

public class ShareEmailUtil {

    private static final String FROM_EMAIL = "anh.huynhleduc@gmail.com";
    private static final String PASSWORD = "oslc bvel axgh iunz"; // Gmail App Password

    public static void sendShareMail(String toEmail,
                                     String senderName,
                                     String restaurantName,
                                     String link) {

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
                new Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
                    }
                });

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(FROM_EMAIL, "Owl Review"));
            msg.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail)
            );

            msg.setSubject("📤 " + senderName + " đã chia sẻ một quán ăn với bạn");

            String content =
                    "Xin chào,\n\n"
                            + senderName + " đã chia sẻ với bạn một quán ăn thú vị trên Owl Review.\n\n"
                            + "🍽️ Quán ăn: " + restaurantName + "\n"
                            + "🔗 Xem chi tiết tại đây:\n"
                            + link + "\n\n"
                            + "— Owl Review";

            msg.setText(content);

            Transport.send(msg);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
