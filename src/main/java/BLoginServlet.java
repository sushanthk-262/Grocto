
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@SuppressWarnings("unused")
@WebServlet("/BLoginServlet")


public class BLoginServlet extends HttpServlet 
{

	private static final long serialVersionUID = 1L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String docType = "<!DOCTYPE HTML>\n";
		String title = "Grocto";
		
		out.println( docType + "<HTML>\n" + "<HEAD><TITLE>" + title + "</TITLE></HEAD>\n" + "<BODY BGCOLOR=\"#FDF5E6\">\n");

		String url = "jdbc:mysql://localhost:3306/grocto?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String user = "sushanth123";
		String password = "Passwd@123";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);
			
			Statement st = con.createStatement();
			String template = "SELECT email, password FROM buyer WHERE email=?";
			
			PreparedStatement query = con.prepareStatement(template);
			String temp = request.getParameter("email");
			query.setString(1, temp);
			RequestDispatcher req = request.getRequestDispatcher("/login.html");
            req.include(request, response);
			
			ResultSet op = query.executeQuery();
			
			if(!op.next()) {
				out.println("<h1>No user with the given email id is found, pls check again!</h1>");
				//redirect to login.html
			}
			else if(!request.getParameter("password").equals(op.getString(2)))
			{
				out.println("<h1>Incorrect password!Check again</h1>");
				//redirect to login.html
			}
			else {
				out.println("<h1>Loged In successfuly, page will be redirected soon</h1>");
				HttpSession session = request.getSession();
				session.setAttribute("user", request.getParameter("email"));
				session.setAttribute("search", "");
				session.setAttribute("pagecount", "0");
				out.print("<META http-equiv=\"refresh\" content=\"2;URL=http://localhost:8080/Grocto/homePage.jsp\"");
				
			}
			
			
			
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
		//out.print("<META http-equiv=\"refresh\" content=\"2;URL=http://localhost:8080/Grocto/homePage.jsp\"");
		out.println("</BODY>\n" + "</HTML>");
	}

}
