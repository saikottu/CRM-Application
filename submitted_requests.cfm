<cfif NOT structkeyexists(session, "userid")>
   <cflocation url="login.cfm">
</cfif>

<cfif structKeyExists(url, "success") AND url.success EQ "true">
  <script>alert("Successfully submitted a request!");</script>
</cfif>

<cfparam name="url.search" default="">
<cfset searchTerm = trim(url.search)>
<cfparam name="url.page" default="1">
<cfset recordsperpage = 5>
<cfset currentpage = url.page>
<cfset startrow = (currentpage - 1) * recordsperpage>

<!-- Count total matching records -->
<cfquery name="getTotal" datasource="user">
  SELECT COUNT(*) AS total
  FROM requests
  <cfif len(searchTerm)>
    WHERE title LIKE <cfqueryparam value="%#searchTerm#%" cfsqltype="cf_sql_varchar">
       OR description LIKE <cfqueryparam value="%#searchTerm#%" cfsqltype="cf_sql_varchar">
  </cfif>
</cfquery>
<cfset totalrecords = getTotal.total>
<cfset totalpages = ceiling(totalrecords / recordsperpage)>

<!-- Fetch matching records -->
<cfquery name="getreq" datasource="user">
  SELECT * FROM requests
  <cfif len(searchTerm)>
    WHERE title LIKE <cfqueryparam value="%#searchTerm#%" cfsqltype="cf_sql_varchar">
       OR description LIKE <cfqueryparam value="%#searchTerm#%" cfsqltype="cf_sql_varchar">
  </cfif>
  ORDER BY id DESC
  LIMIT <cfqueryparam value="#recordsperpage#" cfsqltype="cf_sql_integer">
  OFFSET <cfqueryparam value="#startrow#" cfsqltype="cf_sql_integer">
</cfquery>

<!DOCTYPE html>
<html>
<head>
  <title>Submitted Requests</title>
  <meta charset="UTF-8">
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
      padding: 12px 20px;
      color: white;
    }

    .navbar a {
      color: white;
      text-decoration: none;
      font-weight: bold;
      margin: 0 10px;
    }

    .navbar a:hover {
      text-decoration: underline;
    }

    .container {
      max-width: 800px;
      margin: 40px auto;
      background: white;
      padding: 25px;
      border-radius: 8px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
      text-align: center;
      color: #333;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }

    th, td {
      padding: 12px 15px;
      border: 1px solid #ddd;
      text-align: center;
    }

    th {
      background-color: rgb(0, 123, 255);
      color: white;
    }

    a.btn-edit {
      background-color: orange;
      padding: 5px 10px;
      color: white;
      border-radius: 4px;
      text-decoration: none;
    }

    a.btn-delete {
      background-color: red;
      padding: 5px 10px;
      color: white;
      border-radius: 4px;
      text-decoration: none;
    }

    a.btn-edit:hover, a.btn-delete:hover {
      opacity: 0.9;
    }

    .home-btn {
      margin-top: 20px;
      text-align: center;
    }

    .home-btn a {
      background-color: rgb(0, 123, 255);
      color: white;
      padding: 10px 20px;
      border-radius: 6px;
      text-decoration: none;
      font-size: 16px;
    }

    .home-btn a:hover {
      background-color: #0056b3;
    }

    .pagination {
      text-align: center;
      margin-top: 20px;
    }

    .pagination a, .pagination strong {
      display: inline-block;
      width: 35px;
      height: 35px;
      line-height: 35px;
      margin: 0 5px;
      text-align: center;
      font-weight: bold;
      font-size: 16px;
      border-radius: 6px;
    }

    .pagination a {
      background-color: rgb(0, 123, 255);
      color: white;
      text-decoration: none;
    }

    .pagination strong {
      background-color: #ccc;
      color: black;
    }

    .pagination a:hover {
      background-color: #0056b3;
    }

    .pagination a.pagi-pn {
      min-width: 50px;
      padding: 8px 5px;
      height: auto;
      line-height: normal;
    }

    .top-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      gap: 10px;
      flex-wrap: wrap;
      margin-bottom: 15px;
    }

    .top-row select {
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 15px;
      width: 250px;
    }

    .download-btn {
      background-color: #007bff;
      color: white;
      border: none;
      padding: 10px 18px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 15px;
      font-weight: bold;
      text-decoration: none;
      transition: background-color 0.3s ease;
    }

    .download-btn:hover {
      background-color: #0056b3;
    }

    .search-row {
      margin: 15px 0;
      text-align: center;
    }

    .search-row input[type="text"] {
      padding: 10px;
      width: 100%;
      max-width: 500px;
      font-size: 15px;
      border: 1px solid #ccc;
      border-radius: 6px;
      box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
    }

    .search-btn {
      padding: 10px 20px;
      margin-top: 10px;
      font-size: 15px;
      border: none;
      border-radius: 6px;
      background-color: rgb(0, 123, 255);
      color: white;
      cursor: pointer;
      font-weight: bold;
    }

    .search-btn:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>

<!-- NAVBAR -->
<div class="navbar">
  <div><a href="requests.cfm">Submit Request</a></div>
  <div><a href="logout.cfm">Logout</a></div>
</div>

<!-- MAIN CONTENT -->
<div class="container">
  <h2>Your Submitted Requests</h2>

  <div class="top-row">
  <div class="left-side">
    <select name="department">
      <option value="">-- All Departments --</option>
      <option value="HR">HR</option>
      <option value="Finance">Finance</option>
      <option value="IT">IT</option>
      <option value="Sales">Sales</option>
      <option value="Admin">Admin</option>
    </select>
  </div>
  <div class="right-side">
    <a href="request_report.cfm" class="download-btn">Download Report</a>
  </div>
</div>


  <!-- Search Row -->
  <div class="search-row">
    <form method="get" action="submitted_requests.cfm">
      <input type="text" name="search" placeholder="Search title or description" value="<cfoutput>#url.search#</cfoutput>">
      <input type="submit" value="Search" class="search-btn">
    </form>
  </div>

  <!-- Records Table -->
  <table>
    <tr>
      <th>Title</th>
      <th>Description</th>
      <th>Actions</th>
    </tr>

    <cfoutput query="getreq">
      <tr>
        <td>#title#</td>
        <td>#description#</td>
        <td>
          <a href="edit.cfm?id=#id#" class="btn-edit">Edit</a>
          <a href="delete.cfm?id=#id#" class="btn-delete" onclick="return confirm('Are you sure you want to delete this request?')">Delete</a>
        </td>
      </tr>
    </cfoutput>

    <cfif getreq.recordcount EQ 0>
      <tr><td colspan="3">No records found</td></tr>
    </cfif>
  </table>

  <!-- Pagination -->
  <div class="pagination">
    <cfoutput>
      <cfif currentpage GT 1>
        <a href="submitted_requests.cfm?page=#currentpage - 1#&search=#urlEncodedFormat(searchTerm)#" class="pagi-pn">Prev</a>
      </cfif>

      <cfloop from="1" to="#totalpages#" index="i">
        <cfif i EQ currentpage>
          <strong>#i#</strong>
        <cfelse>
          <a href="submitted_requests.cfm?page=#i#&search=#urlEncodedFormat(searchTerm)#">#i#</a>
        </cfif>
      </cfloop>

      <cfif currentpage LT totalpages>
        <a href="submitted_requests.cfm?page=#currentpage + 1#&search=#urlEncodedFormat(searchTerm)#" class="pagi-pn">Next</a>
      </cfif>
    </cfoutput>
  </div>

  <!-- Back Button -->
  <div class="home-btn"><a href="home.cfm">Back to Home</a></div>
</div>

</body>
</html>
