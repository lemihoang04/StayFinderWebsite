package model.bo;

import model.bean.admin;
import model.dao.adminDAO;
public class adminBO {
	adminDAO adao = new adminDAO();

	public admin login_admin(String username, String password) {
		admin a = adao.login_admin(username, password);
		return a;
	}
}
