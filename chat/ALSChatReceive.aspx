<!--#include file="incSystem.aspx"-->
<script runat="server">
sub page_load()
	dim say as string=request("say") & ""
	dim cancmd as string=request("cancmd") & ""
	dim canmsg as string=""
	dim requestid as string=request("requestid")
	dim nick as string=getnick
	dim lastmsgdate as string=todaydatetime
	'dim kkitem as object
	'for each kkitem in request.form
	'
	'	response.write( kkitem & " : " & request.form(kkitem) & "<br>")
	'next
	'response.write(now & "-" & cancmd & "-")
	if cancmd<>"" then response.write("<scr" & "ipt language=JavaScript>parent.chat." & cancmd &";</scr" & "ipt>")
	call Rep_chatReceive(requestid,say,cancmd,canmsg,lastmsgdate)
end sub
</script>

