package dao;

import entity.ViewHistory;
import java.util.List;

public interface ViewHistoryDAO {

    void create(Integer userId, Integer restaurantId);

    List<ViewHistory> findByUser(Integer userId);
}
