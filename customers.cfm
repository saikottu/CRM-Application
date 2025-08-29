<cfif NOT structKeyExists(session, "userid")>
    <cflocation url="login.cfm">
</cfif>

<cfset customerService = createObject("component", "customerservice")>

<!-- Prepare search keyword -->
<cfset localKeyword = "">
<cfif structKeyExists(form, "search_keyword")>
    <cfset localKeyword = trim(form.search_keyword)>
</cfif>

<!-- Handle Add -->
<cfif structKeyExists(form, "add")>
    <cfset customerService.addCustomer(trim(form.name), trim(form.email), trim(form.phone))>
    <cflocation url="customers.cfm">
</cfif>

<!-- Handle Edit -->
<cfif structKeyExists(form, "edit_id")>
    <cfset customerService.updateCustomer(
        id = form.edit_id,
        name = trim(form.name),
        email = trim(form.email),
        phone = trim(form.phone)
    )>
    <cflocation url="customers.cfm">
</cfif>

<!-- Handle Delete -->
<cfif structKeyExists(form, "delete_id")>
    <cfset customerService.deleteCustomer(form.delete_id)>
    <cflocation url="customers.cfm">
</cfif>

<!-- Get customers -->
<cfif len(localKeyword)>
    <cfset customers = customerService.searchCustomers(localKeyword)>
<cfelse>
    <cfset customers = customerService.getAllCustomers()>
</cfif>

<!-- Pagination Setup -->
<cfparam name="url.page" default="1">
<cfset currentPage = val(url.page)>
<cfset recordsPerPage = 5>
<cfset startRow = (currentPage - 1) * recordsPerPage + 1>
<cfset endRow = startRow + recordsPerPage - 1>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Management</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fa;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ccc;
        }
        th {
            background-color: rgb(0, 123, 255);
            color: white;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        .editmodel {
            display: none;
            background: #eef;
            padding: 10px;
        }
        .edit-btn, .delete-btn {
            padding: 6px 12px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
        }
        .edit-btn { background-color: #28a745; color: white; }
        .delete-btn { background-color: #dc3545; color: white; }
        .search-btn, .add-btn {
            padding: 8px 12px;
            border: none;
            background-color: black;
            color: white;
            cursor: pointer;
            border-radius: 4px;
            margin-right: 10px;
        }
        input[name="search_keyword"] {
            width: 300px;
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .home-btn, .report-btn {
            background-color: rgb(0, 123, 255);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
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

<a href="home.cfm" class="home-btn">Back to Home</a>
<a href="customer_report.cfm" class="report-btn">Download Customers Report</a>

<h2>Customer Management</h2>

<!-- Search Section -->
<cfoutput>
<form method="post" class="search" style="margin-bottom: 15px;">
    <input type="text" id="searchInput" name="search_keyword" placeholder="Search by name, email, or phone"
           value="#HTMLEditFormat(localKeyword)#">
    <button class="search-btn" type="submit">Search</button>
</form>
</cfoutput>

<!-- Add Customer -->
<form method="post" style="margin-bottom: 30px;">
    <input type="text" name="name" placeholder="Name" required>
    <input type="text" name="email" placeholder="Email" required>
    <input type="text" name="phone" placeholder="Phone">
    <button class="add-btn" type="submit" name="add">Add Customer</button>
</form>

<!-- Customer Results Table -->
<div id="customerResults">
    <table>
        <tr>
            <th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Actions</th>
        </tr>

        <cfset totalRecords = customers.recordCount>
        <cfoutput query="customers">
            <cfif currentRow GTE startRow AND currentRow LTE endRow>
                <tr>
                    <td>#id#</td>
                    <td>#name#</td>
                    <td>#email#</td>
                    <td>#phone#</td>
                    <td class="action-buttons">
                        <button type="button" class="edit-btn" data-id="#id#">Edit</button>
                        <form method="post" style="display:inline;" onsubmit="return confirm('Are you sure?');">
                            <input type="hidden" name="delete_id" value="#id#">
                            <button type="submit" class="delete-btn">Delete</button>
                        </form>
                    </td>
                </tr>

                <!-- Edit form (hidden) -->
                <tr id="editForm#id#" class="editmodel">
                    <td colspan="5">
                        <form method="post">
                            <input type="hidden" name="edit_id" value="#id#">
                            <input type="text" name="name" value="#HTMLEditFormat(name)#" required>
                            <input type="email" name="email" value="#HTMLEditFormat(email)#" required>
                            <input type="text" name="phone" value="#HTMLEditFormat(phone)#">
                            <button type="submit">Save</button>
                            <button type="button" class="cancel-btn">Cancel</button>
                        </form>
                    </td>
                </tr>
            </cfif>
        </cfoutput>
    </table>
</div>

<!-- Pagination Links -->
<cfoutput>
    <cfset totalPages = ceiling(totalRecords / recordsPerPage)>
    <cfif totalPages GT 1>
        <div class="pagination">

            <!-- Prev Button -->
            <cfif currentPage GT 1>
                <a href="customers.cfm?page=#currentPage - 1#" class="pagi-pn">Prev</a>
            </cfif>

            <!-- Page Numbers -->
            <cfloop from="1" to="#totalPages#" index="i">
                <cfif i EQ currentPage>
                    <strong>#i#</strong>
                <cfelse>
                    <a href="customers.cfm?page=#i#">#i#</a>
                </cfif>
            </cfloop>

            <!-- Next Button -->
            <cfif currentPage LT totalPages>
                <a href="customers.cfm?page=#currentPage + 1#" class="pagi-pn">Next</a>
            </cfif>

        </div>
    </cfif>
</cfoutput>



<script>
function bindEditButtons() {
    $(".edit-btn").click(function() {
        var id = $(this).data("id");
        $(".editmodel").hide(); // hide all
        $("#editForm" + id).slideToggle(); // toggle current
    });

    $(".cancel-btn").click(function() {
        $(this).closest(".editmodel").slideUp();
    });
}

$('.report-btn').on('click', function () {
  $.ajax({
    url: "sendMail.cfm",
    type: "POST",
    data: { name: "John", email: "john@example.com" },
    success: function(response) {
      alert("Mail sent. Now downloading...");
      window.location.href = "customer_report.pdf";
    },
    error: function() {
      alert("Failed to send email.");
    }
  });
});

$(document).ready(function() {
    bindEditButtons();

    $('#searchInput').on('keyup', function() {
        var keyword = $(this).val().trim();

        $.ajax({
            url: "customerservice.cfc?method=ajaxSearchCustomers&returnformat=json",
            type: "GET",
            data: { keyword: keyword },
            dataType: "json",
            success: function(data) {
                var html = '<table><tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Actions</th></tr>';

                if (data.length > 0) {
                    $.each(data, function(i, customer) {
                        html += '<tr>' +
                            '<td>' + customer.id + '</td>' +
                            '<td>' + customer.name + '</td>' +
                            '<td>' + customer.email + '</td>' +
                            '<td>' + customer.phone + '</td>' +
                            '<td class="action-buttons">' +
                                '<button type="button" class="edit-btn" data-id="' + customer.id + '">Edit</button>' +
                                '<form method="post" style="display:inline;" onsubmit="return confirm(\'Are you sure?\');">' +
                                    '<input type="hidden" name="delete_id" value="' + customer.id + '">' +
                                    '<button type="submit" class="delete-btn">Delete</button>' +
                                '</form>' +
                            '</td>' +
                        '</tr>' +

                        '<tr id="editForm' + customer.id + '" class="editmodel" style="display:none;">' +
                            '<td colspan="5">' +
                                '<form method="post">' +
                                    '<input type="hidden" name="edit_id" value="' + customer.id + '">' +
                                    '<input type="text" name="name" value="' + customer.name + '" required>' +
                                    '<input type="email" name="email" value="' + customer.email + '" required>' +
                                    '<input type="text" name="phone" value="' + customer.phone + '">' +
                                    '<button type="submit">Save</button>' +
                                    '<button type="button" class="cancel-btn">Cancel</button>' +
                                '</form>' +
                            '</td>' +
                        '</tr>';
                    });
                } else {
                    html += '<tr><td colspan="5">No results found</td></tr>';
                }

                html += '</table>';
                $('#customerResults').html(html);
                bindEditButtons();
            },
            error: function(xhr, status, error) {
                console.error("AJAX Error:", error);
            }
        });
    });
});
</script>
</body>
</html>
