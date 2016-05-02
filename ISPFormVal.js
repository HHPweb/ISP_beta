// JavaScript Document
<!-- hide script from old browsers
function ckLogForm(form) {
	if($('#dept').val() == "") {
		window.alert("Please select a department");
		form.dept.focus();
		return false;
		}
}



<!-- Dynamic Version by: Nannette Thacker -->
<!-- http://www.shiningstar.net -->
<!-- Original by :  Ronnie T. Moore -->
<!-- Web Site:  The JavaScript Source -->
<!-- Use one function for multiple text areas on a page -->
<!-- Limit the number of characters per textarea -->
<!-- Begin
function textCounter(field,cntfield,maxlimit) {
	if (field.val().length > maxlimit) // if too long...trim it!
	field.val() = field.val().substring(0, maxlimit);
	// otherwise, update 'characters left' counter
else
	cntfield.val( maxlimit - field.val().length );
}
//  End -->
function checkSelects(e) {
	if($('#term').val() == "Select Term") {
			window.alert('Please select a term');
			//e.preventDefault();
			//return false;
			valled = false;
	}
	if($('#year').val() == "Select Year") {
		window.alert('Please select a year');
		//e.preventDefault();
		//return false;
		valled = false;
	}
}

function checkCourseInfo(e) {
	if($('#prefix').val() == "") {
		window.alert('Please enter a course prefix');
		e.preventDefault();
		return false;
	}
	if($('#number').val() == "") {
		window.alert('Please enter a course number');
		e.preventDefault();
		return false;
	}
	if($('#hours').val() == "") {
		window.alert('Please enter course credit hours');
		e.preventDefault();
		return false;
	}
}

//valdatin checks to make sure a radio button question has been answered
	//only works on cf radio buttons as written here
function valdatin(form, ctrl, value) {
myOption = -1;
for (i=ctrl.length-1; i > -1; i--) {
	if (ctrl[i].checked) {
		myOption = i; 
		i = -1;
	}
}
if (myOption == -1) {
	return false;
}
return true;
}
// end hiding script from old browsers -->