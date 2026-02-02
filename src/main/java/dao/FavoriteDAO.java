package dao;

import entity.Favorite;
import java.util.List;

public interface FavoriteDAO {

    void like(Integer userId, Integer restaurantId);

    void unlike(Integer userId, Integer restaurantId);

    boolean isLiked(Integer userId, Integer restaurantId);

    // 🔥 BẠN ĐANG THIẾU METHOD NÀY TRONG IMPL
    List<Favorite> findLikedByUser(Integer userId);
}
