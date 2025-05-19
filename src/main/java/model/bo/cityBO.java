package model.bo;

import java.util.List;

import model.bean.city;
import model.dao.cityDAO;
public class cityBO {
	cityDAO cityDAO = new cityDAO();

	public city getCityById(int id) {
		return cityDAO.getCityById(id);
	}

	public List<city> getAllCities() {
		return cityDAO.getAllCities();
	}


}
