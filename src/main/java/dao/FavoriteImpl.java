package dao;

import entity.Favorite;
import entity.Restaurant;
import entity.Users;
import jakarta.persistence.EntityManager;
import util.XJPA;

import java.time.LocalDateTime;
import java.util.List;

public class FavoriteImpl implements FavoriteDAO {

    @Override
    public void like(Integer userId, Integer restaurantId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();

            // nếu đã like rồi thì không insert nữa
            if (isLiked(userId, restaurantId)) {
                em.getTransaction().rollback();
                return;
            }

            Favorite f = new Favorite();
            f.setUser(em.find(Users.class, userId));
            f.setRestaurant(em.find(Restaurant.class, restaurantId));
            f.setLikedAt(LocalDateTime.now());

            em.persist(f);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void unlike(Integer userId, Integer restaurantId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();

            em.createQuery(
                            "DELETE FROM Favorite f " +
                                    "WHERE f.user.userId = :uid " +
                                    "AND f.restaurant.restaurantId = :rid"
                    )
                    .setParameter("uid", userId)
                    .setParameter("rid", restaurantId)
                    .executeUpdate();

            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean isLiked(Integer userId, Integer restaurantId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            Long count = em.createQuery(
                            "SELECT COUNT(f) FROM Favorite f " +
                                    "WHERE f.user.userId = :uid " +
                                    "AND f.restaurant.restaurantId = :rid",
                            Long.class
                    )
                    .setParameter("uid", userId)
                    .setParameter("rid", restaurantId)
                    .getSingleResult();

            return count > 0;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Favorite> findLikedByUser(Integer userId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT f FROM Favorite f " +
                                    "WHERE f.user.userId = :uid " +
                                    "ORDER BY f.likedAt DESC",
                            Favorite.class
                    )
                    .setParameter("uid", userId)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}
