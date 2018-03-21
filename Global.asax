<%@ Application Language="C#" %>

<script runat="server">

	void RegisterRoutes(System.Web.Routing.RouteCollection routes) {
		routes.MapPageRoute("", "", "~/default.aspx");
		routes.MapPageRoute(
			"contact-us",
			"contact",
			"~/contact.aspx"
		);
		routes.MapPageRoute(
			"category",
			"c/{id}/{detail}",
			"~/category.aspx"
		);
		routes.MapPageRoute(
			"product",
			"p/{id}/{detail}",
			"~/product.aspx"
		);
		
		routes.MapPageRoute(
			"SPEXSpeakerRoute",
			"knowledge-base/spex-speaker",
			"~/knowledge-base/SPEX-Speaker.aspx"
		);
		// jacob orig
		routes.MapPageRoute(
			"bufferRoutes",
			"buffers-and-conductivity",
			"~/buffers-and-conductivity.aspx"
		);

		
		routes.MapPageRoute(
			"sdsRoutes",
			"knowledge-base/SDS",
			"~/knowledge-base/MSDS.aspx"
		);
		routes.MapPageRoute(
			"webinarRoutes",
			"knowledge-base/webinars",
			"~/knowledge-base/webinars.aspx"
		);
		routes.MapPageRoute(
			"optimizeRoute",
			"knowledge-base/optimize",
			"~/knowledge-base/optimize.aspx"
		);
		routes.MapPageRoute(
			"carbonBlackRoute",
			"knowledge-base/carbon-black-reagents",
			"~/knowledge-base/carbon-black-reagents.aspx"
		);
		routes.MapPageRoute(
			"speciationRoute",
			"knowledge-base/speciation",
			"~/knowledge-base/speciation.aspx"
		);
		routes.MapPageRoute(
			"productGuideRoute",
			"knowledge-base/product-guides",
			"~/knowledge-base/product-guides.aspx"
		);
		routes.MapPageRoute(
			"periodicTableRoute",
			"knowledge-base/periodic-table",
			"~/knowledge-base/periodic-table.aspx"
		);
		routes.MapPageRoute(
			"KB1",
			"knowledge-base/{id}/{detail}",
			"~/content.aspx"
		);
		routes.MapPageRoute(
			"KB2",
			"knowledge-base/{id}",
			"~/content.aspx"
		);
		/*routes.MapPageRoute(
			"news",
			"news/{id}/{detail}",
			"~/news/article.aspx"
		);
		routes.MapPageRoute(
			"events",
			"events/{id}/{detail}",
			"~/events/event.aspx"
		);*/
		routes.MapPageRoute(
			"blog category",
			"blog/cat/{id}/{category}",
			"~/blog/default.aspx"
		);
		routes.MapPageRoute(
			"blog month",
			"blog/month/{month}",
			"~/blog/default.aspx"
		);
		routes.MapPageRoute(
			"blog author",
			"blog/author/{id}/{author}",
			"~/blog/default.aspx"
		);
		routes.MapPageRoute(
			"blog tag",
			"blog/tag/{id}/{tag}",
			"~/blog/default.aspx"
		);
		routes.MapPageRoute(
			"blog",
			"blog/{id}/{detail}",
			"~/blog/post.aspx"
		);
		routes.MapPageRoute(
			"cannabisRoute",
			"products/cannabis",
			"~/cannabis/default.aspx"
		);
		routes.MapPageRoute(
			"pesticideResidueStateRoute",
			"products/cannabis/presticide-residues/{state}",
			"~/cannabis/pesticide-residues.aspx"
		);
		routes.MapPageRoute(
			"cannabisCatRoute",
			"products/cannabis/{cat}",
			"~/cannabis/cannabis.aspx"
		);
		
		routes.MapPageRoute(
			"pesticideMixesRoute",
			"products/pesticides/pesticide-mixes",
			"~/products/pesticides/pesticide-mixes.aspx"
		);
		
		routes.MapPageRoute(
			"epaMethodRoute",
			"products/pesticides/epa-methods",
			"~/products/pesticides/epa-methods.aspx"
		);
		
		routes.MapPageRoute(
			"pesticideMethodRoute",
			"products/pesticides/{method}",
			"~/products/pesticides/pesticides.aspx"
		);
		
		routes.MapPageRoute(
			"singleWebinarRoute",
			"webinar/{webinar}",
			"~/knowledge-base/single.aspx"
		);
		
		routes.MapPageRoute(
			"spectroscopyRoute",
			"spectroscopy",
			"~/knowledge-base/spectroscopy.aspx"
		);
		
		routes.MapPageRoute(
			"testingKitsRoute",
			"testing-kits",
			"~/products/testing-kits.aspx"
		);
		
		routes.MapPageRoute(
			"lcgcRoute",
			"lcgc",
			"~/knowledge-base/lcgc.aspx"
		);
		
		routes.MapPageRoute("", "organic-standards/{cat}/{*family}", "~/search_organic_category.aspx");
		
		routes.MapPageRoute("", "inorganic-standards/{cat}", "~/search_inorganic_category.aspx");
		
		routes.MapPageRoute(
			"feedbackRoute",
			"feedback",
			"~/feedback.aspx"
		);
		
		routes.MapPageRoute(
			"pageContentRoute",
			"page/{page_id}",
			"~/preview.aspx"
		);
		
		routes.MapPageRoute(
			"spexperienceRoute",
			"SPEXperience",
			"~/spexperience.aspx"
		);
		
		routes.MapPageRoute("", "customer-center/my-orders/{order}", "~/customer-center/my-orders/default.aspx");
		
		routes.MapPageRoute("", "products/{slug}", "~/products/page-content.aspx");
		
		routes.MapPageRoute("", "purchase-options/{slug}", "~/purchase-options/page-content.aspx");
		
		routes.MapPageRoute("", "password-reset/{fplink}", "~/password-reset.aspx");
	}
	
	void Application_Start(object sender, EventArgs e) 
    {
		RegisterRoutes(System.Web.Routing.RouteTable.Routes);
	}
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        


	void Application_BeginRequest(object sender, EventArgs e) {
		
		if (HttpContext.Current.Request.Url.Host.ToString().ToLower().Contains("spexcertiprep.net")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/");
		}
		
		if (HttpContext.Current.Request.Url.Host.ToString().ToLower().Contains("http://www.spexcertiprep.com/hipure_inorganic")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/");
		}
		
		if (HttpContext.Current.Request.Url.Host.ToString().ToLower().Contains("prostds.com")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/products/organic/");
		}
		
		if (HttpContext.Current.Request.Url.Host.ToString().ToLower().Contains("spexertificate.com")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/products/SPEXertificate.aspx");
		}
		
		if (HttpContext.Current.Request.Url.Host.ToString().ToLower().Contains("specertificate.com")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/products/SPEXertificate.aspx");
		}
				
		if (HttpContext.Current.Request.Url.Host.ToString().ToLower().Contains("chemspex.com")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/");
		}
		
		if (HttpContext.Current.Request.Url.Host.ToString().ToLower().Contains("canncustoms.com")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/products/cannabis");
		}
		
		if (HttpContext.Current.Request.Url.Host.ToString().ToLower().Contains("cannstandard.com")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/products/cannabis");
		}
		
		if (HttpContext.Current.Request.Url.Host.ToString().ToLower().Contains("cannstandards.com")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/products/cannabis");
		}
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("http://www.spexcertiprep.com/default.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/");
		}
		if (HttpContext.Current.Request.Url.Host.ToString().Equals("certiprep.com")) {
			string absPath = HttpContext.Current.Request.Url.PathAndQuery;
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com" + absPath);
		}
		if (HttpContext.Current.Request.Url.Host.ToString().Equals("dev.certiprep.com")) {
			string absPath = HttpContext.Current.Request.Url.PathAndQuery;
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com" + absPath);
		}
		if (HttpContext.Current.Request.Url.Host.ToString().Equals("spexcertiprep.com"))
        {
            string absPath = HttpContext.Current.Request.Url.PathAndQuery;
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com" + absPath);
        }
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("spexcertiprepsolids.com")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "http://www.spexcertiprep.com/default.aspx");
		}
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("spexcertiprep.us")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "http://www.spexcertiprep.com/default.aspx");
		}
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/spexcrmfaq.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "http://www.spexcertiprep.com/default.aspx");
		}
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/spexcontactus.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "http://www.spexcertiprep.com/default.aspx");
		}
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/knowledge-base/msds-download.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "http://www.spexcertiprep.com/knowledge-base/msds.aspx");
		}
		
		//if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/assets")) {
		//	HttpContext.Current.Response.Status = "301 Moved Permanently";
		//	HttpContext.Current.Response.AddHeader("Location", "/");
		//}
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/knowledge-base/dilutilator.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/knowledge-base/dilutulator.aspx");
		}
		//if (HttpContext.Current.Request.Url.ToString().Contains("/knowledge-base/MSDS.aspx")) {
		//	HttpContext.Current.Response.Status = "301 Moved Permanently";
		//	HttpContext.Current.Response.AddHeader("Location", "/knowledge-base/SDS");
		//}
        if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/knowledge-base/webinars.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/knowledge-base/webinars");
		}
		if (HttpContext.Current.Request.Url.ToString().Contains("/ECS/optimize.aspx") || HttpContext.Current.Request.Url.ToString().ToLower().Contains("/knowledge-base/optimize.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/knowledge-base/optimize");
		}
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/knowledge-base/carbon-black-reagents.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/knowledge-base/carbon-black-reagents");
		}
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/knowledge-base/speciation.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/knowledge-base/speciation");
		}
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/knowledge-base/product-guides.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/knowledge-base/product-guides");
		}
		if (HttpContext.Current.Request.Url.ToString().Equals("http://www.spexcertiprep.com/knowledge-base/periodic-table.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/knowledge-base/periodic-table");
		}
        if (HttpContext.Current.Request.Url.Host.ToString().Equals("http://www.spexcertiprep.com/abo"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com");
        }
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/cannabis/quechers")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/quechers");
		}
		
		//****** CANNABIS NEW PAGE ROUTING ******//
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/cannabis/carbamates.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/cannabis/carbamates");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/cannabis/pesticide-residues.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/cannabis/pesticide-residues");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/cannabis/residual-solvents.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/cannabis/residual-solvents");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/cannabis/heavy-metals.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/cannabis/heavy-metals");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/cannabis/terpenes.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/cannabis/terpenes");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/cannabis/pyrethroids.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/cannabis/pyrethroids");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/cannabis/chlorinated-hydrocarbons.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/cannabis/chlorinated-hydrocarbons");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/cannabis/organophosphates.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/cannabis/organophosphates");
		}
		//****** CANNABIS NEW PAGE ROUTING ******//
		
		if (HttpContext.Current.Request.Url.Host.ToString().Equals("http://www.spexcertiprep.com/cannabis/"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/products/cannabis");
        }
		if (HttpContext.Current.Request.Url.Host.ToString().Equals("http://www.spexcertiprep.com/30mL/"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/30mL-plasma-shots/");
        }
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/assets"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/organic");
        }
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/spmain/sprep/handbook/tech2/Pulvtec9.htm"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/knowledge-base/catalog-request.aspx");
        }
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/uploads/spex"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com");
        }
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/uploads/uncertainty_webinarslides_2011-10-27_"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/uploads/Uncertainty_WebinarSlides_2011-10-27_Final.pdf");
        }
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/uploads/red_wine_"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/uploads/Red_Wine_Chem_NEMC.pdf");
        }
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/imazapyr"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com");
        }
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/Rejected-By-UrlScan?~/knowledge-base/msds.aspxhttp://spexcertiprep.com/products/SPEXertificate.aspx"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/products/SPEXertificate.aspx");
        }
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/uploads/bpaandphthalateslaboratorywater_"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/uploads/BPAandPhthalatesLaboratoryWater_ApplicationNote.pdf");
        }
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/msds/8270"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/knowledge-base/MSDS.aspx");
        }
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/msds/astm"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/knowledge-base/MSDS.aspx");
        }		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/uploads/uncertainty_"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/uploads/Uncertainty_WebinarSlides_2011-10-27_Final.pdf");
        }
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/uploads/metalsin"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/uploads/MetalsinLipstick_ApplicationNote.pdf");
        }
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/cannabis/chlorinated-hydrocardons"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/products/cannabis/chlorinated-hydrocarbons");
        }
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/search_inorganic_category.aspx%3Fcat%3DAA/ICP-AES%20Standards"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/search_inorganic_category.aspx");
        }


         if(HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/products/Wine-Standards/default.aspx")){
            HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "http://www.spexcertiprep.com/products/wine-standards/default.aspx");
        }

        
         if(HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/knowledge-base/ask-a-chemist")){
          HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "http://www.spexcertiprep.com/knowledge-base/ask-a-chemist.aspx");

         }

         if(HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/knowledge-base/catalogs/SPoints.pdf")){
            HttpContext.Current.Response.Status = "301 Moved Permanently";
			  HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com");
        }

         if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/crm-organic/method.aspx?id=37"))
         {
             HttpContext.Current.Response.Status = "301 Moved Permanently";
             HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/");
         }

         if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/crm-organic/method.aspx?id=54")) 
         {          
             HttpContext.Current.Response.Status = "301 Moved Permanently";
             HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/");
         } 


         if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/uploads/files/Pesticide_Infographic_Final.pdf"))
         {
             HttpContext.Current.Response.Status = "301 Moved Permanently";
             HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/");
         }
		 
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/search_inorganic_category.aspx?category=1&cat=1&p=100&page=0"))
         {
             HttpContext.Current.Response.Status = "301 Moved Permanently";
             HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/search_organic_category.aspx?cat=1");
         }
        
        if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("uploads/iso 9001 2008 ul 2012.pdf"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "http://www.spexcertiprep.com");
        }

        if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("uploads/files/pesticide_infographic_final.pdf"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "http://www.spexcertiprep.com");
        }

		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/search_organic_category.aspx")) {
			string cat = Request["cat"];
			int caseSwitch = Convert.ToInt32(cat);
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			switch (caseSwitch) {
				case 1:
					HttpContext.Current.Response.AddHeader("Location", "/organic-standards/gas-chromatography");
					break;
				case 2:
					HttpContext.Current.Response.AddHeader("Location", "/organic-standards/gas-chromatography-and-mass-spectrometry");
					break;
				case 3:
					HttpContext.Current.Response.AddHeader("Location", "/organic-standards/liquid-chromatography");
					break;
				case 4:
					HttpContext.Current.Response.AddHeader("Location", "/organic-standards/liquid-chromatography-and-mass-spectrometry");
					break;
				default:
					HttpContext.Current.Response.AddHeader("Location", "/products/organic/");
					break;
			}
		}
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/organic-standards/gas-chromatography"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/organic-standards/gas-chromatography-and-mass-spectrometry");
        }
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/organic-standards/liquid-chromatography"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/organic-standards/liquid-chromatography-and-mass-spectrometry");
        }
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/search_inorganic_category.aspx?")) {
			string cat = Request["cat"];
			int caseSwitch = Convert.ToInt32(cat);
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			switch (caseSwitch) {
				case 1:
					HttpContext.Current.Response.AddHeader("Location", "/inorganic-standards/aa-icp-standards");
					break;
				case 2:
					HttpContext.Current.Response.AddHeader("Location", "/inorganic-standards/clp-standards");
					break;
				case 3:
					HttpContext.Current.Response.AddHeader("Location", "/inorganic-standards/icp-ms-standards");
					break;
				case 4:
					HttpContext.Current.Response.AddHeader("Location", "/inorganic-standards/ic-ise-standards");
					break;
				case 5:
					HttpContext.Current.Response.AddHeader("Location", "/inorganic-standards/cyanide-standards");
					break;
				case 6:
					HttpContext.Current.Response.AddHeader("Location", "/inorganic-standards/organometallic-oil-standards");
					break;
				case 7:
					HttpContext.Current.Response.AddHeader("Location", "/inorganic-standards/fusion-fluxes");
					break;
				case 8:
					HttpContext.Current.Response.AddHeader("Location", "/inorganic-standards/miscellaneous-chemistries");
					break;
				default:
					HttpContext.Current.Response.AddHeader("Location", "/products/inorganic/");
					break;
			}
		}
		
		
        if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/aa-icp-inorganic")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "/inorganic-standards/aa-icp-standards");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/conductivity-std")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "/inorganic-standards/miscellaneous-chemistries");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/gc-ms-organic-std")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "/organic-standards/gas-chromatography-and-mass-spectrometry");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/gc-organic-std")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "/organic-standards/gas-chromatography");
		}
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().ToLower().Equals("http://www.spexcertiprep.com/icp-ms-standards")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "/inorganic-standards/icp-ms-standards");
		}
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/ICPMS-Standards")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "/inorganic-standards/icp-ms-standards");
		}
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/AAICP-Inorganic")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "/inorganic-standards/aa-icp-standards");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/lc-organic-std")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "/organic-standards/liquid-chromatography");
		}
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/GCMS-Organic")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "/organic-standards/gas-chromatography-and-mass-spectrometry");
		}
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().ToLower().Equals("http://www.spexcertiprep.com/organic-standards")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "/products/organic");
		}
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/Organic-CRM")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "/products/organic");
		}
		
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().ToLower().Equals("http://www.spexcertiprep.com/pcb-standards")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "/search.aspx?search=pcb");
		}
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().ToLower().Equals("http://www.spexcertiprep.com/quechers-products")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "/products/quechers");
		}
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().ToLower().Equals("http://www.spexcertiprep.com/usp-standards")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "/products/usp");
		}
		
        if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("sampleprep/article.aspx"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "http://www.spexcertiprep.com");
        }

        if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/hipure_inorganic/"))
         {
             HttpContext.Current.Response.Status = "301 Moved Permanently";
             HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com");
         }


        if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("crm-organic/"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "http://www.spexcertiprep.com");
        }

        if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("hipure_inorganic/"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.AddHeader("Location", "http://www.spexcertiprep.com");
        }

        if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Contains("search_inorganic_category.aspx%3fcat%3d3"))
        {
            HttpContext.Current.Response.Status = "301 Moved Permanently";
            HttpContext.Current.Response.RedirectPermanent("http://www.spexcertiprep.com/search_inorganic_category.aspx?cat=3");
        }
      
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/505")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-505");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/507")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-507");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/508")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-508");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/515")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-515");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/525")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-525");
		}
            
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/531")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-531");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/547")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-547");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/548")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-548");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/549")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-549");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/608")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-608");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/615")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-615");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/619")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-619");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/622")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-622");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/8081")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-8081");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/8082")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-8082");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/8141")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-8141");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/8151")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-8151");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/clp")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-clp");
		}
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/products/pesticides/tclp")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/pesticides/epa-method-tclp");
		}
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/feedback.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/feedback");
		}	
		
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/spexperience.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/SPEXperience");
		}	
		
		/*start jacob added*/
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("/inorganic-standards/miscellaneous-chemistries")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/inorganic/");
		}
		if (HttpContext.Current.Request.Url.ToString().ToLower().Contains("inorganic-standards/cyanide-standards")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/inorganic/");
		}
		/* no effect might as well comment since the routing of this page is found in line 22 , keyword:SPEXSpeakerRoute
		
		*/
		/*end jacob added*/
		
		
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().ToLower().Equals("http://www.spexcertiprep.com/pipette-washers")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/search_labstuff.aspx");
		}
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().ToLower().Equals("http://www.spexcertiprep.com/wine-standards")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/products/wine-standards/");
		}
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/knowledge-base/SPEX-Speaker") || HttpContext.Current.Request.Url.AbsoluteUri.ToString().Equals("http://www.spexcertiprep.com/knowledge-base/spexspeaker") || HttpContext.Current.Request.Url.ToString().Contains("/knowledge-base/SPEX-Speaker.aspx") || HttpContext.Current.Request.Url.ToString().ToLower().Contains("knowledge-base/spex-speaker.aspx")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/knowledge-base/spex-speaker");
		}
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().ToLower().Equals("http://www.spexcertiprep.com/customer-center")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/customer-center/current-orders/");
		}
		
		if (HttpContext.Current.Request.Url.AbsoluteUri.ToString().ToLower().Equals("https://www.spexcertiprep.com/knowledge-base/files/")) {
			HttpContext.Current.Response.Status = "301 Moved Permanently";
			HttpContext.Current.Response.AddHeader("Location", "/knowledge-base");
		}
		
	}

	void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }






    protected void Application_Error(Object sender, EventArgs e)
    {
        //Exception exception = Server.GetLastError();
        //if (exception is HttpUnhandledException)
        //{
        //    if (exception.InnerException == null)
        //    {
        //        Server.Transfer("error.aspx", false);
        //        return;
        //    }
        //    exception = exception.InnerException;
        //}

        //if (exception is HttpException)
        //{
        //    if (((HttpException)exception).GetHttpCode() == 404)
        //    {

        //        // Log if wished.
        //        Server.ClearError();
        //        Server.Transfer("error.aspx", false);
        //        return;
        //    }
        //}

        //if (Context != null && Context.IsCustomErrorEnabled)
        //    Server.Transfer("error.aspx", false);
        ////else
        ////Log.Error("Unhandled Exception trapped in Global.asax", exception);
    }

</script>
