using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Lucene.Net.Analysis;
using Lucene.Net.Analysis.Standard;
using Lucene.Net.Documents;
using Lucene.Net.QueryParsers;
using Lucene.Net.Search;
using Lucene.Net.Search.Highlight;
using Lucene.Net.Store;
using Lucene.Net.Util;
using Version = Lucene.Net.Util.Version;

public partial class search : System.Web.UI.Page
{
	protected DataTable Results = new DataTable();
	private string indexDirectory = "";
	protected LuceneSearcher srch;

	protected void Page_Load(object sender, EventArgs e) {
		if (!IsPostBack) {
			if (this.Query != null) {
				doSearch();
				DataBind();
			}
		}
		Page.Title = "Search " + Global.TitleSuffixSep + Global.TitleSuffix;
	}

	private void doSearch() {
		srch = new LuceneSearcher();
		srch.Search(this.Query);
		Results = srch.ResultsTable;
	}

	/// <summary>
	/// Page links. DataTable might be overhead but there used to be more fields in previous version so I'm keeping it for now.
	/// </summary>
	protected DataTable Paging {
		get {
			// pageNumber starts at 1
			int pageNumber = (srch.StartAt + srch.ResultsPerPage - 1) / srch.ResultsPerPage;

			DataTable dt = new DataTable();
			dt.Columns.Add("html", typeof(string));

			DataRow ar = dt.NewRow();
			ar["html"] = PagingItemHtml(srch.StartAt, pageNumber + 1, false);
			dt.Rows.Add(ar);

			int previousPagesCount = 4;
			for (int i = pageNumber - 1; i >= 0 && i >= pageNumber - previousPagesCount; i--) {
				int step = i - pageNumber;
				DataRow r = dt.NewRow();
				r["html"] = PagingItemHtml(srch.StartAt + (srch.ResultsPerPage * step), i + 1, true);

				dt.Rows.InsertAt(r, 0);
			}

			int nextPagesCount = 4;
			for (int i = pageNumber + 1; i <= srch.PageCount && i <= pageNumber + nextPagesCount; i++) {
				int step = i - pageNumber;
				DataRow r = dt.NewRow();
				r["html"] = PagingItemHtml(srch.StartAt + (srch.ResultsPerPage * step), i + 1, true);

				dt.Rows.Add(r);
			}
			return dt;
		}
	}

	/// <summary>
	/// Prepares HTML of a paging item (bold number for current page, links for others).
	/// </summary>
	/// <param name="start"></param>
	/// <param name="number"></param>
	/// <param name="active"></param>
	/// <returns></returns>
	private string PagingItemHtml(int start, int number, bool active) {

		if (active)
			return "<a href=\"Search.aspx?q=" + this.Query + "&start=" + start + "\">" + number + "</a>";
		else
			return "<b>" + number + "</b>";
	}

	/// <summary>
	/// Return search query or null if not provided.
	/// </summary>
	protected string Query {
		get {
			string query = this.Request.Params["q"];
			if (query == String.Empty)
				return null;
			return query;
		}
	}

	protected void ButtonSearch_Click(object sender, System.EventArgs e) {
		this.Response.Redirect("/search/?q=" + TextBoxQuery.Text.Trim());
	}
	
}