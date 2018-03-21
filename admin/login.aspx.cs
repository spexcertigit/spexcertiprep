using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        clsAdminUser myUser = new clsAdminUser();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        clsAdminUser myUser = new clsAdminUser();
        if (myUser.DoLogin(txtUser.Text.Trim(), txtPass.Text.Trim()))
        {
            if (myUser.CheckLog(myUser.UserID))
            {
                Response.Redirect("dashboard.aspx");
            }
            else
            {
                Response.Write("<script>alert('Your account is currently logged in!');</script>");
            }
        }
        else
        {
            Response.Write("<script>alert('An error has occured when logging in!');</script>");
        }
    }
}