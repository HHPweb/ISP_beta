<cftry>
<cfif isDefined('Form.myApp')>
	 <cfquery dataSource="hhp_apps" name="myQuery"> 
            UPDATE ISP_forms
            SET complete = 'yes',date = '#DateFormat(now(), "m-d-yyyy")# #TimeFormat(now())#'
            WHERE id = <cfqueryparam value="#Form.myApp#" CFSQLType="CF_SQL_VARCHAR">
    </cfquery> 
    
    <cfset comment = "Course completed.">
    <cfquery datasource="hhp_apps" name="createComm">
        INSERT INTO ISP_comm (app,author,date,comment) 
        VALUES( '#Form.myApp#','#Session.pirateid#','#DateFormat(now(), "m-d-yyyy")# #TimeFormat(now())#','#comment#' ) 
    </cfquery>
</cfif>
<cfoutput>You have marked this course completed.</cfoutput>
<cfcatch type="any">
<cfoutput>There was an error: #cfcatch.Message#</cfoutput>
</cfcatch>
</cftry>