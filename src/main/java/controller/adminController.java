package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

import model.bean.admin;
import model.bean.user;
import model.bo.adminBO;
import model.bo.userBO;

/**
 * Servlet implementation class adminController
 */
@WebServlet(name = "adminController", urlPatterns = { "/admin", "/admin_login", "/admin_logout", "/admin_dashboard",
		"/admin_users" })
public class adminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private adminBO adminBo = new adminBO();
	private userBO userBo = new userBO();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public adminController() {
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
			case "/admin_login":
				showAdminLoginForm(request, response);
				break;
			case "/admin_logout":
				logoutAdmin(request, response);
				break;
			case "/admin_dashboard":
				showDashboard(request, response);
				break;
			case "/admin_users":
				showUsersManager(request, response);
				break;
			case "/admin":
				redirectToDashboardOrLogin(request, response);
				break;
			default:
				response.sendRedirect(request.getContextPath() + "/admin_login");
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
			case "/admin_login":
				authenticateAdmin(request, response);
				break;
			default:
				response.sendRedirect(request.getContextPath() + "/admin_login");
				break;
		}
	}

	private void showAdminLoginForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute("admin") != null) {
			response.sendRedirect(request.getContextPath() + "/admin_dashboard");
			return;
		}
		request.getRequestDispatcher("login_admin.jsp").forward(request, response);
	}

	private void authenticateAdmin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		// Validate input
		if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
			request.setAttribute("errorMessage", "Username and password are required");
			request.getRequestDispatcher("login_admin.jsp").forward(request, response);
			return;
		}

		admin adminUser = adminBo.login_admin(username, password);

		if (adminUser != null) {
			// Login successful
			HttpSession session = request.getSession();
			session.setAttribute("admin", adminUser);
			response.sendRedirect(request.getContextPath() + "/admin_dashboard");
		} else {
			// Login failed
			request.setAttribute("errorMessage", "Invalid username or password");
			request.getRequestDispatcher("login_admin.jsp").forward(request, response);
		}
	}

	private void logoutAdmin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.removeAttribute("admin");
		}
		response.sendRedirect(request.getContextPath() + "/admin_login");
	}

	private void showDashboard(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("admin") != null) {
			request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
		} else {
			response.sendRedirect(request.getContextPath() + "/admin_login");
		}
	}

	private void redirectToDashboardOrLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute("admin") != null) {
			response.sendRedirect(request.getContextPath() + "/admin_dashboard");
		} else {
			response.sendRedirect(request.getContextPath() + "/admin_login");
		}
	}

	private void showUsersManager(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Check if admin is logged in
		HttpSession session = request.getSession();
		if (session.getAttribute("admin") == null) {
			response.sendRedirect(request.getContextPath() + "/admin_login");
			return;
		}

		// Get search parameters
		String searchType = request.getParameter("search_type");
		String searchText = request.getParameter("searchtxt");

		// Get user list based on search or get all
		ArrayList<user> userList;
		if (searchType != null && searchText != null && !searchText.isEmpty()) {
			userList = new model.dao.userDAO().getUserListBySearch(searchType, searchText);
		} else {
			userList = userBo.getUserList();
		}

		// Set attributes and forward to the page
		request.setAttribute("userList", userList);

		// Get any messages from the session (could be set from userController
		// operations)
		if (session.getAttribute("successMessage") != null) {
			request.setAttribute("successMessage", session.getAttribute("successMessage"));
			session.removeAttribute("successMessage");
		}

		if (session.getAttribute("errorMessage") != null) {
			request.setAttribute("errorMessage", session.getAttribute("errorMessage"));
			session.removeAttribute("errorMessage");
		}

		request.getRequestDispatcher("/users_manager.jsp").forward(request, response);
	}
}
