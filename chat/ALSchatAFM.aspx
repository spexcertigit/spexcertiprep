<!--#include file="incSystem.aspx" -->
<script runat="server">
dim afmneturl as string=""
sub page_load()
	afmneturl=appsettings.afmneturl & "afmsearch.aspx"
end sub
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="ALSStyles.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function openafm(){
	var afm=window.open("<%=appsettings.afmneturl%>afmmain.aspx","afm");
}

</script>

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="border-bottom:#f7f7f7 2 solid;background-color:#7e94ca;height:50;filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#f1f1f1, endColorstr=#d4d4d4);}">
<form name="form1" method="post" action="<%=afmneturl%>" target="afm" style="margin:0">
  <table width="96%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td class="GeneralText"><b><img src="images/icAFM.gif" width="16" height="16" hspace="4" align="absmiddle">Absolute 
        FAQ Manager : 
        <input name="question" id="question" type="text" class="SmallNotes" style="width:30%">
        <input name="search" type="submit" class="SmallNotes" value="Search">
        <input name="openfaq" type="button" class="SmallNotes" value="Open" onclick="javascript:openafm();">
        </b></td>
    </tr>
  </table>
</form>
</body>
</html>
