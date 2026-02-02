package entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "Restaurant")
public class Restaurant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "RestaurantId")
    private Integer restaurantId;


    @Column(name = "Name")
    private String name;

    @Column(name = "PosterUrl")
    private String posterUrl;

    @Column(name = "VideoUrl")
    private String videoUrl;

    @Column(name = "ViewCount")
    private int viewCount;

    @OneToMany(mappedBy = "restaurant")
    private List<Favorite> favorites;

    @OneToMany(mappedBy = "restaurant")
    private List<Shares> shares;

    @OneToMany(mappedBy = "restaurant")
    private List<ViewHistory> viewHistory;
}
