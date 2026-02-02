package util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class XJPA {
    private static final EntityManagerFactory factory =
            Persistence.createEntityManagerFactory("RestaurantDB");

    public static EntityManager getEntityManager() {
        return factory.createEntityManager();
    }
}
