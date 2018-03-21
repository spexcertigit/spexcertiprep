using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class products_spexertificate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ((Inside)Master).AllowShareThisIcon=false;
        clsContent myContent = new clsContent(13);

        Page.Title = "SPEXertificate - Products" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
        ltrHeadline.Text = myContent.PageHeader;;
        ltrBody.Text = myContent.Contents;
        ltrSubHeader.Text = myContent.SubHeader;
    }
    protected void cmdSubmit_Click(object sender, EventArgs e) {
        clsUser myUser = new clsUser();
        if (!myUser.LoggedIn) {
            mvMessage.SetActiveView(vwAnon);
        } else {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
                string SQL = "SELECT FileName FROM certiCertifcates WHERE LotNumber = @LotNumber";

                using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@LotNumber", SqlDbType.VarChar, 25).Value = lot_number.Text.Trim();
                    cmd.Connection.Open();
                    SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                    if (dr.HasRows) {
                        dr.Read();
                        hlDownload.NavigateUrl = @"/certificates/" + dr["FileName"].ToString();
                        mvMessage.SetActiveView(vwResult);
                    } else {
                        mvMessage.SetActiveView(vwNotFound);
                    }
                    cmd.Connection.Close();
                }
            }
        }
    }
}