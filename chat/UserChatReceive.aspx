<!--#include file="incSystem.aspx" -->
<script runat="server">
sub page_load()
	call nocache()
	dim say as string=request("say") & ""
	dim requestid as string=getcookie("xlaALSrequest","requestid") & ""
	if say<>"" then
		say=replace(say,vbcrlf,"")
		call usr_chatreceive(say,requestid)
	end if
end sub
</script>




