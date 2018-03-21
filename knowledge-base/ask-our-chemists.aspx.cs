using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;

public partial class knowledge_base_FAQs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


Response.Status = "301 Moved Permanently";
Response.AddHeader("Location","ask-a-chemist.aspx");


//        clsContent myContent = new clsContent(1);
//
//        Page.Title = "Ask A Chemist - Knowledge Base" + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
//        ltrHeadline.Text = myContent.PageHeader; ;
//        ltrContent.Text = myContent.Contents;
//        ltrSubHeader.Text = myContent.SubHeader;
//
//        StringBuilder sb = new StringBuilder();
//        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
//            string SQL = "SELECT * FROM AskAChemist ORDER BY responsedate desc";
//            string CurrentTechnique = "";
//
//            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
//                cmd.CommandType = CommandType.Text;
//                cmd.Connection.Open();
//                SqlDataReader dr = cmd.ExecuteReader();
//                while (dr.Read()) {
//                    sb.AppendLine("<dt><a class='question' href='#'>" + dr["question"].ToString().Trim() + "</a></dt> <dd class='answer'>" + dr["answer"].ToString().Trim() + "</dd>");
//                }
//                cmd.Connection.Close();
//            }
//        }
//        ltrBody.Text = sb.ToString();
    }
}