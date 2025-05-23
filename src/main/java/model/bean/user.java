package model.bean;

public class user {
	private String id;
	private String username;
	private String password;
	private String email;
	private String phone;
	private String name;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "user [id=" + id + ", username=" + username + ", password=" + password + ", email=" + email + ", phone="
				+ phone + ", name=" + name + "]";
	}

	public user(String id, String username, String password, String email, String phone, String name) {
		this.id = id;
		this.username = username;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.name = name;
	}	
	
}
