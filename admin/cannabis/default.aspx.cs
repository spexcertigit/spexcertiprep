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

public partial class cannabis_items : System.Web.UI.Page
{	
	public string com = "";
	 
    protected void Page_Load(object sender, EventArgs e)
    {		
	  lvcannabisTable.DataSource = populate_cannabis_list();
	  lvcannabisTable.DataBind();
    }
	
	public DataTable populate_cannabis_list(){
		using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)){
			string com = "SELECT a.cpfamID, a.banner, b.cfFamily FROM certiCannabis a INNER JOIN cp_roi_Families b ON a.cpfamID = b.cfID WHERE b.cfID != '1'";
			SqlDataAdapter adpt = new SqlDataAdapter(com, con);
			DataTable dt = new DataTable();
			adpt.Fill(dt);
			return dt;
		}
	}
	
	protected void ddlDisplay_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataPager1.PageSize = Convert.ToInt32(ddlDisplay.SelectedValue);
        lvcannabisTable.DataSource = populate_cannabis_list();
        lvcannabisTable.DataBind();
    }
	
	[WebMethod()]
	public static string deleteItem(string cannabisid)
	{
		string SQL = "";
		string SQL2 = "";
		string SQL3 = "";
		string imgname = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			
			SQL2 =  "SELECT * FROM certiCannabis a INNER JOIN cp_roi_Families b ON a.cpfamID = b.cfID WHERE a.cpfamID = @cpfamID";
			using (SqlCommand cmd2 = new SqlCommand(SQL2, cn)) {
                cmd2.CommandType = CommandType.Text;
				cmd2.Parameters.Add("cpfamID", SqlDbType.NVarChar).Value = cannabisid;
                cmd2.Connection.Open();
                SqlDataReader dr = cmd2.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
						imgname = dr["banner"].ToString();
                        cmd2.Connection.Close();
                    }
            }
						
			SQL = "DELETE FROM [certiCannabis] WHERE cpfamID = @ID";
			
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("ID", SqlDbType.NVarChar).Value = cannabisid;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
			
			SQL3 = "DELETE FROM [cp_roi_Families] WHERE cfID = @ID3";
			
            using (SqlCommand cmd3 = new SqlCommand(SQL3, cn)) {
                cmd3.CommandType = CommandType.Text;
				cmd3.Parameters.Add("ID3", SqlDbType.NVarChar).Value = cannabisid;
                cmd3.Connection.Open();
                cmd3.ExecuteNonQuery();
                cmd3.Connection.Close();
            }
			
			
			
			//delete image
			//File.Delete(mapMethod("~/cannabis/img/" + imgname));
		
			
			
				
		}
		return "true";
		
	}
	
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}