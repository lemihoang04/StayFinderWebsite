package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
				list.add(new room(rs.getString("title"), rs.getString("description"), rs.getString("room_type"),
						rs.getDouble("price"), rs.getDouble("area"), rs.getString("address"), rs.getString("city"),
						rs.getString("district"), rs.getString("images"), rs.getString("created_at"),
						rs.getString("expiry_date"), rs.getString("status")));
			}
		} catch (Exception e) {
			e.printStackTrace();
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
				list.add(new room(rs.getString("title"), rs.getString("description"), rs.getString("room_type"),
						rs.getDouble("price"), rs.getDouble("area"), rs.getString("address"), rs.getString("city"),
						rs.getString("district"), rs.getString("images"), rs.getString("created_at"),
						rs.getString("expiry_date"), rs.getString("status")));
			}
		} catch (Exception e) {
			e.printStackTrace();
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
				room = new room(rs.getString("title"), rs.getString("description"), rs.getString("room_type"),
						rs.getDouble("price"), rs.getDouble("area"), rs.getString("address"), rs.getString("city"),
						rs.getString("district"), rs.getString("images"), rs.getString("created_at"),
						rs.getString("expiry_date"), rs.getString("status"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return room;
	}

	public boolean addRoom(String title, String description, String room_type, double price, double area, String address,
			String city, String district, String images, String created_at, String expiry_date, String status) {
		String query = "INSERT INTO rooms (title, description, room_type, price, area, address, city, district, images, created_at, expiry_date, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean updateRoom(String id, String title, String description, String room_type, double price, double area,
			String address, String city, String district, String images, String created_at, String expiry_date,
			String status) {
		String query = "UPDATE rooms SET title = ?, description = ?, room_type = ?, price = ?, area = ?, address = ?, city = ?, district = ?, images = ?, created_at = ?, expiry_date = ?, status = ? WHERE id = ?";
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
			ps.setString(13, id);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
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
		}
		return false;
	}
	
}
