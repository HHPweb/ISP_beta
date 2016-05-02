<!DOCTYPE HTML>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<html lang="en-us">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="css/normalize.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" type="text/css" href="https://core.ecu.edu/baldwinc/jquery/css/purple-theme/jquery-ui-1.9.0.custom.css" />
<link rel="stylesheet" type="text/css" href="myStyle.css" />

<script src="js/vendor/modernizr-2.6.2.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>
<script src="https://core.ecu.edu/baldwinc/jquery/datejs/date.js" type="text/javascript"></script>
<script src="https://core.ecu.edu/baldwinc/jquery/js/jquery.corner.js" type="text/javascript"></script>
<script type="text/javascript" src="ISP.js"></script>
<script type="text/javascript" src="proposal.js"></script>

<!--- checking to see if they've logged in --->
<cfif IsDefined("Session.pirateid") IS FALSE>
	<cflocation url = "index.cfm">
</cfif>
<cfif IsDefined("Session.position")>
	<cfoutput> <script type="text/javascript">var position = '#Session.position#';</script> </cfoutput>
</cfif>
<cfif IsDefined("Form.myApp")>
	<cfoutput> <script type="text/javascript">var myAp = '#Form.myApp#';var passedOn = '#Form.passedOn#';</script> </cfoutput>
<cfelse>
	<cfoutput> 
		<script type="text/javascript">
        	var myAp = 'new';
			var sLast = '#Session.last#';
			var sFirst = '#Session.first#';
			var sMiddle = '#Session.middle#';
			var pirateid = '#Session.pirateid#';
			var email = '#Session.email#';
        </script> 
	
	</cfoutput>
</cfif>
            
<cfset myDate = #DateFormat(now(), "m-d-yyyy")#>


<cffunction name="findProcessors">
	<cfquery name="getProcs" datasource="hhp_apps">
    	SELECT email,last,first FROM faculty_staff WHERE staff = 'yes'
    </cfquery>
    <cfset options = "">
    <cfloop query="getProcs">
    	<cfset opt = "<option value='" & UCase(getProcs.email) & "'>" & getProcs.first & " " & getProcs.last & "</option>">
		<cfset options &= opt>
    </cfloop>
<cfreturn options>
</cffunction>

<cffunction name="listSupervisors">
	<cfquery name="getFaculty" datasource="hhp_apps">
    	SELECT email,last,first FROM faculty_staff WHERE faculty = 'yes' AND dept = '#Session.dept#'
    </cfquery>
    <cfset options = "">
    <cfloop query="getFaculty">
    	<cfset opt = "<option value='" & UCase(getFaculty.email) & "'>" & getFaculty.first & " " & getFaculty.last & "</option>">
		<cfset options &= opt>
    </cfloop>
<cfreturn options>
</cffunction>

</head>
<body>
<div id="wrapper"> 
    <div class="ECU_Banner"> 
    	<img src="images/eastcarolinauniversity.gif" alt="East Carolina University" />
        <div id="subHeader">
    		The College of Health and Human Performance
		</div><!--end subHeader-->
        <div style="clear:both"></div>
    </div><!--end ECU_Banner-->
        
    <div class="divText"> 
            <h1>Independent Study Proposal Form</h1>
    </div> 

	<div id="instructions">&nbsp;
             
             	<div class="logoff"><p style="padding:0;margin:0;line-height:normal"><strong><cfoutput>#Session.first#  #Session.last#</cfoutput></strong></p></div>
        <div class="logoff"><a class="btn" href="proposals.cfm">back to list</a></div>
        <div class="logoff"><a class="btn" href="index.cfm">log off</a></div>
        <div id="commButDiv" class="logoff btn">comments</div>
        <div id="delButDiv" class="logoff btn">delete application</div>
        
             <div id="dlForm">
             	<cfif isDefined("Form.myApp")>
                    
					<cfinclude template="comModal.cfm">
						<cfoutput>Proposal ID = #Form.myApp#</cfoutput>
                </cfif>
                         
              </div><!--end dlForm-->
              
             <div id="appDate"></div>
             <div style="clear:both"></div>
        </div><!--end instructions-->
        
                <div id="formDiv">
                    <cfinclude template="admin/form.cfm">
               </div><!--end formDiv-->

	
    <cfinclude template="footer.cfm">
</div><!-- end of the wrapper div -->
<script type="text/javascript">$('#wrapper').corner("bottom");$('#foot').corner("bottom")</script>

</body>
</html>
