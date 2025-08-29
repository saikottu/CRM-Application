<cfif NOT structkeyexists(session, "userid")>
  <cflocation url="login.cfm">
</cfif>

<!DOCTYPE html>
<html>
<head>
  <title>CRM - View Logs</title>
  <meta charset="UTF-8">
  <style>
    body {
      margin: 10px;
      font-family: Arial, sans-serif;
      background-color: #f2f4f7;
    }

    .container {
      max-width: 1150px;
      margin: 0px auto;
      background: white;
      padding: 25px;
      border-radius: 8px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
      margin: 0px;
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

    .homebtn-container {
      text-align: center;
      margin-top: 20px;
    }

    .home-btn {
      background-color: rgb(0, 123, 255);
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
      display: inline-block;
      text-decoration: none;
    }
    
    .pagination {
    text-align: center;
    margin-top: 20px;
  }
  .pagination a {
    display: inline-block;
    width: 35px;
    height: 35px;
    line-height: 35px;
    margin: 0 5px;
    text-align: center;
    text-decoration: none;
    font-weight: bold;
    font-size: 16px;
    border-radius: 6px;
    color: white;
    background-color:rgb(0, 123, 255);
  }

  .pagination strong {
    display: inline-block;
    width: 35px;
    height: 35px;
    line-height: 35px;
    margin: 0 5px;
    text-align: center;
    font-weight: bold;
    font-size: 16px;
    border-radius: 6px;
    background-color: #ccc;
    color: black;
  }

  .pagination a:hover {
    background-color:rgb(0, 123, 255);
  }
  .pagination a.pagi-pn {
    min-width: 50px;
    padding: 8px 5px;
    height: auto;
    line-height: normal;
  }
  </style>
</head>
<body>

<cfparam name="url.page" default="1">
<cfset recordsPerPage = 8>
<cfset currentPage = url.page>

<!--- total number of records --->
<cfquery name="getTotal" datasource="user">
  SELECT COUNT(*) AS total FROM logs
</cfquery>
<cfset totalRecords = getTotal.total>
<cfset totalPages = ceiling(totalRecords / recordsPerPage)>
<cfset startRow = (currentPage - 1) * recordsPerPage>

<cfquery name="myquery" datasource="user">
  SELECT * FROM logs
  ORDER BY id DESC
  LIMIT <cfqueryparam value="#recordsPerPage#" cfsqltype="cf_sql_integer">
  OFFSET <cfqueryparam value="#startRow#" cfsqltype="cf_sql_integer"> 
</cfquery>

<div class="container">
  <h2>Activity Logs</h2>

  <table>
    <tr>
      <th>ID</th>
      <th>Username</th>
      <th>Action</th>
      <th>Request ID</th>
      <th>Timestamp</th>
      <th>Details</th>
    </tr>
    <cfoutput query="myquery">
      <tr>
        <td>#id#</td>
        <td>#username#</td>
        <td>#action#</td>
        <td>#request_id#</td>
        <td>#timestamp#</td>
        <td>#details#</td>
      </tr>
    </cfoutput>
  </table>

  <div class="pagination">
    <cfoutput>
      <!-- Previous Button -->
      <cfif currentPage GT 1>
        <a href="logs.cfm?page=#currentPage - 1#" class="pagi-pn">Prev</a>
      </cfif>

      <!-- Page Numbers -->
      <cfloop from="1" to="#totalPages#" index="i">
        <cfif i EQ currentPage>
          <strong>#i#</strong>
        <cfelse>
          <a href="logs.cfm?page=#i#">#i#</a>
        </cfif>
      </cfloop>

      <!-- Next Button -->
      <cfif currentPage LT totalPages>
        <a href="logs.cfm?page=#currentPage + 1#" class="pagi-pn">Next</a>
      </cfif>
    </cfoutput>
  </div>

  <!--- Back to Home Button --->
  <div class="homebtn-container">
    <a class="home-btn" href="home.cfm">Back to Home</a>
  </div>
</div>

</body>
</html>
