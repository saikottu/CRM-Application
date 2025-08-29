<cfif NOT structkeyexists(session, "userid")>
   <cflocation url="login.cfm">
</cfif>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Submit Request</title>
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
      background-color: rgb(0, 123, 255);
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
      color: rgb(0, 123, 255);
      padding: 8px 16px;
      border-radius: 5px;
      font-weight: bold;
      text-decoration: none;
    }

    .logout-btn a:hover {
      background-color: #e0e0e0;
    }

    .toggle-menu {
      display: none;
      padding: 10px;
      margin: 10px;
      background-color: #f0f0f0;
      border-radius: 6px;
    }

    .toggle-menu a {
      text-decoration: none;
      color: rgb(0, 123, 255);
      font-weight: bold;
    }

    .form-container {
      max-width: 500px;
      margin: 50px auto;
      background: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    h2 {
      text-align: center;
      margin-bottom: 20px;
      color: #333;
    }

    label {
      display: block;
      margin: 10px 0 5px;
      font-weight: bold;
    }

    input[type="text"],
    textarea {
      width: 95%;
      padding: 10px;
      margin-bottom: 15px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    input[type="submit"] {
      background-color: rgb(0, 123, 255);
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      width: 100%;
      font-size: 16px;
    }

    .back-link {
      display: block;
      text-align: center;
      margin-top: 15px;
    }

    .back-link a {
      color: rgb(0, 123, 255);
      text-decoration: none;
      font-size: 16px;
    }

    .back-link a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

<!-- Top Navbar -->
<div class="navbar">
  <div class="menu-icon" onclick="toggleMenu()">&#9776;</div>
  <div class="logout-btn">
    <a href="submitted_requests.cfm">View Requests</a>
    <a href="logout.cfm">Logout</a>
  </div>
</div>



<!-- Form processing logic -->



<!-- Form Container -->
<div class="form-container">
  <h2>Submit a New Request</h2>

  <form method="post">
    <label>Title</label>
    <input type="text" name="title" placeholder="Enter Title" required>

    <label>Description</label>
    <textarea name="description" placeholder="Enter Description" rows="4" required></textarea>

    <input type="submit" name="submit" value="Submit">
  </form>

  <div class="back-link">
    <a href="home.cfm">Back to Home</a>
  </div>
</div>

<cfparam name="form.title" default="">
<cfparam name="form.description" default="">


<cfif structkeyexists(form, "submit")>
  <cfquery name="ourquery" datasource="user">
    INSERT INTO requests (title, description)
    VALUES (
      <cfqueryparam value="#form.title#" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="#form.description#" cfsqltype="cf_sql_varchar">
    )
  </cfquery>

  <cfquery name="getID" datasource="user">
    SELECT LAST_INSERT_ID() AS requestID
  </cfquery>

  <cfset newRequestID = getID.requestID>
  
  <cfquery name="logquery" datasource="user">
   INSERT INTO logs(user_id, username, action, request_id, details)
   VALUES (
      <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">,
      <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="Submit Request" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="#newRequestID#" cfsqltype="cf_sql_integer">,
      <cfqueryparam value="Created Request with Title #form.title#" cfsqltype="cf_sql_varchar">
   )
  </cfquery>
   <cflocation url="submitted_requests.cfm?success=true">
   
</cfif>

<!-- JavaScript -->
<script>
  function toggleMenu() {
    var menu = document.getElementById("toggleMenu");
    menu.style.display = (menu.style.display === "block") ? "none" : "block";
  }
</script>

</body>
</html>
