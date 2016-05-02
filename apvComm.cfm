<cftry>
<cfif isDefined('Form.app')>
    <cfparam name="Form.facultyComment" default="" />
    <cfparam name="Form.staffComment" default="" />
    <cfparam name="Form.chairComment" default="" />
    <cfparam name="Form.stdComment" default="" />
    <cfparam name="Form.chairOnly" default="false" />
    <cfparam name="Form.sMail" default="" />
    
    <cfquery datasource="hhp_apps" name="formInfo">
            SELECT chairMail,supervisor,asstMail,first,last,email FROM ISP_forms WHERE id = '#Form.app#'
    </cfquery>
    <!---              Entering activity into the comments db              --->
    <cfset rNow = #DateFormat(now(), "m-d-yyyy")# & " " & #TimeFormat(now())#>
    <cfset comment = "APPROVED by: " & #Session.pirateid#>
        
    <cfquery datasource="hhp_apps" name="createComm">
        INSERT INTO ISP_comm (app,author,date,comment) 
        VALUES( '#Form.app#','#Session.pirateid#','#rNow#','#comment#' ) 
    </cfquery>
        
    <cfif Form.stdComment IS NOT "">
        <cfset comment = "To Student: " & #Form.stdComment#>
        <cfquery datasource="hhp_apps" name="stdComm">
           INSERT INTO ISP_comm (app,author,date,comment) 
           VALUES( '#Form.app#','#Session.pirateid#','#rNow#','#comment#' )
        </cfquery>
    </cfif>
        
    <cfif Form.chairComment IS NOT "">
        <cfset comment = "To Chair: " & #Form.chairComment#>
        <cfquery datasource="hhp_apps" name="chairComm">
           INSERT INTO ISP_comm (app,author,date,comment) 
           VALUES( '#Form.app#','#Session.pirateid#','#rNow#','#comment#' )
        </cfquery>
    </cfif>
        
    <cfif Form.facultyComment IS NOT "">
        <cfset comment = "To Faculty: " & #Form.facultyComment#>
        <cfquery datasource="hhp_apps" name="facultyComm">
            INSERT INTO ISP_comm (app,author,date,comment) 
            VALUES( '#Form.app#','#Session.pirateid#','#rNow#','#comment#' )
        </cfquery>
    </cfif>
        
    <cfif Form.staffComment IS NOT "">
        <cfset comment = "To Staff: " & #Form.staffComment#>
        <cfquery datasource="hhp_apps" name="staffComm">
            INSERT INTO ISP_comm (app,author,date,comment) 
            VALUES( '#Form.app#','#Session.pirateid#','#rNow#','#comment#' )
        </cfquery>
    </cfif>
<!---   ************************************* Faculty has approved ***************************************************--->
	<cfif Session.position IS "faculty">
    	<cfif Form.chairOnly IS "justChair">
        	<!---             Mail the Chair                 --->
             <cfmail to="#formInfo.chairMail#" from = "#Trim(Session.email)#" subject = "Independent Study Proposal">
                This message was generated automatically by the HHP Independent Study Proposal website.
                                
                An independent study proposal for #Form.rName# has been approved by #Session.first# #Session.last# and is waiting for your review.
                
                Comments from Faculty: #Form.chairComment#
                
                Please log in at: https://core.ecu.edu/baldwinc/ISP/index.cfm to review this application.
             </cfmail>
             <cfset msg = "Application was approved. Department chair has been notified.">
        <cfelse>
        	<!---           Mail the student                --->
            <cfmail to = "#Trim(Form.rMail)#" from = "#Trim(Session.email)#" subject = "Independent Study Proposal">
                This message was generated automatically by the HHP Independent Study Proposal website.
                                
                #Form.rName#,
                Your independent study proposal has been approved by your faculty supervisor and is pending review by the department chair.
                
                Comments: #Form.stdComment#
                
                Please log in at: https://core.ecu.edu/baldwinc/ISP/index.cfm to review this application.
             </cfmail>
            <!---             Mail the Chair                 --->
             <cfmail to="#formInfo.chairMail#" from = "#Trim(Session.email)#" subject = "Independent Study Proposal">
                This message was generated automatically by the HHP Independent Study Proposal website.
                                
                An independent study proposal for #Form.rName# has been approved by #Session.first# #Session.last# and is waiting for your review.
                
                Comments from Faculty: #Form.chairComment#
                
                Please log in at: https://core.ecu.edu/baldwinc/ISP/index.cfm to review this application.
             </cfmail>
             <cfset msg = "Application was approved. Student and department chair have been notified.">
        </cfif>
		
    
        <!---              log approval in the forms table             --->
         <cfquery dataSource="hhp_apps" name="myQuery"> 
                UPDATE ISP_forms
                SET date = '#rNow#',facultyApp = 'yes',facultyDate = '#rNow#'
                WHERE id = <cfqueryparam value="#Form.app#" CFSQLType="CF_SQL_VARCHAR">
        </cfquery>
        <!---               send message back to app                   --->
        <cfoutput>#msg#</cfoutput>
        
<!---   ************************************* Chair has approved ***************************************************--->
	<cfelseif Session.position IS "chair">
    	<!---           Mail the student                --->
       <cfmail to = "#Trim(Form.rMail)#" from = "#Trim(Session.email)#" subject = "Independent Study Proposal">
            This message was generated automatically by the HHP Independent Study Proposal website.
                            
            #Form.rName#,
            Your independent study proposal has been approved by your faculty supervisor and the department chair.
            
            Comments: #Form.stdComment#
            
            Please log in at: https://core.ecu.edu/baldwinc/ISP/index.cfm to review this application.
         </cfmail>
         <!---           Mail the faculty                --->
        <cfmail to = "#Trim(formInfo.supervisor)#" from = "#Trim(Session.email)#" subject = "Independent Study Proposal">
            This message was generated automatically by the HHP Independent Study Proposal website.
            
            An independent study proposal for #Form.rName# has been approved by #Session.first# #Session.last#.
            
            Comments from Chair: #Form.facultyComment#
            
            Please log in at: https://core.ecu.edu/baldwinc/ISP/index.cfm to review this application.
        </cfmail>
        <!---           Mail the staff processor                --->
         <cfmail to = "#Trim(Form.sMail)#" from = "#Trim(Session.email)#" subject = "Independent Study Proposal">
            This message was generated automatically by the HHP Independent Study Proposal website.
            
            An independent study proposal for #Form.rName# has been approved by #Session.first# #Session.last#.
            
            Comments from Chair: #Form.staffComment#
            
            Please log in at: https://core.ecu.edu/baldwinc/ISP/index.cfm to review this application.
        </cfmail>
        <!---              log approval in the forms table             --->
         <cfquery dataSource="hhp_apps" name="myQuery"> 
                UPDATE ISP_forms
                SET date = '#rNow#',chairApp = 'yes',chairDate = '#rNow#'
                WHERE id = <cfqueryparam value="#Form.app#" CFSQLType="CF_SQL_VARCHAR">
         </cfquery>
         <!---               send message back to app                   --->
        <cfoutput>Application was approved. Student, processor, and faculty supervisor have been notified.</cfoutput>
<!---   ************************************* Staff has processed ***************************************************--->
    <cfelseif Session.position IS "staff">
    	<!---           Mail everybody                --->
        <cfmail to = "#Trim(formInfo.supervisor)#,#Trim(formInfo.chairMail)#,#Trim(formInfo.email)#" from = "#Trim(Session.email)#" subject = "Independent Study Proposal">
            This message was generated automatically by the HHP Independent Study Proposal website.
            
            An independent study proposal for #formInfo.first# #formInfo.last# has been processed by #Session.first# #Session.last#.
			The course has been added to the student's schedule.
			The faculty supervisor needs to log in to the system and mark this course as being completed after the student has finished all work.
            
        </cfmail>
        <!---              log processed in the forms table             --->
         <cfquery dataSource="hhp_apps" name="myQuery"> 
                UPDATE ISP_forms
                SET date = '#rNow#',processDone = 'yes'
                WHERE id = <cfqueryparam value="#Form.app#" CFSQLType="CF_SQL_VARCHAR">
         </cfquery>
         <!---               send message back to app                   --->
        <cfoutput>Application was marked processed. Student, faculty, and department chair have been notified.</cfoutput>
    </cfif> 
</cfif>

<cfcatch type="any">
<cfoutput>There was an error: #cfcatch.Message#</cfoutput>
</cfcatch>
</cftry>
