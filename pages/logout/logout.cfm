<cfset structClear(session)>
<cfset sessionInvalidate()>
<cflocation url="../../pages/login/login.cfm?error=logout">