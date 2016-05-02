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
<title>HHP Independent Study Proposal</title>



<cfscript>
   StructClear(Session);
</cfscript>
<cfset myDate = #DateFormat(now(), "m-d-yyyy")#>
<cfinclude template="admin/login.cfm">

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
        <p>This Independent Study Form is to be used by all students wishing to engage in an Independent Study, Field Experience, Practicum, or other course in which they work one-on-one with a particular faculty member. PRIOR to completing this form, the student should speak with the potential instructor and work out the details of the course expectations and timelines.</p>
        
        <p><strong>STUDENT:</strong> Complete and submit the form below. Your faculty supervisor will be notified via the email address you provide, so make sure it is correct. The student must be enrolled in the semester in which the independent study work is undertaken. Independent study involves one-on-one mentoring of a student by a faculty member.</p>
        
        <p><strong>COURSE SUBSTITUTION:</strong> Independent study should not be used to replace courses that are regularly offered, except in extraordinary circumstances (e.g., two required courses are offered at the same time during a student's final semester before graduation).</p>
    </div>
    
    <div id="login">
            <!--- All Error messages --->
            <!--- <cfset message="Temporarily unavailable for updates."> --->
        <cfif isDefined("message")>
            <cfoutput><p class="errormessage">#message#</p></cfoutput>
        </cfif>
            
           <form method="post" id="loginform" name="myForm" action="" onsubmit="return ckLogForm(this)">
    <fieldset>
    <legend>Login to start or edit-review a proposal. </legend>
    
           <p> <label for="pirateidinput"><strong>PirateID</strong></label>
            <input id="pirateidinput" name="pirateid" type="text" size="20" /></p>
            <p><label for="passphraseinput"><strong>Passphrase</strong></label>
            <input id="passphraseinput" name="passphrase" type="password" size="20" /></p>	
            <p><label for="dept"><strong>Select Department: </strong>
            <select id="dept" name="dept">
            	<option></option>
                <option>HLTH</option>
                <option>KINE</option>
                <option>RCLS</option>
            </select>
            </label></p>
            <input type="hidden" name="status" value="edit" />
            <input type="hidden" name="login" value="edit" />
            <input type="submit" id="submitBtn" name="subBtn" value="Enter" /><br /><br />
            <a href="http://pirateid.ecu.edu">Forgot your passphrase?</a>
    </fieldset>
    </form> 
           
        </div>
        
    <cfinclude template="footer.cfm">
</div><!-- end of the wrapper div -->


<script type="text/javascript">$('#wrapper').corner("bottom");$('#foot').corner("bottom")</script>
</body>
</html>
