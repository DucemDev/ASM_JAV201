package util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {

    public static void sendOtp(String toEmail, String otp) {

        final String fromEmail = "anh.huynhleduc@gmail.com";
        final String password = "oslc bvel axgh iunz"; // Gmail App Password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(fromEmail, password);
                    }
                });

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail, "Owl Review"));
            msg.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));
            msg.setSubject("Mã OTP khôi phục mật khẩu");
            msg.setText("Mã OTP của bạn là: " + otp);

            Transport.send(msg);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
