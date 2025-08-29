<link rel="stylesheet" href="../../styles/common.css">
<link rel="stylesheet" href="logs.css">

<cfquery name="myquery" datasource="#application.datasource#">
  SELECT * FROM logs ORDER BY id DESC
</cfquery>

<!DOCTYPE html>
<html>
<head>
  <title><cfoutput>CRM - Activity Logs</cfoutput></title>
  <meta charset="UTF-8">
</head>

<div class="container">
  <h2>Activity Logs</h2>

  <table id="logTable">
    <thead>
      <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Action</th>
        <th>Request ID</th>
        <th>Timestamp</th>
        <th>Details</th>
      </tr>
    </thead>
    <tbody>
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
    </tbody>
  </table>

  <div id="pagination" class="pagination"></div>

  <div class="home-btn">
    <a class="home-link" href="../../pages/home Page/home.cfm">Back to Home</a>
  </div>
</div>

<script src="logs.js"></script>


