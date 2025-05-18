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
@WebServlet(name = "userController", urlPatterns = {"/user", "/login", "/register", "/logout", "/profile", "/admin/users"})
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
			case "/admin/users":
				listUsers(request, response);
				break;
			case "/user":
				String operation = request.getParameter("operation");
				if (operation != null) {
					switch (operation) {
						case "edit":
							showEditForm(request, response);
							break;
						case "delete":
							deleteUser(request, response);
							break;
						default:
							response.sendRedirect(request.getContextPath() + "/admin/users");
							break;
					}
				} else {
					response.sendRedirect(request.getContextPath() + "/admin/users");
				}
				break;
			default:
				response.sendRedirect(request.getContextPath() + "/login");
				break;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
							response.sendRedirect(request.getContextPath() + "/admin/users");
							break;
					}
				} else {
					response.sendRedirect(request.getContextPath() + "/admin/users");
				}
				break;
			default:
				response.sendRedirect(request.getContextPath() + "/login");
				break;
		}
	}
	
	private void showLoginForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("user") != null) {
			response.sendRedirect(request.getContextPath() + "/");
			return;
		}
		request.getRequestDispatcher("/login.jsp").forward(request, response);
	}
	
	private void authenticateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
	
	private void showRegisterForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("user") != null) {
			response.sendRedirect(request.getContextPath() + "/");
			return;
		}
		request.getRequestDispatcher("/register.jsp").forward(request, response);
	}
	
	private void registerUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String name = request.getParameter("name");
		
		if (userBO.isExistUsername(username)) {
			request.setAttribute("errorMessage", "Username already exists");
			request.getRequestDispatcher("/register.jsp").forward(request, response);
			return;
		}
		
		// Generate a unique ID
		String id = UUID.randomUUID().toString();
		
		boolean success = userBO.addUser(id, username, password, email, phone, name);
		if (success) {
			request.setAttribute("successMessage", "Registration successful! Please login.");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		} else {
			request.setAttribute("errorMessage", "Registration failed. Please try again.");
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
	
	private void showProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("user") != null) {
			request.getRequestDispatcher("/profile.jsp").forward(request, response);
		} else {
			response.sendRedirect(request.getContextPath() + "/login");
		}
	}
	
	private void updateProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
	
	private void listUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Check admin privileges (this should be improved with proper role checking)
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		String searchType = request.getParameter("search_type");
		String searchText = request.getParameter("searchtxt");
		
		ArrayList<user> userList;
		if (searchType != null && searchText != null && !searchText.isEmpty()) {
			// Assuming userBO has the search method or you access userDAO directly
			userList = new model.dao.userDAO().getUserListBySearch(searchType, searchText);
		} else {
			userList = userBO.getUserList();
		}
		
		request.setAttribute("userList", userList);
		request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
	}
	
	private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("id");
		user existingUser = userBO.getUserByID(userId);
		
		if (existingUser != null) {
			request.setAttribute("user", existingUser);
			request.getRequestDispatcher("/admin/user-form.jsp").forward(request, response);
		} else {
			request.setAttribute("errorMessage", "User not found");
			response.sendRedirect(request.getContextPath() + "/admin/users");
		}
	}
	
	private void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String name = request.getParameter("name");
		
		// If password is empty, get the old password
		if (password == null || password.isEmpty()) {
			user existingUser = userBO.getUserByID(id);
			if (existingUser != null) {
				password = existingUser.getPassword();
			}
		}
		
		boolean success = userBO.updateUser(id, username, password, email, phone, name);
		if (success) {
			request.setAttribute("successMessage", "User updated successfully");
		} else {
			request.setAttribute("errorMessage", "Failed to update user");
		}
		response.sendRedirect(request.getContextPath() + "/admin/users");
	}
	
	private void addUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String name = request.getParameter("name");
		
		if (userBO.isExistUsername(username)) {
			request.setAttribute("errorMessage", "Username already exists");
			request.getRequestDispatcher("/admin/user-form.jsp").forward(request, response);
			return;
		}
		
		// Generate a unique ID
		String id = UUID.randomUUID().toString();
		
		boolean success = userBO.addUser(id, username, password, email, phone, name);
		if (success) {
			request.setAttribute("successMessage", "User added successfully");
		} else {
			request.setAttribute("errorMessage", "Failed to add user");
		}
		response.sendRedirect(request.getContextPath() + "/admin/users");
	}
	
	private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("id");
		
		boolean success = userBO.deleteUser(userId);
		if (success) {
			request.setAttribute("successMessage", "User deleted successfully");
		} else {
			request.setAttribute("errorMessage", "Failed to delete user");
		}
		response.sendRedirect(request.getContextPath() + "/admin/users");
	}
}
