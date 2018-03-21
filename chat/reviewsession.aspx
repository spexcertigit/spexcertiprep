<!-- #include file="incSystem.aspx" -->
<script runat="server">
dim transcript as string=""
sub page_load()
	dim requestid as string=request("requestid")
	if requestid="" or requestid="0" or not(isnumeric(requestid)) or getusrid="" or getusrid="0" then response.end 
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand
	dim dr as SqlDataReader
	mycommand.connection = conn
	mycommand.commandtext = "xlaALSsp_view_request"
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@requestid" , requestid)
	conn.open()
	dr = mycommand.ExecuteReader()
	if dr.read() then transcript=dr("transcript")
	dr.close()
	conn.close()
end sub
</script>
<link rel="stylesheet" href="styles.css" type="text/css">
<script language="JavaScript" type="text/JavaScript">
// Error Handling
window.onerror = donothing;
function donothing(){
	return true;
}

function displaymessage(tosay){
	document.write(tosay + '\n');
}

function cmdpush(thisfile,repname){
	document.write('<span class=reptext><b>' + repname +'&gt; PUSH : <\/b><a href=\'' + thisfile + '\' target=_blank>' + thisfile + '<\/a><\/span>\n');
}


function cmdimage(thisfile,repname){
	document.write('<br><img src=\'' + thisfile + '\'><br>\n');
}

function cmdurl(thislink,repname){
	document.write('<span class=reptext><b>' + repname + '&gt;&nbsp;<\/b><a href=\'' + thislink + '\' target=_blank>' + thislink + '<\/a><\/span>\n');
}

function cmdemail(thislink,repname){
	document.write('<span class=reptext><b>' + repname + '&gt;&nbsp;<\/b><a href=\'mailto:' + thislink + '\'>' + thislink + '<\/a><\/span>\n');
}

</script>
<body>
<%=transcript%>
</body>

