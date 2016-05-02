<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Delete Proposal</title>
<link rel="stylesheet" type="text/css" href="myStyle.css" />
<cfinclude template="jqueryLoad.cfm">
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
    	<h1>Scholarship Application for Students in <br />
    	  The College of Health & Human Performance
</h1> 
<cffunction name="delUser"><!---  --->
   	 <cftry> 
        <cfquery dataSource="hhp_apps" name="deleteApp"> 
            DELETE FROM ISP_forms WHERE id = '#FORM.id#'
        </cfquery>

        <cfoutput>
        	<br /><h3>It looks like you've deleted application ## #FORM.id# from the database.</h3><br /><br />
			<h3><a href="admin/admin.cfm">Return to proposal list</a></h3>
		</cfoutput>
     <cfcatch type="any">
            <cfoutput><br /><br /><br /><br />There was a problem and your application might not have been deleted from the database.<br /><br /> Please contact the <a href="mailto:baldwinc@ecu.edu">administrator</a> with a description of your problem that includes this URL.</cfoutput>
        </cfcatch>
    </cftry> 
</cffunction>


<cffunction name="checkExistence">
	<cfargument name="appDate" type="string">
    <cfquery name="checkExist" datasource="hhp_apps">
    	SELECT id FROM scholarship_applicants WHERE banner = <cfqueryparam value="#Form.banner#" CFSQLType="CF_SQL_VARCHAR"> AND date = '#appDate#'
    </cfquery>
    <cfscript>
		if(checkExist.id != "") {
			return "yes";	
		}else {
			return "no";	
		}
	</cfscript>
</cffunction>
<!--- This if statement is the starting point for this page. We check to see if an id was submitted and trigger the delUser function if it was --->
<cfif IsDefined("Form.id")>
	<cfoutput>#delUser()#</cfoutput>
</cfif>
</div>

 <cfinclude template="footer.cfm">
</div><!-- end of the wrapper div -->
<script type="text/javascript">$('#wrapper').corner("bottom");$('#foot').corner("bottom")</script>

</body>
</html>