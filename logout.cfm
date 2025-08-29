<cfif NOT structkeyexists(session, "userid")>
   <cflocation url="login.cfm">
</cfif>

<cfset structclear(session)>
<cflocation url="login.cfm">