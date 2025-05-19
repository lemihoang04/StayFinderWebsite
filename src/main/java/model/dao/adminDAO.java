package model.dao;

import java.sql.*;
import java.util.*;

import model.bean.admin;

import config.DBconnect;
public class adminDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	public admin login_admin(String username, String password) {
		admin a = null;
		String query = "SELECT * FROM admins WHERE username = ? AND password = ?";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, username);
			ps.setString(2, password);
			rs = ps.executeQuery();
			if (rs.next()) {
				a = new admin(rs.getString("username"), rs.getString("password"));
			}
		} catch (Exception e) {

		}

		return a;
	}
}
