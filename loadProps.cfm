<cfif isDefined("Form.pos")>
	<cfif Form.pos IS "admin">
		<cfset myQ = "SELECT id, last, first, term, supervisor,initDate,email, prefix, number, hours, facultyApp, chairApp, processDone, complete, submitted FROM ISP_forms ORDER BY initDate DESC">
			<cfreturn runQ()>
	<cfelseif Session.position IS "chair">
		<cfset myQ = "SELECT id, last, first, term, supervisor,initDate,email, prefix, number, hours, facultyApp, chairApp, processDone, complete, submitted FROM ISP_forms WHERE chairMail = '#Session.email#' AND (complete != 'yes' OR complete IS NULL) ORDER BY initDate DESC">
			<cfreturn runQ()>
	<cfelseif Session.position IS "staff">
		<cfset myQ = "SELECT id, last, first, term, supervisor,initDate,email, prefix, number, hours, facultyApp, chairApp, processDone, complete, submitted FROM ISP_forms WHERE (dept = '#Session.dept#' OR asstMail = '#Session.email#' ) AND chairApp = 'yes' AND (complete != 'yes' OR complete IS NULL) ORDER BY initDate DESC">
			<cfreturn runQ()>
	<cfelseif Session.position IS "faculty">
		<cfset myQ = "SELECT id, last, first, term, supervisor,initDate,email, prefix, number, hours, facultyApp, chairApp, processDone, complete, submitted FROM ISP_forms WHERE supervisor = '#Session.email#' AND (complete != 'yes' OR complete IS NULL) ORDER BY initDate DESC">
			<cfreturn runQ()>
	<cfelse>
		<cfset myQ = "SELECT id, last, first, term, supervisor,initDate,email, prefix, number, hours, facultyApp, chairApp, processDone, complete, submitted FROM ISP_forms WHERE pirateid = '#Session.pirateid#' ORDER BY initDate DESC">
			<cfreturn runQ()>
	</cfif>
</cfif>
	
<cffunction name="runQ">
	<cfquery name="fetchData" datasource="hhp_apps">
	#preserveSingleQuotes(myQ)#
    </cfquery>
    
    <cfset theJSON = SerializeJSON(fetchData, true)>
    <cfoutput>#theJSON#</cfoutput>
</cffunction>