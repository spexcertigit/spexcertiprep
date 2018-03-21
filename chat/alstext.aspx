<!--#include file="incSystem.aspx" -->
<script runat="server">
dim applicationurl as string=appsettings.applicationurl
dim theurl as string=""
dim d as string=""
dim u as string=""

sub page_load
	call nocache()
	
	if lcase(request.servervariables("HTTPS")) = "on" then applicationurl = replace(applicationurl, "http:", "https:")

	'/// user settings'
	dim ref as string=request.servervariables("http_referer")
	dim ip as string=request.ServerVariables("REMOTE_ADDR")
	dim bypass as string=request("bypass")
	dim paramstart as integer=instr(ref,"?")
	d=request("d")
	u=request("u")
		
	'/// Get Full URL ?'
	if appsettings.getfullurl="" and paramstart>0 then ref=left(ref,paramstart-1)
	theurl=appsettings.applicationurl & "UserPreChat.aspx?ref=" & server.urlencode(ref) & "&d=" & d & "&u=" & u & "&bypass=" & bypass
	if request("debug")="" then response.ContentType="text/javascript"

end sub
</script>
// Absolute Live Support .NET
// Text Link
// Copyright(c) XIGLA SOFTWARE
// http://www.xigla.com 

function xlaALSprecheck(){
	if ((document.body && typeof(document.body.innerHTML)) != 'undefined'){
		return 1;
	} else {
		alert('Your browser does not support several features of this system.\nPlease upgrade to a newer version');
		return 0;
	}
}


function xlaALSrequest(){
	var thecheck=xlaALSprecheck();
	if (thecheck!=0){
		var w = 640, h = 480;
		if (document.all || document.layers) {
		   w = screen.availWidth;
		   h = screen.availHeight;
		}
		var leftPos = (w-<%=appsettings.userwidth%>)/2, topPos = (h-<%=appsettings.userheight%>)/2;
		xlaALSwindow=window.open("<%=theurl%>","ALSRoom","toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=1,width=<%=appsettings.userwidth%>,height=<%=appsettings.userheight%>,top=" + topPos + ",left=" + leftPos);
		xlaALSwindow.focus();
	}
}







