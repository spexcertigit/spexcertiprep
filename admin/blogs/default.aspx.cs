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

public partial class blogs_items : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {		
       lvBlogsTable.DataSource = TableContent;
       lvBlogsTable.DataBind();
    }
	
	protected void ddlDisplay_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataPager1.PageSize = Convert.ToInt32(ddlDisplay.SelectedValue);
        lvBlogsTable.DataSource = TableContent;
        lvBlogsTable.DataBind();
    }
	
	[WebMethod()]
	public static string deleteItem(string blogsid)
	{
		string SQL = "";
		string SQL2 = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			
			SQL2 = "DELETE FROM [cms_BlogPost_Category_xref] WHERE PostID = @ID2";
			SQL = "DELETE FROM [cms_BlogPost] WHERE PostID = @ID";
			
            using (SqlCommand cmd2 = new SqlCommand(SQL2, cn)) {
                cmd2.CommandType = CommandType.Text;
				cmd2.Parameters.Add("ID2", SqlDbType.NVarChar).Value = blogsid;
                cmd2.Connection.Open();
                cmd2.ExecuteNonQuery();
                cmd2.Connection.Close();
            }
			
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("ID", SqlDbType.NVarChar).Value = blogsid;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
			
			/*SQL = "DELETE FROM [cms_BlogPost] WHERE id = " + blogsid;
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }*/
			
			/*SQL2 = "DELETE FROM [cms_BlogPost_Category_xref] WHERE id = " + blogsid;
            using (SqlCommand cmd2 = new SqlCommand(SQL, cn)) {
                cmd2.CommandType = CommandType.Text;
                cmd2.Connection.Open();
                cmd2.ExecuteNonQuery();
                cmd2.Connection.Close();
            }*/
			
		}
		return "<div class='alert alert-success alert-dismissable bg-success'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button>Blog item has been Deleted</div>";
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}