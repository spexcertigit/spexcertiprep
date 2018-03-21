using System;
using System.Collections.Generic;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

/// <summary>
/// Summary description for clsContent
/// </summary>
public class clsContent
{
    private string _PageTitle = "";
    public string PageTitle {
        get {
            return _PageTitle;
        }
    }
    private string _PageHeader = "";
    public string PageHeader {
        get {
            if (_PageHeader.Length > 0) {
                return "<h1>" + _PageHeader + "</h1>";
            } else {
                return "";
            }
        }
    }
    private string _Contents = "";
    public string Contents {
        get {
            return _Contents;
        }
    }
    private string _SubHeader = "";
    public string SubHeader {
        get {
            if (_SubHeader.Length > 0) {
                return "<h2>" + _SubHeader + "</h2>";
            } else {
                return "";
            }
        }
    }

    public clsContent(int ID)
	{
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
            string SQL = "SELECT * FROM cp_PageContent WHERE id = @id";

            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = ID;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows) {
                    dr.Read();
                    _PageTitle = dr["pagetitle_short"].ToString().Trim();
                    _PageHeader = dr["pagetitle_text"].ToString().Trim();
                    _Contents = dr["content"].ToString().Trim();
                    _SubHeader = dr["subheading"].ToString().Trim();
                }
                cmd.Connection.Close();
            }
        }
	}
}