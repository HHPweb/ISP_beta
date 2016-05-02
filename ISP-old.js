
//-----------------------------Begin document ready function--------------------------
	$(document).ready(function() {
		var pd = false;
		var valled = true;//var for form validation initially set to true
		$('.formRow:odd').css('background-color', '#A0A0A0');
		$( "#rejDiv" ).dialog({ //init the rejection modal
			height: 300,
			width: 500,
			modal: true,
			autoOpen: false
		});
		
		$( "#commDiv" ).dialog({ //init the comments modal
			height: 500,
			width: 800,
			modal: true,
			autoOpen: false
		});
		
		$('#apvDiv').dialog({ //init the faculty approval modal
			height: 450,
			width: 500,
			modal: true,
			autoOpen: false
		});
		
		//$(".btn").button();
		
		if (typeof myAp != 'undefined') {
			$('#formBtns').html("<div id=\"subAppBtn\" class=\"btn\">Submit Form</div>");
			//$(".btn").button();
			$('#subAppBtn').click(function() {
				subApp();
				});
		}
		
		$('#delButDiv > a').prop('disabled', true);
		// a session timer/alarm
		setTimeout(function(){sessWarn();}, 110*60*1000);

 		$('#approveAppBtn').click(function() {
			apvForm();
		});

 		$('#cancelApvEvtBtn').click(function() {
			cancelApvEvt();
		});
 
		$('#cancelEvtBtn').click(function() {
			cancelEvt();
		});

		$('#subFormBtn').click(function() {
		    subForm();
		});

		$('#rejFormBtn').click(function() {
		    rejForm();
		});

		$('#cancelRejEvtBtn').click(function() {
		    cancelRejEvt();
		});

		$('#commButDiv').click(function() {
		    openComm();
		});

		$('#delButDiv').click(function() {
		    deleteApp();
		});
	});
//----------------------------End documenet ready function------------------------------\\

//---------------------------Session ending warnings-------------------------------------\\
function sessWarn() {
	var k = confirm("Your session will expire soon. Keep it open?");
	if (k) {
			$.post("renew.cfm");
			setTimeout(function(){sessWarn();}, 110*60*1000);
		}
}
//---------------------------End session ending warnings-------------------------------------\\

//----------------------------Begin filling in form-------------------------------------\\
function fillForm(iD) {
	//jquery ajax call to get data
	$.ajax({
	  cache: false,
	  type: "POST",
	  dataType: 'json',
	  url: "formLoad.cfm",
	  data: { myApp: iD }
	}).success(function (data) {
		//fill the form in here
		$('#pirateid').val(data.DATA.PIRATEID);
		$('#last').val(data.DATA.LAST);
		$('#first').val(data.DATA.FIRST);
		$('#middle').val(data.DATA.MIDDLE);
		$('#address').val(data.DATA.ADDRESS);
		$('#city').val(data.DATA.CITY);
		$('#state').val(data.DATA.STATE);
		$('#zip').val(data.DATA.ZIP);
		$('#phone').val(data.DATA.PHONE);
		$('#email').val(data.DATA.EMAIL);
		$('#goals').val(data.DATA.GOALS);
		$('#outcomes').val(data.DATA.OUTCOMES);
		$('#tasks').val(data.DATA.TASKS);
		$('#evaluation').val(data.DATA.EVALUATION);
		$('#prefix').val(data.DATA.PREFIX);
		$('#number').val(data.DATA.NUMBER);
		$('#crn').val(data.DATA.CRN);
		$('#hours').val(data.DATA.HOURS);
		$('#title').val(data.DATA.TITLE);
		$('#myApp').val(data.DATA.ID);
		var n=String(data.DATA.TERM).split("~");
		$("#term").val(n[0]);
		$('#year').val(n[1]);
		var supr = String(data.DATA.SUPERVISOR);
		//supr = supr.toUpperCase();
		$('#supervisor').val(String(data.DATA.SUPERVISOR).toUpperCase());//.toUpperCase()
		//alert(supr);
		
		$('#asstMail').val(String(data.DATA.ASSTMAIL).toUpperCase());
		if(data.DATA.ASSTMAIL == "") {
			$('#asstMail').val("Select Processor");
		}
		$('#dept').val(data.DATA.DEPT);
		if((data.DATA.FACULTYAPP == "false") && (position == "chair")) {
			//no need to show reject/approve btns to chair if faculty hasn't approved
			$('#formBtns').hide();
		}
		if((data.DATA.FACULTYAPP == "true") && (position == "faculty") && (data.DATA.PROCESSDONE != "true")) {
			$('#formBtns').hide();//if faculty has already approved we hide the buttons unless it has finished being processed by staff
		}
		if(data.DATA.PROCESSDONE == "true") {
			$('#processDone').prop('checked',true);
			$('#delSubBtn').prop('disabled', true);
			if(position == "faculty") {
				$('#rejBtn').hide();
				$('#appBtn').css({float:'none',margin:'0'});
				$('#instructs').html("This will send a notification to the student only.");
				//change the Approve Application button here
				$('#appBtn').text("Course Completed").css('font-size','12px').attr('href', 'javascript:subComplete();');
			}
			if(position == "student") {
				$('input').prop('disabled', true);
				$('select').prop('disabled', true);
				$('textarea').prop('disabled', true);
			}
		}
		if(data.DATA.COMPLETE == "true") {
			$('#complete').prop('checked',true);
		}
		// fill the DE radio button delivery
		$("input[name='delivery']").each(function(i) {
			if($(this).val() == data.DATA.DE){
				$(this).prop("checked", true);
			}
		});
		//fill the writing intensive radio button
		$("input[name='writing']").each(function(i) {
			if($(this).val() == data.DATA.WRITING) {
				$(this).prop("checked", true);
			}
		});
	});
	
}


//----------------------------Comments--------------------------------------------------\\
function openComm() {
		$('#commDiv').dialog('open');
		fetchPosts();
	}
	
//make the Ajax call when comment is submitted
    function subForm() {
		ColdFusion.Ajax.submitForm('myComm', 'mkComm.cfm', call, err);
    }
//call is the function that processes the info sent back to us from the Ajax call in submitForm()
    function call(text)
    {
		fetchPosts();
    }
    
    function err(code, msg)
    {
        alert("Error!!! " + code + msg);
    }
	
//triggered by hitting the cancel button on the comment form
	function cancelEvt() {
		$('#commDiv').dialog('close');
	}
	
//make the Ajax call when comment is submitted
		function fetchPosts() {
			//alert("fetching posts");
			ColdFusion.Ajax.submitForm('pullPosts', 'pullPosts.cfm', callbackz, errorHandlerz);
		}
//callbackz is the function that processes the info sent back to us from the Ajax call in submitForm()
		function callbackz(text)
		{
			var msg = $.trim(text);
			$('textarea[id][name="comment"]').val('');
			$('#posts').html(msg);
		}
		
		function errorHandlerz(code, msg)
		{
			alert("Error!!! " + code + msg);
		}
//----------------------------End comments----------------------------------------------

//----------------------------Reject application----------------------------------------
function openRej() {
		$('#rejDiv').dialog('open');
	}
	
//make the Ajax call when rejection comment is submitted
    function rejForm() {
		ColdFusion.Ajax.submitForm('myRejComm', 'rejComm.cfm', rejCall, rejErr);
    }
//rejCall is the function that processes the info sent back to us from the Ajax call in submitForm()
    function rejCall(text)
    {
		cancelRejEvt();
		var msg = $.trim(text);
		alert(msg);
		saveForm();
    }
    
    function rejErr(code, msg)
    {
        alert("Error!!! " + code + msg);
    }
	
	//triggered by hitting the cancel button on the comment form
	function cancelRejEvt() {
		$('#rejDiv').dialog('close');
	}
//------------------------------End reject application----------------------------------------
//------------------------------ Chair approval -----------------------------------------\\
function subToStaff() {
	//do some form validation and if it passes call subApproval();
	
	if($('#asstMail').val() == "Select Processor" || $('#asstMail').val() == "") {
		alert("Please select the person who will process this application.");
		$('#asstMail').focus();
	}else {
		subApproval();
	}
}

//------------------------------Faculty approval-----------------------------------------\\
function subToChair() {
	//do some form validation and if it passes call subApproval();
	
	if($('#hours').val() == "") {
		alert("Please enter the number of semester hours.");
		$('#hours').focus();
		return;
	}
	if($('#processDone').is(':checked') == true) {
		alert("just need to mark complete");
		
	}else{
		subApproval();
	}
}
//----------------------------faculty marking complete------------------------------------\\
function subComplete() {
	//make an ajax call somewhere to mark the course as being competed.
	var k = $('#myApp').val();
	$.post("complete.cfm", {myApp:k},function( data ) {
				  alert($.trim(data));
				 // saveForm();
			  }).error(function(){alert("error");});
}
//---------------------------- End faculty approval -------------------------------------\\
//----------------------------- Staff processing completed -------------------------------\\
function procCompleted() {
	if($('#crn').val() == "") {
		alert("Please enter the CRN.");
		$('#crn').focus();
		return;
	}
	//do a jquery ajax call to apvComm.cfm - just pass in the app id then saveForm() and alert the return msg.
	var k = $('#myApp').val();
	$.post("apvComm.cfm", {app:k},function( data ) {
				  alert($.trim(data));
				  saveForm();
			  }).error(function(){alert("error");});
}
//----------------------------- end staff processing completed ---------------------------\\

//--------------------------- Process app submissions -------------------------------------\\
function subApproval() {
	$('#apvDiv').dialog('open');
}

function apvForm() {
	saveForm();
	ColdFusion.Ajax.submitForm('myApvComm', 'apvComm.cfm', apvCall, apvErr);
}

function apvCall(text) {
	cancelApvEvt();
	var msg = $.trim(text);
	alert(msg);
}

function apvErr(code, msg) {
	alert("Error!!! " + code + msg);
}

function cancelApvEvt() {
	$('#apvDiv').dialog('close');
}

//------------------------------End app submission-------------------------------------\\


//------------------------------Saving a form-----------------------------------------
    function saveForm() {
		ColdFusion.Ajax.submitForm('appForm', 'saveForm.cfm', saveCall, saveErr);
    }
//callback is the function that processes the info sent back to us from the Ajax call in submitForm()
    function saveCall(text)
    {
		//cancelRejEvt();
		var msg = $.trim(text);
		if(position == "student") {
			alert(msg);
		}
    }
    
    function saveErr(code, msg)
    {
        alert("Error!!! " + code + msg);
    }
//------------------------------End saving a form-----------------------------------------


//------------------------------Submitting an application----------------------------------

function subApp() {
	//set valled to true before doing form validations
	var valled = true;
	valled = checkVal();
	if(valled == true) {
		ColdFusion.Ajax.submitForm('appForm', 'submitApp.cfm', subAppCall, subAppErr);
	}else{}
	
    }
//callback is the function that processes the info sent back to us from the Ajax call in submitForm()
    function subAppCall(text)
    {
		//cancelRejEvt();
		var msg = $.trim(text);
		alert(msg);
    }
    
    function subAppErr(code, msg)
    {
        alert("Error!!! " + code + msg);
    }
//------------------------------End submitting a form-----------------------------------------

//------------------------------Deleting an application-------------------------------	
function deleteApp() {
	var r=confirm("All data associated with this form will be gone FOREVER. \nDelete this application?");
if (r==true)
  {
  	//send the app id to delApp.cfm via ajax and delete it there - then return a message and alert it
  	var k = $('#myApp').val();
	$.post("delApp.cfm", {id:k},function( data ) {
				  alert($.trim(data));
				  window.location.replace("proposals.cfm");
			  }).error(function(){alert("mystery error");});

  }
else
  {
  return false;
  }
}

function fillDept(myDept) {//function fills in the radio button for dept if it has already been submitted 
	var myX = document.getElementsByName('dept');//myX is the name of the question (such as "Q1") and this creates an array of all inputs with that name
				for(y=0;y<myX.length;y++) {//loop over the items (radio buttons in this case) for each question
					if(myX[y].value == myDept) {//find the one with a value that matches what was submitted on the form
						myX[y].checked = true;//check the radio button that matches
					}
				}
}
//---------------------------End deleting application------------------------------------\\

//---------------------------Form validations-----------------------------------------\\

//this gets called by each textarea via a onKeyUp and onKeyDown - see the form for details
function checkVal(){
	//check select drop downs
	if($('#term').val() == "Select Term") {
			alert('Please select a term');
			return false;
	}
	if($('#year').val() == "Select Year") {
		alert('Please select a year');
		return false;
	}
	if($('#supervisor').val() == "Select Faculty Supervisor") {
		alert('Please select your supervisor');
		return false;
	}
	
	//check text fields
	if($('#pirateid').val() == "") {
		alert('Pirate ID is a required field.');
		return false;
	}
	var maile = $('#email').val();
	if((maile.indexOf('@') == -1) || (maile.length < 10)) {
		alert('Please provide a proper email address.');
		$('#email').focus();
		return false;
	}
	if($('#prefix').val() == "") {
		alert('Please provide Course Prefix');
		$('#prefix').focus();
		return false;
	}
	if($('#number').val() == "") {
		alert('Please provide Course Number');
		$('#number').focus();
		return false;
	}
	if($('#title').val() == "") {
		alert('Please provide Course Prefix');
		$('#title').focus();
		return false;
	}
	
	//checking radio buttons
	var radio_groups = {};
	$(":radio").each(function(){
		radio_groups[this.name] = true;
	})
	
	for(group in radio_groups){
		if_checked = !!$(":radio[name="+group+"]:checked").length;
		if(if_checked) {
			//alert("good boy");
		}else {
			alert("Please indicate if this course is writing intensive.");
			return;
		}
	}
	
//if everything checks out we return true
	return true;
}

//function for limiting number of characters in text fields
function textCounter(field,maxlimit) { 
	if (field.value.length > maxlimit) { // if too long...trim it!
		field.value = field.value.substring(0, maxlimit);
		alert("There is a "+ maxlimit +" character limit.");
	}
}

//check for department at initial login
function ckLogForm(form) {
	if($('#dept').val() == "") {
		alert("Please select a department");
		form.dept.focus();
		return false;
		}
}
