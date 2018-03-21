using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Data;
using System.Text;
using System.Net.Mail;
using System.Text.RegularExpressions;

public partial class news_add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/categories/");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {		
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
			string SQL = "";
            if (ddlCategories.SelectedItem.Value == "2") {
				int cfID = 0;
				SQL = "SELECT TOP 1 cfID FROM cp_roi_Families ORDER BY cfID DESC";
				using (SqlCommand cmd = new SqlCommand(SQL, cn))
				{
					cmd.CommandType = CommandType.Text;
					cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					if (dr.HasRows) {
						dr.Read();
						cfID = Convert.ToInt32(dr["cfID"]) + 1;
					}
					cmd.Connection.Close();
				}
				
				SQL = "INSERT INTO [cp_roi_Families] ([T537_Exists], [cfID], [cfTypeID], [cfFamily], [cfOrd], [slug], [title], [description]) VALUES ('1', @cfID, '2', @title, @cfID, @slug, @title, @description)";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Parameters.Add("@cfID", SqlDbType.Int).Value = cfID;
					cmd.Parameters.Add("@slug", SqlDbType.NVarChar, 256).Value = txtSlug.Text;
					cmd.Parameters.Add("@title", SqlDbType.NVarChar, 100).Value = txtTitle.Text;
					cmd.Parameters.Add("@description", SqlDbType.Text).Value = txtBody.Text;
					cmd.Connection.Open();
					try {
						cmd.ExecuteNonQuery();
					} catch (Exception ex) {
						Response.Write(ex);
					}
					cmd.Connection.Close();
				}
			}else if (ddlCategories.SelectedItem.Value == "1") {
				int catID = 0;
				SQL = "SELECT TOP 1 CatID FROM cp_roi_AnTechs ORDER BY CatID DESC";
				using (SqlCommand cmd = new SqlCommand(SQL, cn))
				{
					cmd.CommandType = CommandType.Text;
					cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					if (dr.HasRows) {
						dr.Read();
						catID = Convert.ToInt32(dr["CatID"]) + 1;
					}
					cmd.Connection.Close();
				}
				
				SQL = "INSERT INTO [cp_roi_AnTechs] ([T535_Exists], [CatID], [CatName], [CatLong], [slug], [description]) VALUES ('1', @catID, @title, @title, @slug, @description)";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Parameters.Add("@catID", SqlDbType.Int).Value = catID;
					cmd.Parameters.Add("@title", SqlDbType.NVarChar, 100).Value = txtTitle.Text;
					cmd.Parameters.Add("@slug", SqlDbType.NVarChar, 256).Value = txtSlug.Text;
					cmd.Parameters.Add("@description", SqlDbType.Text).Value = txtBody.Text;
					cmd.Connection.Open();
					try {
						cmd.ExecuteNonQuery();
					} catch (Exception ex) {
						Response.Write(ex);
					}
					cmd.Connection.Close();
				}

			}
			
			Response.Write("<script>location.replace('/admin/categories/add.aspx?success=1');</script>");
        }
        
    }
	
	[WebMethod()]
	public static string checkSlug(string slug)
	{
		string output = slug;
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) AS cnt FROM cp_roi_Families WHERE slug = @slug", cn))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("slug", SqlDbType.NVarChar, 256).Value = slug;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					dr.Read();
					if (Convert.ToInt32(dr["cnt"]) > 0) {
						output += "-" + dr["cnt"].ToString();
					}
				}
				cmd.Connection.Close();
            }
			
			using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) AS cnt FROM cp_roi_AnTechs WHERE slug = @slug", cn))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("slug", SqlDbType.NVarChar, 256).Value = slug;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					dr.Read();
					if (Convert.ToInt32(dr["cnt"]) > 0) {
						output += "-" + dr["cnt"].ToString();
					}
				}
				cmd.Connection.Close();
            }
						
		}
		return output;
	}
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}