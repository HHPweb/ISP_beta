<cfajaximport>

<!---             Modal for comments                                --->
<div id="commDiv" title="Comments">
	<div id="posts"></div>
    <cfoutput>
        <form name="pullPosts" id="pullPosts" action="pullPosts.cfm" method="post">
        	<input type="hidden" name="myApp" value="#Form.myApp#" />
        </form>
    </cfoutput>
    
      <div id="myComment">
    <form name="myComm" id="myComm" action="mkComm.cfm" method="post">
        <label for="comment">Enter Comments</label><br />
        <textarea id="comment" name="comment" cols="80" rows="2"></textarea>
        <cfoutput>
        	<input type="hidden" name="app" id="app" value="#Form.myApp#" />
        </cfoutput>
        <hr />
        <div id="subFormBtn" class="linkText" style="padding: 10px;float:left;">
        	Post Comment 
       </div>
       <div id="cancelEvtBtn" class="linkText" style="padding:10px;float:right;">
       		Close
       </div>
    </form>
    </div><!--end myComment-->
</div><!--end commDiv-->

<!---                   Modal for rejecting apps              --->
<div id="rejDiv" title="Reject Application">
    
      <div id="myRejComment">
        <form name="myRejComm" id="myRejComm" action="rejComm.cfm" method="post">
            <label for="comment"><p>Please provide comments for this application rejection.</p></label>
            <textarea id="comment" name="comment" cols="50" rows="3"></textarea>
            <cfif Session.position IS "chair">
				<cfoutput>
                	<br /><label for="facOnly"><input type="checkbox" id="facOnly" name="facOnly" value="justFac" /> Check to notify faculty supervisor WITHOUT mailing student</label>
                </cfoutput>
            </cfif>
            <cfoutput>
                <input type="hidden" name="app" id="rejApp" value="#Form.myApp#" />
                <input type="hidden" name="rName" value="#Form.rName#" />
                <input type="hidden" name="rMail" value="#Form.rMail#" />
            </cfoutput>
            <hr />
            <div id="rejFormBtn" class="linkText" style="padding: 10px;float:left;">
                Reject Application 
           </div>
           <div id="cancelRejEvtBtn" class="linkText" style="padding:10px;float:right;">
                Close
           </div>
        </form>
    </div><!--end myComment-->
</div><!--end commDiv-->

<!---                   Modal for approving apps              --->
<div id="apvDiv" title="Approve Application">
	<div id="myApvComment">
    <!---*************faculty is approving*************************--->
    <cfif Session.position IS "faculty">
		<cfoutput>
                <form name="myApvComm" id="myApvComm" action="ApvComm.cfm" method="post">
                    <label for="stdComment"><p>Comments for the student.</p></label>
                    <textarea id="stdComment" name="stdComment" cols="50" rows="3"></textarea>
                    
                    <label for="chairComment"><p>Comments for the Chair.</p></label>
                    <textarea id="chairComment" name="chairComment" cols="50" rows="3"></textarea>
                    <cfoutput>
                		<br /><label for="chairOnly"><input type="checkbox" id="chairOnly" name="chairOnly" value="justChair" /> Check to notify Chair WITHOUT mailing student.</label>
                	
                        <input type="hidden" name="app" id="apvApp" value="#Form.myApp#" />
                        <input type="hidden" name="rName" value="#Form.rName#" />
                        <input type="hidden" name="rMail" value="#Form.rMail#" />
                        
                    </cfoutput>
                    <hr />
                    <div id="approveAppBtn" class="linkText" style="padding: 10px;float:left;">
                        Approve Application 
                   </div>
                   <div id="cancelApvEvtBtn" class="linkText" style="padding:10px;float:right;">
                        Close
                   </div>
                </form>
        </cfoutput>
    <cfelseif Session.position IS "chair">
    	<!---*************chair is approving*************************--->
		<cfoutput>
        	<p>Student, faculty and staff will be notified.</p>
            <form name="myApvComm" id="myApvComm" action="ApvComm.cfm" method="post">
                <label for="stdComment"><p>Comments for the student.</p></label>
                <textarea id="stdComment" name="stdComment" cols="50" rows="3"></textarea>
                
                <label for="facultyComment"><p>Comments for the faculty supervisor.</p></label>
                <textarea id="facultyComment" name="facultyComment" cols="50" rows="3"></textarea>
                
                <label for="staffComment"><p>Comments for the staff processor.</p></label>
                <textarea id="staffComment" name="staffComment" cols="50" rows="3"></textarea>
                
                <cfoutput>
                    <input type="hidden" name="app" id="apvAppCh" value="#Form.myApp#" />
                    <input type="hidden" name="rName" value="#Form.rName#" />
                    <input type="hidden" name="rMail" value="#Form.rMail#" />
                    <input type="hidden" name="sMail" id="sMail" value="" />
                </cfoutput>
                <hr />
                <div id="approveAppBtn" class="linkText" style="padding: 10px;float:left;">
                    Approve Application 
               </div>
               <div id="cancelApvEvtBtn" class="linkText" style="padding:10px;float:right;">
                    Close
               </div>
            </form>
        </cfoutput>
    <cfelseif Session.position IS "staff">
    	<cfoutput>
        
        </cfoutput>
    </cfif>
    </div><!--end myComment-->
</div><!--end commDiv-->
