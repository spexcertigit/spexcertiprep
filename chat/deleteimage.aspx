<!-- #include file="incSystem.aspx" -->
<script runat="server">
sub page_load()
	dim lvl as integer=uservalidate(1)
	dim img as string=request("img")
	dim defaultimg as string=request("defaultimg")

	'/// Is a valid file to delete ? ///'
	if (img.startswith("files/") or img.startswith("representatives/")) and img.endswith(".gif") then 
		try
			System.IO.File.Delete(server.mappath(img))
			img=defaultimg
		catch
			'/// Nothing Happens ///'
		end try
	end if
	response.redirect(img)

end sub

</script>

