
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>


<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Grocto-ShopKeeper</title>
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
 
  <img height= 70px width= auto class= "logo" src="images/logo.jpg"><br>
  <div class="dropdown">
   <a href="homePageSK.jsp">Home</a>
  </div>
  <input type="text" name="" placeholder="Search...">
  <a href="login.html"><img src="images/account.jpg" height=60px width=auto></a>
</div>


<div class="cont">
 <%
  String usrEmail = (String)session.getAttribute("user");
 if (session.getAttribute("user") == null) {
		out.println("<H1><I> SESSION TIMED OUT. YOU WILL BE REDIRECTED TO HOME PAGE AGAIN <I> </H1>");
		out.print("<META http-equiv=\"refresh\" content=\"5;URL=http://localhost:8080/grocto/login.html\"");
		//return;
	}
  out.print(" <p style=\"font-size: 52px; color: white; font: fantasy;\">Welcome shopkeeper: "+usrEmail+" !</p>");
  %>
</div>
<div class="deals">
  <button class="sk-options" onclick="openAdd()" >Add new item!</button>
  <button class="sk-options" onclick="openUpdate()" >Update existing item stock!</button>
  <button class="sk-options" onclick="openDelete()">Delete existing item!</button>
  <a href="openReports.jsp" ><button class="sk-options">Get reports!!</button></a>
</div>
<div id="contDeals" class="deals" style="background-image: linear-gradient(to left, green, yellowgreen, green);">
  <h2>My Items:</h2>
  
  <%
 	String url = "jdbc:mysql://localhost:3306/grocto?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
	String user = "sushanth123";
	String password = "Passwd@123";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, user, password);

		
		String query ="select * from items WHERE sKemail='"+usrEmail+"';";
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
			out.print("<input type = 'hidden' name = 'name'      value ="+Item_name+">");
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

	}
	con.close();     
	}
	catch(SQLException e){
	      out.print("can't connect to Database "+e);
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
            <li><a href="#">Dairy Products</a></li>
            <li><a href="#">Processed food</a></li>
          </ul>
        </div>
        <div class="footer-col">
          <h4>get help</h4>
          <ul>
            <li><a href="#">shipping</a></li>
            <li><a href="#">order status</a></li>
            <li><a href="#">Logout</a></li>
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

   

 <script>
   var user =  document.getElementById("contDeals");

   function openAdd(){
    user.innerHTML=`
    <div class="deals">
    <form class="myForm" method="get" action="addItemServlet">
    <h2>Your email id:(As shown above)</h2>
    <input type="text" name="sKemail" required>
    <h2>Item Name:</h2>
    <input type="text" name="name" required>
    <h2>Item price</h2>
    <input type="number" name="price" required>
    <h2>Item quantity</h2>
    <input type="number" name="quantity" required>
    <h2>Item image</h2>
    <input type="text" name="imageLink" required>
    <h2>Item Description</h2>
    <input type="text" name="description" required>
    <h2>Item Category[Fruits and Veggies or Dairy Products or Processed Food]</h2>
    <input type="text" name="category" required>
    <br><br>
    <button type="submit" name="submit-btn">Submit</button>
    </form>
    </div>
    <style>
    h2{
      background-color: limegreen;
      color: white;  
    }
    </style>
    `;
   }
   function openUpdate() {
    user.innerHTML=`
    <div class="deals">
    <form class="myForm" method="get" action="updateQuantityServlet">
    <h2>Item id</h2>
    <input type="number" name="itemId" required>
    <h2>Item quantity</h2>
    <input type="number" name="quantity" required>
    <br><br>
    <button type="submit" name="submit-btn">Submit</button>
    </form>
    </div>
    <style>
    h2{
      background-color: limegreen;
      color: white;  
    }
    </style>
    `;
   }

   function openDelete(){
    user.innerHTML=`
    <div class="deals">
    <form class="myForm">
    <h2>Item price</h2>
    <input type="number" name="price">
    </form>
    </div>
    <style>
    h2{
      background-color: limegreen;
      color: white;  
    }
    </style>
    `;
   }
   
 </script>
</body>
</html>




