<!DOCTYPE html>
<html>
<head>
  <title>Register</title>
  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background-color: #f2f4f7;
    }

    .form-container {
      max-width: 400px;
      margin: 60px auto;
      background: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    h2 {
      text-align: center;
      color: #333;
    }

    label {
      display: block;
      margin-top: 15px;
      font-weight: bold;
    }

    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    input[type="submit"] {
      background-color: green;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      margin-top: 20px;
      width: 100%;
      font-size: 16px;
    }

    input[type="submit"]:hover {
      background-color: green;
    }

    .login-link {
      text-align: center;
      margin-top: 20px;
    }

    .login-link a {
      color:  green;
      text-decoration: none;
      font-weight: bold;
    }

    .login-link a:hover {
      text-decoration: underline;
    }

    .success-msg {
      color: green;
      text-align: center;
      margin-top: 10px;
    }

    .error-msg {
      color: red;
      text-align: center;
      margin-top: 10px;
    }
  </style>
</head>
<body>

<div class="form-container">
  <h2>User Registration</h2>

  <!-- Alert Messages -->
  <cfif structKeyExists(url, "error")>
    <cfif url.error EQ "username">
      <script>alert("Username already exists or registration failed");</script>
    <cfelseif url.error EQ "password">
      <script>alert("Password Incorrect");</script>
    </cfif>
  <cfelseif structKeyExists(url, "success")>
    <script>alert("Registration successful!");</script>
  </cfif>

  <!-- Registration Form -->
  <form method="post" action="register_process.cfm">
    <label>Username:</label>
    <input type="text" name="username" required>

    <label>Enter Password:</label>
    <input type="password" name="password" required>

    <label>Confirm Password:</label>
    <input type="password" name="cpassword" required>

    <input type="submit" value="Register">
  </form>

  <div class="login-link">
    Already registered? <a href="login.cfm">Login Here</a>
  </div>
</div>

</body>
</html>
