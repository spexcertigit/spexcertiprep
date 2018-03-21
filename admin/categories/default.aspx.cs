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
using System.IO;
using System.Data;
using System.Text;
using System.Net.Mail;
using System.Text.RegularExpressions;

public partial class news_items : System.Web.UI.Page
{
	public int currRegion = 1;
	
    protected void Page_Load(object sender, EventArgs e)
    {
		if (!IsPostBack) {
			if (Session["currLang"] != null) {
				TableContent.SelectParameters["region"].DefaultValue = Session["currLang"].ToString();
				currRegion = Convert.ToInt32(Session["currLang"]);
			}
			inorgTech.Visible = true;
			orgTech.Visible = false;
		}

        lvNewsTable.DataSource = TableContent;
        lvNewsTable.DataBind();
    }
	
	protected void ddlDisplay_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataPager1.PageSize = Convert.ToInt32(ddlDisplay.SelectedValue);
        lvNewsTable.DataSource = TableContent;
        lvNewsTable.DataBind();
    }
	
	protected void ddlLang_SelectedIndexChanged(object sender, EventArgs e)
    {
		currRegion = Convert.ToInt32(ddlLang.SelectedValue);
		Session["currLang"] = currRegion;
    }
	
	protected void btnOrg_Click(object sender, EventArgs e)
    {
		orgTech.Visible = true;
		inorgTech.Visible = false;
	}
	
	protected void btnInOrg_Click(object sender, EventArgs e)
    {
		inorgTech.Visible = true;
		orgTech.Visible = false;
	}
	
	public static string mapMethod(string path) {
		var mappedPath = HttpContext.Current.Server.MapPath(path);
		return mappedPath;
	}
}