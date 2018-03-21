<!--#include file="incSystem.aspx" -->
<script runat="server">
dim userid as string=""
dim requestid as string=""
dim userimg as string=""
dim nick as string=""
dim publicinfo as string=""

sub page_load()
	requestid=getcookie("xlaALSrequest","requestid")
	if requestid="" then response.end()
	userid=request("userid")
	userimg="default.gif"
	if userid<>"" and isnumeric(userid) then 
		tblUserphoto.visible=true
		dim conn as New SqlConnection(connectionstr)
		dim mycommand as New SqlCommand
		mycommand.connection = conn
		dim dr as SqlDataReader
		mycommand.commandtext = "xlaALSsp_user_chat_get_photo"
		mycommand.CommandType = CommandType.StoredProcedure
		mycommand.Parameters.Add( "@userid" , userid )
		conn.open()
		dr = mycommand.ExecuteReader()
		if dr.read()
			nick=dr("nick") & ""
			publicinfo=dr("publicinfo") & ""
		end if
		dr.close()
		conn.close()		

		'/// Check if photo exists ///'
		userimg=userid & ".gif"
		if not(System.IO.File.Exists(server.mappath("representatives/" & userimg))) then userimg="default.gif"
	end if
end sub


</script>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Page-Enter" content="blendTrans(Duration=2.0)">
<link rel="stylesheet" href="styles.css" type="text/css">

<body bgcolor="#F5F5F5" leftmargin="0" topmargin="10" rightmargin="0">
<table width="120" border="0" align="center" cellpadding="6" cellspacing="0" class="BkgUserChatTop" id="tblUserphoto" runat="server">
  <tr> 
    <td align="center"><img src="representatives/<%=userimg%>" vspace="2"> <br>
        <span class="Text"> <b><%=nick%></b> </span></td>
    </tr>
    <tr>
    <td align="center"><span class="Text"><%=publicinfo%></span></td>
    </tr>
  </table>
</body>