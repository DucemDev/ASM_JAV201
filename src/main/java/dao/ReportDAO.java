package dao;

import java.util.List;
import entity.Users;

public interface ReportDAO {
    List<Object[]> countLikesByRestaurant();
    List<Users> findUsersByLikedRestaurant(String restaurantId);
    List<String> findEmailsBySharedRestaurant(String restaurantId);
    List<Object[]> findCommentsByRestaurant(String restaurantId);
}