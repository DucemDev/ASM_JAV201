package dao;

import entity.Restaurant;
import entity.Users;
import entity.ViewHistory;
import jakarta.persistence.EntityManager;
import util.XJPA;

import java.time.LocalDateTime;
import java.util.List;

public class ViewHistoryImpl implements ViewHistoryDAO {

    @Override
    public void create(Integer userId, Integer restaurantId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();

            ViewHistory vh = new ViewHistory();
            vh.setUser(em.find(Users.class, userId));
            vh.setRestaurant(em.find(Restaurant.class, restaurantId));
            vh.setViewedAt(LocalDateTime.now());

            em.persist(vh);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    @Override
    public List<ViewHistory> findByUser(Integer userId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.createQuery(
                            """
                            SELECT v
                            FROM ViewHistory v
                            WHERE v.user.userId = :uid
                            ORDER BY v.viewedAt DESC
                            """,
                            ViewHistory.class
                    )
                    .setParameter("uid", userId)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}
