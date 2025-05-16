package config;

import java.sql.*;

public class DBconnect {
	private static String url = "jdbc:mysql://localhost:3306/dulieu";
	public Connection getConnection() throws Exception {
		
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(url,"root","");
			return conn;
		}
	}