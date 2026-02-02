package dao;

import entity.Users;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import util.JpaUtil;
import util.XJPA;

import java.util.List;

public class UsersImpl implements UsersDAO {

    @Override
    public Users findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Users.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Users> findAll() {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.createQuery("SELECT u FROM Users u", Users.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void create(Users user) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Users user) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(Integer id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();

            // 1️⃣ Xóa bảng phụ trước
            em.createQuery("DELETE FROM Favorite f WHERE f.user.userId = :id")
                    .setParameter("id", id)
                    .executeUpdate();

            em.createQuery("DELETE FROM Shares s WHERE s.user.userId = :id")
                    .setParameter("id", id)
                    .executeUpdate();

            em.createQuery("DELETE FROM Comment c WHERE c.user.userId = :id")
                    .setParameter("id", id)
                    .executeUpdate();

            em.createQuery("DELETE FROM ViewHistory v WHERE v.user.userId = :id")
                    .setParameter("id", id)
                    .executeUpdate();

            // 2️⃣ Xóa user
            Users u = em.find(Users.class, id);
            if (u != null) {
                em.remove(u);
            }

            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }



    @Override
    public Users findByEmail(String email) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT u FROM Users u WHERE u.email = :email";
            return em.createQuery(jpql, Users.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }@Override
    public void updateOtp(String email, String otp) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();

            int updated = em.createQuery(
                            "UPDATE Users u SET u.otpCode = :otp WHERE u.email = :email"
                    )
                    .setParameter("otp", otp)
                    .setParameter("email", email)
                    .executeUpdate();

            em.getTransaction().commit();
            em.clear(); // ⬅️ BẮT BUỘC

            System.out.println("OTP UPDATED ROW = " + updated);
            System.out.println("OTP SAVED TO DB = " + otp);

        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }



    @Override
    public void resetPassword(String email, String newPassword) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();

            int updated = em.createQuery(
                            "UPDATE Users u " +
                                    "SET u.password = :password, u.otpCode = NULL " +
                                    "WHERE u.email = :email"
                    )
                    .setParameter("password", newPassword)
                    .setParameter("email", email)
                    .executeUpdate();

            em.getTransaction().commit();

            System.out.println("RESET PASSWORD UPDATED ROW = " + updated);

        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public boolean verifyOtp(String email, String otp) {
        EntityManager em = XJPA.getEntityManager();
        try {
            Long count = em.createQuery(
                            "SELECT COUNT(u) FROM Users u " +
                                    "WHERE u.email = :email AND u.otpCode = :otp",
                            Long.class
                    )
                    .setParameter("email", email)
                    .setParameter("otp", otp)
                    .getSingleResult();

            return count == 1;
        } finally {
            em.close();
        }
    }

}