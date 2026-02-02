package entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "Shares", schema = "dbo")
public class Shares {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ShareId")
    private String shareId;

    @Column(name = "RecipientEmail")
    private String recipientEmail;

    // 🔥 SỬA ĐÚNG TÊN CỘT
    @Column(name = "SharedAt")
    private LocalDateTime sharedAt;

    @ManyToOne
    @JoinColumn(name = "UserId")
    private Users user;

    @ManyToOne
    @JoinColumn(name = "RestaurantId")
    private Restaurant restaurant;
}
