package dao;

import entity.Restaurant;
import jakarta.persistence.EntityManager;
import util.XJPA;

import java.util.List;

public class RestaurantImpl implements RestaurantDAO {

    // ===== FIND BY ID =====
    @Override
    public Restaurant findById(Integer id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.find(Restaurant.class, id);
        } finally {
            em.close();
        }
    }

    // ===== FIND ALL =====
    @Override
    public List<Restaurant> findAll() {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT r FROM Restaurant r",
                    Restaurant.class
            ).getResultList();
        } finally {
            em.close();
        }
    }

    // ===== CREATE =====
    @Override
    public void create(Restaurant restaurant) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(restaurant);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    // ===== UPDATE =====
    @Override
    public void update(Restaurant restaurant) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(restaurant);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    // ===== DELETE =====
    @Override
    public void delete(Integer id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();

            em.createQuery("DELETE FROM Favorite f WHERE f.restaurant.restaurantId = :id")
                    .setParameter("id", id)
                    .executeUpdate();

            em.createQuery("DELETE FROM Shares s WHERE s.restaurant.restaurantId = :id")
                    .setParameter("id", id)
                    .executeUpdate();

            em.createQuery("DELETE FROM Comment c WHERE c.restaurant.restaurantId = :id")
                    .setParameter("id", id)
                    .executeUpdate();

            em.createQuery("DELETE FROM ViewHistory v WHERE v.restaurant.restaurantId = :id")
                    .setParameter("id", id)
                    .executeUpdate();

            Restaurant r = em.find(Restaurant.class, id);
            if (r != null) {
                em.remove(r);
            }

            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }


    // ===== INCREASE VIEW =====
    @Override
    public void increaseView(Integer id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            Restaurant r = em.find(Restaurant.class, id);
            if (r != null) {
                r.setViewCount(r.getViewCount() + 1);
                em.merge(r);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    // ===== SEARCH BY NAME =====
    @Override
    public List<Restaurant> searchByName(String keyword) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT r FROM Restaurant r WHERE r.name LIKE :kw",
                            Restaurant.class
                    )
                    .setParameter("kw", "%" + keyword + "%")
                    .getResultList();
        } finally {
            em.close();
        }
    }

    // ===== TOP 6 VIEW =====
    @Override
    public List<Restaurant> findTop6ByView() {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT r FROM Restaurant r ORDER BY r.viewCount DESC",
                            Restaurant.class
                    )
                    .setMaxResults(6)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    // ===== PAGINATION =====
    @Override
    public List<Restaurant> findPage(int page, int size) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT r FROM Restaurant r ORDER BY r.restaurantId",
                            Restaurant.class
                    )
                    .setFirstResult((page - 1) * size)
                    .setMaxResults(size)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}
