using System;
using System.Collections.Generic;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.SessionState;

/// <summary>
/// Summary description for clsUser
/// </summary>
public class clsUser
{
    private bool _LoggedIn = false;
    public bool LoggedIn {
        get {
            return _LoggedIn;
        }
    }

    private string _DisplayName = "";
    public string DisplayName {
        get {
            return _DisplayName;
        }
    }

    private string _ForROI_ID = "";
    public string ForROI_ID {
        get {
            return _ForROI_ID;
        }
    }
    private string _FirstName = "";
    public string FirstName {
        get {
            return _FirstName;
        }
    }
    private string _LastName = "";
    public string LastName {
        get {
            return _LastName;
        }
    }
    private string _Email = "";
    public string Email {
        get {
            return _Email;
        }
    }
    private int _UserID = 0;
    public int UserID {
        get {
            return _UserID;
        }
    }
    private string _CustomerNumber = "";
    public string CustomerNumber {
        get {
            return _CustomerNumber;
        }
    }
    private string _DiscountCode = "00";
    public string DiscountCode {
        get {
            return _DiscountCode;
        }
    }
    private double _DiscountAmount = 0;
    public double DiscountAmount {
        get {
            return _DiscountAmount;
        }
    }
    private string _PriceCode = "1";
    public string PriceCode {
        get {
            return _PriceCode;
        }
    }
    private string _Region = "";
    public string Region {
        get {
            return _Region;
        }
    }
    public string CurrencySymbol {
        get {
            if (_Region == "UK") {
                return "&pound;";
            } else {
                return "$";
            }
        }
    }

    public string WebUserID {
        get {
            string ret = "";

            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
                string SQL = "";
                if (_Region == "UK") {
                    SQL = "SELECT Web_User_ID FROM uk_roi_CONTACT_MASTER WHERE ID = @ID";
                } else {
                    SQL = "SELECT Web_User_ID FROM cp_roi_CONTACT_MASTER WHERE ID = @ID";
                }
                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@ID", SqlDbType.Char, 10).Value = _UserID.ToString();
                    cmd.Connection.Open();
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        ret = dr["Web_User_ID"].ToString();
                    }
                    cmd.Connection.Close();
                }
            }
            return ret;
        }
    }
    public string Password {
        get {
            string ret = "";

            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
                string SQL = "";
                if (_Region == "UK") {
                    SQL = "SELECT Web_PW_SQL FROM uk_roi_CONTACT_MASTER WHERE ID = @ID";
                } else {
                    SQL = "SELECT Web_PW_SQL FROM cp_roi_CONTACT_MASTER WHERE ID = @ID";
                }
                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@ID", SqlDbType.Char, 10).Value = _UserID.ToString();
                    cmd.Connection.Open();
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        ret = dr["Web_Pw_Sql"].ToString();
                    }
                    cmd.Connection.Close();
                }
            }
            return ret;
        }
    }


    public clsUser() {
        if (HttpContext.Current.Session != null && HttpContext.Current.Session["userid"] != null && HttpContext.Current.Session["userid"].ToString().Length > 0) {
            _LoggedIn = true;
            _DisplayName = _FirstName = HttpContext.Current.Session["username"].ToString();
            _LastName = HttpContext.Current.Session["LastName"].ToString();
            _Email = HttpContext.Current.Session["Email"].ToString();
            _UserID = Convert.ToInt32(HttpContext.Current.Session["userid"]);
            _CustomerNumber = HttpContext.Current.Session["Cust_Number"].ToString();
            _DiscountCode = HttpContext.Current.Session["DiscountCode"].ToString();
            _DiscountAmount = Convert.ToDouble(HttpContext.Current.Session["DiscountAmount"]);
            _PriceCode = HttpContext.Current.Session["PriceCode"].ToString();
            _Region = HttpContext.Current.Session["Region"].ToString();
        } else {
            _LoggedIn = false;
            _DisplayName = "";

            // generate random session ID for anonymous purchase
            //if (HttpContext.Current.Session != null && HttpContext.Current.Session["randomid"] != null) {
			if (HttpContext.Current.Request.Cookies["tempuser"] != null) {
                //_UserID = Convert.ToInt32(HttpContext.Current.Session["randomid"]);
				_UserID = Convert.ToInt32(HttpContext.Current.Request.Cookies["tempuser"]["randomid"]);
            } else {
                Random random = new Random();
                _UserID = GetRandomSessionId();
				HttpCookie certiCookie = new HttpCookie("tempuser");
				certiCookie.Values["randomid"] = UserID.ToString();
				certiCookie.Expires = DateTime.Now.AddYears(50);
				HttpContext.Current.Response.Cookies.Add(certiCookie);
                //HttpContext.Current.Session["randomid"] = UserID.ToString();
            }

            // Determine Region
            if (HttpContext.Current.Session["region"] == null || HttpContext.Current.Session["region"].ToString() == "") {
                //if session region doesn't exist
                //1st check for cookie
                if (HttpContext.Current.Request.Cookies["certiprep"] != null) {
                    //if a cookie exists, 
                    //set region var to cookie value				
                    _Region = HttpContext.Current.Server.HtmlEncode(HttpContext.Current.Request.Cookies["certiprep"]["saved_region"].ToString());
                } else if (HttpContext.Current.Request["region"] != null) {
                    // cookie doens't exist, now check for region param exists in query string, probably came from switchboard page and can't accept cookies, set session region with param from query string
                    _Region = HttpContext.Current.Request["region"].ToString(); //set region var to request param value
                } else {
                    //no session var exists, no cookie exists and no request param exists, not sure where they came from, default to all USA
                    _Region = "USA";
                }

                //set the session region to either saved_region from cookie or region from query string param or to default	
                HttpContext.Current.Session["region"] = _Region;
            } else {
                _Region = HttpContext.Current.Session["region"].ToString();
            }
        }
	}

    public bool DoLogin(string Username, string Password) {
        bool ret = false;
        bool isUKuser = false;

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            //Fix password deletion problem caused by ROI sync
			string SQL = "UPDATE cp_roi_CONTACT_MASTER" +
						"	SET Web_Pw_Sql = @Password," +
						"	Web_User_Password = @Password," +
						"	Web_User_ID = Email_Addr" +
						"	WHERE Email_Addr = @Email" +
						"	AND Web_Pw_Sql IS NULL" +
						"	AND Web_User_ID IS NULL";
			using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.Add("@Email", SqlDbType.VarChar, 60).Value = Username;
				cmd.Parameters.Add("@Password", SqlDbType.VarChar, 25).Value = Password;
				cmd.Connection.Open();
				cmd.ExecuteNonQuery();
				cmd.Connection.Close();
			}

			SQL = "SELECT * FROM cp_roi_CONTACT_MASTER WHERE Web_User_ID = @Username AND Web_Pw_Sql = @Password";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@Username", SqlDbType.VarChar, 60).Value = Username;
                cmd.Parameters.Add("@Password", SqlDbType.VarChar, 25).Value = Password;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (!dr.HasRows) {
                    // Not a US user - check UK
                    cmd.Connection.Close();
                    cmd.CommandText = "SELECT * FROM uk_roi_CONTACT_MASTER WHERE Web_User_ID = @Username AND Web_Pw_Sql = @Password";

                    cmd.Connection.Open();
                    dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    isUKuser = true;
                }

                if (dr.HasRows) {
                    // Is a user of some kind
                    dr.Read();
                    ret = true;
                    _UserID = Convert.ToInt32(dr["ID"]);
                    HttpContext.Current.Session["userid"] = _UserID.ToString();
                    _DisplayName = dr["First_Name"].ToString().Trim();
                    HttpContext.Current.Session["username"] = _DisplayName;
                    _LastName = dr["Last_Name"].ToString().Trim();
                    HttpContext.Current.Session["LastName"] = _LastName;
                    _Email = dr["Email_Addr"].ToString().Trim();
                    HttpContext.Current.Session["Email"] = _Email;
                    _CustomerNumber = dr["Cust_Nbr"].ToString().Trim();
                    HttpContext.Current.Session["cust_number"] = _CustomerNumber;
                    cmd.Connection.Close();
                } else {
                    //Is NOT a user
                    cmd.Connection.Close();
                    return false;
                }
            }
	        if (isUKuser) {
                SQL = "SELECT ISNULL(discount_code, '00') AS discount_code, ISNULL(sales_price_code, '1') AS sales_price_code, Country_Code ='UK' FROM uk_roi_CMBILL WHERE Bill_To_Customer = @Cust_Nbr";
	        } else {
                SQL = "SELECT ISNULL(discount_code, '00') AS discount_code, ISNULL(sales_price_code, '1') AS sales_price_code, ISNULL(Country_Code, 'USA') AS Country_Code FROM cp_roi_CMBILL WHERE Bill_To_Customer = @Cust_Nbr";
            }
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@Cust_Nbr", SqlDbType.Char, 6).Value = _CustomerNumber;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows) {
                    dr.Read();
                    _DiscountCode = dr["discount_code"].ToString().Trim();
                    HttpContext.Current.Session["DiscountCode"] = _DiscountCode;
                    _PriceCode = dr["sales_price_code"].ToString().Trim();
                    HttpContext.Current.Session["PriceCode"] = _PriceCode;
                    _Region = dr["Country_Code"].ToString().Trim();
                    HttpContext.Current.Session["Region"] = _Region;
                } else {
                    HttpContext.Current.Session["DiscountCode"] = _DiscountCode;
                    HttpContext.Current.Session["PriceCode"] = _PriceCode;
                    HttpContext.Current.Session["Region"] = _Region;
                }
                cmd.Connection.Close();
            }

            //Get the discount amount
		    // this is the discount assigned to the customer, not the item itself
            if (_DiscountCode.Length > 0) {
                if (_Region == "UK") {
                    SQL = "SELECT ISNULL(default_mult, 0) AS default_mult FROM uk_roi_TRADE_DISCOUNT WHERE Discount_Code = @DiscountCode";
                } else {
                    SQL = "SELECT ISNULL(default_mult, 0) AS default_mult FROM cp_roi_TRADE_DISCOUNT WHERE Discount_Code = @DiscountCode";
                }
                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@DiscountCode", SqlDbType.Char, 3).Value = _DiscountCode;
                    cmd.Connection.Open();
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        _DiscountAmount = Convert.ToDouble(dr["default_mult"]);
                        HttpContext.Current.Session["DiscountAmount"] = _DiscountAmount.ToString();
                    }
                    cmd.Connection.Close();
                }
            }

            // move any products in the shopping trolley assigned to this user's temp id to the new ID
            //if (HttpContext.Current.Session["randomid"] != null) {
			if (HttpContext.Current.Request.Cookies["tempuser"] != null) {
                //string TempID = HttpContext.Current.Session["randomid"].ToString();
				string TempID = HttpContext.Current.Request.Cookies["tempuser"]["randomid"].ToString();
                SQL = "UPDATE sprepPersistentCart SET userid = @CurrentUserID WHERE userid = @TempID";
                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@CurrentUserID", SqlDbType.Int).Value = _UserID;
                    cmd.Parameters.Add("@TempID", SqlDbType.Int).Value = TempID;
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();
                }
				HttpContext.Current.Request.Cookies["tempuser"].Expires = DateTime.Now.AddDays(-1);
                //HttpContext.Current.Session["randomid"] = null;
            }
        }
		
        return ret;
    }

    public void CreateAccount(string Last_Name, string First_Name, string Web_Pw_Sql, string Email_Addr, string Company, string ReferralSource, string Country, string PhoneNbr, string Add1, string Add2, string City, string State, string Zip) {

        string UserID = "";
        string Master_Table_Name = "cp_roi_CONTACT_MASTER";
        string CustomerNumber = "";
        if (Country == "UK") {
            Master_Table_Name = "uk_roi_CONTACT_MASTER";
            CustomerNumber = "666666";
        } else  if (Country == "USA") {
            CustomerNumber = "99999";
        }

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT id, ForROI_ID FROM " + Master_Table_Name + " WHERE Web_User_ID = @CustomerMail";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@CustomerMail", SqlDbType.VarChar, 60).Value = Email_Addr;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows) {
                    //Account already exists for this email
                    dr.Read();
                    UserID = dr["ID"].ToString();
					_ForROI_ID = dr["ForROI_ID"].ToString();

                    UpdateAccount(UserID, Last_Name, First_Name, Web_Pw_Sql, PhoneNbr, Master_Table_Name);
                    return;
                }
                cmd.Connection.Close();
            }
            // Create an account for this person
            // id in contact_master isn't auto-incrementing
            // so we have to generate a user number
            // last maximum id + 5 should do it
            UserID = (GetNewUserID(Master_Table_Name) + 5).ToString();

            SQL = "INSERT INTO " + Master_Table_Name + " " +
				"(ID, Last_Name, First_Name, Customer_Name, ReferralSource, " + 
					"Web_User_ID, Web_User_Password, Web_Pw_Sql, Cust_Nbr, " + 
					"Email_Addr, ForROI_ID, CreateDt, Phone_Nbr, Address1, Address2, City, State, Zip) " +
				"VALUES (@ID, @Last_Name, @First_Name, @Customer_Name, @ReferralSource," + 
					"@Web_User_ID, @Web_User_Password, @Web_Pw_Sql, @Cust_Nbr, " +
					"@Email_Addr, @ForROI_ID, getdate(), @Phone_Nbr, @Add1, @Add2, @City, @State, @Zip)";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@ID", SqlDbType.VarChar, 10).Value = UserID;
                cmd.Parameters.Add("@Last_Name", SqlDbType.VarChar, 15).Value = Last_Name;
                cmd.Parameters.Add("@First_Name", SqlDbType.VarChar, 15).Value = First_Name;
				cmd.Parameters.Add("@Customer_Name", SqlDbType.Char, 30).Value = Company;
				cmd.Parameters.Add("@ReferralSource", SqlDbType.VarChar, 50).Value = ReferralSource;
                cmd.Parameters.Add("@Web_User_ID", SqlDbType.VarChar, 50).Value = Email_Addr;
                cmd.Parameters.Add("@Web_User_Password", SqlDbType.VarChar, 20).Value = Web_Pw_Sql;
                cmd.Parameters.Add("@Web_Pw_Sql", SqlDbType.VarChar, 25).Value = Web_Pw_Sql;
                cmd.Parameters.Add("@Cust_Nbr", SqlDbType.VarChar, 6).Value = CustomerNumber;
                cmd.Parameters.Add("@Email_Addr", SqlDbType.VarChar, 60).Value = Email_Addr;
                cmd.Parameters.Add("@ForROI_ID", SqlDbType.VarChar, 50).Value = "W_" + UserID;
				cmd.Parameters.Add("@Phone_Nbr", SqlDbType.VarChar, 50).Value = PhoneNbr;
				cmd.Parameters.Add("@Add1", SqlDbType.Text).Value = Add1;
				cmd.Parameters.Add("@Add2", SqlDbType.Text).Value = Add2;
				cmd.Parameters.Add("@City", SqlDbType.NVarChar, 100).Value = City;
				cmd.Parameters.Add("@State", SqlDbType.NVarChar, 100).Value = State;
				cmd.Parameters.Add("@Zip", SqlDbType.NVarChar, 10).Value = Zip;
				
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();

				_ForROI_ID = "W_" + UserID; //RT: 2011_11_14 ForROI_ID was not showing up in emails. Hopefully this will fix it.
            }
        }

    }

    public void UpdateAccount(string ID, string Last_Name, string First_Name, string Web_Pw_Sql, string PhoneNbr, string Master_Table_Name) {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "UPDATE " + Master_Table_Name + " SET " +
                "Last_Name = @Last_Name, " +
                "First_Name = @First_Name, " +
                "Web_Pw_Sql = @Web_Pw_Sql, " +
				"Phone_Nbr = @Phone_Nbr " +
                "WHERE ID = @ID";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@ID", SqlDbType.VarChar, 10).Value = ID;
                cmd.Parameters.Add("@Last_Name", SqlDbType.VarChar, 15).Value = Last_Name;
                cmd.Parameters.Add("@First_Name", SqlDbType.VarChar, 15).Value = First_Name;
                cmd.Parameters.Add("@Web_Pw_Sql", SqlDbType.VarChar, 25).Value = Web_Pw_Sql;
				cmd.Parameters.Add("@Phone_Nbr", SqlDbType.VarChar, 50).Value = PhoneNbr;

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
        }
    }

    public void DoLogout() {
        HttpContext.Current.Session["username"] = null;
        HttpContext.Current.Session["LastName"] = null;
        HttpContext.Current.Session["Email"] = null;
        HttpContext.Current.Session["userid"] = null;
        HttpContext.Current.Session["Cust_Number"] = null;
        HttpContext.Current.Session["DiscountCode"] = null;
        HttpContext.Current.Session["DiscountAmount"] = null;
        HttpContext.Current.Session["PriceCode"] = null;
        HttpContext.Current.Session["Region"] = null;
        HttpContext.Current.Session["randomid"] = null;
    }

    private int GetNewUserID(string Master_Table_Name) {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT TOP 1 ID FROM " + Master_Table_Name + " ORDER BY CAST(ID AS Integer) DESC";
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                int UserID = Convert.ToInt32(cmd.ExecuteScalar());
                cmd.Connection.Close();
                return UserID;
            }
        }
    }
    private int GetRandomSessionId() {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            using (SqlCommand cmd = new SqlCommand("sp_CertiGetRandomSessionId", cn)) {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@RETURN", SqlDbType.Int);
                cmd.Parameters["@RETURN"].Direction = ParameterDirection.ReturnValue;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                int UserID = Convert.ToInt32(cmd.Parameters["@RETURN"].Value);
                cmd.Connection.Close();
                return UserID;
            }
        }
    }
}