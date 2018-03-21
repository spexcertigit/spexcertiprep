using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for clsUser
/// </summary>
public class clsAdminUser
{
    private bool _LoggedIn = false;
    public bool LoggedIn
    {
        get
        {
            return _LoggedIn;
        }
    }

    private string _UserName = "";
    public string UserName
    {
        get
        {
            return _UserName;
        }
    }
    private string _DisplayName = "";
    public string DisplayName
    {
        get
        {
            return _DisplayName;
        }
    }
    private int _UserID = 0;
    public int UserID
    {
        get
        {
            return _UserID;
        }
    }
    private int _Status = 0;
    public int Status
    {
        get
        {
            return _Status;
        }
    }
	public clsAdminUser()
	{
        if (HttpContext.Current.Session != null && HttpContext.Current.Session["adminuid"] != null && HttpContext.Current.Session["adminuid"].ToString().Length > 0)
        {
            _LoggedIn = true;
            _UserName = HttpContext.Current.Session["adminuname"].ToString();
        }
        else
        {
            _LoggedIn = false;
            _UserName = "";
        }
	}
    public bool DoLogin(string Username, string Password)
    {
        bool ret = false;
        string SQL = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
            SQL = "SELECT * FROM admin_users WHERE username = @username AND password = @password AND site = 'cp'";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@username", SqlDbType.NVarChar).Value = Username;
                cmd.Parameters.Add("@password", SqlDbType.NVarChar).Value = Password;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows)
                {
                    dr.Read();
                    _UserID = Convert.ToInt32(dr["id"]);
                    HttpContext.Current.Session["adminuid"] = _UserID.ToString();
                    _UserName = dr["username"].ToString();
                    HttpContext.Current.Session["adminuname"] = _UserName.ToString();
                    _Status = Convert.ToInt32(dr["status"]);
                    HttpContext.Current.Session["userstatus"] = _Status.ToString();
                    _DisplayName = dr["displayname"].ToString();
                    HttpContext.Current.Session["displayname"] = _DisplayName.ToString();
                    ret = true;
					updateLoggedin(Convert.ToInt32(_UserID), 1);
                }
                cmd.Connection.Close();
            }
			
        }
        return ret;
    }
    public void DoLogout()
    {
		updateLoggedin(Convert.ToInt32(HttpContext.Current.Session["adminuid"]), 0);
        HttpContext.Current.Session["adminuid"] = null;
        HttpContext.Current.Session["adminuname"] = null;
        HttpContext.Current.Session["userstatus"] = null;
        HttpContext.Current.Session["displayname"] = null;
    }
	
	public bool updateLoggedin(int userID, int status) {
		bool ret = false;
        string SQL = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
            SQL = "UPDATE [admin_users] SET [status] = @stat WHERE id = @id";;
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = userID;
				cmd.Parameters.Add("@stat", SqlDbType.Int).Value = status;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
            }
        }
        return ret;
	}
	
    public bool CheckLog(int userID) {
        bool ret = false;
        string SQL = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
            SQL = "SELECT * FROM admin_users WHERE id = @id AND loggedin = 0";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = userID;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows)
                {
                    ret = true;
                }
                cmd.Connection.Close();
            }
        }
        return ret;
    }
	
	public bool CheckPermission(int userID) {
        bool ret = false;
        string SQL = "";

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiprep"].ConnectionString))
        {
            SQL = "SELECT * FROM admin_users WHERE id = @id AND status = 0";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = userID;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows)
                {
                    ret = true;
                }
                cmd.Connection.Close();
            }
        }
        return ret;
    }
}