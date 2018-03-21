<!--#include file="incSystem.aspx" -->
<script runat="server">

sub page_load()
	dim requestid as string=getcookie("xlaALSrequest","requestid")
	dim rating as string="0"
	dim comments as string=""
	dim survey as string=""
	
	'/// Get Rating ///'
	if appsettings.allowrating<>"" then
		rating=request("_rating")
		if rating<>"" and isnumeric(rating) then
			if val(rating)>5 or val(rating)<0 then rating=0
		else
			rating="0"
		end if
	end if
	
	'/// Get Comments ///'
	if appsettings.allowcomments<>"" then comments=left(request("_comments"),999)
	
	'//// Get any other form field submitted ///'
	dim ix as integer=0
	dim formfield as string=""
	dim fieldvalue as string=""
	For ix = 0 to Request.Form.Count-1
    	formfield = Request.Form.Keys(ix)
    	fieldvalue = Request.Form.Item(ix)
		if formfield<>"_rating" and formfield<>"_comments" and formfield<>"_button" then
			survey & =  "<b>" & formfield & " :</b> " & replace(server.htmlencode(fieldvalue),vbcrlf,"<br>") & vbcrlf
		end if
	next
	
	'/// Save Results ///'
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand
	mycommand.connection = conn
	mycommand.commandtext = "xlaALSsp_comment_session"
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@requestid" ,requestid)
	mycommand.Parameters.Add( "@rating" ,rating)
	mycommand.Parameters.Add( "@comments" ,comments)
	mycommand.Parameters.Add( "@survey" ,survey)
	conn.open()
	mycommand.executenonquery()
	response.write("<sc" & "ript language=JavaScript>top.close();</s" & "cript>")
end sub
</script>


