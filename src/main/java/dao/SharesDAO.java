package dao;

public interface SharesDAO {
    void share(Integer userId, Integer restaurantId, String email);
}

