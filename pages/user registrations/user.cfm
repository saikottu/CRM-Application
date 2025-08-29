<link rel="stylesheet" href="../../styles/common.css">
<link rel="stylesheet" href="user.css">
<!DOCTYPE html>
<html>
<head>
  <title><cfoutput>CRM - User Registrations</cfoutput></title>
  <meta charset="UTF-8">
</head>
<body>
<!-- Get all users -->
<cfquery name="userfetch" datasource="#application.datasource#">
    SELECT * FROM users
    ORDER BY id DESC
</cfquery>

<div class="container">
    <h2>Registered Users</h2>

    <cfif userfetch.recordcount EQ 0>
        <cfoutput>No Users are Registered</cfoutput>
    <cfelse>
        <table id="userTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query="userfetch">
                    <tr>
                        <td>#id#</td>
                        <td>#username#</td>
                        <td>
                            <cfif username EQ "admin">
                                Admin
                            <cfelse>
                                General User
                            </cfif>
                        </td>
                    </tr>
                </cfoutput>
            </tbody>
        </table>

        <!-- Placeholder for pagination -->
        <div class="pagination" id="pagination"></div>
    </cfif>

    <div class="home-btn">
        <a href="../../pages/home Page/home.cfm" class="home-link">Back to Home</a>
    </div>
</div>

<!-- Include jQuery and custom JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="user.js"></script>

