<cfcomponent> 
<cfset This.name = "HHP_Scholarships"> 
<cfset This.Sessionmanagement=true> 
<cfset This.Sessiontimeout="#createtimespan(0,2,0,0)#"> <!---this is where we set the session timeout    (days,hours,minutes,seconds)--->
<cfset This.applicationtimeout="#createtimespan(5,0,0,0)#"> 

<cffunction name="onApplicationStart"> 
    <cftry>
    <!--- Test whether the DB that this application uses is accessible 
    by selecting some data. ---> 
    <cfquery name="testDB" dataSource="hhp_apps" maxrows="2"> 
    SELECT anner FROM scholarship_applicants 
    </cfquery> 
    <!--- If we get database error, report it to the user, log the error 
    information, and do not start the application. ---> 
    <cfcatch type="database"> 
    <cfoutput> 
    This application encountered an error.<br> 
    Please contact support. 
    </cfoutput> 
    </cfcatch> 
	</cftry>	
    <cfscript> 
    Application.availableResources=0; 
    Application.counter1=1; 
    Application.sessions=0; 
    </cfscript> 
    <!--- You do not need to return True if you don't set the cffunction returntype attribute. 
    ---> 
</cffunction> 

<cffunction name="onApplicationEnd"> 
	<cfargument name="ApplicationScope" required=true/>  
</cffunction> 

<cffunction name="onRequestStart"> 
</cffunction> 

<cffunction name="onSessionStart"> 
	<cfscript> 
    Session.started = now(); 
    </cfscript> 
    <cflock timeout="5" throwontimeout="No" type="EXCLUSIVE" scope="SESSION"> 
    <cfset Application.sessions = Application.sessions + 1> 
    </cflock> 
</cffunction> 

<cffunction name="onSessionEnd"> 
    <cfargument name = "SessionScope" required=true/> 
    <cflog file="#This.Name#" type="Information" text="Session: 
    #arguments.SessionScope.sessionid# ended"> 
</cffunction> 

<cffunction name="onError"> 
    <cfargument name="Exception" required=true/> 
    <cfargument type="String" name = "EventName" required=true/> 
    <!--- Log all errors. ---> 
    <cflog file="#This.Name#" type="error" text="Event Name: #Eventname#"> 
    <cflog file="#This.Name#" type="error" text="Message: #exception.message#"> 
    <!--- Some exceptions, including server-side validation errors, do not 
     generate a rootcause structure. ---> 
    <cfif isdefined("exception.rootcause")> 
    <cflog file="#This.Name#" type="error" 
    text="Root Cause Message: #exception.rootcause.message#"> 
    </cfif> 
    <!--- Display an error message if there is a page context. ---> 
    <cfif NOT (Arguments.EventName IS onSessionEnd) OR 
    (Arguments.EventName IS onApplicationEnd)> 
    <cfoutput> 
    <h2>An unexpected error occurred.</h2> 
    <p>Please provide the following information to technical support:</p> 
    <p>Error Event: #EventName#</p> 
    <p>Error details:<br> 
    <cfdump var=#exception#></p> 
    </cfoutput> 
    </cfif> 
 </cffunction> 
</cfcomponent>