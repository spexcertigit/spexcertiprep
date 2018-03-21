<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Login | SPEX CertiPrep</title>
    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/styles.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="loginform">
				<img src="/images/certiprep_logo_new.png" alt="SPEX CertiPrep" />
                <asp:TextBox ID="txtUser" runat="server" placeholder="Username"></asp:TextBox>
                <asp:TextBox ID="txtPass" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
        
                <asp:Button ID="btnSubmit" runat="server" Text="Login" CssClass="button-primary show" OnClick="btnSubmit_Click" />
            </div>
        </div>
        <div id="footer">© 2015-2016 Sci5 Development Inc. Version 3.0</div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SPEXCertiPrep %>" SelectCommand="SELECT * FROM [admin_users]"></asp:SqlDataSource>
    </form>
</body>
</html>
