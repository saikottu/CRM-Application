<link rel="stylesheet" href="../../../styles/common.css">
<link rel="stylesheet" href="view_requests.css?v=6">
<script src="view_requests.js"></script>

<!DOCTYPE html>
<html>
<head>
  <title><cfoutput>CRM - View Requests</cfoutput></title>
  <meta charset="UTF-8">
</head>

<cfif structKeyExists(url, "success") AND url.success EQ "true">
  <script>alert("Successfully submitted a request!");</script>
</cfif>

<cfparam name="url.search" default="">
<cfset searchTerm = trim(url.search)>

<!-- Query: Get all filtered records -->
<cfquery name="getreq" datasource="#application.datasource#">
  SELECT * FROM requests
  WHERE 1=1
  <cfif structKeyExists(form, "department") AND len(trim(form.department))>
    AND department LIKE <cfqueryparam value="#form.department#" cfsqltype="cf_sql_varchar">
  </cfif>
  <cfif len(searchTerm)>
    AND (title LIKE <cfqueryparam value="%#searchTerm#%" cfsqltype="cf_sql_varchar">
         OR description LIKE <cfqueryparam value="%#searchTerm#%" cfsqltype="cf_sql_varchar">)
  </cfif>
  ORDER BY id DESC
</cfquery>

<cfif structkeyexists(form, "reset")>
 <cflocation url="view_requests.cfm">
</cfif>

<!-- MAIN CONTENT -->
<div class="container">
  <h2>Your Submitted Requests</h2>

  <div class="top-row">
    <div class="left-side">
      <form method="post">
        <select name="department">
          <option value="">-- All Departments --</option>
          <option value="HR" <cfif structKeyExists(form, "department") AND form.department EQ "HR">selected</cfif>>HR</option>
          <option value="Finance" <cfif structKeyExists(form, "department") AND form.department EQ "finance">selected</cfif>>Finance</option>
          <option value="IT" <cfif structKeyExists(form, "department") AND form.department EQ "it">selected</cfif>>IT</option>
          <option value="Sales" <cfif structKeyExists(form, "department") AND form.department EQ "sales">selected</cfif>>Sales</option>
          <option value="Admin" <cfif structKeyExists(form, "department") AND form.department EQ "admin">selected</cfif>>Admin</option>
        </select>
        <input type="submit" value="filter">
        <input type="submit" value="reset" name="reset">
      </form>
    </div>
    <div class="right-side">
      <cfoutput>
        <a href="../../../pages/requests/request_report/request_report.cfm?department=#URLEncodedFormat(structKeyExists(form, 'department') ? form.department : '')#" class="download-btn">Download Report</a>
      </cfoutput>
    </div>
  </div>

  <!-- Search Row -->
  <div class="search-row">
    <form method="get" action="view_requests.cfm">
      <input type="text" name="search" placeholder="Search title or description" value="<cfoutput>#url.search#</cfoutput>">
      <input type="submit" value="Search" class="search-btn">
    </form>
  </div>

  <!-- Records Table -->
  <table id="viewRequestsTable">
    <thead>
      <tr>
        <th>Title</th>
        <th>Description</th>
        <th>Department</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      <cfoutput query="getreq">
        <tr>
          <td>#title#</td>
          <td>#description#</td>
          <td>#department#</td>
          <td>
            <a href="../../../pages/requests/edit_request/edit.cfm?id=#id#" class="btn-edit">Edit</a>
            <a href="../../../pages/requests/delete_request/delete.cfm?id=#id#" class="btn-delete" onclick="return confirm('Are you sure you want to delete this request?')">Delete</a>
          </td>
        </tr>
      </cfoutput>

      <cfif getreq.recordcount EQ 0>
        <tr><td colspan="4">No records found</td></tr>
      </cfif>
    </tbody>
  </table>

  <!-- Pagination Container -->
  <div class="pagination" id="pagination"></div>

  <!-- Back Button -->
  <div class="home-btn">
    <a href="../../../pages/home Page/home.cfm" class="home-link">Back to Home</a>
  </div>
</div>
