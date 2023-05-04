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
@WebServlet("/updateQuantityServlet")
public class updateQuantityServlet extends HttpServlet 
{

	private static final long serialVersionUID = 1L;
	private static final int NULL = 0;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		String url = "jdbc:mysql://localhost:3306/grocto?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String user = "sushanth123";
		String password = "Passwd@123";

		String template = "UPDATE items SET quantity = ? WHERE itemId=?";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);
			PreparedStatement ins = con.prepareStatement(template);
			
			ins.setInt(2,Integer.parseInt(request.getParameter("itemId")));
			ins.setInt(1,Integer.parseInt(request.getParameter("quantity")));
			ins.executeUpdate();
			PrintWriter out = response.getWriter();
			RequestDispatcher req = request.getRequestDispatcher("/homePageSK.jsp");
            req.include(request, response);
            
			out.println("<script> alert(Stock updated successfully!);</script>");
			
			con.close();
		} catch (Exception e) {
				System.out.print(e);
		}
	}

}
