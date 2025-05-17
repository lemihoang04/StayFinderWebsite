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

	public room getRoomByID(String id) {
		roomDAO roomDAO = new roomDAO();
		return roomDAO.getRoomByID(id);
	}

	public boolean addRoom(String title, String description, String room_type, double price, double area,
			String address, String city, String district, String images, String created_at, String expiry_date,
			String status) {
		roomDAO roomDAO = new roomDAO();
		return roomDAO.addRoom(title, description, room_type, price, area, address, city, district, images, created_at,
				expiry_date, status);
	}

	public boolean updateRoom(String id, String title, String description, String room_type, double price, double area,
			String address, String city, String district, String images, String created_at, String expiry_date,
			String status) {
		roomDAO roomDAO = new roomDAO();
		return roomDAO.updateRoom(id, title, description, room_type, price, area, address, city, district, images,
				created_at, expiry_date, status);
	}

	public boolean deleteRoom(String id) {
		roomDAO roomDAO = new roomDAO();
		return roomDAO.deleteRoom(id);
	}
	
}
