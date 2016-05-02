<cfif isDefined("Form.myApp")>
	<cfquery name="fetchData" datasource="hhp_apps">
		Select * From ISP_forms Where id = '#Form.myApp#'
    </cfquery>
    
    <cfset theJSON = SerializeJSON(fetchData, true)>
    <cfoutput>#theJSON#</cfoutput>
<cfelse>
	<cfoutput>myApp not in post data.</cfoutput>
</cfif>

<!---<cfset getID.departDate = DateFormat(getID.departDate, "mm/dd/yyyy")>
    <cfset getID.returnDate = DateFormat(getID.returnDate, "mm/dd/yyyy")>--->