<!--#include file="incSystem.aspx" -->
<script runat="server">
dim img as string=""
dim onlinestatus as boolean=false
dim theurl as string=""
dim u as string=""
dim d as string=""
dim randomid as integer 
dim applicationurl as string=appsettings.applicationurl
sub page_load()
	'/// Do browser check ///'
	dim useragent as string=request.servervariables("http_user_agent")
	'if instr(1,useragent,"MAC",1)<>0 then
	'	response.write("//ALS is not supportted by this browser")
	'	response.end
	'	exit sub
	'end if

	if lcase(request.servervariables("HTTPS")) = "on" then applicationurl = replace(applicationurl, "http:", "https:")
	
	'/// Check On-line status'
	d=request("d") & ""	'/// For Accesing Departments ///'
	u=request("u") & ""	'/// For Accesing to users directly ///'
	if d<>"" and u<>"" then d="" : u=""
	onlinestatus=isonline(d,u)

	'/// Department Icon'
	if d<>"" then
		if onlinestatus then img="d" & d & "on.gif" else img="d" & d & "off.gif"
	end if
	
	'/// Users Icon'
	if u<>"" and d="" then
		if onlinestatus then img="u" & u & "on.gif" else img="u" & u &"off.gif"
	end if
	
	'/// Anyone On-line'
	if u="" and d="" then 
		if onlinestatus then img="chat_active.png" else img="chat_inactive.png"
	end if
	
	'/// Check For File'
	if img<>"chat_active.png" and img<>"chat_inactive.png" then
		if not(System.IO.File.Exists(server.mappath("files/" & img))) then
			if onlinestatus then img="chat_active.png" else img="chat_inactive.png"
		end if
	end if	
	if request("getstatus")<>"" then response.redirect("files/" & img)
	
	'/// user settings'
	dim ref as string=request.servervariables("http_referer")
	dim ip as string=request.ServerVariables("REMOTE_ADDR")
	dim bypass as string=request("bypass")
	dim paramstart as integer=instr(ref,"?")
	
	'/// Check for IP Block ///'
	if appsettings.blockips<>"" then 
		if isipblocked(ip) then 
			response.write("// Absolute Live Support .NET : IP " & ip & " is blocked")
			response.end()
			exit sub
		end if
	end if
		
	'/// Get Full URL ?'
	if appsettings.getfullurl="" and paramstart>0 then ref=left(ref,paramstart-1)
	
	dim objRandom as new system.random()
	randomid = objRandom.Next(99999)

	img="<a href='javascript:;' target=_self onclick='javascript:xlaALSprecheck_" & randomid & "()'><img src='" & applicationurl & "files/" & img & "' border=0 id='xlaALSstatusimg_" & randomid & "'></a>"
	img=replace(img,"/","\/")
	theurl=appsettings.applicationurl & "UserPreChat.aspx?ref=" & server.urlencode(ref) & "&d=" & d & "&u=" & u & "&bypass=" & bypass
end sub
</script>

// Absolute Live Support .NET
// Copyright(c) XIGLA SOFTWARE
// http://www.xigla.com 

function xlaALSprecheck_<%=randomid%>(){
	if ((document.body && typeof(document.body.innerHTML)) != 'undefined'){
		xlaALSrequest_<%=randomid%>();
	} else {
		alert('Your browser does not support several features of this system.\nPlease upgrade to a newer version');
	}
}
function xlaALSrequest_<%=randomid%>(){
	var w = 640, h = 480;
	if (document.all || document.layers) {
	   w = screen.availWidth;
	   h = screen.availHeight;
	}
	var leftPos = (w-<%=appsettings.userwidth%>)/2, topPos = (h-<%=appsettings.userheight%>)/2;
	xlaALSwindow=window.open("<%=theurl%>","ALSRoom","toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=1,width=<%=appsettings.userwidth%>,height=<%=appsettings.userheight%>,top=" + topPos + ",left=" + leftPos);
	xlaALSwindow.focus();
}

document.write("<%=img%>");

<%if appsettings.buttonstatuscheck<>"" then%>
function xlaALScheckstatus_<%=randomid%>(){
	var nt=String(Math.random()).substr(2,10);
	document.getElementById("xlaALSstatusimg_<%=randomid%>").src='<%=appsettings.applicationurl%>als.aspx?u=<%=u%>&d=<%=d%>&getstatus=1&nt=' + nt;
	setTimeout("xlaALScheckstatus_<%=randomid%>();", 20000);
}

xlaALScheckstatus_<%=randomid%>();
<%end if%>


