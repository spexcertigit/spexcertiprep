using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Security.Cryptography;

public partial class password_reset : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) {
		
    }
	
	protected void cmdUpdate_Click(object sender, EventArgs e) {
		
		string hashed = Page.RouteData.Values["fplink"].ToString();
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = 	"UPDATE [cp_roi_CONTACT_MASTER] " + 
							"	SET [Web_User_Password] = @pass, [Web_Pw_Sql] = @pass WHERE [fplink] = @fplink";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@fplink", SqlDbType.NVarChar, 32).Value = hashed;
				cmd.Parameters.Add("@pass", SqlDbType.NVarChar, 50).Value = txtCPass.Text;
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
                } catch (Exception ex) {
                    Response.Write(ex);
                }
                cmd.Connection.Close();
			}
		}
		
		Response.Write("<script>location.replace('" + HttpContext.Current.Request.Url.AbsolutePath + "?success=1')</script>");
	}
}