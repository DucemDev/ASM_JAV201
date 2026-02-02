package dao;

import entity.Users;
import jakarta.persistence.EntityManager;
import util.XJPA;

import java.util.List;

public class ReportImpl implements ReportDAO {

    @Override
    public List<Object[]> countLikesByRestaurant() {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql =
                    "SELECT r.name, COUNT(f) " +
                            "FROM Restaurant r LEFT JOIN Favorite f " +
                            "ON f.restaurant = r " +
                            "GROUP BY r.name";

            return em.createQuery(jpql, Object[].class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Users> findUsersByLikedRestaurant(String restaurantId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql =
                    "SELECT f.user " +
                            "FROM Favorite f " +
                            "WHERE f.restaurant.restaurantId = :rid";

            return em.createQuery(jpql, Users.class)
                    .setParameter("rid", Integer.parseInt(restaurantId))
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<String> findEmailsBySharedRestaurant(String restaurantId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql =
                    "SELECT s.recipientEmail " +
                            "FROM Shares s " +
                            "WHERE s.restaurant.restaurantId = :rid";

            return em.createQuery(jpql, String.class)
                    .setParameter("rid", Integer.parseInt(restaurantId))
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Object[]> findCommentsByRestaurant(String restaurantId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql =
                    "SELECT c.user.username, c.content, c.createdAt " +
                            "FROM Comment c " +
                            "WHERE c.restaurant.restaurantId = :rid " +
                            "ORDER BY c.createdAt DESC";

            return em.createQuery(jpql, Object[].class)
                    .setParameter("rid", Integer.parseInt(restaurantId))
                    .getResultList();
        } finally {
            em.close();
        }
    }
}
