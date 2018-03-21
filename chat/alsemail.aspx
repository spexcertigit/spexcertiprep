<!--#include file="incSystem.aspx" -->
<script runat="server">
dim img as string=""
dim onlinestatus as boolean=false
dim theurl as string=""
dim u as string=""
dim d as string=""
dim randomid as integer 

sub page_load
	call nocache()
	'/// Who was requested
	d=request("d") & ""	'/// For Accesing Departments ///'
	u=request("u") & ""	'/// For Accesing to users directly ///'
	if d<>"" and u<>"" then d="" : u=""

	'/// user settings'
	dim ref as string=request.servervariables("http_referer")
	dim ip as string=request.ServerVariables("REMOTE_ADDR")
	dim bypass as string=request("bypass")
	dim paramstart as integer=instr(ref,"?")
		
	response.contenttype="text/html"
	
	'/// Get Full URL ?'
	if appsettings.getfullurl="" and paramstart>0 then ref=left(ref,paramstart-1)
	theurl=appsettings.applicationurl & "UserPreChat.aspx?ref=" & server.urlencode(ref) & "&d=" & d & "&u=" & u & "&bypass=" & bypass
	
end sub
</script>

<script language="JavaScript" type="text/JavaScript">
function xlaALSprecheck(){
	if ((document.body && typeof(document.body.innerHTML)) != 'undefined'){
		xlaALSrequest();
	} else {
		alert('Your browser does not support several features of this system.\nPlease upgrade to a newer version');
	}
}

function xlaALSrequest(){
	var w = 640, h = 480;
	if (document.all || document.layers) {
	   w = screen.availWidth;
	   h = screen.availHeight;
	}
	var leftPos = (w-<%=appsettings.userwidth%>)/2, topPos = (h-<%=appsettings.userheight%>)/2;
	xlaALSwindow=window.open("<%=theurl%>","ALSRoom","toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=1,width=<%=appsettings.userwidth%>,height=<%=appsettings.userheight%>,top=" + topPos + ",left=" + leftPos);
	xlaALSwindow.focus();
}

xlaALSprecheck();
self.location.href='<%=appsettings.siteurl%>';
</script>
