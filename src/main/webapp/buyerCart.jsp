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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="homepage.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" >
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" >
  <link href="https://fonts.googleapis.com/css2?family=Josefin+Sans&display=swap" rel="stylesheet">
  
<title>Grocto - My Cart </title>
</head>
<body>
<div id="body">
<div class="navbar">
  <img height= 70px width= auto class= "logo" src="images/logo.jpg">
   <div class="dropdown">
    <a href="homePage.jsp"><button class="dropbtn">Home</button></a>
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
 

 <div id ="cont" class="cont">
     <p style="font-size: 52px; color: white; font: fantasy;">My Cart</p>
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
 <div id="deals" class="deals" style="background-image: linear-gradient(to left, green, yellowgreen, green);">
   <%
   String url = "jdbc:mysql://localhost:3306/grocto?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
   String user = "sushanth123";
   String password = "Passwd@123";

   try
	{
	Connection con = DriverManager.getConnection(url,user,password);

    String query ="select * from items where itemId IN (SELECT itemId from cart where email='"+usrEmail+"');";
    Statement s = con.createStatement();
    ResultSet r = s.executeQuery(query);

    while(r.next()){
      int Item_id = r.getInt(6);
      String Item_name = r.getString(1);
      String link = r.getString(4);
      int price = r.getInt(2);
      int stock = r.getInt(3);
      String desc = r.getString(5);
      out.print("<div>");
out.print("<image height=100px width=100px border='2px solid black' src = '"+link+"' alt = 'cannot load the image'>");
        out.print("<div>");
        out.print("<div style='float: right;padding: 20px;'>");										
		out.print("<form method = 'get' action ='addCartServlet'>");
		out.print("<input type = 'hidden' name = 'Email'      value ="+usrEmail+">");
		out.print("<input type = 'hidden' name = 'Item_id'  value = "+Item_id+"><br>");
		out.print("</form>");
		int id = -1;
if(session.getAttribute("id") != null){
  id = (int)session.getAttribute("id"); 
}
if(id == Item_id){
  if(session.getAttribute("msgCart") == null){
    ;
  }
  else{
    out.print(session.getAttribute("msgCart"));
    request.setAttribute("msgCart", null);
  }
}
out.print("</div>");												

          
		  out.print("<span><b><font color='white'>Id : </font></b>"+Item_id+"</span><br><br>");
          out.print("<span><b><font color='white'>Name : </font></b>"+Item_name+"</span><br>");
          out.print("<span><b><font color='white'>Price : </font></b>"+price+"</span><br>");
          out.print("<span><b><font color='white'>stock : </font></b>"+stock+"</span><br>");
          out.print("<span><b><font color='white'>Description  :</font></b>"+desc+"</span><br><br>");
		  
        out.print("</div>");
		
		out.print("<hr>");
		

		out.print("</div>");

    }     con.close();  
    
}
catch(SQLException e){
      out.print("can't connect to Database "+e);
    }
    %>
	<button id= "<%= session.getAttribute("user") %>" onclick="checkout(this)" >Checkout</button>
 </div>
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
 
 <script type="text/javascript">
   function checkout(obj){

    var usrEmail = $(obj).attr("id");
    const xhttp = new XMLHttpRequest();
      console.log(usrEmail);
      xhttp.onload  = function() {
        //if (xhttp.readyState == 4 && xhttp.status == 200) {
          document.getElementById("body").innerHTML = xhttp.responseText;        
        //}
      };
      xhttp.open("POST", "checkout.jsp?email="+usrEmail);
      xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      xhttp.send("usrEmail="+usrEmail);
   }
 </script>
</body>
</html>