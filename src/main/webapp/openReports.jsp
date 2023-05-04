<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Grocto-  get your reports here!</title>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="homepage.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" >
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" >
  <link href="https://fonts.googleapis.com/css2?family=Josefin+Sans&display=swap" rel="stylesheet">
</head>
<body>
<div class="navbar">
  <img height= 70px width= auto class= "logo" src="images/logo.jpg">
   <div class="dropdown">
    <button class="dropbtn">Home</button>
  </div>
  <div class="dropdown">
    <button class="dropbtn">About us</button>
  </div>
   <div class="dropdown">
    <button class="dropbtn"> Categories</button>
    <div class="dropdown-content">
     <a href="#">Fruits and Vegetables</a>
     <a href="#">Dairy Products</a>
     <a href="#">Processed Food</a>
    </div>
   </div>
   <form method="post" action="searchServlet" >
		<input id="search1" name="search1" type="text" placeholder="Search for an Item">
		<input id="search" name="search" type="submit" value="GO">
	</form>
   <a href="login.html"><img src="images/account.jpg" height=60px width=auto></a>
   <a href="buyerCart.jsp"><img src="images/cart2.jpg" height=60px width=auto></a>
 </div>
 
 <div class="cont">
     <p style="font-size: 52px; color: white; font: fantasy;">Grocto - One stop for all Grocery needs!</p>
 </div>
 
 <div >
 <%
  String usrEmail = (String)session.getAttribute("user");
 if (session.getAttribute("user") == null) {
    out.println("<H1><I> SESSION TIMED OUT. YOU WILL BE REDIRECTED TO HOME PAGE AGAIN <I> </H1>");
    out.print("<META http-equiv=\"refresh\" content=\"5;URL=http://localhost:8080/Grocto/login.html\"");
    //return;
  }
  out.print(" <p style=\"font-size: 52px; color: black;\">Welcome user: "+usrEmail+" !</p>");
  
  int count = 0;

  String url = "jdbc:mysql://localhost:3306/grocto?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
  String user = "sushanth123";
  String password = "Passwd@123";
	
	
	
	String template = "SELECT itemId, quantity, email, oDate FROM orders;";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, user, password);

		PreparedStatement query = con.prepareStatement(template, ResultSet.TYPE_SCROLL_SENSITIVE,
		ResultSet.CONCUR_UPDATABLE);
		//query.setString(1, request.getParameter("email"));

		ResultSet rs = query.executeQuery();
		String str = "";
			
		if (!rs.next()) {
			out.println(
			"<h1 align=\"center\"><I>No Transactions yet.</I></h1>");
		} else {
			java.sql.ResultSetMetaData rsmd = rs.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
			rs.beforeFirst();

			str = "<TABLE BORDER=1 ALIGN=CENTER><TR BGCOLOR=\"#FF0000\">\n";
			str = str
			+ "<TH> ITEM_ID </TH><TH> QUANTITY </TH><TH> BUYER_EMAIL </TH><TH> DATE OF PURCHASE </TH></TR>\n";
			String columnValue;
			
			while (rs.next()) {
		str = str + "<TR>\n";
		for (int i = 1; i <= columnsNumber; i++) {
			columnValue = rs.getString(i);
			if (rsmd.getColumnName(i).equals("VENDOR_EMAIL")) {
				continue;
			}
			str = str + "<td> " + columnValue + " </td>";
		}
		
		
		str = str + "</TR>\n";
		}
			str = str + "</TABLE>";
			out.println(str);
			out.println("<form method=\"post\" action=\"\"><br>");
			out.println("<input type=\"date\" id=\"start\" name=\"start\" >");
			out.println("<input type=\"date\" id=\"end\" name=\"end\" >");
			out.println("<button name=\"bt1\" onclick=\"return test4()\" > Find Purchases between Dates </button>");
			out.println("</form>");
			con.close();
		}

	} catch (Exception ex) 
	{
		out.println(ex);
	}
  %>
</div>

<div style="background-image: linear-gradient(to left, green, yellowgreen, green);">
		<% 
		if ("POST".equalsIgnoreCase(request.getMethod()))
		{
			String str;
			String template1 = "SELECT itemId, quantity, email, oDate FROM orders WHERE oDate BETWEEN ? AND ?";
			try{
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection(url, user, password);
				PreparedStatement query = con.prepareStatement(template1, ResultSet.TYPE_SCROLL_SENSITIVE,
						ResultSet.CONCUR_UPDATABLE);
				
				String temp1 = request.getParameter("start");
				String temp2 = request.getParameter("end");
				query.setString(1, temp1);
				query.setString(2, temp2);
				
				ResultSet rs = query.executeQuery();
				
				if (!rs.next()) {
					out.println(
					"<h1 align=\"center\"><I>NO TRANSACTIONS FOUND</I></h1>");
				}
				rs.beforeFirst();
				java.sql.ResultSetMetaData rsmd = rs.getMetaData();
				int columnsNumber = rsmd.getColumnCount();
					

				str = "<TABLE BORDER=1 ALIGN=CENTER><TR BGCOLOR=\"#FF0000\">\n";
				str = str + "<TH> ITEM_ID </TH><TH> QUANTITY </TH><TH> BUYER_EMAIL </TH><TH> DATE OF PURCHASE </TH></TR>\n";
				String columnValue;
					
				while (rs.next()) 
				{
					str = str + "<TR>\n";
					for (int i = 1; i <= columnsNumber; i++) {
						columnValue = rs.getString(i);
						if (rsmd.getColumnName(i).equals("VENDOR_EMAIL")) 
						{
							continue;
						}
						str = str + "<td> " + columnValue + " </td>";
					}
					str = str + "</TR>\n";
				}
				str = str + "</TABLE>";
				out.println(str);					
				con.close();
			}
			catch(Exception ex){
				out.println(ex);
			}
		}
		%>
		</div>


 <footer class="footer">
     <div class="container">
      <div class="row">
        <div class="footer-col">
          <h4>Category</h4>
          <ul>
            <li><a href="#">Fruits and Veggies</a></li>
            <li><a href="#">Dairy Produts</a></li>
            <li><a href="#">Processed food</a></li>
          </ul>
        </div>
        <div class="footer-col">
          <h4>get help</h4>
          <ul>
            <li><a href="#">FAQ</a></li>
            <li><a href="#">shipping</a></li>
            <li><a href="#">returns</a></li>
            <li><a href="#">order status</a></li>
            <li><a href="#">payment options</a></li>
          </ul>
        </div>
        <div class="footer-col">
          <h4>Contact us</h4>
          <ul>
            <li><a href="#">Phone: +91 6301129398</a></li>
            <li><a href="#">E mail: sushanth.kulkarni262@gmail.com</a></li>
          </ul>
        </div>
      </div>
     </div>
  </footer>

</body>
</html>