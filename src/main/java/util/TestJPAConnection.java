package util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class TestJPAConnection {

    public static void main(String[] args) {

        String DBNAME="RestaurantDB";
        System.out.println("=== START JPA CONNECTION TEST ===");

        try {
            EntityManagerFactory emf =
                    Persistence.createEntityManagerFactory(DBNAME);



            EntityManager em = emf.createEntityManager();


            em.close();
            emf.close();

            System.out.println("Kết nối thành công với DB: "+DBNAME);

        } catch (Exception e) {
            System.out.println("Kết nối thất bại với DB: "+DBNAME);
            e.printStackTrace();
        }
    }
}
