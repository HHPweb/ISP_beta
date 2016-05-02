 <cffunction name="delUser"><!---  --->
   	 <cftry>
      <cfquery dataSource="hhp_apps" name="trashApp"> 
            INSERT ISP_trash
			SELECT * FROM ISP_forms 
            WHERE id = #FORM.id#
        </cfquery>
  
        <cfquery dataSource="hhp_apps" name="deleteApp"> 
            DELETE FROM ISP_forms WHERE id = '#FORM.id#'
        </cfquery>
        
        <cfoutput>Application has been deleted.</cfoutput>
     <cfcatch type="any">
            <cfoutput>There was an error: #cfcatch.Message#. Application may not have been deleted.</cfoutput>
        </cfcatch>
    </cftry>
</cffunction>



<!--- This if statement is the starting point for this page. We check to see if an id was submitted and trigger the delUser function if it was --->
<cfif IsDefined("Form.id")>
	<cfoutput>#delUser()#</cfoutput>
<cfelse>
	<cfoutput>Error: no id value in post vars</cfoutput>
</cfif>
