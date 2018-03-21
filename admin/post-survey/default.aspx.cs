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

			if (Session["fromDate"] != null && Session["toDate"] != null) {
				if (Session["fromDate"].ToString() != "" && Session["toDate"].ToString() != "") {
					fromDate.Text = Session["fromDate"].ToString();
					toDate.Text = Session["toDate"].ToString();
					TableContent.SelectCommand = "SELECT pos.OrderID, pos.customer_id, cm.First_Name, cm.Last_Name, cm.Email_Addr, wod.billing_address1, wod.billing_address2, wod.billing_city, wod.billing_area, wod.billing_postcode, wod.billing_country, cm.Cust_Nbr, pos.QuestionText, pos.QuestionAnswer, pos.QuestionComment, pos.DateCreated FROM certiPostOrderSurvey pos INNER JOIN cp_roi_CONTACT_MASTER cm ON pos.customer_id = cm.ID INNER JOIN WebOrderDetails wod ON wod.id = pos.OrderID WHERE (pos.DateCreated BETWEEN '" + fromDate.Text + "' AND '" + toDate.Text + "') ORDER BY pos.DateCreated DESC";
				}				
			}
			
			using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
				using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) AS cnt FROM certiPostOrderSurvey pos INNER JOIN cp_roi_CONTACT_MASTER cm ON pos.customer_id = cm.ID INNER JOIN WebOrderDetails wod ON wod.id = pos.OrderID", cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					if (dr.HasRows) {
						dr.Read();
						string all = dr["cnt"].ToString().Trim();
						ddlDisplay.Items.Insert(6, new ListItem("All", all));
					}
				}
			}
		}
		
        PostSurveyResultTable.DataSource = TableContent;
        PostSurveyResultTable.DataBind();
    }
	
	protected void ddlDisplay_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataPager1.PageSize = Convert.ToInt32(ddlDisplay.SelectedValue);
        PostSurveyResultTable.DataSource = TableContent;
        PostSurveyResultTable.DataBind();
    }
	
	
	protected void btnFilter_Click(object sender, EventArgs e) {
		if (fromDate.Text != "" && toDate.Text != "") {
			TableContent.SelectCommand = "SELECT pos.OrderID, pos.customer_id, cm.First_Name, cm.Last_Name, cm.Email_Addr, wod.billing_address1, wod.billing_address2, wod.billing_city, wod.billing_area, wod.billing_postcode, wod.billing_country, cm.Cust_Nbr, pos.QuestionText, pos.QuestionAnswer, pos.QuestionComment, pos.DateCreated FROM certiPostOrderSurvey pos INNER JOIN cp_roi_CONTACT_MASTER cm ON pos.customer_id = cm.ID INNER JOIN WebOrderDetails wod ON wod.id = pos.OrderID WHERE (pos.DateCreated BETWEEN '" + fromDate.Text + "' AND '" + toDate.Text + "') ORDER BY pos.DateCreated DESC";
			Session["fromDate"] = fromDate.Text;
			Session["toDate"] = toDate.Text;
			PostSurveyResultTable.DataSource = TableContent;
			PostSurveyResultTable.DataBind();
		}else {
			Session.Remove("fromDate");
			Session.Remove("toDate");
		}
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}