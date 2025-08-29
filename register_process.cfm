<cfparam name="form.username" default="">
<cfparam name="form.password" default="">
<cfparam name="form.cpassword" default="">

<cfif form.password EQ form.cpassword>

    <!-- Check if username already exists -->
    <cfquery name="checkUser" datasource="user">
        SELECT id FROM users WHERE username = <cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfif checkUser.recordCount EQ 0>
        <!-- Username is unique, insert new user -->
        <cfquery name="insertUser" datasource="user">
            INSERT INTO users (username, password)
            VALUES (
                <cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.password#" cfsqltype="cf_sql_varchar">
            )
        </cfquery>

        <!-- Redirect to register page with success -->
        <cflocation url="register.cfm?success=true">

    <cfelse>
        <!-- Username already exists -->
        <cflocation url="register.cfm?error=username">
    </cfif>

<cfelse>
    <!-- Passwords do not match -->
    <cflocation url="register.cfm?error=password">
</cfif>
