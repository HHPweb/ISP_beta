<cftry>
<cfif isDefined('Form.email')>
    <cfparam name="Form.crn" default="" />
    <cfparam name="Form.hours" default="" />
    <cfparam name="Form.asstMail" default="" />
    <cfparam name="Form.complete" default="no" />
		<cfparam name="Form.deanAppr" default="false" />
    
    <cfset myTerm="#Form.term#~#Form.year#">
    <!--- figure out what the department is if it isn't set  --->
    <cfif isDefined('Form.dept') AND Form.dept IS NOT ""><!---  if dept has been set on the form we go with that --->
    	<cfset dept = Form.dept>
    <cfelse><!---  otherwise we go with the Session value for dept  --->
    	<cfset dept = Session.dept>
    </cfif>
    
	 <cfquery dataSource="hhp_apps" name="myQuery"> 
            UPDATE ISP_forms
            SET date = '#DateFormat(now(), "m-d-yyyy")# #TimeFormat(now())#',last = '#Trim(Form.last)#',first = '#Trim(Form.first)#',middle = '#Trim(Form.middle)#',address = '#Trim(Form.address)#',city = '#Trim(Form.city)#',state = '#Trim(Form.state)#',zip = '#Trim(Form.zip)#',phone = '#Trim(Form.phone)#',email = '#Trim(Form.email)#',term = '#myTerm#',supervisor = '#Trim(Form.supervisor)#',goals = '#Trim(Form.goals)#',outcomes = '#Trim(Form.outcomes)#',tasks = '#Trim(Form.tasks)#',evaluation = '#Trim(Form.evaluation)#',prefix = '#Trim(Form.prefix)#',number = '#Trim(Form.number)#',crn = '#Trim(Form.crn)#',hours = '#Trim(Form.hours)#',asstMail = '#Trim(Form.asstMail)#',writing = '#Trim(Form.writing)#',complete = '#Trim(Form.complete)#',dept = '#dept#',title = '#Trim(Form.title)#',de = '#Trim(Form.delivery)#',deanAppr = '#Form.deanAppr#'
            WHERE id = <cfqueryparam value="#Form.myApp#" CFSQLType="CF_SQL_VARCHAR">
    </cfquery> 
    
    <cfset comment = "Application was saved by this user.">
    <cfquery datasource="hhp_apps" name="createComm">
        INSERT INTO ISP_comm (app,author,date,comment) 
        VALUES( '#Form.myApp#','#Session.pirateid#','#DateFormat(now(), "m-d-yyyy")# #TimeFormat(now())#','#comment#' ) 
    </cfquery>
    
    
</cfif>
<cfoutput>Your changes have been saved.</cfoutput>
<cfcatch type="any">
<cfoutput>There was an error: #cfcatch.Message#</cfoutput>
</cfcatch>
</cftry>
