<cftry>
<cfif isDefined('Form.app')>
	<cfparam name="Form.facOnly" default="no" />
    <cfquery datasource="hhp_apps" name="formInfo">
       SELECT chairMail,supervisor,asstMail FROM ISP_forms WHERE id = '#Form.app#'
    </cfquery>
	<cfset comment = "REJECTED: " & Form.comment>
    <cfquery datasource="hhp_apps" name="createComm">
        INSERT INTO ISP_comm (app,author,date,comment) 
        VALUES( '#Form.app#','#Session.pirateid#','#DateFormat(now(), "m-d-yyyy")# #TimeFormat(now())#','#comment#' ) 
    </cfquery>
<!---   ************************************* Faculty has rejected ***************************************************--->
    <cfif Session.position IS "faculty">
    	<cfset msg = "Application was rejected and student notified.">
        <cfmail to = "#Trim(Form.rMail)#" from = "#Trim(Session.email)#" subject = "Independent Study Proposal">
            This message was generated automatically by the HHP Independent Study Proposal website.
                            
            #Form.rName#,
            Your independent study proposal has been rejected.
            
            Comments: #Form.comment#
            
            Please log in at: http://www2.ecu.edu/hhp/ISP/ to review this application.
        </cfmail>
<!---   ************************************* Chair has rejected ***************************************************--->
	<cfelseif Session.position IS "chair">
    	 <cfif Form.facOnly IS "justFac">
         	<cfset sendTo = #formInfo.supervisor#>
            <cfset msg = "Application was rejected and faculty supervisor notified.">
         <cfelse>
         	<cfset sendTo = #Trim(formInfo.supervisor)# & "," & #Trim(Form.rMail)#>
            <cfset msg = "Application was rejected. Student and faculty supervisor were notified.">
         </cfif>
         <cfmail to = "#sendTo#" from = "#Trim(Session.email)#" subject = "Independent Study Proposal">
            This message was generated automatically by the HHP Independent Study Proposal website.
                            
            An independent study for #Form.rName# has been rejected by the department chair.
            
            Comments: #Form.comment#
            
            Please log in at: http://www2.ecu.edu/hhp/ISP/ to review this application.
          </cfmail>
          <!---                    Reset facultyApp so faculty will see it needs approval--->
          <cfquery datasource="hhp_apps" name="reset">
          	UPDATE ISP_forms
            SET facultyApp = 'no' 
            WHERE id = '#Form.app#'
          </cfquery>
    </cfif>
    
</cfif>
<cfoutput>#msg#</cfoutput>
<cfcatch type="any">
<cfoutput>There was an error: #cfcatch.Message#</cfoutput>
</cfcatch>
</cftry>

