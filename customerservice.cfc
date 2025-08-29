<cfcomponent displayname="CustomerService">

    <!-- Add customer -->
    <cffunction name="addCustomer" access="public" returntype="boolean" output="false">
        <cfargument name="name" type="string" required="true">
        <cfargument name="email" type="string" required="true">
        <cfargument name="phone" type="string" required="false">

        <cfquery datasource="user">
            INSERT INTO customers (name, email, phone)
            VALUES (
                <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.phone#" cfsqltype="cf_sql_varchar">
            )
        </cfquery>

        <cfreturn true>
    </cffunction>

    <!-- Get all customers -->
    <cffunction name="getAllCustomers" access="public" returntype="query" output="false">
        <cfquery name="customers" datasource="user">
            SELECT id, name, email, phone FROM customers ORDER BY id DESC
        </cfquery>

        <cfreturn customers>
    </cffunction>

    <!-- Search customers -->
    <cffunction name="searchCustomers" access="public" returntype="query" output="false">
        <cfargument name="keyword" type="string" required="true">
        <cfset var searchTerm = "%" & arguments.keyword & "%" />
        <cfquery name="results" datasource="user">
            SELECT id, name, email, phone
            FROM customers
            WHERE name LIKE <cfqueryparam value="#searchTerm#" cfsqltype="cf_sql_varchar">
               OR email LIKE <cfqueryparam value="#searchTerm#" cfsqltype="cf_sql_varchar">
               OR phone LIKE <cfqueryparam value="#searchTerm#" cfsqltype="cf_sql_varchar">
            ORDER BY id DESC
        </cfquery>
        <cfreturn results>
    </cffunction>

    <!-- AJAX Search -->
    <cffunction name="ajaxSearchCustomers" access="remote" returntype="any" output="false" returnFormat="json">
        <cfargument name="keyword" type="string" required="false" default="">
        <cfset var result = []>
        <cfset var searchTerm = "%" & arguments.keyword & "%" >

        <cfquery name="q" datasource="user">
            SELECT id, name, email, phone
            FROM customers
            WHERE name LIKE <cfqueryparam value="#searchTerm#" cfsqltype="cf_sql_varchar">
               OR email LIKE <cfqueryparam value="#searchTerm#" cfsqltype="cf_sql_varchar">
               OR phone LIKE <cfqueryparam value="#searchTerm#" cfsqltype="cf_sql_varchar">
            ORDER BY id DESC
        </cfquery>

        <cfloop query="q">
            <cfset arrayAppend(result, {
                "id" = q.id,
                "name" = q.name,
                "email" = q.email,
                "phone" = q.phone
            })>
        </cfloop>

        <cfreturn result>
    </cffunction>

    <!-- Update customer -->
    <cffunction name="updateCustomer" access="public" returntype="boolean" output="false">
        <cfargument name="id" type="numeric" required="true">
        <cfargument name="name" type="string" required="true">
        <cfargument name="email" type="string" required="true">
        <cfargument name="phone" type="string" required="false">

        <cfquery datasource="user">
            UPDATE customers
            SET name = <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,
                email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
                phone = <cfqueryparam value="#arguments.phone#" cfsqltype="cf_sql_varchar">
            WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfreturn true>
    </cffunction>

    <!-- Delete customer -->
    <cffunction name="deleteCustomer" access="public" returntype="boolean" output="false">
        <cfargument name="id" type="numeric" required="true">

        <cfquery datasource="user">
            DELETE FROM customers WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfreturn true>
    </cffunction>

</cfcomponent>
