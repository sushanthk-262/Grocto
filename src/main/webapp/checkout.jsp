<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="homepage.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" >
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" >
  <link href="https://fonts.googleapis.com/css2?family=Josefin+Sans&display=swap" rel="stylesheet">
<title>Grocto - Checkout</title>
</head>
<body>
	<div class="navbar">
  <img height= 70px width= auto class= "logo" src="images/logo.jpg">
   <div class="dropdown">
    <button class="dropbtn" >Home</button>
  </div>
  <div class="dropdown">
    <button class="dropbtn">About us</button>
  </div>
   <div class="dropdown">
    <button class="dropbtn"> Categories<i class="fa fa-caret-down"></i></button>
    <div class="dropdown-content">
     <a href="#">Fruits and Vegetables</a>
     <a href="#">Dairy Products</a>
     <a href="#">Processed Food</a>
    </div>
   </div>
   <input type="text" name="" placeholder="Search...">
   <a href="login.html"><img src="images/account.jpg" height=60px width=auto></a>
   <a href="#"><img src="images/cart2.jpg" height=60px width=auto></a>
 </div>
	
	<div class="deals">
 <%
  String usrEmail = (String)session.getAttribute("user");
 if (session.getAttribute("user") == null) {
    out.println("<H1><I> SESSION TIMED OUT. YOU WILL BE REDIRECTED TO HOME PAGE AGAIN <I> </H1>");
    out.print("<META http-equiv=\"refresh\" content=\"5;URL=http://localhost:8080/Grocto/login.html\"");
    //return;
  }
  out.print(" <p style=\"font-size: 52px; color: black;\">Welcome user: "+usrEmail+" !</p>");
  %>
</div>

 <div class="deals" style="background-image: linear-gradient(to left, green, yellowgreen, green);">
   <%
   String url = "jdbc:mysql://localhost:3306/grocto?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
   String user = "sushanth123";
   String password = "Passwd@123";


   

  try(Connection con = DriverManager.getConnection(url,user,password) ;){
  	try (Statement st = con.createStatement()){
      usrEmail = request.getParameter("email");
      Statement st1 = con.createStatement() ;
      ResultSet rs = st1.executeQuery("select * from items, cart where items.itemId = cart.itemId and cart.email='"+usrEmail+"';");
      
      con.setAutoCommit(false);
      int i = 1 ;
      int iId,q,pr;
      String uEmail;
      double tp = 0;
      LocalDate od ;
      
      while(rs.next()){
    	  
        iId =rs.getInt(6) ;
        pr=rs.getInt(2);
        uEmail = rs.getString(11);
        q = rs.getInt(12) ;
        tp = pr*q;

        st.executeUpdate("update items set quantity=quantity-"+q+" where itemId="+iId);
        PreparedStatement inserter = con.prepareStatement("insert into orders(email, itemId, quantity, tPrice, oDate) values('"+uEmail+"',?,?,?,?);");
        
        //inserter.setString(1,"sus@gmail.com");
        inserter.setInt(1,iId);
        inserter.setInt(2,q);
        inserter.setDouble(3,tp);
        inserter.setDate(4,java.sql.Date.valueOf(LocalDate.now()));
        
        inserter.executeUpdate();
       
      }
      st.executeUpdate("delete from cart where email='"+usrEmail+"';"); 
      con.commit();
      out.print("<h2> Purchase Completed!</h2> <br><h2>The total cart value is : "+tp+"</h2><br>");
      out.print("<a href='homePage.jsp'> Cluck me to return to homepage</a>");
  	} catch (SQLException ex) {

  		try {

  			con.rollback();
  			out.print("Pusrchase failed");
  			out.print(ex.toString());
  		} catch (SQLException ex1) {
  			out.print("Transaction rollback is failed"+ex1);
  		}
  	}
  	con.close();  
  }
  catch(SQLException e){
    out.print("can't connect to Database : "+e);
  }
    %>
    
 </div>
	
	
	
</body>
</html>