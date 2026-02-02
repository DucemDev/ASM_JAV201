package dao;

import entity.Restaurant;
import entity.Shares;
import entity.Users;
import jakarta.persistence.EntityManager;
import util.XJPA;

import java.time.LocalDateTime;

public class SharesImpl implements SharesDAO {

    @Override
    public void share(Integer userId, Integer restaurantId, String email) {

        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();

            Users user = em.find(Users.class, userId);
            Restaurant restaurant = em.find(Restaurant.class, restaurantId);

            if (user == null || restaurant == null) {
                throw new RuntimeException("User hoặc Restaurant không tồn tại");
            }

            Shares s = new Shares();
            // ❗ ShareId trong DB là INT IDENTITY → KHÔNG set tay
            s.setUser(user);
            s.setRestaurant(restaurant);
            s.setRecipientEmail(email);
            s.setSharedAt(LocalDateTime.now());

            em.persist(s);
            em.getTransaction().commit();

        } finally {
            em.close();
        }
    }
}
