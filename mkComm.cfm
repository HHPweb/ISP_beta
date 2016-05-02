<cftry>
<cfif isDefined('Form.app')>
    <!--- <cfquery datasource="hhp_apps" name="bug">
        INSERT INTO bugging VALUES( '#appt#' ) 
    </cfquery> ---> 
    <cfquery datasource="hhp_apps" name="createComm">
        INSERT INTO ISP_comm (app,author,date,comment) 
        VALUES( '#Form.app#','#Session.pirateid#','#DateFormat(now(), "m-d-yyyy")# #TimeFormat(now())#','#Form.comment#' ) 
    </cfquery>
</cfif>
<cfoutput>Comment was posted.</cfoutput>
<cfcatch type="any">
<cfoutput>There was an error: #cfcatch.Message#</cfoutput>
</cfcatch>
</cftry>
