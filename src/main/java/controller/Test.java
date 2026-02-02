package controller;

import dao.UsersDAO;
import dao.UsersImpl;

public class Test {
    public static void main(String args[]) {
       UsersDAO userDAO = new UsersImpl();
       userDAO.findAll().forEach(System.out::println);
    }
}
