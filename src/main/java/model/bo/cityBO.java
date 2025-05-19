package model.bo;

import java.lang.reflect.Array;
import java.util.ArrayList;

import model.bean.city;
import model.dao.cityDAO;

public class cityBO {
	cityDAO cityDAO = new cityDAO();

	public city getCityById(int id) {
		return cityDAO.getCityById(id);
	}

	public ArrayList<city> getCityList() {
		return cityDAO.getAllCities();
	}

}
