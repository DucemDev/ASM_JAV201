package dao;

import entity.Restaurant;
import java.util.List;

public interface RestaurantDAO {

    Restaurant findById(Integer id);

    List<Restaurant> findAll();

    void create(Restaurant restaurant);

    void update(Restaurant restaurant);

    void delete(Integer id);

    void increaseView(Integer id);

    List<Restaurant> searchByName(String keyword);

    List<Restaurant> findTop6ByView();

    List<Restaurant> findPage(int page, int size);
}

