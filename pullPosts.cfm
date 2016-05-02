<cftry>
<cfif isDefined('Form.myApp')>
<cfquery name="getPosts" datasource="hhp_apps">
	SELECT * FROM ISP_comm WHERE app = <cfqueryparam value="#Form.myApp#" CFSQLType="CF_SQL_VARCHAR"> ORDER BY date ASC
</cfquery>

        <cfif getPosts.RecordCount LT 1>
        	<cfoutput><p>No comments posted to date.</p><hr /></cfoutput>
        </cfif>
        <cfloop query="getPosts">
        	<cfset pDate = DateFormat(date, "mm/dd/yyyy") & " - " & TimeFormat(date, "hh:mm tt")>
			<cfif getPosts.CurrentRow mod 2 is 0>
        		<cfoutput>
                    <div class="ePost">
                        <div class="pNfo"><strong>#author#</strong>: <br  />#pDate#</div>
                        <div class="pComm">#comment#</div>
                        <div style="clear:both"></div>
                    </div>
                </cfoutput>
            <cfelse>
            	<cfoutput>
                    <div class="oPost">
                         <div class="pNfo"><strong>#author#</strong>: <br  />#pDate#</div>
                        <div class="pComm">#comment#</div>
                        <div style="clear:both"></div>
                    </div>
                </cfoutput>
            </cfif>
        	
        </cfloop>
</cfif>
<cfcatch type="any">
<cfoutput>There was an error: #cfcatch.Message#</cfoutput>
</cfcatch>
</cftry>
