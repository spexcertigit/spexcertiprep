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

public partial class timeline : System.Web.UI.Page
{

	protected string TranslateCategory(string cat) {
		switch (cat) {
			case "1":
				return "CertiPrep General Updates"; 
			case "2":
				return "CertiPrep Newsletters"; 
			case "3":
				return"CertiPrep Press Releases"; 
			case "4":
				return"SamplePrep General Updates"; 
			case "5":
				return "SamplePrep Newsletters"; 
			default:
				return "SamplePrep Press Releases"; 
		}
	}
			
			
    protected void Page_Load(object sender, EventArgs e)
    {
		Page.Title = "SPEX CertiPrep Timeline " + ConfigurationSettings.AppSettings["gsDefaultPageTitle"];
	
	}

}