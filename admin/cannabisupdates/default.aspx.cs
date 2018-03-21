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

public partial class cannabis_updates : System.Web.UI.Page
{	
	public string com = "";
	 
    protected void Page_Load(object sender, EventArgs e)
    {		
	  lvcannabisupdatesTable.DataSource = populate_cannabisupdates_list();
	  lvcannabisupdatesTable.DataBind();
    }
	
	public DataTable populate_cannabisupdates_list(){
		SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString);
        string com = "SELECT * FROM certiCannabisUpdates";
        SqlDataAdapter adpt = new SqlDataAdapter(com, con);
        DataTable dt = new DataTable();
       	adpt.Fill(dt);
		return dt;
	
		
	}
	
	protected void ddlDisplay_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataPager1.PageSize = Convert.ToInt32(ddlDisplay.SelectedValue);
        lvcannabisupdatesTable.DataSource = populate_cannabisupdates_list();
        lvcannabisupdatesTable.DataBind();
    }
	
	[WebMethod()]
	public static string deleteItem(string cannabisupdatesid)
	{
		string SQL = "";
		
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			
			SQL = "DELETE FROM [certiCannabisUpdates] WHERE id = @ID";
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("ID", SqlDbType.NVarChar).Value = cannabisupdatesid;
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