<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CRM Users Registrations</title>
    <style>
        body {
            margin: 10px;
            font-family: Arial, sans-serif;
            background-color: #f2f4f7;
        }

        .container {
            max-width: 1150px;
            margin: 0 auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            margin: 0;
            text-align: center;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: rgb(0, 123, 255);
            color: white;
        }

        .homebtn-container {
            text-align: center;
            margin-top: 20px;
        }

        .home-btn {
            background-color: rgb(0, 123, 255);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            display: inline-block;
            text-decoration: none;
        }
        
        .pagination {
            text-align: center;
            margin-top: 20px;
        }

        .pagination a {
            display: inline-block;
            width: 35px;
            height: 35px;
            line-height: 35px;
            margin: 0 5px;
            text-align: center;
            text-decoration: none;
            font-weight: bold;
            font-size: 16px;
            border-radius: 6px;
            color: white;
            background-color: rgb(0, 123, 255);
        }

        .pagination strong {
            display: inline-block;
            width: 35px;
            height: 35px;
            line-height: 35px;
            margin: 0 5px;
            text-align: center;
            font-weight: bold;
            font-size: 16px;
            border-radius: 6px;
            background-color: #ccc;
            color: black;
        }

        .pagination a:hover {
            background-color: rgb(0, 123, 255);
        }

        .pagination a.pagi-pn {
            min-width: 50px;
            padding: 8px 5px;
            height: auto;
            line-height: normal;
        }
    </style>
</head>
<body>

<!-- Pagination Logic -->
<cfparam name="url.page" default="1">
<cfset recordsPerPage = 7>
<cfset currentpage = url.page>

<!-- total number of records -->
<cfquery name="getTotal" datasource="user">
    SELECT COUNT(*) AS total FROM users
</cfquery>
<cfset totalrecords = getTotal.total>
<cfset totalpages = ceiling(totalrecords / recordsPerPage)>
<cfset startrow = (currentpage - 1) * recordsPerPage>

<div class="container">
    <h2>Registered Users</h2>

    <cfquery name="userfetch" datasource="user">
        SELECT * FROM users
        ORDER BY id DESC
        LIMIT <cfqueryparam value="#recordsPerPage#" cfsqltype="cf_sql_integer">
        OFFSET <cfqueryparam value="#startrow#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfif userfetch.recordcount EQ 0>
        <cfoutput>No Users are Registered</cfoutput>
    <cfelse>
        <table>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Status</th>
            </tr>
            <cfoutput query="userfetch">
                <tr>
                    <td>#id#</td>
                    <td>#username#</td>
                    <td>
                        <cfif username EQ "admin">
                            Admin
                        <cfelse>
                            General User
                        </cfif>
                    </td>
                </tr>
            </cfoutput>
        </table>

        <div class="pagination">
            <cfoutput>
                <!-- Prev Button -->
                <cfif currentpage GT 1>
                    <a href="users.cfm?page=#currentpage-1#" class="pagi-pn">Prev</a>
                </cfif>

                <!-- Page Numbers -->
                <cfloop from="1" to="#totalpages#" index="i">
                    <cfif i EQ currentpage>
                        <strong>#i#</strong>
                    <cfelse>
                        <a href="users.cfm?page=#i#">#i#</a>
                    </cfif>
                </cfloop>

                <!-- Next Button -->
                <cfif currentpage LT totalpages>
                    <a href="users.cfm?page=#currentpage+1#" class="pagi-pn">Next</a>
                </cfif>
            </cfoutput>
        </div>
    </cfif>

    <div class="homebtn-container">
        <a href="home.cfm" class="home-btn">Back to Home</a>
    </div>
</div>

</body>
</html>
