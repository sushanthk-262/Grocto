import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.*;

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
@WebServlet("/addItemServlet")
public class addItemServlet extends HttpServlet 
{

	private static final long serialVersionUID = 1L;
	private static final int NULL = 0;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		String url = "jdbc:mysql://localhost:3306/grocto?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String user = "sushanth123";
		String password = "Passwd@123";

		String template = "INSERT INTO items VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);
			PreparedStatement ins = con.prepareStatement(template);
			
			ins.setString(1, request.getParameter("name"));
			ins.setInt(2,Integer.parseInt(request.getParameter("price")));
			ins.setInt(3, Integer.parseInt(request.getParameter("quantity")));
			ins.setString(4, request.getParameter("imageLink"));
			ins.setString(5, request.getParameter("description"));
			ins.setString(7, request.getParameter("category"));
			ins.setString(8, request.getParameter("sKemail"));
			ins.setInt(6, NULL);

			ins.executeUpdate();
			PrintWriter out = response.getWriter();
			RequestDispatcher req = request.getRequestDispatcher("/homePageSK.jsp");
            req.include(request, response);
            
			out.println("Item added successfully!");
			
			con.close();
		} catch (Exception e) {
				System.out.print(e);
		}
	}

}
