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
using System.Data;
using System.Text;

public partial class loyal_customer_reward: System.Web.UI.Page
{
    protected string sTitle = "";
	protected string sDesc = "";
    protected int ProductCount = 0;
    protected string Region = "US";
    protected string CurrencySymbol = "$";
    protected string CatCode = "1";
    protected clsUser myUser;
	protected string prodTitle = "";
	protected string strCatalog = "";
	
	protected bool LoggedIn = false;
	protected string cusID = "";
	protected string webCusID = "";
    protected string DisplayName = "";

    protected void Page_Load(object sender, EventArgs e)
    {
		myUser = new clsUser();
		
        if (!myUser.LoggedIn) {
            //If user is not logged in
			Response.Redirect("/");
        } else {
            LoggedIn = true;
            DisplayName = myUser.FirstName + " " + myUser.LastName;
			webCusID = myUser.UserID.ToString().Trim();
			cusID = myUser.CustomerNumber.Trim();
        }
		
        Region = myUser.Region;
        CurrencySymbol = myUser.CurrencySymbol;
        CatCode = myUser.DiscountCode;
		
		Page.Header.Title = "Loyal Customer Rewards | SPEX CertiPrep";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)){
				using (SqlCommand cmd = new SqlCommand("SELECT cm.Bill_To_Customer, cm.Customer_Name, dbo.certi_fnGetAvailableSPoints(@CustomerNumber) as 'AvailableSPoints' FROM cp_roi_CM cm WHERE cm.RecordId = @CustomerNumber", cn)){
						cmd.CommandType = CommandType.Text;
						//cmd.Parameters.Add("CustomerNumber", SqlDbType.NVarChar).Value = "15589";
						cmd.Parameters.Add("CustomerNumber", SqlDbType.NVarChar).Value = cusID;
						
						cmd.Connection.Open();
						
						SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
						if (dr.HasRows) {
								dr.Read();
								bill.Text = dr["Bill_To_Customer"].ToString();
								name.Text = dr["Customer_Name"].ToString();
								spoint.Text = dr["AvailableSPoints"].ToString();
								
								
								cmd.Connection.Close();
						}
				}
		}
			
    }
	
    
	
   
	
	
}