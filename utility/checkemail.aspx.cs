using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class equipment_and_accessories_checkpart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["query"] != null) {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
                string SQL = "SELECT COUNT(*) FROM sp_roi_CONTACT_MASTER WHERE Web_User_ID = @Query";
                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@Query", SqlDbType.VarChar, 60).Value = Request.QueryString["query"].ToString();
                    cmd.Connection.Open();
                    int recordCount = Convert.ToInt32(cmd.ExecuteScalar());
                    cmd.Connection.Close();
                    if (recordCount > 0) {
                        ltrResults.Text = "<span class='green'>This username is available</span>";
                    }
                }
            }
        }
    }
}