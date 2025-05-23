package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Comparator;
import java.util.UUID;

import model.bo.roomBO;
import model.bean.room;
import model.bean.user;
import model.bo.userBO;
import model.bean.city;
import model.bo.cityBO;

@WebServlet(name = "roomController", urlPatterns = { "/rooms", "/room-info", "/add-room", "/edit-room", "/delete-room",
		"/my-rooms", "/search-rooms", "/home" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class roomController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private roomBO roomBO;

	public roomController() {
		super();
		roomBO = new roomBO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getServletPath();
		String operation = request.getParameter("operation");

		try {
			if (action.equals("/room") && operation != null) {
				switch (operation) {
					case "view":
						viewRoomJson(request, response);
						return;
					case "delete":
						deleteRoom(request, response);
						return;
				}
			}

			switch (action) {
				case "/home":
					showHome(request, response);
					break;
				case "/rooms":
					listRooms(request, response);
					break;
				case "/room-info":
					showRoomInfo(request, response);
					break;
				case "/add-room":
					showAddRoomForm(request, response);
					break;
				case "/edit-room":
					showEditRoomForm(request, response);
					break;
				case "/delete-room":
					deleteRoom(request, response);
					break;
				case "/my-rooms":
					showMyRooms(request, response);
					break;
				case "/search-rooms":
					searchRooms(request, response);
					break;
				default:
					showHome(request, response);
					break;
			}
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getServletPath();
		String operation = request.getParameter("operation");

		try {
			if (action.equals("/room") && operation != null) {
				switch (operation) {
					case "add":
						addRoomAdmin(request, response);
						return;
					case "update":
						updateRoomAdmin(request, response);
						return;
					case "delete":
						deleteRoomAdmin(request, response);
						return;
				}
			}

			switch (action) {
				case "/add-room":
					addRoom(request, response);
					break;
				case "/edit-room":
					updateRoom(request, response);
					break;
				case "/search-rooms":
					searchRooms(request, response);
					break;
				default:
					listRooms(request, response);
					break;
			}
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	private void listRooms(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get all rooms
		cityBO cityBO = new cityBO();
		ArrayList<city> cityList = cityBO.getCityList();
		request.setAttribute("cityList", cityList);
		ArrayList<room> roomList = roomBO.getRoomList();
		request.setAttribute("roomList", roomList);

		request.setAttribute("pageTitle", "Tất cả phòng trọ");
		request.setAttribute("totalRooms", roomList.size());

		// Truyền cityList sang JSP để render select city/district động
		request.getRequestDispatcher("search.jsp").forward(request, response);
	}

	private void showHome(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get featured rooms for home page
		ArrayList<room> roomList = roomBO.getFeatureRooms();
		request.setAttribute("roomList", roomList);
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	private void showAddRoomForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Check if user is logged in
		HttpSession session = request.getSession();
		if (session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		cityBO cityBO = new cityBO();
		ArrayList<city> cityList = cityBO.getCityList();
		request.setAttribute("cityList", cityList);
		request.getRequestDispatcher("addroom.jsp").forward(request, response);
	}

	private boolean handleAddRoom(HttpServletRequest request) throws ServletException, IOException {
		// Check if user is logged in
		HttpSession session = request.getSession();
		if (session.getAttribute("user") == null) {
			return false;
		}

		// Get user from session
		user currentUser = (user) session.getAttribute("user");
		String user_id = currentUser.getId();

		// Get parameters from form
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		double price = Double.parseDouble(request.getParameter("price"));
		double area = Double.parseDouble(request.getParameter("area"));
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String district = request.getParameter("district");
		String expiryDays = request.getParameter("expiry_date");

		// Process image uploads
		String imagesPath = processImageUploads(request);

		// Calculate expiry date
		String createdAt = LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE);
		String expiryDate = LocalDate.now().plusDays(Integer.parseInt(expiryDays))
				.format(DateTimeFormatter.ISO_LOCAL_DATE);

		// Default values for other fields
		String roomType = "standard"; // Default room type
		String status = "available"; // Default status

		// Save room to database
		return roomBO.addRoom(title, description, roomType, price, area, address, city, district, imagesPath, createdAt,
				expiryDate, status, user_id);
	}

	private void addRoom(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (handleAddRoom(request)) {
			request.setAttribute("message", "Đăng tin thành công. Tin của bạn đang chờ duyệt.");
			request.getRequestDispatcher("success.jsp").forward(request, response);
		} else {
			request.setAttribute("error", "Có lỗi xảy ra khi đăng tin. Vui lòng thử lại.");
			request.getRequestDispatcher("addroom.jsp").forward(request, response);
		}
	}

	private void showEditRoomForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Check if user is logged in
		HttpSession session = request.getSession();
		if (session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		String id = request.getParameter("id");
		room room = roomBO.getRoomByID(id);

		if (room != null) {
			cityBO cityBO = new cityBO();
			ArrayList<city> cityList = cityBO.getCityList();
			request.setAttribute("cityList", cityList);
			request.setAttribute("room", room);
			request.getRequestDispatcher("edit-room.jsp").forward(request, response);
		} else {
			response.sendRedirect("rooms");
		}
	}

	private void updateRoom(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Check if user is logged in
		HttpSession session = request.getSession();
		if (session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		double price = Double.parseDouble(request.getParameter("price"));
		double area = Double.parseDouble(request.getParameter("area"));
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String district = request.getParameter("district");
		String expiryDays = request.getParameter("expiry_date");
		String deletedImages = request.getParameter("deletedImages");

		room existingRoom = roomBO.getRoomByID(id);

		if (existingRoom != null) {
			// Xử lý ảnh đã bị xóa (nếu có)
			String imagesPath = existingRoom.getImages();
			if (deletedImages != null && !deletedImages.isEmpty()) {
				String[] currentImages = imagesPath.split(",");
				String[] toDelete = deletedImages.split(",");
				StringBuilder remainingImages = new StringBuilder();

				for (String img : currentImages) {
					boolean shouldKeep = true;
					for (String del : toDelete) {
						if (img.equals(del.trim())) {
							shouldKeep = false;
							break;
						}
					}
					if (shouldKeep) {
						if (remainingImages.length() > 0) {
							remainingImages.append(",");
						}
						remainingImages.append(img);
					}
				}

				imagesPath = remainingImages.toString();
			}

			// Check if new images are uploaded
			Collection<Part> parts = request.getParts();
			boolean hasNewImages = false;

			for (Part part : parts) {
				if (part.getName().equals("images") && part.getSize() > 0) {
					hasNewImages = true;
					break;
				}
			}

			if (hasNewImages) {
				String newImagesPath = processImageUploads(request);
				if (!imagesPath.isEmpty() && !newImagesPath.isEmpty()) {
					imagesPath += "," + newImagesPath;
				} else if (newImagesPath.isEmpty()) {
					// Không làm gì nếu không có ảnh mới
				} else {
					imagesPath = newImagesPath;
				}
			}

			// Calculate new expiry date if changed
			String expiryDate = existingRoom.getExpiryDate();
			if (expiryDays != null && !expiryDays.isEmpty()) {
				String expiryDateOnly = expiryDate.substring(0, 10); // Lấy phần yyyy-MM-dd
				LocalDate currentExpiryDate = LocalDate.parse(expiryDateOnly);
				LocalDate newExpiryDate = currentExpiryDate.plusDays(Integer.parseInt(expiryDays));
				expiryDate = newExpiryDate.format(DateTimeFormatter.ISO_LOCAL_DATE);
			}

			boolean success = roomBO.updateRoom(id, title, description, existingRoom.getRoomType(), price, area,
					address, city, district, imagesPath, existingRoom.getCreatedAt(), expiryDate,
					existingRoom.getStatus(), existingRoom.getUser_id());

			if (success) {
				request.setAttribute("message", "Cập nhật tin thành công!");
				showRoomInfo(request, response);
			} else {
				request.setAttribute("error", "Có lỗi xảy ra khi cập nhật tin. Vui lòng thử lại.");
				showEditRoomForm(request, response);
			}
		} else {
			response.sendRedirect("rooms");
		}
	}

	private void deleteRoom(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Check if user is logged in
		HttpSession session = request.getSession();
		if (session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		String id = request.getParameter("id");
		boolean success = roomBO.deleteRoom(id);

		if (success) {
			request.setAttribute("message", "Xóa tin thành công!");
		} else {
			request.setAttribute("error", "Có lỗi xảy ra khi xóa tin. Vui lòng thử lại.");
		}

		showMyRooms(request, response);
	}

	private void showMyRooms(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Check if user is logged in
		HttpSession session = request.getSession();
		if (session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// In a real application, you'd get the user ID from the session and filter
		// rooms by user ID
		// For now, we'll just show all rooms
		ArrayList<room> roomList = roomBO.getRoomList();
		request.setAttribute("roomList", roomList);
		request.getRequestDispatcher("my-rooms.jsp").forward(request, response);
	}

	private void searchRooms(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get search parameters for advanced search
		String city = request.getParameter("city");
		String district = request.getParameter("district");
		String minPrice = request.getParameter("minPrice");
		String maxPrice = request.getParameter("maxPrice");
		String minArea = request.getParameter("minArea");
		String maxArea = request.getParameter("maxArea");
		String searchtxt = request.getParameter("searchtxt");
		String sortBy = request.getParameter("sortBy");

		ArrayList<room> searchResults;
		String pageTitle = "Kết quả tìm kiếm";

		// Check if we have any search criteria
		boolean hasAdvancedSearchCriteria = (city != null && !city.trim().isEmpty())
				|| (district != null && !district.trim().isEmpty()) || (minPrice != null && !minPrice.trim().isEmpty())
				|| (maxPrice != null && !maxPrice.trim().isEmpty()) || (minArea != null && !minArea.trim().isEmpty())
				|| (maxArea != null && !maxArea.trim().isEmpty()) || (searchtxt != null && !searchtxt.trim().isEmpty());

		if (hasAdvancedSearchCriteria) {
			// Perform advanced search
			searchResults = roomBO.getAdvancedSearchResults(city, district, minPrice, maxPrice, minArea, maxArea,
					searchtxt);

			// Build page title based on search criteria
			StringBuilder titleBuilder = new StringBuilder("Kết quả tìm kiếm: ");
			ArrayList<String> criteria = new ArrayList<>();

			if (searchtxt != null && !searchtxt.trim().isEmpty()) {
				criteria.add("\"" + searchtxt + "\"");
			}

			if (city != null && !city.trim().isEmpty()) {
				criteria.add(city);
			}
			if (district != null && !district.trim().isEmpty()) {
				criteria.add(district);
			}
			if ((minPrice != null && !minPrice.trim().isEmpty()) || (maxPrice != null && !maxPrice.trim().isEmpty())) {
				criteria.add("Giá " + (minPrice != null && !minPrice.trim().isEmpty() ? "từ " + minPrice + " đ" : "")
						+ (maxPrice != null && !maxPrice.trim().isEmpty() ? " đến " + maxPrice + " đ" : ""));
			}
			if ((minArea != null && !minArea.trim().isEmpty()) || (maxArea != null && !maxArea.trim().isEmpty())) {
				criteria.add("Diện tích " + (minArea != null && !minArea.trim().isEmpty() ? "từ " + minArea + "m²" : "")
						+ (maxArea != null && !maxArea.trim().isEmpty() ? " đến " + maxArea + "m²" : ""));
			}

			if (!criteria.isEmpty()) {
				titleBuilder.append(String.join(", ", criteria));
				pageTitle = titleBuilder.toString();
			}
		} else {
			// No search criteria, show all rooms
			searchResults = roomBO.getRoomList();
			pageTitle = "Tất cả phòng trọ";
		}

		// Handle sorting
		if (sortBy != null && !sortBy.isEmpty()) {
			// Sort the search results based on sortBy parameter
			switch (sortBy) {
				case "price-low":
					searchResults.sort(Comparator.comparing(room::getPrice));
					break;
				case "price-high":
					searchResults.sort(Comparator.comparing(room::getPrice).reversed());
					break;
				case "area-low":
					searchResults.sort(Comparator.comparing(room::getArea));
					break;
				case "area-high":
					searchResults.sort(Comparator.comparing(room::getArea).reversed());
					break;
			}
		}

		// Set attributes for the JSP
		request.setAttribute("roomList", searchResults);
		request.setAttribute("city", city);
		request.setAttribute("district", district);
		request.setAttribute("minPrice", minPrice);
		request.setAttribute("maxPrice", maxPrice);
		request.setAttribute("minArea", minArea);
		request.setAttribute("maxArea", maxArea);
		request.setAttribute("searchtxt", searchtxt);
		request.setAttribute("sortBy", sortBy);
		request.setAttribute("pageTitle", pageTitle);
		request.setAttribute("totalRooms", searchResults.size());

		// Đảm bảo cityList cũng được truyền khi search
		cityBO cityBO = new cityBO();
		ArrayList<city> cityList = cityBO.getCityList();
		request.setAttribute("cityList", cityList);

		// Always forward to search.jsp for displaying search results
		request.getRequestDispatcher("search.jsp").forward(request, response);
	}

	private String processImageUploads(HttpServletRequest request) throws ServletException, IOException {
		// Define the upload directory
		String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdir();
		}

		StringBuilder imagesPaths = new StringBuilder();
		Collection<Part> parts = request.getParts();

		for (Part part : parts) {
			if (part.getName().equals("images") && part.getSize() > 0) {
				String fileName = UUID.randomUUID().toString() + getFileName(part);
				String filePath = uploadPath + File.separator + fileName;

				// Write file to disk
				part.write(filePath);

				// Save file path in comma-separated string
				if (imagesPaths.length() > 0) {
					imagesPaths.append(",");
				}
				imagesPaths.append("uploads/").append(fileName);
			}
		}

		return imagesPaths.toString();
	}

	private String getFileName(Part part) {
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");

		for (String item : items) {
			if (item.trim().startsWith("filename")) {
				return item.substring(item.indexOf("=") + 2, item.length() - 1);
			}
		}
		return "";
	}

	private void showRoomInfo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		room room = roomBO.getRoomByID(id);

		if (room != null) {
			// Get user data associated with this room
			String userId = room.getUser_id();
			userBO userBO = new userBO();
			user owner = userBO.getUserByID(userId);

			// Set attributes for JSP
			request.setAttribute("room", room);
			request.setAttribute("owner", owner);
			request.getRequestDispatcher("room-info.jsp").forward(request, response);
		} else {
			response.sendRedirect("rooms");
		}
	}

	private void viewRoomJson(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String roomId = request.getParameter("id");
		room roomData = roomBO.getRoomByID(roomId);

		if (roomData != null) {
			// Get the owner's name
			userBO userBO = new userBO();
			user owner = userBO.getUserByID(roomData.getUser_id());
			String ownerName = (owner != null) ? owner.getName() : "Unknown";

			// Set response type to JSON
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");

			// Create JSON manually
			String roomJson = "{" +
					"\"id\":\"" + roomData.getId() + "\"," +
					"\"title\":\"" + escapeJSON(roomData.getTitle()) + "\"," +
					"\"description\":\"" + escapeJSON(roomData.getDescription()) + "\"," +
					"\"roomType\":\"" + roomData.getRoomType() + "\"," +
					"\"price\":" + roomData.getPrice() + "," +
					"\"area\":" + roomData.getArea() + "," +
					"\"address\":\"" + escapeJSON(roomData.getAddress()) + "\"," +
					"\"city\":\"" + roomData.getCity() + "\"," +
					"\"district\":\"" + escapeJSON(roomData.getDistrict()) + "\"," +
					"\"images\":\"" + roomData.getImages() + "\"," +
					"\"createdAt\":\"" + roomData.getCreatedAt() + "\"," +
					"\"expiryDate\":\"" + roomData.getExpiryDate() + "\"," +
					"\"status\":\"" + roomData.getStatus() + "\"," +
					"\"user_id\":\"" + roomData.getUser_id() + "\"," +
					"\"userName\":\"" + escapeJSON(ownerName) + "\"" +
					"}";

			// Write JSON to response
			response.getWriter().write(roomJson);
		} else {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			response.getWriter().write("{\"error\":\"Room not found\"}");
		}
	}

	private String escapeJSON(String input) {
		if (input == null)
			return "";
		return input.replace("\\", "\\\\")
				.replace("\"", "\\\"")
				.replace("\n", "\\n")
				.replace("\r", "\\r")
				.replace("\t", "\\t");
	}

	private void addRoomAdmin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();

		// Get form parameters
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		double price = Double.parseDouble(request.getParameter("price"));
		double area = Double.parseDouble(request.getParameter("area"));
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String district = request.getParameter("district");
		String status = request.getParameter("status");
		String userId = request.getParameter("user_id");

		// Process image uploads (reuse existing method)
		String imagesPath = processImageUploads(request);

		// Set dates
		String createdAt = LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE);
		String expiryDate = LocalDate.now().plusDays(30).format(DateTimeFormatter.ISO_LOCAL_DATE); // Default 30 days

		// Default room type
		String roomType = "standard";

		boolean success = roomBO.addRoom(title, description, roomType, price, area, address,
				city, district, imagesPath, createdAt, expiryDate, status, userId);

		if (success) {
			session.setAttribute("successMessage", "Phòng trọ đã được thêm thành công");
		} else {
			session.setAttribute("errorMessage", "Không thể thêm phòng trọ. Vui lòng thử lại");
		}

		response.sendRedirect(request.getContextPath() + "/admin_rooms");
	}

	private void updateRoomAdmin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		double price = Double.parseDouble(request.getParameter("price"));
		double area = Double.parseDouble(request.getParameter("area"));
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String district = request.getParameter("district");
		String status = request.getParameter("status");
		String deletedImages = request.getParameter("deletedImages");

		room existingRoom = roomBO.getRoomByID(id);
		if (existingRoom != null) {
			// Process deleted images
			String imagesPath = existingRoom.getImages();
			if (deletedImages != null && !deletedImages.isEmpty()) {
				String[] currentImages = imagesPath.split(",");
				String[] toDelete = deletedImages.split(",");
				StringBuilder remainingImages = new StringBuilder();
				for (String img : currentImages) {
					boolean keep = true;
					for (String del : toDelete) {
						if (img.trim().equals(del.trim())) {
							keep = false;
							break;
						}
					}
					if (keep) {
						if (remainingImages.length() > 0) {
							remainingImages.append(",");
						}
						remainingImages.append(img);
					}
				}
				imagesPath = remainingImages.toString();
			}
			// Process new images if any
			Collection<Part> parts = request.getParts();
			boolean hasNewImages = false;
			for (Part part : parts) {
				if (part.getName().equals("images") && part.getSize() > 0) {
					hasNewImages = true;
					break;
				}
			}
			if (hasNewImages) {
				String newImagesPath = processImageUploads(request);
				if (!imagesPath.isEmpty() && !newImagesPath.isEmpty()) {
					imagesPath += "," + newImagesPath;
				} else if (!newImagesPath.isEmpty()) {
					imagesPath = newImagesPath;
				}
			}
			// Update room in database
			boolean success = roomBO.updateRoom(id, title, description, existingRoom.getRoomType(),
					price, area, address, city, district, imagesPath, existingRoom.getCreatedAt(),
					existingRoom.getExpiryDate(), status, existingRoom.getUser_id());
			if (success) {
				session.setAttribute("successMessage", "Phòng trọ đã được cập nhật thành công");
			} else {
				session.setAttribute("errorMessage", "Không thể cập nhật phòng trọ. Vui lòng thử lại");
			}
		} else {
			session.setAttribute("errorMessage", "Không tìm thấy phòng trọ");
		}
		response.sendRedirect(request.getContextPath() + "/admin_rooms");
	}

	private void deleteRoomAdmin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = request.getParameter("id");

		boolean success = roomBO.deleteRoom(id);

		if (success) {
			session.setAttribute("successMessage", "Phòng trọ đã được xóa thành công");
		} else {
			session.setAttribute("errorMessage", "Không thể xóa phòng trọ. Vui lòng thử lại");
		}

		response.sendRedirect(request.getContextPath() + "/admin_rooms");
	}
}
