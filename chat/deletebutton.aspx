<!-- #include file="incSystem.aspx" -->
<script runat="server">
sub page_load()
	dim lvl as integer=uservalidate(1)
	dim deptid as string=request("deptid")
	dim userid as string=request("userid")
	dim status as string=request("status")
	dim filename as string="files/d" & deptid & status & ".gif"
	dim newimage as string="files/" & status & "line.gif"
	if userid<>"" then filename="files/u" & userid & status & ".gif"
	
	try
		System.IO.File.Delete(server.mappath(filename))
	catch
		newimage=filename
	end try
	
	response.Redirect(newimage)
end sub

</script>

