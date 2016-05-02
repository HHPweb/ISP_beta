//-----------------------------Begin document ready function--------------------------
$(document).ready(function() {
//----------------------------- this is an existing form -------------------------\\
	if(myAp != "new") {
		fillForm(myAp);
		$('#complete').prop('disabled', true);//disabling this for everybody but enabling it under the faculty "if"
//------------------------ user is a student ------------------------------------\\
		if(position == "student") {
			$('#crn').prop('disabled', true);
			$('#dept').prop('disabled', true);
			$('#hours').prop('disabled', true);
			$('#asstMail').prop('disabled', true);
			$('#processDone').prop('disabled', true);
			$('#complete').prop('disabled', true);
			$('#formBtns').html("<p style=\"background-color:#fff;padding:3px;margin-bottom:5px;\">Clicking the save button <strong>Will Not</strong> send a notification to your faculty supervisor.<br>Click the submit button if you want your faculty supervisor to be notified.</p><div id=\"subAppBtn\" class=\"btn\" style=\"float:left;\">Submit Form</div> <div id=\"saveBtn\" class=\"btn\" style=\"margin-left: 230px;\">Save Changes</div>");
			$('#subAppBtn').click(function() {
				subApp();
				});
			$('#saveBtn').click(function() {
				saveForm();
				});
		}
//----------------------- user is faculty -------------------------------------------\\
		if(position == "faculty") {
			//$('#complete').prop('disabled', false);
			$('#asstMail').prop('disabled', true);
			$('#crn').prop('disabled', true);
			$('#processDone').prop('disabled', true);
			$('#formBtns').html("<p id=\"instructs\" style=\"background-color:#fff;padding:3px;margin-bottom:5px;\">Clicking either button <strong>Will</strong> send a notification to the student.<br>Clicking approve will also notify the department chair.</p><a id=\"rejBtn\" class=\"btn\" href=\"javascript:openRej();\">Reject Application</a> <a id=\"appBtn\" class=\"btn\" style=\"margin-left: 230px;\" href=\"javascript:subToChair();\">Approve Application</a><div style=\"clear:both\"></div>");
			if($('#processDone').is(':checked') == "true") {
				$('#rejBtn').hide();
			}
			
		}
//----------------------- user is chair ----------------------------------------------\\
		if(position == "chair") {
			$('#processDone').prop('disabled', true);
			$('#formBtns').html("<p style=\"background-color:#fff;padding:3px;margin-bottom:5px;\">Clicking either button <strong>Will</strong> send a notification to the student and faculty supervisor.<br>Clicking approve will also notify the processor that you have selected.</p><a id=\"rejBtn\" class=\"btn\" href=\"javascript:openRej();\">Reject Application</a> <a id=\"appBtn\" class=\"btn\" style=\"margin-left: 230px;\" href=\"javascript:subToStaff();\">Approve Application</a><div style=\"clear:both\"></div>");
			console.log( "hey " + $( '#sMail' ).val() );
			$('#asstMail').change(function() {
			  $('#sMail').val($('#asstMail').val());
			});
		}
//----------------------- user is staff ----------------------------------------------\\	
		if(position == "staff") {
			$('#processor').hide();
			$('#formBtns').html("<div id=\"appBtn\" class=\"btn\" style=\"width:200px;float:none;margin:0\">Processing Completed</div><div style=\"clear:both\"></div>");
			$('#appBtn').click(function() {
				procCompleted();
				});
			
		}
//----------------------- end of user is staff ----------------------------------------------\\
		if((passedOn == "True") && (position != "faculty")) {
			$('#formBtns').hide();
		}else{
			$('#formBtns').show();
			}
		
	}//end of scripts for forms that aren't new
	if(myAp == "new") {
		$('#commButDiv').hide();
//------------------------ user is a student ------------------------------------\\
		if(position == 'student') {
			$('#facOnly').hide();
			$('#last').val(sLast);
			$('#first').val(sFirst);
			$('#middle').val(sMiddle);
			$('#pirateid').val(pirateid);
			$('#email').val(email);
		}
		
//----------------------- user is faculty -------------------------------------------\\
		if(position == 'faculty') {
			$('#asstMail').prop('disabled', true);
			$('#processDone').prop('disabled', true);	
		}
	}
//---------------------- for all NEW applications -------------------------------------\\
	//$('.btn').button();
	$('#state').val('NC');
	fillDept('#JSStringFormat(Session.dept)#');
	$('#classroom').prop('checked', true);
 
});
//----------------------------End documenet ready function------------------------------\\

