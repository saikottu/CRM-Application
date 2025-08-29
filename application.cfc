<cfcomponent>
 <cfset this.name = "CRMv2"> 
    <cfset this.sessionManagement = true>
    <cfset this.applicationTimeout = createTimeSpan(0, 2, 0, 0)>
    <cfset this.sessionTimeout = createTimeSpan(0, 0, 30, 0)>

    
    <!-- Runs when a session starts -->
    <cffunction name="onSessionStart" returnType="void">
        <cfset session.started = now()>
    </cffunction>

    <!-- Runs when a session ends -->
    <cffunction name="onSessionEnd" returnType="void">
        <cfargument name="sessionScope" required="true">
        <!--- You can log session info or perform cleanup here --->
        <cflog file="sessionLog" text="Session ended for user: #structKeyExists(arguments.sessionScope, 'username') ? arguments.sessionScope.username : 'Unknown'#">
    </cffunction>

    <!-- Runs when the application starts -->
    <cffunction name="onApplicationStart" returnType="boolean">
        <cfreturn true>
    </cffunction>

    <!-- Runs when the application ends -->
    <cffunction name="onApplicationEnd" returnType="void">
        <cfargument name="applicationScope" required="true">
        <!--- You can log shutdown or release resources here --->
        <cflog file="appLog" text="Application CRMApp ended at #now()#">
    </cffunction>
</cfcomponent>

