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

public partial class event_items : System.Web.UI.Page
{	
	public string com = "";
	 
    protected void Page_Load(object sender, EventArgs e)
    {		
	  lveventTable.DataSource = populate_events_list();
	  lveventTable.DataBind();
    }
	
	public DataTable populate_events_list(){
		using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)){
			string com = "SELECT * FROM cms_Event WHERE Site = 'cp' ORDER BY CreateDate DESC";
			SqlDataAdapter adpt = new SqlDataAdapter(com, con);
			DataTable dt = new DataTable();
			adpt.Fill(dt);
			return dt;
		}
	}
	
	protected void ddlDisplay_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataPager1.PageSize = Convert.ToInt32(ddlDisplay.SelectedValue);
        lveventTable.DataSource = populate_events_list();
        lveventTable.DataBind();
    }
	
	[WebMethod()]
	public static string deleteItem(string eventsid)
	{
		string SQL = "";
		string SQL2 = ""; 
		
		string imgname = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			
			SQL2 =  "SELECT * FROM cms_Event WHERE EventSerial = @ID2";
			using (SqlCommand cmd2 = new SqlCommand(SQL2, cn)) {
                cmd2.CommandType = CommandType.Text;
				cmd2.Parameters.Add("ID2", SqlDbType.Int).Value = eventsid;
                cmd2.Connection.Open();
                SqlDataReader dr = cmd2.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
						imgname = dr["ImageUrl"].ToString();
					} 
                cmd2.Connection.Close();
            }
						
			SQL = "DELETE FROM cms_Event WHERE EventSerial = @ID";
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("ID", SqlDbType.Int).Value = eventsid;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
						
			//delete image
			File.Delete(mapMethod("~/images/events/" + imgname));
			
				
		}
		return "true";
		
	}
	
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}