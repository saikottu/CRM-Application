<!DOCTYPE html>
<html>
<head>
  <title>CRM Home Page</title>
  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background-color: #f2f4f7;
    }

    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color:rgb(0, 123, 255);
      padding: 15px 20px;
      color: white;
    }

    .menu-icon {
      font-size: 26px;
      cursor: pointer;
      user-select: none;
    }

    .logout-btn a {
      background-color: white;
      color:rgb(0, 123, 255);
      padding: 8px 16px;
      border-radius: 5px;
      font-weight: bold;
      text-decoration: none;
    }

    .logout-btn a:hover {
      background-color: #e0e0e0;
    }

    .container {
      max-width: 600px;
      margin: 30px auto;
      background: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    h2 {
      text-align: center;
      margin-bottom: 20px;
      color: #1a1a1a;
    }
    #menu {
     display: none;
     position: absolute;
     top: 60px; /* adjust to appear below navbar */
     left: 20px;
     background: #f8f8f8;
     border-radius: 6px;
     padding: 15px 20px;
     box-shadow: 0 2px 8px rgba(0,0,0,0.15);
     z-index: 10;
    }

    .open .icon-menu {
      display: none;
    }

    .icon-close {
      display: none;
    }

    .open .icon-close {
      display: inline;
    }

    .open #menu {
      display: block;
    }

    ul {
      list-style-type: none;
      padding: 0;
    }

    li {
      margin: 10px 0;
    }

    a.menu-link {
      text-decoration: none;
      color:rgb(0, 123, 255);
      font-weight: bold;
    }

    a.menu-link:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

<!-- Navigation Bar -->
<div class="navbar">
  <div id="toggleBtn" class="menu-icon">
    <span class="icon-menu">&#9776;</span>
    <span class="icon-close">&#9776;</span>
  </div>

  <div class="logout-btn">
    <a href="logout.cfm">Logout</a>
  </div>
</div>

<cfif structkeyexists(session, "userid")>
  <div class="container">
    <h2>
      <cfoutput>Welcome, #session.username#</cfoutput>
    </h2>

    <div id="menu">
      <ul>
        <li><a href="Profile.cfm" class="menu-link">Go to my Profile</a></li>
        <li><a href="requests.cfm" class="menu-link">Submit Request</a></li>
        <li><a href="submitted_requests.cfm" class="menu-link">View Requests</a></li>
        <cfif session.username EQ "admin">
         <li><a href="logs.cfm" class="menu-link">View Logs</a></li>
         <li><a href="customers.cfm" class="menu-link">Customers</a></li>
         <li><a href="users.cfm" class="menu-link">Registered Users</a></li>
        </cfif>
         
      </ul>
    </div>
  </div>
<cfelse>
  <cflocation url="login.cfm">
</cfif>

<script>
  const toggleBtn = document.getElementById("toggleBtn");
  const body = document.body;

  toggleBtn.addEventListener("click", function () {
    body.classList.toggle("open");
  });
</script>

</body>
</html>
