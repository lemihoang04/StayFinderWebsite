package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;

import model.bo.userBO;
import model.bean.user;

/**
 * Servlet implementation class userController
 */
@WebServlet(name = "userController", urlPatterns = { "/user", "/login", "/register", "/logout", "/profile" })
public class userController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private userBO userBO = new userBO();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public userController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getServletPath();

		switch (action) {
			case "/login":
				showLoginForm(request, response);
				break;
			case "/register":
				showRegisterForm(request, response);
				break;
			case "/logout":
				logout(request, response);
				break;
			case "/profile":
				showProfile(request, response);
				break;
			case "/user":
				String operation = request.getParameter("operation");
				if (operation != null) {
					switch (operation) {
						case "view":
							viewUserJson(request, response);
							break;
						case "edit":
							showEditForm(request, response);
							break;
						case "delete":
							deleteUser(request, response);
							break;
						default:
							response.sendRedirect(request.getContextPath() + "/admin_users");
							break;
					}
				} else {
					response.sendRedirect(request.getContextPath() + "/admin_users");
				}
				break;
			default:
				response.sendRedirect(request.getContextPath() + "/login");
				break;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getServletPath();

		switch (action) {
			case "/login":
				authenticateUser(request, response);
				break;
			case "/register":
				registerUser(request, response);
				break;
			case "/profile":
				updateProfile(request, response);
				break;
			case "/user":
				String operation = request.getParameter("operation");
				if (operation != null) {
					switch (operation) {
						case "update":
							updateUser(request, response);
							break;
						case "add":
							addUser(request, response);
							break;
						default:
							response.sendRedirect(request.getContextPath() + "/admin_users");
							break;
					}
				} else {
					response.sendRedirect(request.getContextPath() + "/admin_users");
				}
				break;
			default:
				response.sendRedirect(request.getContextPath() + "/login");
				break;
		}
	}

	private void showLoginForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute("user") != null) {
			response.sendRedirect(request.getContextPath() + "/");
			return;
		}
		request.getRequestDispatcher("/login.jsp").forward(request, response);
	}

	private void authenticateUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		user authenticatedUser = userBO.login(username, password);

		if (authenticatedUser != null) {
			HttpSession session = request.getSession();
			session.setAttribute("user", authenticatedUser);
			response.sendRedirect(request.getContextPath() + "/");
		} else {
			request.setAttribute("errorMessage", "Invalid username or password");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}
	}

	private void showRegisterForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute("user") != null) {
			response.sendRedirect(request.getContextPath() + "/");
			return;
		}
		request.getRequestDispatcher("/register.jsp").forward(request, response);
	}

	private void registerUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String name = request.getParameter("name");

		// Validation
		if (username == null || username.trim().isEmpty() ||
				password == null || password.trim().isEmpty() ||
				email == null || email.trim().isEmpty() ||
				phone == null || phone.trim().isEmpty() ||
				name == null || name.trim().isEmpty()) {

			request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin");
			request.getRequestDispatcher("/register.jsp").forward(request, response);
			return;
		}

		// Validate username format (5-20 chars, no special characters)
		if (!username.matches("^[a-zA-Z0-9]{5,20}$")) {
			request.setAttribute("errorMessage", "Tên đăng nhập cần từ 5-20 ký tự và không chứa ký tự đặc biệt");
			request.getRequestDispatcher("/register.jsp").forward(request, response);
			return;
		}

		// Validate password strength
		if (!password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$")) {
			request.setAttribute("errorMessage", "Mật khẩu cần ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số");
			request.getRequestDispatcher("/register.jsp").forward(request, response);
			return;
		}

		// Check if passwords match
		if (!password.equals(confirmPassword)) {
			request.setAttribute("errorMessage", "Mật khẩu và xác nhận mật khẩu không khớp");
			request.getRequestDispatcher("/register.jsp").forward(request, response);
			return;
		}

		// Check for duplicate username
		if (userBO.isExistUsername(username)) {
			request.setAttribute("errorMessage", "Tên đăng nhập đã tồn tại, vui lòng chọn tên khác");
			request.getRequestDispatcher("/register.jsp").forward(request, response);
			return;
		}

		// Check for duplicate email
		if (userBO.isEmailExist(email)) {
			request.setAttribute("errorMessage", "Email đã được sử dụng, vui lòng sử dụng email khác");
			request.getRequestDispatcher("/register.jsp").forward(request, response);
			return;
		}

		// Check for duplicate phone
		if (userBO.isPhoneExist(phone)) {
			request.setAttribute("errorMessage", "Số điện thoại đã được sử dụng, vui lòng sử dụng số khác");
			request.getRequestDispatcher("/register.jsp").forward(request, response);
			return;
		}

		// Register the user with auto-generated ID
		boolean success = userBO.addUserWithAutoId(username, password, email, phone, name);
		if (success) {
			request.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
			response.sendRedirect(request.getContextPath() + "/login?success=register");
		} else {
			request.setAttribute("errorMessage", "Đăng ký thất bại. Vui lòng thử lại.");
			request.getRequestDispatcher("/register.jsp").forward(request, response);
		}
	}

	private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		response.sendRedirect(request.getContextPath() + "/login");
	}

	private void showProfile(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("user") != null) {
			request.getRequestDispatcher("/profile.jsp").forward(request, response);
		} else {
			response.sendRedirect(request.getContextPath() + "/login");
		}
	}

	private void updateProfile(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("user") != null) {
			user currentUser = (user) session.getAttribute("user");

			String id = currentUser.getId();
			String username = currentUser.getUsername(); // Username shouldn't change
			String password = request.getParameter("password");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String name = request.getParameter("name");

			// Check if email already exists for another user
			if (!email.equals(currentUser.getEmail()) && userBO.isEmailExist(email, id)) {
				request.setAttribute("errorMessage", "Email already in use by another account");
				request.getRequestDispatcher("/profile.jsp").forward(request, response);
				return;
			}

			// Check if phone already exists for another user
			if (!phone.equals(currentUser.getPhone()) && userBO.isPhoneExist(phone, id)) {
				request.setAttribute("errorMessage", "Phone number already in use by another account");
				request.getRequestDispatcher("/profile.jsp").forward(request, response);
				return;
			}

			if (password == null || password.isEmpty()) {
				password = currentUser.getPassword(); // Keep old password if not provided
			}

			boolean success = userBO.updateUser(id, username, password, email, phone, name);
			if (success) {
				// Update the session with new user data
				user updatedUser = userBO.getUserByID(id);
				session.setAttribute("user", updatedUser);

				request.setAttribute("successMessage", "Profile updated successfully");
			} else {
				request.setAttribute("errorMessage", "Failed to update profile");
			}
			request.getRequestDispatcher("/profile.jsp").forward(request, response);
		} else {
			response.sendRedirect(request.getContextPath() + "/login");
		}
	}

	// Remove or comment out the listUsers method since it's now handled by
	// adminController
	/*
	 * private void listUsers(HttpServletRequest request, HttpServletResponse
	 * response)
	 * throws ServletException, IOException {
	 * // This functionality is now handled by adminController
	 * }
	 */

	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userId = request.getParameter("id");
		user existingUser = userBO.getUserByID(userId);

		if (existingUser != null) {
			request.setAttribute("user", existingUser);
			request.getRequestDispatcher("/admin/user-form.jsp").forward(request, response);
		} else {
			request.setAttribute("errorMessage", "User not found");
			response.sendRedirect(request.getContextPath() + "/admin_users");
		}
	}

	private void updateUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String name = request.getParameter("name");
		
		HttpSession session = request.getSession();
		
		// Get the existing user to compare values
		user existingUser = userBO.getUserByID(id);
		if (existingUser == null) {
			session.setAttribute("errorMessage", "Không tìm thấy người dùng");
			response.sendRedirect(request.getContextPath() + "/admin_users");
			return;
		}
		
		// Check for duplicate email (if changed)
		if (!email.equals(existingUser.getEmail()) && userBO.isEmailExist(email, id)) {
			session.setAttribute("errorMessage", "Email đã được sử dụng bởi người dùng khác");
			response.sendRedirect(request.getContextPath() + "/admin_users");
			return;
		}
		
		// Check for duplicate phone (if changed)
		if (!phone.equals(existingUser.getPhone()) && userBO.isPhoneExist(phone, id)) {
			session.setAttribute("errorMessage", "Số điện thoại đã được sử dụng bởi người dùng khác");
			response.sendRedirect(request.getContextPath() + "/admin_users");
			return;
		}

		// If password is empty, keep the old password
		if (password == null || password.isEmpty()) {
			password = existingUser.getPassword();
		}

		boolean success = userBO.updateUser(id, username, password, email, phone, name);

		if (success) {
			session.setAttribute("successMessage", "Đã cập nhật thông tin người dùng thành công");
		} else {
			session.setAttribute("errorMessage", "Không thể cập nhật thông tin người dùng");
		}
		response.sendRedirect(request.getContextPath() + "/admin_users");
	}

	private void addUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String name = request.getParameter("name");

		if (userBO.isExistUsername(username)) {
			HttpSession session = request.getSession();
			session.setAttribute("errorMessage", "Tên đăng nhập đã tồn tại");
			response.sendRedirect(request.getContextPath() + "/admin_users");
			return;
		}

		// Check for duplicate email
		if (userBO.isEmailExist(email)) {
			HttpSession session = request.getSession();
			session.setAttribute("errorMessage", "Email đã tồn tại");
			response.sendRedirect(request.getContextPath() + "/admin_users");
			return;
		}

		// Check for duplicate phone
		if (userBO.isPhoneExist(phone)) {
			HttpSession session = request.getSession();
			session.setAttribute("errorMessage", "Số điện thoại đã tồn tại");
			response.sendRedirect(request.getContextPath() + "/admin_users");
			return;
		}

		boolean success = userBO.addUserWithAutoId(username, password, email, phone, name);
		HttpSession session = request.getSession();

		if (success) {
			session.setAttribute("successMessage", "Đã thêm người dùng mới thành công");
		} else {
			session.setAttribute("errorMessage", "Không thể thêm người dùng mới");
		}
		response.sendRedirect(request.getContextPath() + "/admin_users");
	}

	private void deleteUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userId = request.getParameter("id");

		boolean success = userBO.deleteUser(userId);
		HttpSession session = request.getSession();

		if (success) {
			session.setAttribute("successMessage", "Đã xóa người dùng thành công");
		} else {
			session.setAttribute("errorMessage", "Không thể xóa người dùng");
		}
		response.sendRedirect(request.getContextPath() + "/admin_users");
	}

	// Add this new method to return user data as JSON
	private void viewUserJson(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userId = request.getParameter("id");
		user userData = userBO.getUserByID(userId);

		if (userData != null) {
			// Set response type to JSON
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");

			// Create JSON manually (alternatively, you could use a library like Gson)
			String userJson = "{" +
					"\"id\":\"" + userData.getId() + "\"," +
					"\"username\":\"" + userData.getUsername() + "\"," +
					"\"email\":\"" + userData.getEmail() + "\"," +
					"\"phone\":\"" + userData.getPhone() + "\"," +
					"\"name\":\"" + userData.getName() + "\"" +
					"}";

			// Write JSON to response
			response.getWriter().write(userJson);
		} else {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			response.getWriter().write("{\"error\":\"User not found\"}");
		}
	}
}
