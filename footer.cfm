<cfajaximport>
<script type="text/javascript">
	$(document).ready(function() {
 // hides the roster as soon as the DOM is ready
  $('#ereport').hide();
  $('#errSubDiv').click(function() {
	  submitErr();
  })
  $('#navInfo').val(navigator.userAgent);
  
 // toggles the roster on clicking the noted link  
  $('#ereport-toggle').click(function() {
    $('#ereport').toggle(400);
    return false;
  });
 // $('#ereport-toggle').hover(function() {$('#ereport-toggle').}, handlerOut)
  
  //scroll to bottom so that error report shows for sure
  $('#ereport-toggle').click(function(){
        $('html, body').animate({scrollTop:$(document).height()}, 'slow');
		$('#errMail').val('');
		$('#link').val('');
		$('#comment').val('');
        return false;
    });
		
		//error reporting script
    function submitErr() {
        ColdFusion.Ajax.submitForm('errForm', '../error.cfm', errCallback,
            errorHandler);
    }
    
    function errCallback(text)
    {
        var msg = $.trim(text);
		alert(msg);
    }
    
    function errorHandler(code, msg)
    {
        alert("Error!!! " + code + msg);
    }
		//end error reporting

});
</script>


<div id="foot" class="footer"> 
        <div style="float:left;margin-left: 20px;padding-top: 10px;">Built and maintained by Charles Baldwin.</div> 
        <div id="ereport-toggle" style="float:right;margin-right:20px;padding-top:10px;cursor:pointer;">Send an Error Report.</div>
        <div style="clear:both">&nbsp;</div>
<div id="ereport" style="border-top:2px solid #FFF;line-height:1.5;">
<cfoutput>
<cfif isDefined("Session.email")>
	<cfset myEmail = #Session.email#>
<cfelse>
	<cfset myEmail = "">
</cfif>
<cfset currentURL = CGI.SERVER_NAME & CGI.PATH_INFO>
	<form name="errForm" id="errForm" action="https://core.ecu.edu/baldwinc/error.cfm" method="post">
        <label for="errMail">Your email: &nbsp;&nbsp;<input type="text" size="30" id="errMail" name="errMail" value="#myEmail#" /></label><br />
        <label for="link">The url of the page where the error occurred:<br />
        <input type="text" id="link" name="link" size="70" /></label><br />
        <label for="comment">Please provide a description of the error.</label><br />
        <textarea id="comment" name="comment" cols="60" rows="8"></textarea>
        <input type="hidden" name="url" value="#currentURL#" />
		<input type="hidden" name="navInfo" id="navInfo" value="" />
        <div style="padding: 10px;">
        	<div id="errSubDiv" style="cursor:pointer;width:150px;margin:0 auto">Submit form</div>
       </div>
    </form>
</div><!--end ereport-->
</cfoutput>
</div><!--end footer-->