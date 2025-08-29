<cfif NOT structkeyexists(session, "userid")>
    <cflocation url="login.cfm">
</cfif>

<cfif structKeyExists(url, "download") AND url.download EQ "true">

    <cfcontent type="application/pdf">
    <cfheader name="Content-Disposition" value="attachment;filename=request_report.pdf">

    <cfquery name="getRequests" datasource="user">
        SELECT id, title, description
        FROM requests
        ORDER BY id DESC
    </cfquery>

    <cfset reportDate = dateFormat(now(), "dd-mmm-yyyy")>

    <cfdocument format="pdf" fontembed="yes" marginTop="1" marginBottom="1" marginLeft="1" marginRight="1">
        <cfdocumentsection>
            <cfdocumentitem type="header">
                <h2 style="text-align:center;">Your Submitted Requests</h2>
                <p style="text-align:center;">Generated on <cfoutput>#reportDate#</cfoutput></p>
            </cfdocumentitem>

            <table style="width:100%; border-collapse:collapse; font-family:Arial;">
                <tr style="background-color:#003399; color:white;">
                    <th style="border:1px solid #000; padding:8px;">ID</th>
                    <th style="border:1px solid #000; padding:8px;">Title</th>
                    <th style="border:1px solid #000; padding:8px;">Description</th>
                </tr>

                <cfloop query="getRequests">
                    <tr>
                        <td style="border:1px solid #000; padding:8px;">
                            <cfoutput>#getRequests.id#</cfoutput>
                        </td>
                        <td style="border:1px solid #000; padding:8px;">
                            <cfoutput>#getRequests.title#</cfoutput>
                        </td>
                        <td style="border:1px solid #000; padding:8px;">
                            <cfoutput>#getRequests.description#</cfoutput>
                        </td>
                    </tr>
                </cfloop>
            </table>
        </cfdocumentsection>
    </cfdocument>

<cfelse>

<!-- HTML Page with Success Message and Styled Button -->
<!DOCTYPE html>
<html>
<head>
    <title>CRM Download Report</title>
    <meta charset="UTF-8">
    <style>
        body {
            background-color: #f6f6f6;
            font-family: Arial, sans-serif;
            text-align: center;
            padding-top: 100px;
        }

        .success-msg {
            color: green;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .download-link {
            display: inline-block;
            background-color:rgb(0, 123, 255);
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            font-size: 16px;
        }

        .download-link:hover {
            background-color:rgb(0, 123, 255);}

        .back-btn {
         margin-top: 20px;
         text-align: center;
        }

        .back-btn a {
         color: rgb(0, 123, 255);
         text-decoration: none;
         font-size: 16px;
        }
        .back-btn a:hover {
         text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="success-msg">Customer PDF Report generated successfully</div>
    <a href="request_report.cfm?download=true" class="download-link">DOWNLOAD HERE</a></br>
    <div class="back-btn"><a href="submitted_requests.cfm">Back to View Requests</a></div>
</body>
</html>

</cfif>
