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

public partial class plasmashots : System.Web.UI.Page
{
    public int page_id = 101;

	
    protected void Page_Load(object sender, EventArgs e)
    {
		image1Con.ImageUrl = getMetaValue(102, "image_url1");
		
		
		if(!Page.IsPostBack){
			header1.Text = getMetaValue(102, "header1");
			header2.Text = getMetaValue(102, "header2");
			image1.Text	= getMetaValue(102, "image_url1");
			long_content1.Text = getMetaValue(102, "long_content1");
		}
    }
	
	public string getMetaValue(int page_id, string meta_value)
	{
		string result = "error";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
		{
			using (SqlCommand cmd = new SqlCommand("SELECT pm.meta_value FROM cms_new_Page p INNER JOIN cms_new_Page_Meta pm on p.page_id = pm.page_id WHERE p.page_id = @page_id AND pm.meta_name = @meta_name", cn))
			{
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("page_id", SqlDbType.NVarChar).Value = page_id;
				cmd.Parameters.Add("meta_name", SqlDbType.NVarChar).Value = meta_value;
				cmd.Connection.Open();
				
				SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
				if (dr.HasRows)
				{
					dr.Read();
					result = dr["meta_value"].ToString();
					cmd.Connection.Close();
				}
			}
		}
		return result;	
	}
	

	
    protected void btnCancel_Click(object sender, EventArgs e)
    {
       // Response.Redirect("/admin/editpage/");
    }
    
	protected void btnSave_Click(object sender, EventArgs e)
    {
		
		/*save_db("header1", header1.Text);
		save_db("header2", header2.Text);
		save_db("image_url1", image1.Text);
		save_db("image_url2", image2.Text);
		save_db("paragraph1", paragraph1.Text);
		save_db("long_content1", long_content1.Text);
		save_db("long_content2", long_content2.Text);
		
		
		Response.Write("<script>location.replace('/admin/edit-custom-standards/?success=1');</script>");*/		
		
	}
	public void save_db(string meta_name, string meta_value)
    {
		string SQL = "";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
		
			SQL = " UPDATE [cms_new_Page_Meta] SET [meta_value] = @meta_value WHERE [page_id] = @page_id AND [meta_name] = @meta_name";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("meta_value", SqlDbType.Text, 2147483647).Value = meta_value;
				cmd.Parameters.Add("meta_name", SqlDbType.NVarChar, 255).Value = meta_name;
				cmd.Parameters.Add("page_id", SqlDbType.Int).Value = page_id;
            	
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
					
                } catch (Exception ex) {
					Response.Write("<script> alert('OPPS! Something went wrong when saving the item." + ex.Message +"');</script>");
					
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