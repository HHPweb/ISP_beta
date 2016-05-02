<!---                               addUser is called to save a new application (myApp isDefined = 0)                                 --->

<cffunction name="findChair"><!---   function to figure out who the chair is, based either on Session.dept of the user or input on the app form    --->
	<cfif isDefined('Form.dept') AND Form.dept IS NOT "">
    	<cfquery name="getChair" datasource="hhp_apps">
            SELECT email FROM faculty_staff WHERE dept = '#Form.dept#' AND chair = 'yes'
        </cfquery>
        <cfset cMail = getChair.email>
    <cfelse>
    	<cfquery name="getChair" datasource="hhp_apps">
            SELECT email FROM faculty_staff WHERE dept = '#Session.dept#' AND chair = 'yes'
        </cfquery>
        <cfset cMail = getChair.email>
    </cfif>
    
    <cfreturn cMail>
</cffunction>

<cffunction name="findDept">
	<cfif isDefined('Form.dept') AND Form.dept IS NOT ""><!---  if dept has been set on the form we go with that --->
    	<cfset dept = Form.dept>
    <cfelse><!---  otherwise we go with the Session value for dept  --->
    	<cfset dept = Session.dept>
    </cfif>
    <cfreturn dept>
</cffunction>

<cffunction name="addUser">
             <cftry>
                <cfset myTerm="#Form.term#~#Form.year#">
                <cfset chairMail = findChair()>
                <cfset dept = findDept()>
                <cfquery dataSource="hhp_apps" name="myQuery"> 
                    INSERT INTO ISP_forms
                    (date,last,first,middle,address,city,state,zip,phone,pirateid,email,term,supervisor,goals,outcomes,tasks,evaluation,prefix,number,initDate,writing,title,chairMail,dept,crn,hours,de) 
                    VALUES 
                    ('#DateFormat(now(), "m-d-yyyy")# #TimeFormat(now())#','#Trim(Form.last)#','#Trim(Form.first)#','#Trim(Form.middle)#','#Trim(Form.address)#','#Trim(Form.city)#','#Trim(Form.state)#','#Trim(Form.zip)#','#Trim(Form.phone)#','#Trim(Session.pirateid)#','#Trim(Form.email)#','#myTerm#','#Trim(Form.supervisor)#','#Trim(Form.goals)#','#Trim(Form.outcomes)#','#Trim(Form.tasks)#','#Trim(Form.evaluation)#','#Trim(Form.prefix)#','#Trim(Form.number)#','#DateFormat(now(), "m-d-yyyy")# #TimeFormat(now())#','#Trim(Form.writing)#','#Trim(Form.title)#','#chairMail#','#dept#','#Trim(Form.crn)#','#Trim(Form.hours)#','#Trim(Form.delivery)#')
                </cfquery>
                
                <cfif Session.position IS NOT "student">
                	<cfmail to = "#Trim(Form.email)#,#Trim(Form.supervisor)#" from = "#Trim(Session.email)#" subject = "Independent Study Proposal">
        This message was generated automatically by the HHP Independent Study Proposal website.
                        
        An independent study proposal has been submitted for #Form.first# #Form.last# by #Session.email#.
        Please log in at: http://www2.ecu.edu/hhp/ISP to review this proposal.
                        </cfmail>
                        
                       <cfoutput>Your form has been submitted and #Trim(Form.email)# was notified.</cfoutput>
                <cfelse>
                	<cfmail to = "#Trim(Form.supervisor)#" from = "#Trim(Form.email)#" subject = "Independent Study Proposal">
        This message was generated automatically by the HHP Independent Study Proposal website.
                        
        An independent study proposal from #Trim(Form.first)# #Trim(Form.last)# has been submitted and awaits your approval.
        Please log in at: http://www2.ecu.edu/hhp/ISP/ to review this application.
                        </cfmail>
                       <cfoutput>Your form has been submitted and #Trim(Form.supervisor)# was notified.</cfoutput> 
                </cfif>
                        
                
        
                 <cfcatch type="any">
                    <cfmail to = "baldwinc@ecu.edu" from = "#Trim(Form.email)#" subject = "Independent Study Proposal Failure">
An independent study proposal from #Trim(Form.first)# #Trim(Form.last)# has failed to be written to the db during an initial submision.  Where have we gone wrong?
        
         Diagnostic messages from ColdFusion.
            Message: #cfcatch.message#
            
         Caught an exception, type = #CFCATCH.TYPE#
         
Form data dump:

last = #Trim(Form.last)#
first = #Trim(Form.first)#
middle = #Trim(Form.middle)#
address = #Trim(Form.address)#
city = #Trim(Form.city)#
state = #Trim(Form.state)#
zip = #Trim(Form.zip)#
phone = #Trim(Form.phone)#
email = #Trim(Form.email)#
term = #myTerm#
writing intensive = #Trim(Form.writing)#
supervisor = #Trim(Form.supervisor)#

goals = #Trim(Form.goals)#

outcomes = #Trim(Form.outcomes)#

tasks = #Trim(Form.tasks)#

evaluation = #Trim(Form.evaluation)#

prefix = #Trim(Form.prefix)#
number = #Trim(Form.number)#
title = #Trim(Form.title)#
                        </cfmail>
					<cfoutput><br /><br /><br /><br />There was a problem and your data was not written to the database.<br /><br /> Please contact the <a href="mailto:baldwinc@ecu.edu">administrator</a> with a description of your problem.</cfoutput>
                </cfcatch>
            </cftry>
        </cffunction>

<!---                               updateUser is called to update an existing application (myApp isDefined)                                 --->
        
        <cffunction name="updateUser">
            <!---<cfoutput>Would be updating existing user if they hit the submit form button - not save changes</cfoutput>--->
			<cftry>
            	<cfset myTerm="#Form.term#~#Form.year#"> 
                <cfset chairMail = findChair()>
                 <cfset dept = findDept()>
                <cfquery dataSource="hhp_apps" name="myQuery"> 
                    UPDATE ISP_forms
                    SET date = '#DateFormat(now(), "m-d-yyyy")# #TimeFormat(now())#',last = '#Trim(Form.last)#',first = '#Trim(Form.first)#',middle = '#Trim(Form.middle)#',address = '#Trim(Form.address)#',city = '#Trim(Form.city)#',state = '#Trim(Form.state)#',zip = '#Trim(Form.zip)#',phone = '#Trim(Form.phone)#',pirateid = '#Trim(Form.pirateid)#',email = '#Trim(Form.email)#',term = '#myTerm#',supervisor = '#Trim(Form.supervisor)#',goals = '#Trim(Form.goals)#',outcomes = '#Trim(Form.outcomes)#',tasks = '#Trim(Form.tasks)#',evaluation = '#Trim(Form.evaluation)#',prefix = '#Trim(Form.prefix)#',number = '#Trim(Form.number)#',writing = '#Trim(Form.writing)#',title = '#Form.title#',chairMail = '#chairMail#',dept = '#dept#',crn = '#Form.crn#',hours = '#Form.hours#',de = '#Form.delivery#',deanAppr = '#Form.deanAppr#'
                    WHERE id = <cfqueryparam value="#Form.myApp#" CFSQLType="CF_SQL_VARCHAR">
                </cfquery>
                
                 <cfmail to = "#Trim(Form.supervisor)#" from = "#Trim(Form.email)#" subject = "Independent Study Proposal">
        This message was generated automatically by the HHP Independent Study Proposal website.
                        
        An independent study proposal from #Trim(Form.first)# #Trim(Form.last)# has been edited and awaits your approval.
        Please log in at: http://www2.ecu.edu/hhp/ISP/ to review this application.
                        </cfmail>
                        
                <cfoutput>Your form has been updated and notification has been sent to: #Form.supervisor#.</cfoutput>
                <cfcatch type="any">
                    <cfmail to = "baldwinc@ecu.edu" from = "#Trim(Form.email)#" subject = "Independent Study Proposal Failure">
An independent study proposal from #Trim(Form.first)# #Trim(Form.last)# has failed to be written to the db during an update.  Where have we gone wrong?
        
         Diagnostic messages from ColdFusion.
            Message: #cfcatch.message#
            
         Caught an exception, type = #CFCATCH.TYPE#
         
Form data dump:

last = #Trim(Form.last)#
first = #Trim(Form.first)#
middle = #Trim(Form.middle)#
address = #Trim(Form.address)#
city = #Trim(Form.city)#
state = #Trim(Form.state)#
zip = #Trim(Form.zip)#
phone = #Trim(Form.phone)#
email = #Trim(Form.email)#
term = #myTerm#
writing intensive = #Trim(Form.writing)#
supervisor = #Trim(Form.supervisor)#

goals = #Trim(Form.goals)#

outcomes = #Trim(Form.outcomes)#

tasks = #Trim(Form.tasks)#

evaluation = #Trim(Form.evaluation)#

prefix = #Trim(Form.prefix)#
number = #Trim(Form.number)#
                        </cfmail>
					<cfoutput><br /><br /><br /><br />There was a problem and your data was not written to the database.<br /><br /> Please contact the <a href="mailto:baldwinc@ecu.edu">administrator</a> with a description of your problem.</cfoutput>
                </cfcatch>
            </cftry> 
        </cffunction>
<!---                                                     end updateUser                                                                    --->
		<cfif IsDefined("Form.myApp") and IsDefined("Session.pirateid")>
            <!---           set defaults for form items that may be missing        --->
            <cfparam name="Form.crn" default="" />
            <cfparam name="Form.hours" default="" />
            <cfparam name="Form.complete" default="no" />
						<cfparam name="Form.deanAppr" default="false" />
            
			<cfif Form.myApp IS "">
            	<cfoutput>#addUser()#</cfoutput>
            <cfelse>
            	<cfoutput>#updateUser()#</cfoutput>
            </cfif>
        <cfelse>
            <cflocation url = "index.cfm">
        </cfif>