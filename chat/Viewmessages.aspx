<!--#include file="incSystem.aspx" -->
<script runat="server">
dim userid as string=""
dim msgid as string=""

Sub Page_Load()
	userid=getusrid
	if userid="0" or userid="" then response.Redirect("logout.aspx")
	if appsettings.messenger="" then response.End()

	msgid=request("msgid")
	if msgid="" or not(isnumeric(msgid)) then msgid="0"
end sub

sub button_click(s as object, e as eventargs)
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand("xlaALSsp_messenger_delete_all",conn)
	mycommand.commandType =  CommandType.Storedprocedure
	mycommand.Parameters.Add( "@userid" , userid )
	conn.open()
	mycommand.ExecuteScalar()
	conn.close()
end sub
</script>
<html>
<head>
<title>Messages Received</title>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=windows-1256">
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
</head>
<body onload="top.focus();">
<form runat="server">
  <table width="100%" border="0" cellspacing="1" cellpadding="1">
    <tr> 
      <td><span class="MainTitles">Messages Received</span><span class="PagerText"><br>
        </span></td>
      <td width="60" align="right" class="PagerText"> 
        <asp:linkbutton Text="Delete All" CssClass="PagerText" OnClick="button_click" runat="server" /></td>
    </tr>
    <%
	dim conn as New SqlConnection(connectionstr)
	dim mycommand as New SqlCommand
	mycommand.connection = conn
	mycommand.commandtext = "xlaALSsp_messenger_view"
	mycommand.CommandType = CommandType.StoredProcedure
	mycommand.Parameters.Add( "@userid", userid)
	mycommand.Parameters.Add( "@msgid", msgid)
	conn.open()
	dim dr as SqlDataReader=mycommand.ExecuteReader()
	do while dr.read()
%>
    <tr> 
      <td colspan="2" bgcolor="#999999" class="PagerText"></td>
    </tr>
    <tr align="left" valign="top"> 
      <td bgcolor="#FFFFCC" class="PagerText"><b><%=dr("msgdate")%></b><br> <%=dr("msgcontent")%><br> 
        <br></td>
      <td width="60" align="right" bgcolor="#FFFFCC" class="PagerText"><a href="Viewmessages.aspx?msgid=<%=dr("msgid")%>"><img src="images/btnSmallKill.gif" width="36" height="13" border="0"></a></td>
    </tr>
    <%loop
  dr.close()
  conn.close()%>

  </table>
</form>
</body>
</html>
