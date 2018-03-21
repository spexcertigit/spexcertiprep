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
using System.Net.Mail;
using System.IO;
using System.Text.RegularExpressions;

public partial class hipure_inorganic : System.Web.UI.Page
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
	public string webCusID = "";
    protected string DisplayName = "";

    protected void Page_Load(object sender, EventArgs e)
    {
		myUser = new clsUser();
		//Response.Write("currently loggedin:" + myUser.UserID.ToString());
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
		
		Page.Header.Title = "Account Settings | SPEX CertiPrep";
		
		if (!Page.IsPostBack){
			using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
				string SQL = 	"SELECT Last_Name, " +
									"	First_Name, " + 
									"	ISNULL(Cust_Nbr, '') AS spexAcc, " + 
									"	ISNULL(Customer_Name, '') AS Company, " + 
									"	Email_Addr, " +
									"	ISNULL(Phone_Nbr, '') AS Phone " +
									"FROM cp_roi_CONTACT_MASTER WHERE ID = @ID";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Parameters.Add("ID", SqlDbType.NVarChar, 50).Value = webCusID;
					cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					if (dr.HasRows) {
						dr.Read();
						txtFName.Text = dr["First_Name"].ToString().Trim();
						txtLName.Text = dr["Last_Name"].ToString().Trim();
						//txtCompany.Text = dr["Company"].ToString().Trim();
						//txtEmail.Text = dr["Email_Addr"].ToString().Trim();
						//txtPhone.Text = dr["Phone"].ToString().Trim();
						ltrAccNum.Text = dr["spexAcc"].ToString().Trim();
					}
					cmd.Connection.Close();
				}
				SQL = 	"SELECT Address_1, " +
							"	ISNULL(Address_2, '') AS Address2, " +
							"	Customer_Name, " +
							"	City, State, Zip, " +
							"	Country_Code " +
							"FROM cp_roi_CMSHIP WHERE Bill_To_Customer = @cusID";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Parameters.Add("cusID", SqlDbType.NVarChar, 50).Value = cusID;
					cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					if (dr.HasRows) {
						dr.Read();
						txtShipAdd1.Text = dr["Address_1"].ToString().Trim();
						txtShipAdd2.Text = dr["Address2"].ToString().Trim();
						txtShipCompany.Text = dr["Customer_Name"].ToString().Trim();
						txtShipCity.Text = dr["City"].ToString().Trim();
						txtShipState.Text = dr["State"].ToString().Trim();
						txtShipZip.Text = dr["Zip"].ToString().Trim();
						if (dr["Country_Code"].ToString().Trim() != "") {
							ddlShipCountry.SelectedValue = dr["Country_Code"].ToString().Trim();
						}
					}
					cmd.Connection.Close();
				}
				
				SQL = 	"SELECT Address_1, " +
							"	ISNULL(Address_2, '') AS Address2, " +
							"	Customer_Name, " +
							"	City, State, Zip, " +
							"	Country_Code " +
							"FROM cp_roi_CMBILL WHERE Bill_To_Customer = @cusID";
				using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
					cmd.CommandType = CommandType.Text;
					cmd.Parameters.Add("cusID", SqlDbType.NVarChar, 50).Value = cusID;
					cmd.Connection.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					if (dr.HasRows) {
						dr.Read();
						txtBillAdd1.Text = dr["Address_1"].ToString().Trim();
						txtBillAdd2.Text = dr["Address2"].ToString().Trim();
						txtBillCompany.Text = dr["Customer_Name"].ToString().Trim();
						txtBillCity.Text = dr["City"].ToString().Trim();
						txtBillState.Text = dr["State"].ToString().Trim();
						txtBillZip.Text = dr["Zip"].ToString().Trim();
						if (dr["Country_Code"].ToString().Trim() != "") {
							ddlBillCountry.SelectedValue = dr["Country_Code"].ToString().Trim();
						}
					}
					cmd.Connection.Close();
				}
			}
		}
    }
	
	public static string RemoveSpecialCharacters(string str) {
	   StringBuilder sb = new StringBuilder();
	   foreach (char c in str) {
		  if ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || c == '.' || c == '_') {
			 sb.Append(c);
		  }
	   }
	   return sb.ToString();
	}
	
		
	protected void cmdSubmit_Click(object sender, EventArgs e) {
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = 	"UPDATE [cp_roi_CONTACT_MASTER] " + 
							"	SET [Last_Name] = @lname, " +
							"		[First_Name] = @fname " +
							"	WHERE [ID] = @ID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@ID", SqlDbType.NVarChar, 10).Value = webCusID;
				cmd.Parameters.Add("@lname", SqlDbType.NVarChar, 50).Value = txtLName.Text;
				cmd.Parameters.Add("@fname", SqlDbType.NVarChar, 50).Value = txtFName.Text;
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
                } catch (Exception ex) {
                    Response.Write(ex);
                }
                cmd.Connection.Close();
			}
			string shipSQL = "";
			
			SQL = "SELECT Bill_To_Customer FROM cp_roi_CMSHIP WHERE Bill_To_Customer = @cusID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("cusID", SqlDbType.NVarChar, 6).Value = cusID;
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					shipSQL = "UPDATE cp_roi_CMSHIP SET Address_1 = @add1, Address_2 = @add2, Customer_Name = @company, City = @city, State = @state, Zip = @zip, Country_Code = @cc WHERE Bill_To_Customer = @ID";
				}else {
					shipSQL = "INSERT INTO cp_roi_CMSHIP (Bill_To_Customer, Address_1, Address_2, Customer_Name, City, State, Zip, RecordID, Country_Code) VALUES (@ID, @add1, @add2, @company, @city, @state, @zip, @ID, @cc)";
				}
				cmd.Connection.Close();
			}
			//Response.Write("<script>console.log('" + shipSQL + "')</script>");
			using (SqlCommand cmd = new SqlCommand(shipSQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@ID", SqlDbType.NVarChar, 6).Value = cusID;
				cmd.Parameters.Add("@add1", SqlDbType.NVarChar, 30).Value = txtShipAdd1.Text;
				cmd.Parameters.Add("@add2", SqlDbType.NVarChar, 30).Value = txtShipAdd2.Text;
				cmd.Parameters.Add("@company", SqlDbType.NVarChar, 30).Value = txtShipCompany.Text;
				cmd.Parameters.Add("@city", SqlDbType.NVarChar, 30).Value = txtShipCity.Text;
				cmd.Parameters.Add("@state", SqlDbType.NVarChar, 3).Value = txtShipState.Text;
				cmd.Parameters.Add("@zip", SqlDbType.NVarChar, 10).Value = txtShipZip.Text;
				cmd.Parameters.Add("@cc", SqlDbType.NVarChar, 3).Value = ddlShipCountry.SelectedItem.Value;
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
                } catch (Exception ex) {
                    Response.Write(ex);
                }
                cmd.Connection.Close();
			}
			
			string billSQL = "";
			
			SQL = "SELECT Bill_To_Customer FROM cp_roi_CMBILL WHERE Bill_To_Customer = @cusID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("cusID", SqlDbType.NVarChar, 6).Value = cusID;
				cmd.Connection.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					billSQL = "UPDATE cp_roi_CMBILL SET Address_1 = @add1, Address_2 = @add2, Customer_Name = @company, City = @city, State = @state, Zip = @zip, Country_Code = @cc WHERE Bill_To_Customer = @ID";
				}else {
					billSQL = "INSERT INTO cp_roi_CMBILL (Bill_To_Customer, Address_1, Address_2, Customer_Name, City, State, Zip, Country_Code) VALUES (@ID, @add1, @add2, @company, @city, @state, @zip, @cc)";
				}
				cmd.Connection.Close();
			}
			//Response.Write("<script>console.log('" + billSQL + "')</script>");
			using (SqlCommand cmd = new SqlCommand(billSQL, cn)) {
				cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@ID", SqlDbType.NVarChar, 6).Value = cusID;
				cmd.Parameters.Add("@add1", SqlDbType.NVarChar, 30).Value = txtBillAdd1.Text;
				cmd.Parameters.Add("@add2", SqlDbType.NVarChar, 30).Value = txtBillAdd2.Text;
				cmd.Parameters.Add("@company", SqlDbType.NVarChar, 30).Value = txtBillCompany.Text;
				cmd.Parameters.Add("@city", SqlDbType.NVarChar, 30).Value = txtBillCity.Text;
				cmd.Parameters.Add("@state", SqlDbType.NVarChar, 3).Value = txtBillState.Text;
				cmd.Parameters.Add("@zip", SqlDbType.NVarChar, 10).Value = txtBillZip.Text;
				cmd.Parameters.Add("@cc", SqlDbType.NVarChar, 3).Value = ddlBillCountry.SelectedItem.Value;
                cmd.Connection.Open();
                try {
                   cmd.ExecuteNonQuery();
                } catch (Exception ex) {
                    Response.Write(ex);
                }
                cmd.Connection.Close();
			}
		}
		
		Response.Write("<script>location.replace('/customer-center/settings/?success=1')</script>");
    }
	
	protected void cmdUpdate_Click(object sender, EventArgs e) {
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = 	"UPDATE [cp_roi_CONTACT_MASTER] " + 
							"	SET [Web_User_Password] = @pass, [Web_Pw_Sql] = @pass WHERE [ID] = @ID";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@ID", SqlDbType.NVarChar, 10).Value = webCusID;
				cmd.Parameters.Add("@pass", SqlDbType.NVarChar, 50).Value = txtCPass.Text;
                cmd.Connection.Open();
                try {
                    cmd.ExecuteNonQuery();
                } catch (Exception ex) {
                    Response.Write(ex);
                }
                cmd.Connection.Close();
			}
		}
		
		Response.Write("<script>location.replace('/customer-center/settings/?success=1')</script>");
	}
	
	[WebMethod()]
	public static bool checkPassword(string password, string webCusID) {
		bool output = false;
		string SQL = "";
		
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString)) {
			SQL = 	"SELECT Last_Name FROM cp_roi_CONTACT_MASTER WHERE Web_User_Password = @pass AND ID = @ID";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("ID", SqlDbType.NVarChar, 50).Value = webCusID;
				cmd.Parameters.Add("pass", SqlDbType.NVarChar, 20).Value = password;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows) {
					output = true;
                }
				cmd.Connection.Close();
            }
		}
		
		return output;
	}
	
} 