<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<style>
table td {border:1px solid;padding:5px;}
</style>
</head>
<body>
<cfif isDefined('Session.pirateid') AND Session.pirateid IS "baldwinc">

<cfquery datasource="hhp_apps" name="changes">
	UPDATE faculty_staff
    SET chair = 'yes'
    WHERE email = 'wonderpop@gmail.com'
</cfquery>

<cfquery dataSource="hhp_apps" name="myQuery"> 
            SELECT * FROM faculty_staff
</cfquery> 

<cfoutput>
<table>
	<tr>
    	<th>Last</th>
        <th>Email</th>
        <th>Dept</th>
        <th>Chair</th>
        <th>Faculty</th>
        <th>Staff</th>
    </tr>
<cfloop query="myQuery">
	<tr><td>#myQuery.last#</td>
    	<td>#myQuery.email#</td>
        <td>#myQuery.dept#</td>
        <td>#myQuery.chair#</td>
        <td>#myQuery.faculty#</td>
        <td>#myQuery.staff#</td>
    </tr>
</cfloop>
</table>
</cfoutput>

</cfif>

</body>
</html>