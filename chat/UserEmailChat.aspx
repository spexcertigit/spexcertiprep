<!--#include file="incSystem.aspx" -->
<script runat="server">
sub page_load()
	dim email as string=request("email") & ""
	dim requestid as string = ""
	dim transcript as string=request("chattranscript")
	
	requestid=getcookie("xlaALSrequest","requestid") & ""
	if instr(email,"@")>1 and requestid<>"" and appsettings.allowemailchat<>"" then
		'/// Retrieve Log to send as email
		dim name as string=""
		dim topic as string=""
		dim requestdate as string=""
		
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand("xlaALSsp_email_chat",conn)
		mycommand.commandType =  CommandType.Storedprocedure
		mycommand.Parameters.Add( "@requestid" , requestid )
		conn.open()
		dim dr as SqlDataReader = mycommand.ExecuteReader()
		if dr.read() then
			name=dr("name")
			topic=dr("topic")
			requestdate=dr("requestdate")
		end if
		dr.close()
		conn.close()
		
		if requestdate<>"" then
			'//// E-Mail Request
			dim subject as string=appsettings.subject & " " & topic 
			dim message as string="<!-- Absolute Live Support : Chat Transcription begins  -->"
			message &= "<b>Topic : </b>" & topic & "<br><b>Customer :</b> " & name & "<br><b>E-Mail :</b> <a href=mailto:" & email & ">" & email & "</a><br><b>Date : </b>" & requestdate & "<br><hr>" & transcript & "<hr><br><b>" & appsettings.license & "<br><a href=" & appsettings.siteurl & ">" & appsettings.siteurl & "</a></b>"
			try
				call sendmail(email,"",subject,message)
			catch 
				'Nothing Happens
			end try
		end if
	end if
	response.write("<scr" & "ipt language=JavaScr" & "ipt>if(top.chat){top.chat.chatsent();}alert('A copy of the chat transcript has been sent by e-mail to : " & email & "');</s" & "cript>")
end sub

</script>

