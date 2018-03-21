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

public partial class career_add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack){
		 //populate_category_list();  
	  }
	 
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/admin/pages/");
    }
	
	
    protected void btnSave_Click(object sender, EventArgs e)
    {
		string fileName = "";
		string prefix = DateTime.Now.ToString("MMdd-HHmmss-");
		bool active = false;
		
		if (ddlStatus.SelectedItem.Value == "1") {
			active = true;
		}
		
		if (FileUpload1.HasFile)
		{
			fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
			fileName = prefix + fileName;
			FileUpload1.PostedFile.SaveAs(Server.MapPath("~/images/page-banners/") + fileName);
		}
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
            string SQL = "INSERT INTO [cpPages] ([name], [slug], [location], [layout], [banner], [excerpt], [meta_title], [meta_keys], [meta_description], [page_order], [created_date], [active], [content1], [content2], [content3], [author], [banner_bgcolor]) VALUES (@name, @slug, @location, @layout, @banner, @excerpt, @meta_title, @meta_keys, @meta_description, @page_order, @created_date, @active, @content1, @content2, @content3, @author, @banner_bgcolor)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@name", SqlDbType.NVarChar, 200).Value = txtName.Text.Trim();
				cmd.Parameters.Add("@slug", SqlDbType.NVarChar, 256).Value = txtSlug.Text.Trim();
				cmd.Parameters.Add("@location", SqlDbType.NVarChar, 256).Value = ddlLocation.SelectedItem.Value;
				cmd.Parameters.Add("@layout", SqlDbType.NVarChar, 20).Value = ddlLayout.SelectedItem.Value;
                cmd.Parameters.Add("@banner", SqlDbType.NVarChar, 256).Value = fileName;
				cmd.Parameters.Add("@excerpt", SqlDbType.Text).Value = txtExcerpt.Text.Trim();
				cmd.Parameters.Add("@meta_title", SqlDbType.NVarChar, 256).Value = txtMetaTitle.Text.Trim();
				cmd.Parameters.Add("@meta_keys", SqlDbType.Text).Value = txtMetaKeys.Text.Trim();
				cmd.Parameters.Add("@meta_description", SqlDbType.Text).Value = txtMetaDesc.Text.Trim();
				cmd.Parameters.Add("@page_order", SqlDbType.Int).Value = txtOrder.Text.Trim();
				cmd.Parameters.Add("@created_date", SqlDbType.DateTime).Value = DateTime.Now;
				cmd.Parameters.Add("@active", SqlDbType.Bit).Value = active;
				cmd.Parameters.Add("@content1", SqlDbType.Text).Value = txtContent1.Text.Trim();
				cmd.Parameters.Add("@content2", SqlDbType.Text).Value = txtContent2.Text.Trim();
				cmd.Parameters.Add("@content3", SqlDbType.Text).Value = txtContent3.Text.Trim();
                cmd.Parameters.Add("@author", SqlDbType.NVarChar, 100).Value = Session["adminuname"].ToString();
				cmd.Parameters.Add("@banner_bgcolor", SqlDbType.NVarChar, 7).Value = txtBannerBgColor.Value;
				
                cmd.Connection.Open();
                try{
                    cmd.ExecuteNonQuery();
					Response.Write("<script>location.replace('/admin/pages/edit.aspx?created=1');</script>");
                } catch (Exception ex) {
                    Response.Write("<script>alert('OPPS! Something went wrong when saving the item." + ex.Message +"');location.replace('/admin/pages/add.aspx');</script>");
                }
                
            }
        }        
    }
	
	[WebMethod()]
	public static string checkSlug(string slug)
	{
		string output = slug;
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) AS cnt FROM cpPages WHERE slug = @slug", cn))
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