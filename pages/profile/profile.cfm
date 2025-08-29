<cfif structKeyExists(form, "submit")>
  <cfif structKeyExists(form, "fileUpload") AND len(form.fileUpload) GT 0>
    <cffile 
      action="upload"
      fileField="fileUpload"
      destination="#expandPath('/CRMv2/uploads')#"
      accept="image/jpeg,image/png,image/gif"
      nameConflict="makeunique"
      result="uploadResult">
    
    <cfset session.profilePic = "/CRMv2/uploads/#uploadResult.serverFile#">
    
    <cfquery name="updateProfilePic" datasource="#application.datasource#">
      UPDATE users
      SET profile_picture = <cfqueryparam value="#uploadResult.serverFile#" cfsqltype="cf_sql_varchar">
      WHERE id = <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">
    </cfquery>
    
    <cflocation url="profile.cfm?upload=success">
  </cfif>
</cfif>

<cfif structKeyExists(form, "delete")>
  <cfif structKeyExists(session, "profilePic") AND fileExists(expandPath(session.profilePic))>
    <cffile action="delete" file="#expandPath(session.profilePic)#">
  </cfif>
  <cfset structDelete(session, "profilePic")>
  <cflocation url="profile.cfm?upload=delete">
</cfif>

<link rel="stylesheet" href="../../styles/common.css">
<link rel="stylesheet" href="profile.css">

<!DOCTYPE html>
<html>
<head>
  <title><cfoutput>CRM - My Profile</cfoutput></title>
  <meta charset="UTF-8">
</head>

<cfif structKeyExists(url, "upload")>
  <cfif url.upload EQ "success">
    <script>
      alert("Successfully Uploaded!");
      window.location.href = "profile.cfm";
    </script>
  <cfelseif url.upload EQ "delete">
    <script>
      alert("Successfully Deleted!");
      window.location.href = "profile.cfm";
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
  <form enctype="multipart/form-data" method="post">
      <label>Upload New Profile Picture:</label><br><br>
      <input type="file" name="fileUpload"><br><br>
      <input type="submit" name="submit" value="Upload" class="upload-btn">
  </form>

  <!-- Delete Form -->
  <form method="post">
      <input type="submit" name="delete" value="Delete Profile Picture" class="delete-btn">
  </form>

  <a href="../../pages/home Page/home.cfm" class="home-link">Back to Home</a>
</div>

