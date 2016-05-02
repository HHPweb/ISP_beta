<cfif Session.position IS NOT "admin">
	<cflocation url="../index.cfm">
<cfelse>
	<cfif IsDefined("Form.cat")>
		<cflock timeout=20 scope="Session" type="Exclusive">
			<cfset Session.position = #Form.cat#>
		</cflock>
		<cflocation url="../proposals.cfm">
	</cfif>
</cfif>