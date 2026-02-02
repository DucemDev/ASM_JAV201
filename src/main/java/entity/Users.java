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
@Table(name = "Users", schema = "dbo")
public class Users {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "UserId")
    private Integer  userId;

    @Column(name = "UserName")
    private String username;

    @Column(name = "Password")
    private String password;

    @Column(name = "Email",  unique = true)
    private String email;

    @Column(name = "Role")
    private boolean role;

    @Column(name = "OtpCode")
    private String otpCode;

    @Column(name = "Status")
    private boolean status;

    @OneToMany(mappedBy = "user")
    private List<Shares> shares;

    @OneToMany(mappedBy = "user")
    private List<Favorite> favorites;

    @OneToMany(mappedBy = "user")
    private List<ViewHistory> viewHistory;

    @OneToMany(mappedBy = "user")
    private List<Comment> comments;
}
