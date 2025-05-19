package model.dao;

import java.sql.*;
import java.util.*;

import model.bean.city;

import config.DBconnect;

public class cityDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	public ArrayList<city> getAllCities() {
		ArrayList<city> cityList = new ArrayList<>();

		try {
			conn = new DBconnect().getConnection();
			String query = "SELECT * FROM citys";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("id");
				String city_name = rs.getString("city_name");
				String[] districts = getDistrictsByCity(id);

				city cityObj = new city(id, city_name, districts);
				cityList.add(cityObj);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
		return cityList;
	}

	private String[] getDistrictsByCity(int cityId) {
		ArrayList<String> districtList = new ArrayList<>();
		Connection distConn = null;
		PreparedStatement distPs = null;
		ResultSet distRs = null;

		try {
			distConn = new DBconnect().getConnection();
			String query = "SELECT district_name FROM districts WHERE city_id = ?";
			distPs = distConn.prepareStatement(query);
			distPs.setInt(1, cityId);
			distRs = distPs.executeQuery();

			while (distRs.next()) {
				districtList.add(distRs.getString("district_name"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (distRs != null)
					distRs.close();
				if (distPs != null)
					distPs.close();
				if (distConn != null)
					distConn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return districtList.toArray(new String[0]);
	}

	public city getCityById(int cityId) {
		city cityObj = null;

		try {
			conn = new DBconnect().getConnection();
			String query = "SELECT * FROM citys WHERE id = ?";
			ps = conn.prepareStatement(query);
			ps.setInt(1, cityId);
			rs = ps.executeQuery();

			if (rs.next()) {
				int id = rs.getInt("id");
				String city_name = rs.getString("city_name");
				String[] districts = getDistrictsByCity(id);

				cityObj = new city();
				cityObj.setId(id);
				cityObj.setCity_name(city_name);
				cityObj.setDistrict(districts);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}

		return cityObj;
	}

	private void closeResources() {
		try {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
