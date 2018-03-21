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

public partial class webinars_items : System.Web.UI.Page
{	
	public string com = "";
	 
    protected void Page_Load(object sender, EventArgs e)
    {		
      AdministerWebinarsTable.DataSource = populate_administerwebinars_list();
	  AdministerWebinarsTable.DataBind();
    }
	
	public DataTable populate_administerwebinars_list(){
		SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString);
        string com = "SELECT id, title, SUBSTRING(description,1, 50) description FROM cpWebinar ORDER BY created_date ASC";
        SqlDataAdapter adpt = new SqlDataAdapter(com, con);
        DataTable dt = new DataTable();
        adpt.Fill(dt);
		return dt;
		
	}
	
	protected void ddlDisplay_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataPager1.PageSize = Convert.ToInt32(ddlDisplay.SelectedValue);
        AdministerWebinarsTable.DataSource = populate_administerwebinars_list();
        AdministerWebinarsTable.DataBind();
    }
	
	[WebMethod()]
	public static string deleteItem(string passid)
	{
		string SQL = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			
			
			SQL = "DELETE FROM [cpWebinar] WHERE id = @ID";
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("ID", SqlDbType.NVarChar).Value = passid;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
				
		}
		return "true";
		
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}