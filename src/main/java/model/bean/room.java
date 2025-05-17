package model.bean;

public class room {
	private String id;
	private String title;
	private String description;
	private String roomType;
	private double price;
	private double area;
	private String address;
	private String city;
	private String district;
	private String images;
	private String createdAt;
	private String expiryDate;
	private String status;
	
	// Constructor with id
	public room(String id, String title, String description, String roomType, double price, double area, String address,
			String city, String district, String images, String createdAt, String expiryDate, String status) {
		this.id = id;
		this.title = title;
		this.description = description;
		this.roomType = roomType;
		this.price = price;
		this.area = area;
		this.address = address;
		this.city = city;
		this.district = district;
		this.images = images;
		this.createdAt = createdAt;
		this.expiryDate = expiryDate;
		this.status = status;
	}
	
	// Constructor without id (for insertion)
	public room(String title, String description, String roomType, double price, double area, String address,
			String city, String district, String images, String createdAt, String expiryDate, String status) {
		this.title = title;
		this.description = description;
		this.roomType = roomType;
		this.price = price;
		this.area = area;
		this.address = address;
		this.city = city;
		this.district = district;
		this.images = images;
		this.createdAt = createdAt;
		this.expiryDate = expiryDate;
		this.status = status;
	}
	
	// Getters and setters
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getRoomType() {
		return roomType;
	}
	
	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}
	
	public double getPrice() {
		return price;
	}
	
	public void setPrice(double price) {
		this.price = price;
	}
	
	public double getArea() {
		return area;
	}
	
	public void setArea(double area) {
		this.area = area;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getCity() {
		return city;
	}
	
	public void setCity(String city) {
		this.city = city;
	}
	
	public String getDistrict() {
		return district;
	}
	
	public void setDistrict(String district) {
		this.district = district;
	}
	
	public String getImages() {
		return images;
	}
	
	public void setImages(String images) {
		this.images = images;
	}
	
	public String getCreatedAt() {
		return createdAt;
	}
	
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	
	public String getExpiryDate() {
		return expiryDate;
	}
	
	public void setExpiryDate(String expiryDate) {
		this.expiryDate = expiryDate;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
}
