
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
@WebServlet("/searchServlet")


public class searchServlet extends HttpServlet 
{

	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
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
			if (request.getParameter("search").equals("GO")) 
			{
				String key = request.getParameter("search1");
				HttpSession session = request.getSession();
				session.setAttribute("search", key);
				//out.println("all ok ");
				out.print("<META http-equiv=\"refresh\" content=\"0;URL=http://localhost:8080/Grocto/homePage.jsp\"");
			}
			
			
		} catch (Exception e) {
			System.out.println(e);
		}
		//out.print("<META http-equiv=\"refresh\" content=\"2;URL=http://localhost:8080/Grocto/homePage.jsp\"");
		out.println("</BODY>\n" + "</HTML>");
	}

}

