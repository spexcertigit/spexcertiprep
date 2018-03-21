using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;
using System.Net.Mail;
using System.Text.RegularExpressions;

public partial class search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) {

		List<String> catprods = new List<String>(); 
		string[] compare;
		string[] stringSeparators = new string[] {"::"};
		string output = "";
		string catH1 = "";
		string canNav = "";
		string cannUpdate = "", drContent = "", miwContent = "", esContent = "", miscContent = "",flyer = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT cfID, cfFamily FROM cp_roi_Families WHERE cfTypeID = 7";			
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
                    while(dr.Read()) {
						string catName = dr["cfFamily"].ToString().Trim().ToLower().Replace(" ", "-");
						Regex re = new Regex("[;\\\\/:*?\"<>|&']");
						catName = re.Replace(catName, "-");
						catName = catName.Replace("---","-");
						catprods.Add(dr["cfID"].ToString() + "::" + catName);
					}
                }
                cmd.Connection.Close();
            }
			foreach (string cateName in catprods) {
				compare = cateName.Split(stringSeparators, StringSplitOptions.RemoveEmptyEntries);
				canNav += "<li><a href='/products/cannabis/"+ compare[1] +"'>" + getCannabisCatName(compare[0]) + "</a></li>";
			}
			
			SQL = "SELECT title, media, link_url FROM certiCannabisUpdates WHERE active = 1 ORDER BY id DESC";			
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					while(dr.Read()) {			
						cannUpdate +=	"<li>" +
											dr["media"].ToString().Trim() + ": <a href='" + dr["link_url"].ToString().Trim() + "' target='_blank'>" +
												dr["title"].ToString().Trim() +
											"</a>" +
										"</li>";
					}
                }
                cmd.Connection.Close();
            }
			
			SQL = "SELECT method, description, slug FROM certiPesticidesMethods WHERE class = 'dr'";			
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					while(dr.Read()) {
						drContent += "<div class='method-section'><a href='/products/pesticides/" + dr["slug"].ToString().Trim() + "'><h2 class='method'>" + dr["method"].ToString().Trim() + "</h2></a><p>" + dr["description"]. ToString().Trim() + "</p></div>";
					}
                }
                cmd.Connection.Close();
            }
			
			SQL = "SELECT method, description, slug FROM certiPesticidesMethods WHERE class = 'miw'";			
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					while(dr.Read()) {
						miwContent += "<div class='method-section'><a href='/products/pesticides/" + dr["slug"].ToString().Trim() + "'><h2 class='method'>" + dr["method"].ToString().Trim() + "</h2></a><p>" + dr["description"]. ToString().Trim() + "</p></div>";
					}
                }
                cmd.Connection.Close();
            }
			
			SQL = "SELECT method, description, slug FROM certiPesticidesMethods WHERE class = 'es'";			
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					while(dr.Read()) {
						esContent += "<div class='method-section'><a href='/products/pesticides/" + dr["slug"].ToString().Trim() + "'><h2 class='method'>" + dr["method"].ToString().Trim() + "</h2></a><p>" + dr["description"]. ToString().Trim() + "</p></div>";
					}
                }
                cmd.Connection.Close();
            }
			
			SQL = "SELECT method, description, slug FROM certiPesticidesMethods WHERE class = 'misc'";			
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					while(dr.Read()) {
						miscContent += "<div class='method-section'><a href='/products/pesticides/" + dr["slug"].ToString().Trim() + "'><h2 class='method'>" + dr["method"].ToString().Trim() + "</h2></a><p>" + dr["description"]. ToString().Trim() + "</p></div>";
					}
                }
                cmd.Connection.Close();
            }
		}
		ltrDR.Text = drContent;
		ltrMIW.Text = miwContent;
		ltrES.Text = esContent;
		ltrMisc.Text = miscContent;
		ltrCannabisUpdate.Text = cannUpdate;
    }

	protected string getCannabisCatName(string famID) {
		string catName = "";
		using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["SPEXCertiPrep"].ConnectionString)) {
			string SQL = "SELECT cfID, cfFamily FROM cp_roi_Families WHERE cfID = " + famID;			
            using (SqlCommand cmd = new SqlCommand(SQL, cn)) {
                cmd.CommandType = CommandType.Text;
                cmd.Connection.Open();
                SqlDataReader dr = cmd.ExecuteReader();
				if (dr.HasRows) {
					dr.Read();
                    catName = dr["cfFamily"].ToString().Trim();
                }
                cmd.Connection.Close();
            }
			return catName;
		}
	}
  	
	protected void selectedChange(object sender, EventArgs e) {
		Response.Redirect("/products/pesticides/" + s_method.SelectedValue);
	}
}