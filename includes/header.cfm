<body>
<!-- Navigation Bar -->
<div class="header">
  <div id="toggleBtn" class="menu-icon">&#9776;</div>
  <div class="right-section">
    <cfoutput>
      <p>Logged in as</p>|<span class="username">#session.username#</span>
      <a href="#application.logoutPath#" class="logout-btn">Logout</a>
    </cfoutput>
  </div>
</div>
