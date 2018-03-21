using System;
using System.Collections.Generic;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.SessionState;

/// <summary>
/// Summary description for clsHelper
/// </summary>
public class clsHelper
{

    private string _PromoExpiration = "";

    public string PromoExpiration
    {
        get
        {
            return PromoExpiration;
        }
    }
    public string GetPromoExpiration(string PromoCode)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString))
        {
            string SQL = "SELECT TOP 1 Expiration FROM cp_roi_CrmProm WHERE Prom_Code = '" + PromoCode + "' ORDER BY Expiration DESC";
            using (SqlCommand cmd = new SqlCommand(SQL, cn))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                DateTime PromoExpiration = Convert.ToDateTime(cmd.ExecuteScalar());
                cmd.Connection.Close();

                return PromoExpiration.ToShortDateString();
            }
        }
    }


	public clsHelper()
	{
		//
		// TODO: Add constructor logic here
		//
	}




}