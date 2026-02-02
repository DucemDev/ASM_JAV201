package dao;

import entity.Users;
import java.util.List;

public interface UsersDAO {

    Users findById(Integer id);
    List<Users> findAll();
    void create(Users user);
    void update(Users user);
    void delete(Integer id);

    Users findByEmail(String email);

    void updateOtp(String email, String otp);
    void resetPassword(String email, String newPassword);
    boolean verifyOtp(String email, String otp);
}
