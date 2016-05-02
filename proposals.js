//-----------------------------Begin document ready function--------------------------
$(document).ready(function() {
	$( "#loadinDiv" ).dialog({ 
		height: 350,
		width: 400,
		modal: true,
		autoOpen: false
	});
	$("#cat").change(function(){
		$("#swapForm").submit();
	});
	$.post("loadProps.cfm", {pos:pos},function( data ) {
		if(data.DATA.ID.length < 1) {
			$('#propsTable > tbody:last').append('<tr><td colspan="8" style="text-align:center"><p class="errormessage">No proposals found.</p></td></tr>');
		}
		$.each(data.DATA.ID, function (i, v) {
		    
			//figure out passedOn
			var passedOn = "False";
			if(pos == "staff") {
				if(data.DATA.PROCESSDONE[i] == "yes") {
					passedOn = "True";
				}else if(data.DATA.CHAIRAPP == "yes") {
					passedOn = "True";
				}
			}
			//set name
			var rName = data.DATA.FIRST[i] + '&nbsp;' + data.DATA.LAST[i];
			//determine status
			var statClass = "notCleared";
			var status = "Pending Faculty Approval";
			if(data.DATA.COMPLETE[i] == true) {
				status = "Course Completed";
				statClass = "cleared";
			}else if(data.DATA.PROCESSDONE[i] == "yes") {
				status = "Student Registered";
			}else if(data.DATA.CHAIRAPP[i] === "yes") {
				status = "Pending Final Processing";
			}else if(data.DATA.FACULTYAPP[i] == "yes") {
				status = "Pending Chair Approval";
			}
			$('#propsTable > tbody:last').append('<tr><td><form name="selectForm" action="proposal.cfm" method="post"><input type="hidden" name="rMail" value="'+data.DATA.EMAIL[i]+'"/><input type="hidden" name="rName" value="'+ rName + '"/><input type="hidden" name="myApp" value="'+data.DATA.ID[i]+'"/><input type="hidden" name="passedOn" value="'+passedOn+'"/><input name="submit" value="Open" type="submit" /></form></td><td><p class="'+statClass+'">'+status+'</p></td><td>'+ data.DATA.INITDATE[i] + '</td><td>' + rName + '</td><td>' + data.DATA.TERM[i] + '</td><td>' + data.DATA.SUPERVISOR[i] + '</td><td>' + data.DATA.PREFIX[i] + '&nbsp;' + data.DATA.NUMBER[i] + '</td><td>' + data.DATA.HOURS[i] + '</td></tr>');
		});//end of loop over returned json
				  }, "json").error(function(){alert("error");});	
});
//----------------------------End documenet ready function------------------------------\\