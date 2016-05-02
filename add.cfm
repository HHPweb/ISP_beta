<!---<form action="add.cfm" method="post">
<textarea name="faculty" cols="80" rows="15"></textarea>
<input type="submit" name="submit" value="Enter" />
</form>

<cfif isDefined('Form.faculty')>
     <cfloop index="faculty" list="#Form.faculty#" delimiters="~">
     	<cfset facList = ArrayNew(1)>
        <cfloop index="deets" list="#faculty#" delimiters=",">
        	<cfset ArrayAppend(facList,"#deets#")>
        </cfloop>
        <cfoutput><p>#facList[1]#</p></cfoutput>
        <cfquery dataSource="hhp_apps" name="myQuery"> 
            INSERT INTO faculty_staff
            	(email,dept,last,first,chair,faculty,staff,admin,status)
            VALUES
            	('#facList[1]#','#facList[2]#','#facList[3]#','#facList[4]#','#facList[5]#','#facList[6]#','#facList[7]#','#facList[8]#','#facList[9]#');
     	</cfquery>
     </cfloop>   
</cfif>--->