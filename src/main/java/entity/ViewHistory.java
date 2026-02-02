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
@Table(name = "ViewHistory", schema = "dbo")
public class ViewHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "HistoryId")
    private Integer historyId;   // 🔥 INTEGER – DB sinh

    @Column(name = "ViewedAt")
    private LocalDateTime viewedAt;

    @ManyToOne
    @JoinColumn(name = "UserId")
    private Users user;

    @ManyToOne
    @JoinColumn(name = "RestaurantId")
    private Restaurant restaurant;

    @Transient
    private String viewedAtFormatted;
}
