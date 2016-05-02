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
<script src="proposals.js" type="text/javascript"></script>

<cfif IsDefined("Session.pirateid") is False>
	<cflocation url = "index.cfm">
</cfif>
<cfif IsDefined("Session.position")>
	<cfoutput><script type="text/javascript">var pos = '#Session.position#';</script></cfoutput>
</cfif>
<cfset myDate = #DateFormat(now(), "m-d-yyyy")#>
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
    
	<div id="instructions">
    	<div class="logoff">
			<p style="padding:0;margin:0;line-height:normal">
				<strong><cfoutput>#Session.first#   #Session.last#  - #Session.position#</cfoutput></strong></p>
		</div>
		<cfif Session.position IS "admin">
			<div class="logoff">
				<form id="swapForm" name="swapForm" action="admin/chgRole.cfm" method="post">
				<select name="cat" id="cat">
					<option value="admin">admin</option>
					<option value="chair">chair</option>
					<option value="staff">staff</option>
					<option value="faculty">faculty</option>
					<option value="student">student</option>
				</select>
			</form>
		</div><!-- end role change div -->
		</cfif>
        <div class="logoff"><a class="btn" href="index.cfm">log off</a></div>
        <div class="logoff"><a class="btn" href="proposal.cfm">New Application</a></div>
        <div style="clear:both"></div>
    </div>
            
    
	<div id="tableDiv" class="divText">
		<table id="propsTable"><tbody><tr><th>Select</th><th>Status</th><th>Date</th><th>Name</th><th>Term</th><th>Supervisor</th><th>Course</th><th>Hours</th></tr></tbody></table>
	</div>
	<cfinclude template="footer.cfm">
</div><!-- end of the wrapper div -->
<script type="text/javascript">$('#wrapper').corner("bottom");$('#foot').corner("bottom")</script>
 
</body>
</html>
