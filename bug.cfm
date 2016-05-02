<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>HHP Independent Study Proposal</title>
<link rel="stylesheet" type="text/css" href="myStyle.css" />
<cfinclude template="jqueryLoad.cfm">
<!--- checking to see if they've logged in --->
<cfif IsDefined("Session.pirateid") IS FALSE>
	<cflocation url = "index.cfm">
</cfif>
<cfset myDate = #DateFormat(now(), "m-d-yyyy")#>
<script type="text/javascript" src="comments.js"></script>
<script type="text/javascript" src="rejection.js"></script>
<script type="text/javascript" src="save.js"></script>
<script type="text/javascript" src="ISPFormVal.js"></script>
</head>
<body>
<div id="wrapper"> 
    <div class="ECU_Banner"> 
        <img src="images/eastcarolinauniversity.gif" alt="East Carolina University" /> 
    </div> 
    <div id="subHeader">
        The College of Health and Human Performance
    </div>
        
    <div class="divText"> 
            <h1>Independent Study Proposal Form</h1>
    </div> 
		<div style="height: 100px;background-color:#9C9;">
         <form action="apvComm.cfm" method="post">
         	<input type="hidden" name="app" value="1" />
            <input type="submit" name="submit" value="submit" />
         </form>
                    
	
    <cfinclude template="footer.cfm">
</div><!-- end of the wrapper div -->
<script type="text/javascript">$('#wrapper').corner("bottom");$('#foot').corner("bottom")</script>

</body>
</html>
