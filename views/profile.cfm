<link rel="stylesheet" href="css/profile.css">

<cfif structKeyExists(url, "upload")>
  <cfif url.upload EQ "success">
    <script>
      alert("Successfully Uploaded!");
      window.location.href = "index.cfm?crm=profile";
    </script>
  <cfelseif url.upload EQ "delete">
    <script>
      alert("Successfully Deleted!");
      window.location.href = "index.cfm?crm=profile";
    </script>
  </cfif>
</cfif>

<div class="container">
  <cfoutput>
    <h2>Welcome, #session.username#</h2>
  </cfoutput>

  <cfif structKeyExists(session, "profilePic") AND len(trim(session.profilePic)) GT 0>
    <cfoutput>
      <img src="#session.profilePic#" class="profile-pic" alt="Profile Picture">
    </cfoutput>
  <cfelse>
    <p>No profile picture uploaded.</p>
  </cfif>

  <!-- Upload Form -->
  <form enctype="multipart/form-data" method="post" action="index.cfm?crm=addpic">
      <label>Upload New Profile Picture:</label><br><br>
      <input type="file" name="fileUpload"><br><br>
      <input type="submit" name="submit" value="Upload" class="upload-btn">
  </form>

  <!-- Delete Form -->
  <form method="post" action="index.cfm?crm=deletepic">
      <input type="submit" name="delete" value="Delete Profile Picture" class="delete-btn">
  </form>

  <a href="index.cfm" class="home-link">Back to Home</a>
</div>

