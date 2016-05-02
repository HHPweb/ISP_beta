<cfsilent>
<!--- ECU Active Directory Attributes and Real World Equivalents --->
<!---
mail        = fully qualified e-mail address (so a student == pirateid@students.ecu.edu, faculty == pirateid@ecu.edu )
sn          = last name (surname)
givenName   = first name
initials    = middle initial(s)
displayName = lastname, firstname middlename
memberof    = A/D group membership
company     = mailstop (controlled field, regex for just number = ^\d+ )
physicalDeliveryOfficeName = office as put in Banner Self Service by employees, not controlled
telephoneNumber = telephone as entered in Banner Self Service, not controlled
sAMAccountName = pirateid

No attributes are case sensitive; queries or filters can specify any capitalization
--->


<!--- Prefixes of cfcatch.Message when using cfldap --->
<cfset connectionFailedMessage     = "Connection to LDAP server failed">
<cfset authenticationFailedMessage = "Authentication failed">

<cfif isDefined("FORM.login") AND TRIM(FORM.pirateid) NEQ "" AND TRIM(FORM.passphrase) NEQ "">
	<!--- User has submitted a Pirate Id and Password --->
	<cfset pirateid   = Trim(FORM.pirateid)>
	<cfset passphrase = Trim(FORM.passphrase)>
	
	<!--- check for intra\ and eliminate --->
	<cfset pirateid = REReplaceNoCase(pirateid, "^intra", "")>
	<cfset pirateid = ReReplaceNoCase(pirateid, "^\\", "")>
	
	<!--- Normalize pirate id for insertion into registration database --->
	<!--- Normalization is NOT necessary for server auth, but nice for application use --->
	<!--- If your user db contains pirateids, it must NOT NOT NOT contain collected passwords --->
	<cfset pirateid = LCase(pirateid)>
		
	<!--- Attempt to query campus A/D server using user's crdentials --->
	<cftry>
		<!--- Specifying attributes is optional in cfldap, but increases speed if you do --->
		<!--- Leave off attributes attribute and do cfdump of usercheck to see data coming back --->	
		<cfldap action="query" 
			server="firstmate.ecu.edu" 
			scope="subtree" 
			username="intra\#pirateid#" 
			password="#passphrase#"
			start="dc=intra,dc=ecu,dc=edu"
			filter="SAMAccountname=#pirateid#"
			maxRows="1"
			name="usercheck"
			attributes="mail,sn,givenName,initials,memberof,company,physicalDeliveryOfficeName">
			
		<!--- No thrown exception, check for proper membership --->
		<!--- students registered == people who are taking a class now or next term --->
		<!--- facultystaff == people who are ECU affiliated but not official employees (ala PCMH people) --->
		<!--- If you have your own custom A/D groups, add them to this if block --->
		<cfset memberof = UCase(usercheck.memberof)>
			<!--- They are ECU people, login and password are correct --->
			
            <cfquery name="findFac" datasource="hhp_apps">
            	SELECT faculty,chair,staff,admin FROM faculty_staff WHERE email = '#usercheck.mail#'
            </cfquery>
            
            <cfif findFac.admin IS "yes">
            	<cfset position = "admin">
            <cfelseif findFac.chair IS "yes">
            	<cfset position = "chair">
            <cfelseif findFac.faculty IS "yes">
            	<cfset position = "faculty">
            <cfelseif findFac.staff IS "yes">
            	<cfset position = "staff">
            <cfelse>
            	<cfset position = "student">
            </cfif>
<!---sometimes I need to impersonate people to track down problems --->
            <cfif pirateid IS "baldwinc">
							<cfset position = "chair">
                <cfset usercheck.mail = "ballards@ecu.edu">
                <cfset usercheck.givenName = "Sharon">
                <cfset usercheck.sn = "Ballard">
                <cfset pirateid = "ballards">
								<cfset usercheck.middle = "M">
									<!--->
            	<cfset position = "staff">
                <cfset usercheck.mail = "hughesel@ecu.edu">
                <cfset usercheck.givenName = "Elaine">
                <cfset usercheck.sn = "Hughes">
                <cfset pirateid = "hughesel">
                <cfset usercheck.middle = "T">
                <cfset position = "chair">
                <cfset usercheck.mail = "altmans@ecu.edu">
                <cfset usercheck.givenName = "Stacey">
                <cfset usercheck.sn = "Altman">
                <cfset pirateid = "altmans">
                <cfset usercheck.middle = "T">--->
            </cfif>
            <cflock timeout=20 scope="Session" type="Exclusive">
				<cfset Session.pirateid = #pirateid#>
                <cfset Session.email = #usercheck.mail#>
                <cfset Session.first = #usercheck.givenName#>
                <cfset Session.last = #usercheck.sn#>
                <cfset Session.middle = #usercheck.initials#>
                <cfset Session.dept = #FORM.dept#>
                <cfset Session.position = #position#>
            </cflock> 
			<cflocation url="proposals.cfm">
		
	<cfcatch type="Application">
		<cfif Left(cfcatch.Message, Len(connectionFailedMessage)) EQ connectionFailedMessage>
			<cfset message = "Connection to server failed.  Please contact the ECU Help Desk at 252-328-9866.">
		<cfelseif Left(cfcatch.Message, Len(authenticationFailedMessage)) EQ authenticationFailedMessage>
			<cfset message = "Incorrect Pirate Id or Passphrase.">
		</cfif>
	</cfcatch>
	</cftry>
</cfif>
</cfsilent>