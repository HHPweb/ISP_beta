* Working on a redesign of the independent study form.

- Outward facing pages
	-index.cfm
	-proposals.cfm
	-proposal.cfm

- Backend
	-submitApp.cfm
		handles db insert for newly submitted applications addUser() and updates to existing applications
		updateUser(). Also generates email to supervisor. Try catch that sends an error report to me
		on failed db write attempts.
