package model.dao;

import java.sql.*;
import java.util.*;

import model.bean.user;

import config.DBconnect;

public class userDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	public ArrayList<user> getUserList() {
		ArrayList<user> list = new ArrayList<>();
		String query = "SELECT * FROM users";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new user(rs.getString("id"), rs.getString("username"), rs.getString("password"),
						rs.getString("email"), rs.getString("phone"), rs.getString("name")));
			}
		} catch (Exception e) {

		}

		return list;
	}

	public user getUserByID(String id) {
		user u = null;
		String query = "SELECT * FROM users WHERE id = ?";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if (rs.next()) {
				u = new user(rs.getString("id"), rs.getString("username"), rs.getString("password"),
						rs.getString("email"), rs.getString("phone"), rs.getString("name"));
			}
		} catch (Exception e) {

		}

		return u;
	}

	public user login(String username, String password) {
		user u = null;
		String query = "SELECT * FROM users WHERE username = ? AND password = ?";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, username);
			ps.setString(2, password);
			rs = ps.executeQuery();
			if (rs.next()) {
				u = new user(rs.getString("id"), rs.getString("username"), rs.getString("password"),
						rs.getString("email"), rs.getString("phone"), rs.getString("name"));
			}
		} catch (Exception e) {

		}

		return u;
	}

	public ArrayList<user> getUserListBySearch(String search_type, String searchtxt) {
		ArrayList<user> list = new ArrayList<>();
		String query = "SELECT * FROM users WHERE 1 = 1";
		if (search_type != null && searchtxt != null) {
			query += " AND " + search_type + " LIKE ?";
		}
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			if (search_type != null && searchtxt != null) {
				ps.setString(1, "%" + searchtxt + "%");
			}
			rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new user(rs.getString("id"), rs.getString("username"), rs.getString("password"),
						rs.getString("email"), rs.getString("phone"), rs.getString("name")));
			}
		} catch (Exception e) {

		}

		return list;
	}

	public user getUserByUsername(String username) {
		user u = null;
		String query = "SELECT * FROM users WHERE username = ?";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, username);
			rs = ps.executeQuery();
			if (rs.next()) {
				u = new user(rs.getString("id"), rs.getString("username"), rs.getString("password"),
						rs.getString("email"), rs.getString("phone"), rs.getString("name"));
			}
		} catch (Exception e) {

		}

		return u;
	}

	public boolean addUser(String id, String username, String password, String email, String phone, String name) {
		String query = "INSERT INTO users (id, username, password, email, phone, name) VALUES (?, ?, ?, ?, ?, ?)";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, id);
			ps.setString(2, username);
			ps.setString(3, password);
			ps.setString(4, email);
			ps.setString(5, phone);
			ps.setString(6, name);
			if (ps.executeUpdate() > 0) {
				return true;
			}
		} catch (Exception e) {

		}

		return false;
	}

	public boolean updateUser(String id, String username, String password, String email, String phone, String name) {
		String query = "UPDATE users SET username = ?, password = ?, email = ?, phone = ?, name = ? WHERE id = ?";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, username);
			ps.setString(2, password);
			ps.setString(3, email);
			ps.setString(4, phone);
			ps.setString(5, name);
			ps.setString(6, id);
			if (ps.executeUpdate() > 0) {
				return true;
			}
		} catch (Exception e) {

		}

		return false;
	}

	public boolean deleteUser(String id) {
		String query = "DELETE FROM users WHERE id = ?";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, id);
			if (ps.executeUpdate() > 0) {
				return true;
			}
		} catch (Exception e) {

		}

		return false;
	}

	public boolean checkEmailExists(String email, String currentUserId) {
		String query = "SELECT COUNT(*) FROM users WHERE email = ? AND id != ?";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, email);
			ps.setString(2, currentUserId);
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
		return false;
	}

	public boolean checkPhoneExists(String phone, String currentUserId) {
		String query = "SELECT COUNT(*) FROM users WHERE phone = ? AND id != ?";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, phone);
			ps.setString(2, currentUserId);
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
		return false;
	}

	public boolean checkEmailExists(String email) {
		String query = "SELECT COUNT(*) FROM users WHERE email = ?";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, email);
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
		return false;
	}

	public boolean checkPhoneExists(String phone) {
		String query = "SELECT COUNT(*) FROM users WHERE phone = ?";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, phone);
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
		return false;
	}

	public boolean addUserWithAutoId(String username, String password, String email, String phone, String name) {
		String query = "INSERT INTO users (username, password, email, phone, name) VALUES (?, ?, ?, ?, ?)";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, username);
			ps.setString(2, password);
			ps.setString(3, email);
			ps.setString(4, phone);
			ps.setString(5, name);
			if (ps.executeUpdate() > 0) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
		return false;
	}

	private void closeResources() {
		try {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
