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

public partial class post_survery : System.Web.UI.Page
{	
	public string com = "";
	 
    protected void Page_Load(object sender, EventArgs e)
    {		
      PostSurveyResultTable.DataSource = populate_administerwebinars_list();
	  PostSurveyResultTable.DataBind();
    }
	
	public DataTable populate_administerwebinars_list(){
		SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString);
        string com = "SELECT pos.OrderID, pos.customer_id, cm.First_Name, cm.Last_Name, cm.Email_Addr, wod.billing_address1, wod.billing_address2, wod.billing_city, wod.billing_area, wod.billing_postcode, wod.billing_country, cm.Cust_Nbr, pos.QuestionText, pos.QuestionAnswer, pos.QuestionComment, pos.DateCreated FROM certiPostOrderSurvey pos INNER JOIN cp_roi_CONTACT_MASTER cm ON pos.customer_id = cm.ID INNER JOIN WebOrderDetails wod ON wod.id = pos.OrderID ORDER BY pos.DateCreated DESC";
        SqlDataAdapter adpt = new SqlDataAdapter(com, con);
        DataTable dt = new DataTable();
        adpt.Fill(dt);
		return dt;
		
	}
	
	protected void ddlDisplay_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataPager1.PageSize = Convert.ToInt32(ddlDisplay.SelectedValue);
        PostSurveyResultTable.DataSource = populate_administerwebinars_list();
        PostSurveyResultTable.DataBind();
    }
	
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}