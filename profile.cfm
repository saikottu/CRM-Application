<cfif NOT structKeyExists(session, "userid")>
    <cflocation url="login.cfm">
</cfif>

<!DOCTYPE html>
<html>
<head>
    <title>CRM User Profile Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }
        .container {
            background: white;
            padding: 30px;
            margin: 60px auto;
            width: 400px;
            text-align: center;
            border-radius: 12px;
            box-shadow: 0px 0px 15px rgba(0,0,0,0.1);
        }
        .upload-btn {
            background-color: green;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .delete-btn {
            background-color: red;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
            cursor: pointer;
        }
        a.home-link {
            display: block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
        }
        img.profile-pic {
            margin-top: 15px;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #ddd;
        }
    </style>
</head>
<body>
<cfif structKeyExists(url, "upload")>
  <cfif url.upload EQ "success">
    <script>alert("Successfully Uploaded!");</script>
  <cfelseif url.upload EQ "delete">
    <script>alert("Successfully Deleted!");</script>
  </cfif>
</cfif>

<div class="container">
    <cfoutput>
        <h2>Welcome, #session.username#</h2>
    </cfoutput>

    <!-- Show profile image if uploaded -->
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

    <a href="home.cfm" class="home-link">Back to Home</a>

    <!-- Handle Upload -->
    <cfif structKeyExists(form, "submit")>
      <cfif structKeyExists(form, "fileUpload") AND len(form.fileUpload) GT 0>
        <cffile 
          action="upload"
          fileField="fileUpload"
          destination="C:\ColdFusion2023\cfusion\wwwroot\CRMv2\uploads"
          accept="image/jpeg,image/png,image/gif"
        nameConflict="makeunique"
        result="uploadResult">
        <cfset session.profilePic = "/CRMv2/uploads/#uploadResult.serverFile#">
        <cfquery name="updateProfilePic" datasource="user">
         UPDATE users
         SET profile_picture = <cfqueryparam value="#uploadResult.serverFile#" cfsqltype="cf_sql_varchar">
         WHERE id = <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cflocation url="profile.cfm?upload=success">
      </cfif>
    </cfif>

    <!-- Handle Deletion -->
    <cfif structKeyExists(form, "delete")>
        <cfif structKeyExists(session, "profilePic") AND fileExists(expandPath(session.profilePic))>
          <cffile action="delete" file="#expandPath(session.profilePic)#">
        </cfif>
        <cfset structDelete(session, "profilePic")>
        <cflocation url="profile.cfm?upload=delete">
    </cfif>
</div>
</body>
</html>
