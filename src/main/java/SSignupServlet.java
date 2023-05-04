

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@SuppressWarnings("unused")
@WebServlet("/SSignupServlet")


public class SSignupServlet extends HttpServlet 
{

	private static final long serialVersionUID = 1L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");

		String url = "jdbc:mysql://localhost:3306/grocto?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String user = "sushanth123";
		String password = "Passwd@123";

		String template = "INSERT INTO shopKeeper VALUES(?, ?, ?, ?)";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);
			PreparedStatement ins = con.prepareStatement(template);
			
			ins.setString(2, request.getParameter("name"));
			ins.setString(3, request.getParameter("sName"));
			ins.setString(1, request.getParameter("email"));
			ins.setString(4, request.getParameter("password"));

			ins.executeUpdate();
			PrintWriter out = response.getWriter();
			RequestDispatcher req = request.getRequestDispatcher("/login.html");
            req.include(request, response);
            
			out.println("<h1>Signed Up successfully!!</h1>");

			HttpSession session = request.getSession();
			session.setAttribute("user", request.getParameter("email"));
			session.setAttribute("pagecount", "0");
			out.print("<META http-equiv=\"refresh\" content=\"2;URL=http://localhost:8080/Grocto/homePage.jsp\"");
			
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	}

}
