package model.bo;

import java.util.*;

import model.bean.room;
import model.dao.roomDAO;

public class roomBO {
	roomDAO roomDAO = new roomDAO();
	public ArrayList<room> getRoomList() {
		roomDAO roomDAO = new roomDAO();
		return roomDAO.getRoomList();
	}

	public ArrayList<room> getRoomListBySearch(String search_type, String searchtxt) {
		roomDAO roomDAO = new roomDAO();
		return roomDAO.getRoomListBySearch(search_type, searchtxt);
	}
	public ArrayList<room> getAdvancedSearchResults(String city, String district, String minPriceStr, String maxPriceStr, String minAreaStr, String maxAreaStr, String searchtxt) {
		roomDAO roomDAO = new roomDAO();
		
		// Convert string parameters to appropriate types
		Double minPrice = null;
		Double maxPrice = null;
		Double minArea = null;
		Double maxArea = null;
		
		// Parse price values if provided
		if (minPriceStr != null && !minPriceStr.trim().isEmpty()) {
			try {
				minPrice = Double.parseDouble(minPriceStr);
			} catch (NumberFormatException e) {
				// Invalid number, keep as null
			}
		}
		
		if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
			try {
				maxPrice = Double.parseDouble(maxPriceStr);
			} catch (NumberFormatException e) {
				// Invalid number, keep as null
			}
		}
		
		// Parse area values if provided
		if (minAreaStr != null && !minAreaStr.trim().isEmpty()) {
			try {
				minArea = Double.parseDouble(minAreaStr);
			} catch (NumberFormatException e) {
				// Invalid number, keep as null
			}
		}
		
		if (maxAreaStr != null && !maxAreaStr.trim().isEmpty()) {
			try {
				maxArea = Double.parseDouble(maxAreaStr);
			} catch (NumberFormatException e) {
				// Invalid number, keep as null
			}
		}
				// Call the DAO method with converted parameters
		return roomDAO.getAdvancedSearchResults(city, district, minPrice, maxPrice, minArea, maxArea, searchtxt);
	}

	public room getRoomByID(String id) {
		roomDAO roomDAO = new roomDAO();
		return roomDAO.getRoomByID(id);
	}
	public boolean addRoom(String title, String description, String room_type, double price, double area,
			String address, String city, String district, String images, String created_at, String expiry_date,
			String status, String user_id) {
		roomDAO roomDAO = new roomDAO();
		return roomDAO.addRoom(title, description, room_type, price, area, address, city, district, images, created_at,
				expiry_date, status, user_id);
	}
	public boolean updateRoom(String id, String title, String description, String room_type, double price, double area,
			String address, String city, String district, String images, String created_at, String expiry_date,
			String status, String user_id) {
		roomDAO roomDAO = new roomDAO();
		return roomDAO.updateRoom(id, title, description, room_type, price, area, address, city, district, images,
				created_at, expiry_date, status, user_id);
	}

	public boolean deleteRoom(String id) {
		roomDAO roomDAO = new roomDAO();
		return roomDAO.deleteRoom(id);
	}
	
}
