using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Collections.Generic;

public partial class news_add : System.Web.UI.Page
{
	public int currRegion = 1;

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/distributors/");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
		bool success = false;
		string SortOrder = "0";
		
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
			string SQL = "INSERT INTO [certiDistributor] ([Country], [Company], [Phone], [Fax], [Email], [Email2], [Site], [Address1], [Address2], [Address3], [Address4], [SortOrder], [Latitude], [Longitude],  [ZoomLevel]) VALUES (@Country, @Company, @Phone, @Fax, @Email, @Email2, @Site, @Address1, @Address2, @Address3, @Address4, @SortOrder, @Latitude, @Longitude, @ZoomLevel)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
				if (!string.IsNullOrWhiteSpace(txtOrder.Text)) {
					SortOrder = txtOrder.Text;
				}
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@Country", SqlDbType.NVarChar, 255).Value = txtCountry.Text;
				cmd.Parameters.Add("@Company", SqlDbType.NVarChar, 255).Value = txtCompany.Text;
				cmd.Parameters.Add("@Phone", SqlDbType.NVarChar, 255).Value = txtPhone.Text;
				cmd.Parameters.Add("@Fax", SqlDbType.NVarChar, 255).Value = txtFax.Text;
				cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 255).Value = txtEmail.Text;
				cmd.Parameters.Add("@Email2", SqlDbType.NVarChar, 255).Value = txtEmail2.Text;
				cmd.Parameters.Add("@Site", SqlDbType.NVarChar, 255).Value = txtSite.Text;
				cmd.Parameters.Add("@Address1", SqlDbType.NVarChar, 255).Value = txtAdd1.Text;
				cmd.Parameters.Add("@Address2", SqlDbType.NVarChar, 255).Value = txtAdd2.Text;
				cmd.Parameters.Add("@Address3", SqlDbType.NVarChar, 255).Value = txtAdd3.Text;
				cmd.Parameters.Add("@Address4", SqlDbType.NVarChar, 255).Value = txtAdd4.Text;
				cmd.Parameters.Add("@SortOrder", SqlDbType.Int).Value = SortOrder;
				cmd.Parameters.Add("@Latitude", SqlDbType.NVarChar, 100).Value = txtLat.Text;
				cmd.Parameters.Add("@Longitude", SqlDbType.NVarChar, 100).Value = txtLong.Text;
				cmd.Parameters.Add("@ZoomLevel", SqlDbType.NVarChar, 255).Value = txtZoom.Text;
                cmd.Connection.Open();
                try{
                    cmd.ExecuteNonQuery();
					success = true;
					Response.Write("<script>alert('New distributor has been added!');location.replace('/admin/distributors/?success=1');</script>");
                } catch (Exception ex) {
					Response.Write(ex.Message);
                    Response.Write("<script>alert('OPPS! Something went wrong when saving the item.');location.replace('/admin/distributors/add.aspx');</script>");
                }
                cmd.Connection.Close();
            }
        }
        
    }
	
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}