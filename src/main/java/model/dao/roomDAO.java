package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import model.bean.room;
import config.DBconnect;

public class roomDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	public ArrayList<room> getRoomList() {
		ArrayList<room> list = new ArrayList<>();
		String query = "SELECT * FROM rooms";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new room(rs.getString("id"), rs.getString("title"), rs.getString("description"),
						rs.getString("room_type"),
						rs.getDouble("price"), rs.getDouble("area"), rs.getString("address"), rs.getString("city"),
						rs.getString("district"), rs.getString("images"), rs.getString("created_at"),
						rs.getString("expiry_date"), rs.getString("status"), rs.getString("user_id")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
		return list;
	}

	public ArrayList<room> getRoomListBySearch(String search_type, String searchtxt) {
		ArrayList<room> list = new ArrayList<>();
		String query = "SELECT * FROM rooms WHERE 1 = 1";
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
				list.add(new room(rs.getString("id"), rs.getString("title"), rs.getString("description"),
						rs.getString("room_type"),
						rs.getDouble("price"), rs.getDouble("area"), rs.getString("address"), rs.getString("city"),
						rs.getString("district"), rs.getString("images"), rs.getString("created_at"),
						rs.getString("expiry_date"), rs.getString("status"), rs.getString("user_id")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
		return list;
	}

	public ArrayList<room> getAdvancedSearchResults(String city, String district, Double minPrice, Double maxPrice,
			Double minArea, Double maxArea, String searchtxt) {
		ArrayList<room> list = new ArrayList<>();
		StringBuilder queryBuilder = new StringBuilder("SELECT * FROM rooms WHERE 1=1");
		ArrayList<Object> parameters = new ArrayList<>();

		// Add search text filter if provided
		if (searchtxt != null && !searchtxt.trim().isEmpty()) {
			queryBuilder.append(" AND title LIKE ?");
			parameters.add("%" + searchtxt + "%");
		}

		// Add city filter if provided
		if (city != null && !city.isEmpty()) {
			queryBuilder.append(" AND city = ?");
			parameters.add(city);
		}

		// Add district filter if provided
		if (district != null && !district.isEmpty()) {
			queryBuilder.append(" AND district = ?");
			parameters.add(district);
		}

		// Add price range filter if provided
		if (minPrice != null) {
			queryBuilder.append(" AND price >= ?");
			parameters.add(minPrice);
		}

		if (maxPrice != null) {
			queryBuilder.append(" AND price <= ?");
			parameters.add(maxPrice);
		}

		// Add area range filter if provided
		if (minArea != null) {
			queryBuilder.append(" AND area >= ?");
			parameters.add(minArea);
		}

		if (maxArea != null) {
			queryBuilder.append(" AND area <= ?");
			parameters.add(maxArea);
		}

		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(queryBuilder.toString());

			// Set parameters
			for (int i = 0; i < parameters.size(); i++) {
				Object param = parameters.get(i);
				if (param instanceof String) {
					ps.setString(i + 1, (String) param);
				} else if (param instanceof Double) {
					ps.setDouble(i + 1, (Double) param);
				}
			}

			rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new room(rs.getString("id"), rs.getString("title"), rs.getString("description"),
						rs.getString("room_type"),
						rs.getDouble("price"), rs.getDouble("area"), rs.getString("address"), rs.getString("city"),
						rs.getString("district"), rs.getString("images"), rs.getString("created_at"),
						rs.getString("expiry_date"), rs.getString("status"), rs.getString("user_id")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
		return list;
	}

	public room getRoomByID(String id) {
		room room = null;
		String query = "SELECT * FROM rooms WHERE id = ?";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if (rs.next()) {
				room = new room(rs.getString("id"), rs.getString("title"), rs.getString("description"),
						rs.getString("room_type"),
						rs.getDouble("price"), rs.getDouble("area"), rs.getString("address"), rs.getString("city"),
						rs.getString("district"), rs.getString("images"), rs.getString("created_at"),
						rs.getString("expiry_date"), rs.getString("status"), rs.getString("user_id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
		return room;
	}

	public boolean addRoom(String title, String description, String room_type, double price, double area,
			String address,
			String city, String district, String images, String created_at, String expiry_date, String status,
			String user_id) {
		String query = "INSERT INTO rooms (title, description, room_type, price, area, address, city, district, images, created_at, expiry_date, status, user_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, title);
			ps.setString(2, description);
			ps.setString(3, room_type);
			ps.setDouble(4, price);
			ps.setDouble(5, area);
			ps.setString(6, address);
			ps.setString(7, city);
			ps.setString(8, district);
			ps.setString(9, images);
			ps.setString(10, created_at);
			ps.setString(11, expiry_date);
			ps.setString(12, status);
			ps.setString(13, user_id);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
		return false;
	}

	public boolean updateRoom(String id, String title, String description, String room_type, double price, double area,
			String address, String city, String district, String images, String created_at, String expiry_date,
			String status, String user_id) {
		String query = "UPDATE rooms SET title = ?, description = ?, room_type = ?, price = ?, area = ?, address = ?, city = ?, district = ?, images = ?, created_at = ?, expiry_date = ?, status = ?, user_id = ? WHERE id = ?";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, title);
			ps.setString(2, description);
			ps.setString(3, room_type);
			ps.setDouble(4, price);
			ps.setDouble(5, area);
			ps.setString(6, address);
			ps.setString(7, city);
			ps.setString(8, district);
			ps.setString(9, images);
			ps.setString(10, created_at);
			ps.setString(11, expiry_date);
			ps.setString(12, status);
			ps.setString(13, user_id);
			ps.setString(14, id);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
		return false;
	}

	public boolean deleteRoom(String id) {
		String query = "DELETE FROM rooms WHERE id = ?";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			ps.setString(1, id);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
		return false;
	}

	public int getTotalRoomCount() {
		int count = 0;
		String query = "SELECT COUNT(*) FROM rooms";
		try {
			conn = new DBconnect().getConnection();
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
		return count;
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
