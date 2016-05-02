<form id="appForm" name="appForm" action="submitApp.cfm" method="post">

<div class="formRow">
    <label for="last"><strong>Last Name: </strong> <input name="last" id="last" size="20" maxlength="20" type="text" onKeyDown="textCounter(this,20)" onKeyUp="textCounter(this,20)" /></label>&nbsp; 
    <label for="first"><strong>First:</strong> <input name="first" id="first" size="20" maxlength="20" type="text" onKeyDown="textCounter(this,20)" onKeyUp="textCounter(this,20)" /></label>&nbsp;
    <label for="middle">Middle: <input name="middle" id="middle" size="20" maxlength="20" type="text" onKeyDown="textCounter(this,20)" onKeyUp="textCounter(this,20)" /></label>
</div><!-- end formRow -->
<!-- end line 1 -->

<div class="formRow">
    <label for="address"><strong>Local Address:</strong> <input name="address" id="address" size="40" maxlength="40" type="text" onKeyDown="textCounter(this,40)" onKeyUp="textCounter(this,40)" /></label>&nbsp;
    <label for="city"><strong>City:</strong> <input name="city" id="city" size="40" maxlength="40" type="text" onKeyDown="textCounter(this,20)" onKeyUp="textCounter(this,20)" /></label>
</div><!-- end formRow -->
<!-- end line 2 -->

<div class="formRow">
<label for="state"><strong>State:</strong> <input name="state" id="state" size="2" maxlength="2" type="text" onKeyDown="textCounter(this,2)" onKeyUp="textCounter(this,2)" /></label>&nbsp; &nbsp; &nbsp;
<label for="zip"><strong>Zip:</strong> <input name="zip" id="zip" size="12" maxlength="12" type="text" onKeyDown="textCounter(this,5)" onKeyUp="textCounter(this,5)" /></label>&nbsp;
<label for="phone">Phone: <input name="phone" id="phone" size="13" maxlength="13" type="text" onKeyDown="textCounter(this,13)" onKeyUp="textCounter(this,13)" /></label>
</div><!-- end formRow -->
<!-- end line 3 -->

<div class="formRow">
<label for="pirateid"><strong>Pirate ID:</strong> <input name="pirateid" id="pirateid" size="12" maxlength="12" type="text" onKeyDown="textCounter(this,40)" onKeyUp="textCounter(this,40)" /></label>&nbsp; &nbsp; &nbsp;
<label for="email"><strong>Email:</strong> <input name="email" id="email" size="20" maxlength="40" type="text" onKeyDown="textCounter(this,40)" onKeyUp="textCounter(this,40)" /></label>&nbsp; &nbsp; &nbsp;
<label for="term"><strong>Term:</strong></label> <select name="term" id="term"> <option>Select Term</option><option>Fall</option><option>Spring</option><option>Summer I</option><option>Summer II</option>  </select>&nbsp; &nbsp; &nbsp;
<cfset thisYear=#Year(Now())#>
<label for="year"><strong>Year:</strong></label> <select name="year" id="year"> <option>Select Year</option><option><cfoutput>#thisYear#</cfoutput></option><option><cfoutput>#thisYear+1#</cfoutput></option></select>
</div><!-- end formRow -->
<!-- end line -->

<div class="formRow">
<label for="supervisor"><strong>Faculty Supervisor:</strong> 
  <select id="supervisor" name="supervisor">
    	<option>Select Faculty Supervisor</option>
		<cfoutput>#listSupervisors()#</cfoutput>
    </select></label>
</div><!-- end formRow -->
<!-- end line 4 -->

<div class="formRow">
<label for="prefix"><strong>Course Prefix:</strong> <input name="prefix" id="prefix" size="6" maxlength="6" type="text" onKeyDown="textCounter(this,5)" onKeyUp="textCounter(this,5)" /></label> &nbsp; &nbsp;
<label for="number"><strong>Course Number:</strong> <input name="number" id="number" size="6" maxlength="6" type="text" onKeyDown="textCounter(this,10)" onKeyUp="textCounter(this,10)" /></label> &nbsp; &nbsp;
<label for="title"><strong>Course Title:</strong> <input name="title" id="title" size="50" maxlength="100" type="text" onKeyDown="textCounter(this,100)" onKeyUp="textCounter(this,100)" /></label>
</div><!-- end formRow -->
<!-- end line 5 -->

<div class="formRow">
<label for="yes" class="myRB"><strong>Is this a writing intensive course?</strong> &nbsp; &nbsp; &nbsp; 
    <input name="writing" id="yes" type="radio" value="true"  /> Yes</label>
  &nbsp;&nbsp;<label for="no" class="myRB"><input name="writing" id="no" type="radio" value="false" /> No</label>
</div><!-- end formRow -->
<!-- end line 6 -->

<div class="formRow">
<strong>Is this a distance education course?</strong> &nbsp; &nbsp; &nbsp; 
    <label for="online" class="myRB"><input name="delivery" id="online" type="radio" value="true"  /> Yes</label>
  &nbsp;&nbsp;<label for="classroom" class="myRB"><input name="delivery" id="classroom" type="radio" value="false" /> No</label>
</div>
<!-- end line 6.5 -->

<div class="formRow">
<label for="goals"><strong>Goals of Independent Study:</strong><br />Provide a description of what is to be accomplished through the independent Study.</label>

  <textarea name="goals" cols="80" rows="4" id="goals" maxlength="1500" onKeyDown="textCounter(this,1500)" onKeyUp="textCounter(this,1500)"> </textarea>

</div><!-- end formRow -->
<!-- end line 7 -->

<div class="formRow">
<label for="outcomes"><strong>Learning Outcomes:</strong><br />Identify at least three outcomes that describe the knowledge you will learn or the skills you will develop by the conclusion of the independent study.<br /><br />
At the conclusion of the independent study the student will be able to:</label>

  <textarea name="outcomes" cols="80" rows="4" id="outcomes" maxlength="1500" onKeyDown="textCounter(this,1500)" onKeyUp="textCounter(this,1500)"> </textarea>

</div><!-- end formRow -->
<!-- end line 8 -->

<div class="formRow">
<label for="tasks"><strong>Tasks:</strong><br />Insert an itemized list of tasks you will undertake to accomplish the learning outcomes. Include the estimated total time it will take and the due date for each task. Typically, one item will be keeping a log of hours spent doing all aspects of the independent study. Tasks might include reading and research, interviews with professionals, writing a paper or final report about what was learned, etc.</label>

<textarea name="tasks" cols="80" rows="4" id="tasks" maxlength="1500" onKeyDown="textCounter(this,1500)" onKeyUp="textCounter(this,1500)"> </textarea>

</div><!-- end formRow -->
<!-- end line 9 -->

<div class="formRow">
<label for="evaluation"><strong>Evaluation:</strong><br />Insert an explanation of how the independent study will be evaluated and graded. Indicate the standards required to achieve a particular grade and identify the weightings for tasks or products. The student, the faculty member, or both may propose the grading and evaluation processes.</label><br>
 
  <textarea name="evaluation" cols="80" rows="4" id="evaluation" maxlength="1500" onKeyDown="textCounter(this,1500)" onKeyUp="textCounter(this,1500)"> </textarea>

</div><!-- end formRow -->
<!-- end line 10 -->

<!-- start faculty only area -->
<div id="facOnly">

<div class="facultyArea">
<label for="crn"><strong>CRN:</strong> <input name="crn" id="crn" size="6" maxlength="6" type="text"  /></label> &nbsp; &nbsp;
<label for="hours"><strong>*Semester Hours:</strong>
  <input name="hours" id="hours" size="2" maxlength="2" type="text"  /></label><br /><br />

  <div class="facultyArea" style="margin-bottom:5px;"><strong>*CREDIT HOUR DETERMINATION:</strong> Use the following information to identify the approximate number of hours required for each semester hour earned.<br />
1 cr = 60 hrs of work | 2 cr = 120 hrs of work | 3 cr = 180 hrs of work
</div> 

<div class="facultyArea">
	 <label for="dept"><strong>Department this course will be administered by: &nbsp;</strong></label>
    <select id="dept" name="dept">
    	<option></option>
       <option>HDFS</option>
			<option>HLTH</option>
			<option>IDMR</option>
       <option>KINE</option>
       <option>RCLS</option>
			<option>SOCW</option>
			<option>AROTC</option>
    </select>
    <br />

<div class="facultyArea">
	<label for="deanAppr">
		<input id="deanAppr" name="deanAppr" type="checkbox" value="true" disabled="true">
		Written approval of the dean is on file for this faculty member to teach this course if it exceeds three undergraduate independent study sections for the faculty member in a semester or summer session. <br>(Refer to: <a href="http://www.ecu.edu/ppr/02/07/06" target="_blank"> http://www.ecu.edu/ppr/02/07/06 )</a>
	</label>
</div><!-- end facultyArea -->

    <label for="asstMail"><strong>Department Chair must select person to complete processing:</strong></label>
    <select id="asstMail" name="asstMail">
    	<option>Select Processor</option>
		<cfoutput>#findProcessors()#</cfoutput>
    </select>
    <div id="processor">
	<label for="processDone"><strong>Processing has been completed. &nbsp;</strong><input name="processDone" id="processDone" type="checkbox" value="yes" /></label>
	<!--<span id="compBy">&nbsp;</span>-->
	</div>
    <div><label for="complete"><strong>Course has been completed. &nbsp;</strong><input name="complete" id="complete" type="checkbox" disabled="disabled" value="yes" /></label></div>
</div><!-- end facultyArea -->


</div><!-- end facultyArea -->

</div><!-- end #facOnly-->
<!-- end faculty only area -->

<input type="hidden" id="myApp" name="myApp" value="">

</form>
<div id="formBtns" class="centeredDiv">
	<p>&quot;Save Changes&quot; saves the application <strong>without</strong> notifications to student, faculty, chair, or staff.</p>
    <a id="saveBtn" class="btn" href="javascript:saveForm();">Save Changes</a>
    <a id="rejBtn" class="btn" href="javascript:openRej();">Reject Application</a>
    <a id="appBtn" class="btn" href="javascript:subToChair();">Approve Application</a>
    <div style="clear:both"></div>
</div>

