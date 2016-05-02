<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>HHP Independent Study Proposal</title>
<link rel="stylesheet" type="text/css" href="../myStyle.css" />
<cfinclude template="../jqueryLoad.cfm">
<cfif IsDefined("Session.category") is false or #Session.category# is "student">
	<cflocation url = "../index.cfm">
</cfif>
<cfset myDate = #DateFormat(now(), "m-d-yyyy")#>
<script type="text/javascript" src="../ISPFormVal.js"></script>
</head>
<body>
<div id="wrapper"> 
    <div class="ECU_Banner"> 
        <img src="../images/eastcarolinauniversity.gif" alt="East Carolina University" /> 
    </div> 
    <div id="subHeader">
        The College of Health and Human Performance
    </div>
        
    <div class="divText"> 
            <h1>Independent Study Proposal Form<br />
              The College of Health and Human Performance</h1>
    </div> 
        
    	<cfif IsDefined("Session.pirateid")><!--- checking to see if they've logged in --->
        	<div id="instructions">
                <p><strong>Admin: <cfoutput>#Session.pirateid#</cfoutput></strong><span class="logoff"><a href="../index.cfm">log off</a></span></p>
            </div>
            <cfquery name="findApps" datasource="hhp_apps">
                SELECT id, last, first, term, supervisor,initDate,email, prefix, number, hours, facultyApp, chairApp, processDone, complete FROM ISP_forms 
                ORDER BY initDate DESC
            </cfquery>
            <cfif findApps.RecordCount GT 0 >
                <div class="divText">
                <h2>Select the proposal you want to review.</h2>
                <table><tr><th>Select</th><th>Status</th><th>Date</th><th>Name</th><th>Term</th><th>Supervisor</th><th>Course</th><th>Hours</th></tr>
               <cfloop query="findApps">
                    <cfoutput>
                    	<cfform name="selectForm" action="../adminEdit.cfm" method="post">
                        <tr>
                        	<td>
                            	<cfinput type="hidden" name="editing" value="true">
                                <cfinput type="hidden" name="myApp" value="#findApps.id#" >
                                <cfinput name="submit" value="Open" type="submit" />
                            </td>
                        
                        <td>
                            <cfif findApps.facultyApp IS "yes">
                                <p class="cleared">Faculty Approved</p>
                            <cfelse>
                                <p class="notCleared">Faculty Approved</p>
                            </cfif>
                            <cfif findApps.chairApp IS "yes">
                                <p class="cleared">Chair Approved</p>
                            <cfelse>
                                <p class="notCleared">Chair Approved</p>
                            </cfif>
                            <cfif findApps.processDone IS "yes">
                                <p class="cleared">Processing Complete</p>
                            <cfelse>
                                <p class="notCleared">Processing Complete</p>
                            </cfif>
                            <cfif findApps.complete IS "yes">
                                <p class="cleared">Course Completed</p>
                            <cfelse>
                                <p class="notCleared">Course Completed</p>
                            </cfif>
                            
                        </td>
                        <td>#findApps.initDate#</td>
                        <td>#findApps.first# #findApps.last#</td>
                        <td>#findApps.term#</td>
                        <td>#findApps.supervisor#</td>
                        <td>#findApps.prefix# #findApps.number#</td>
                        <td>#findApps.hours#</td></tr>
                        </cfform>
					</cfoutput>
               </cfloop>
               
               </table>
               </div><!--end divText-->
                
             <cfelse>
                  <cfoutput>You are not listed as the Department Chair for any independent study applications.</cfoutput>
             </cfif>

<cfelse>
	<cflocation url = "index.cfm">
</cfif>
        <cfinclude template="../footer.cfm">
</div><!-- end of the wrapper div -->
<script type="text/javascript">$('#wrapper').corner("bottom");$('#foot').corner("bottom")</script>

</body>
</html>
