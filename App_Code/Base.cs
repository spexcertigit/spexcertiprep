using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;

/// <summary>
/// Summary description for Base
/// </summary>
public class BasePage : Page
{
	private const string m_DefaultCulture = "en-US";
	protected override void InitializeCulture() {
		string culture = m_DefaultCulture;
		if (Request.Cookies["culture"] != null) {
			culture = Request.Cookies["culture"].Value;
		}

		Page.Culture = culture;
		Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
		Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);

		base.InitializeCulture();
	}	
}