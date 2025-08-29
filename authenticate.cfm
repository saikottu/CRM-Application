<cfparam name="form.username" default="">
<cfparam name="form.password" default="">

<cfif structkeyexists(form, "username") AND structkeyexists(form, "password")>

    <cfquery name="myquery" datasource="user">
        SELECT id, username, profile_picture
        FROM users
        WHERE username = <cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">
        AND password = <cfqueryparam value="#form.password#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfif myquery.recordcount EQ 1>
        <cfset session.userid = myquery.id>
        <cfset session.username = form.username>
        <cfif len(myquery.profile_picture)>
         <cfset session.profilePic = "/CRMv2/uploads/#myquery.profile_picture#">
        </cfif>
        <cflocation url="home.cfm">
    <cfelse>
        <cflocation url="login.cfm?error=true">
    </cfif>

</cfif>
