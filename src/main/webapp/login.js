function openBuyer()
{
    var user =  document.getElementById('cont');

    user.innerHTML= ` 
    <div class="card" id="cid">
      <div class="inner-box" id="iBox">
        <div class="card-front">
          <h1>Buyer's Log In</h1><hr><br>
          <br><br><button type="button" name="new-btn" onclick="openShopkeeper()" style="width:50%">Switch to shopkeeper Login/SignUp</button><br><br>
          <form class="form" id="bLogin" method="get" action="BLoginServlet">
            <h2>email id:</h2>
            <input type="email" class="input_box" name="email" placeholder="Enter your email id" required>
            <br><br>
            <h2>Password:</h2>
            <input type="password" class="input_box" name="password" placeholder="Enter your password" required>
            <br><br><button type="submit" name="submit-btn">Submit</button>
            <br><br><button type="button" name="new-btn" onclick="openSignup()">I'm a new buyer here</button>
          </form>
        </div>

        <div class="card-back">
          <h2>Buyer's Sign Up</h2><hr><br>
          <br><br><button type="button" name="new-btn" onclick="openShopkeeper()" style="width:50%">Switch to shopkeeper Login/SignUp</button>
          <form class="form" id="bSignup" method="get" action="BSignupServlet">
            <h2>Name:</h2>
            <input type="text" class="input_box" name="name" placeholder="Enter your Name" required>
            <br><br>
            <h2>EMail id:</h2>
            <input type="email" class="input_box" name="email" placeholder="Enter your email id" required>
            <br><br>
            <h2>Password:</h2>
            <input type="password" class="input_box" name="password" placeholder="Enter your password" required>
            <h2>Confirm Password:</h2>
            <input type="password" class="input_box" name="cpassword" placeholder="Enter your password again" required>
            <!-- Make sure to check if both password match or not-->
            <br><br><button type="submit" name="submit-btn">Submit</button>
            <br><br><button type="button" name="new-btn" onclick="openLogin()">I already have a Buyer account dummy!</button>
          </form>
        </div>
      </div>  
    </div>`;
}


function openShopkeeper()
{
    var user = document.getElementById('cont');
    user.style.transistion = "";

    user.innerHTML=`<div class="card" id="cid">
      <div class="inner-box" id="iBox">
        <div class="card-front">
          <h1>Shopkeeper's Log In</h1><hr><br>
          <br><br><button type="button" name="new-btn" onclick="openBuyer()" style="width:50%">Switch to Buyer Login/SignUp</button>
          <form class="form" method="get" action="SLoginServlet">
            <h2>email id:</h2>
            <input type="email" class="input_box" name="email" placeholder="Enter your email id" required>
            <br><br>
            <h2>Password:</h2>
            <input type="password" class="input_box" name="password" placeholder="Enter your password" required>
            <br><br><button type="submit" name="submit-btn">Submit</button>
            <br><br><button type="button" name="new-btn" onclick="openAdminSignup()">I'm a new shop keeper here</button>
          </form>
        </div>

        <div class="card-back">
          <h2>Shopkeeper's Sign Up</h2><hr><br>

          <button type="button" name="new-btn" onclick="openBuyer()" style="width:50%">Switch to Buyer Login/SignUp</button>
          <form class="form" method="get" action="SSignupServlet">
            <h2>Shopkeeper Name:</h2>
            <input type="text" class="input_box" name="name" placeholder="Enter your Name" required>
            <br><br>

            <h2>Shop Name:</h2>
            <input type="text" class="input_box" name="sName" placeholder="Enter shop Name" required>
            <br><br>

            <h2>EMail id:</h2>
            <input type="email" class="input_box" name="email" placeholder="Enter your email id" required>

            <h2>Password:</h2>
            <input type="password" class="input_box" name="password" placeholder="Enter your password" required>
            
            <h2>Confirm Password:</h2>
            <input type="password" class="input_box" name="cpassword" placeholder="Enter your password again" required>
            <!-- Make sure to check if both password match or not-->
            
            <br><br><button type="submit" name="submit-btn">Submit</button>
            <br><br><button type="button" name="new-btn" onclick="openAdminLogin()">I already have a Buyer account dummy!</button>
          </form>
        </div>
      </div>  
    </div>`;
  }
  
  function openSignup()
  {
    var ele = document.getElementById('iBox');
    ele.style.transform = "rotateY(-180deg)";
  }

  function openLogin()
  {
    var ele = document.getElementById('iBox');
    ele.style.transform = "rotateY( 0deg)";
  }

  function openAdminSignup()
  {
    var ele = document.getElementById('iBox');
    ele.style.transform = "rotateY(-180deg)";
  }

  function openAdminLogin()
  {
    var ele = document.getElementById('iBox');
    ele.style.transform = "rotateY(0deg)";
  }
