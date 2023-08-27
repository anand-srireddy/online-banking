package com.example.finalproject;

import java.sql.*;

public class UserDAO {

    private Connection connection;

    public Users checkLogin(String username, String password) throws SQLException,
            ClassNotFoundException {
        initializeDB();
        String sql = "SELECT * FROM users WHERE username = ? and password = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, username);
        statement.setString(2, password);

        ResultSet result = statement.executeQuery();

        Users user = null;

        if (result.next()) {
            user = new Users();
            user.setFirstname(result.getString("firstname"));
            user.setAccountNumber(result.getInt("accountNumber"));
        }
        connection.close();
        return user;
    }

    public ResultSet findAccountRecord(int acc) throws SQLException, ClassNotFoundException {
        initializeDB();
        String sql = "SELECT * FROM account WHERE accountNumber = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, acc);
        ResultSet result = statement.executeQuery();
        return result;
    }

    public void initializeDB() throws ClassNotFoundException, SQLException {
        String jdbcURL = "jdbc:mysql://localhost/OnlineBanking";
        String dbUser = "root";
        String dbPassword = "root";

        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
    }
}
