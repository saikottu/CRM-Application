<cfset logFilePath = "C:\ColdFusion2023\cfusion\logs\ActivityLogs.log">

<cftry>
    <cfif fileExists(logFilePath)>
    <cfset logContents = fileRead(logFilePath)>
    <cfset logLines = listToArray(logContents, chr(10))>

    <h3>Activity Log Output</h3>

    <table border="1" cellpadding="5" >
	    <tr>
		 <th>User</th>
		 <th>Action</th>
		 <th>RequestID</th>
		 <th>Details</th>
		</tr>
        <cfoutput>
        <cfloop array="#logLines#" index="line">
            <cfset columns = listToArray(line, "|")>
            <tr>
                <cfloop array="#columns#" index="col">
                    <td>#htmlEditFormat(trim(col))#</td>
                </cfloop>
            </tr>
        </cfloop>
        </cfoutput>
    </table>


    <cfelse>
        <cfoutput><p style="color: red;">Log file does not exist at: #logFilePath#</p></cfoutput>
    </cfif>

    <cfcatch type="any">
        <cfoutput><p style="color: red;">Error reading log file: #cfcatch.message#</p></cfoutput>
    </cfcatch>
</cftry>