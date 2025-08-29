<link rel="stylesheet" href="../../styles/common.css">
<link rel="stylesheet" href="home.css">
<!DOCTYPE html>
<html>
<head>
  <title><cfoutput>CRM - Home Page</cfoutput></title>
  <meta charset="UTF-8">
</head>
<div class="page-content">
  <div class="sidebar" id="menu">
    <ul>
      <li><a href="../../pages/profile/profile.cfm" class="menu-link">Go to my Profile</a></li>
      <li>
        <input type="checkbox" id="openInNewTab" value="box" >
        <a href="../../pages/requests/submit_request/submit_request.cfm" class="menu-link" id="submitRequestLink">Submit Request</a>
      </li>
      <li><a href="../../pages/requests/view_requests/view_requests.cfm" class="menu-link">View Requests</a></li>
      <cfif session.username EQ "admin">
        <li><a href="../../pages/activity logs/logs.cfm" class="menu-link">View Logs</a></li>
        <li><a href="../../pages/customer management/customers/customers.cfm" class="menu-link">Customers</a></li>
        <li><a href="../../pages/user registrations/user.cfm" class="menu-link">Registered Users</a></li>
      </cfif>
    </ul>
  </div>

  <div class="main-content">
    <h2><cfoutput>Welcome, #session.username#</cfoutput></h2>
  </div>
</div>

<script src="home.js"></script>
