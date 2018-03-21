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

public partial class news_items : System.Web.UI.Page
{
	public int currRegion = 1;
	
    protected void Page_Load(object sender, EventArgs e)
    {
		if (!IsPostBack) {
			if (Session["currLang"] != null) {
				//TableContent.SelectParameters["region"].DefaultValue = Session["currLang"].ToString();
				currRegion = Convert.ToInt32(Session["currLang"]);
			}
		}
		
        lvNewsTable.DataSource = TableContent;
        lvNewsTable.DataBind();
    }
	
	protected void ddlDisplay_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataPager1.PageSize = Convert.ToInt32(ddlDisplay.SelectedValue);
        lvNewsTable.DataSource = TableContent;
        lvNewsTable.DataBind();
    }
	
	[WebMethod()]
	public static string deleteItem(int newsid)
	{
		string SQL = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {

			SQL = "DELETE FROM [certiDistributor] WHERE DistributorSerial = " + newsid;
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
			
		}
		return "<div class='alert alert-success alert-dismissable bg-success'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button>Distributor has been Deleted!</div>";
	}
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}