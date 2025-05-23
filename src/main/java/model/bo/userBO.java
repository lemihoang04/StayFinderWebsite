package model.bo;

import java.util.*;
import model.dao.userDAO;
import model.bean.user;

public class userBO {
	userDAO udao = new userDAO();

	public ArrayList<user> getUserList() {
		return udao.getUserList();
	}

	public user getUserByID(String id) {
		return udao.getUserByID(id);
	}

	public user login(String username, String password) {
		return udao.login(username, password);
	}

	public boolean isExistUsername(String username) {
		if (udao.getUserByUsername(username) != null)
			return true;
		return false;
	}

	public boolean isEmailExist(String email, String currentUserId) {
		return udao.checkEmailExists(email, currentUserId);
	}

	public boolean isPhoneExist(String phone, String currentUserId) {
		return udao.checkPhoneExists(phone, currentUserId);
	}

	public boolean addUser(String id, String username, String password, String email, String phone, String name) {
		if (udao.addUser(id, username, password, email, phone, name))
			return true;
		return false;
	}

	public boolean updateUser(String id, String username, String password, String email, String phone, String name) {
		if (udao.updateUser(id, username, password, email, phone, name))
			return true;
		return false;
	}

	public boolean deleteUser(String id) {
		if (udao.deleteUser(id))
			return true;
		return false;
	}

	public boolean isEmailExist(String email) {
		return udao.checkEmailExists(email);
	}

	public boolean isPhoneExist(String phone) {
		return udao.checkPhoneExists(phone);
	}

	public boolean addUserWithAutoId(String username, String password, String email, String phone, String name) {
		return udao.addUserWithAutoId(username, password, email, phone, name);
	}

	public int getTotalUserCount() {
		return udao.getTotalUserCount();
	}
}
