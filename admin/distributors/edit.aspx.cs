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

public partial class news_edit : System.Web.UI.Page
{
    public string iID = "";
	public int currRegion = 1;
	public string lang = "";
	public string langOption = "";
	
    protected void Page_Load(object sender, EventArgs e)
    {
		
        string SQL = "";
		
        if (Request.QueryString["id"] != null) {
			iID = Request.QueryString["id"];
		}else {
			Response.Redirect("/admin/distributors/");
		}
		
		currRegion = 1;
		
		
        if (!Page.IsPostBack) {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
				
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM certiDistributor WHERE DistributorSerial = @ID", cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("ID", SqlDbType.Int).Value = iID;

                    cmd.Connection.Open();
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        txtCountry.Text = dr["Country"].ToString();
						txtCompany.Text = dr["Company"].ToString();
						txtPhone.Text = dr["Phone"].ToString();
						txtFax.Text = dr["Fax"].ToString();
						txtPhone.Text = dr["Phone"].ToString();
                        txtEmail.Text = dr["Email"].ToString();
						txtEmail2.Text = dr["Email2"].ToString();
						txtSite.Text = dr["Site"].ToString();
						txtAdd1.Text = dr["Address1"].ToString();
						txtAdd2.Text = dr["Address2"].ToString();
						txtAdd3.Text = dr["Address3"].ToString();
						txtAdd4.Text = dr["Address4"].ToString();
						txtOrder.Text = dr["SortOrder"].ToString();
						txtLat.Text = dr["Latitude"].ToString();
						txtLong.Text = dr["Longitude"].ToString();
						txtZoom.Text = dr["ZoomLevel"].ToString();
                        cmd.Connection.Close();
                    }
                }
            }
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/distributors/");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
		string fileName = "";
		string prefix = DateTime.Now.ToString("MMdd-HHmmss-");
		string SQL = "";
		string SortOrder = "0";
		
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
			if (string.IsNullOrWhiteSpace(txtOrder.Text)) {
				SortOrder = txtOrder.Text;
			}
			SQL = "UPDATE certiDistributor SET " +
						"Country = @Country, " +
						"Company = @Company, " +
						"Phone = @Phone, " +
						"Fax = @Fax, " +
						"Email = @Email, " +
						"Email2 = @Email2, " +
						"Site = @Site, " + 
						"Address1 = @Address1, " +
						"Address2 = @Address2, " +
						"Address3 = @Address3, " +
						"Address4 = @Address4, " +
						"SortOrder = @SortOrder, " +
						"Latitude = @Latitude, " +
						"Longitude = @Longitude, " +
						"ZoomLevel = @ZoomLevel " +
					"WHERE DistributorSerial = @ID";
						
			using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@ID", SqlDbType.Int).Value = iID;
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
				cmd.Parameters.Add("@SortOrder", SqlDbType.NVarChar, 100).Value = txtOrder.Text;
				cmd.Parameters.Add("@Latitude", SqlDbType.NVarChar, 100).Value = txtLat.Text;
				cmd.Parameters.Add("@Longitude", SqlDbType.NVarChar, 100).Value = txtLong.Text;
				cmd.Parameters.Add("@ZoomLevel", SqlDbType.NVarChar, 100).Value = txtZoom.Text;
				


                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
                } catch (Exception ex) {
                    Response.Write(ex);
                }
                cmd.Connection.Close();
            }
        }
        Response.Write("<script>location.replace('/admin/distributors/edit.aspx?id=" + iID + "&success=1');</script>");
    }
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}