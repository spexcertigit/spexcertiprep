using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using Lucene.Net.Analysis;
using Lucene.Net.Analysis.Standard;
using Lucene.Net.Documents;
using Lucene.Net.Index;
using Lucene.Net.QueryParsers;
using Lucene.Net.Search;
using Lucene.Net.Search.Highlight;
using Lucene.Net.Store;
using Version = Lucene.Net.Util.Version;

/// <summary>
/// Summary description for LuceneSearcher
/// </summary>
public class LuceneSearcher
{
	#region Fields
	private string _indexDirectory = "";
	private string _spellDirectory = "";
	private string _baseURL = "";
	private DataTable _Results = new DataTable();
	private int _totalItems = 0;
	private int _startAt = 0; // First item on page (index format).
	private TimeSpan _duration;
	private int _resultsPerPage = 10;
	private int _fromItem = 0;
	private int _toItem = 0;
	private string _query = "";
	#endregion

	#region Constructor
	public LuceneSearcher()
	{
		_indexDirectory = HttpContext.Current.Server.MapPath("~/App_Data/index");
		_spellDirectory = HttpContext.Current.Server.MapPath("~/App_Data/spell");
		_baseURL = "http://spexcertiprep.com";

		// create the result DataTable
		_Results.Columns.Add("title", typeof(string));
		_Results.Columns.Add("sample", typeof(string));
		_Results.Columns.Add("path", typeof(string));
		_Results.Columns.Add("url", typeof(string));
		_Results.Columns.Add("score", typeof(int));

	}
	#endregion

	#region Public Methods
	public void Search(string Query) {
		_query = Query;

		DateTime start = DateTime.Now;

		var analyzer = new StandardAnalyzer(Version.LUCENE_30);

		IndexSearcher searcher = new IndexSearcher(FSDirectory.Open(_indexDirectory));

		//var input = "This is a test";

		var fieldName = "text";
		var minimumSimilarity = 0.5f;
		var prefixLength = 3;
		var query = new BooleanQuery();

		var segments = _query.Split(new[] { " " }, StringSplitOptions.RemoveEmptyEntries);
		foreach (var segment in segments) {
			var term = new Term(fieldName, segment);
			var fuzzyQuery = new FuzzyQuery(term, minimumSimilarity, prefixLength);
			query.Add(fuzzyQuery, Occur.SHOULD);
		}
	
		// parse the query, "text" is the default field to search
		//var parser = new QueryParser(Version.LUCENE_30, "text", analyzer);

		//Query query = parser.Parse(_query);

		// search
		TopDocs hits = searcher.Search(query, 200);

		_totalItems = hits.TotalHits;

		// create highlighter
		IFormatter formatter = new SimpleHTMLFormatter("<span style=\"font-weight:bold;\">", "</span>");
		SimpleFragmenter fragmenter = new SimpleFragmenter(80);
		QueryScorer scorer = new QueryScorer(query);
		Highlighter highlighter = new Highlighter(formatter, scorer);
		highlighter.TextFragmenter = fragmenter;

		// initialize startAt
		_startAt = InitStartAt();

		// how many items we should show - less than defined at the end of the results
		int resultsCount = Math.Min(_totalItems, _resultsPerPage + _startAt);


		for (int i = _startAt; i < resultsCount; i++) {
			// get the document from index
			Document doc = searcher.Doc(hits.ScoreDocs[i].Doc);

			TokenStream stream = analyzer.TokenStream("", new StringReader(doc.Get("text")));
			String sample = highlighter.GetBestFragments(stream, doc.Get("text"), 2, "...");

			String path = doc.Get("path");

			// create a new row with the result data
			DataRow row = _Results.NewRow();
			row["title"] = doc.Get("title");
			row["path"] = path;
			row["url"] = _baseURL + path;
			row["sample"] = sample;
			row["score"] = Convert.ToInt16(hits.ScoreDocs[i].Score * 100);

			_Results.Rows.Add(row);
		}
		searcher.Dispose();

		// result information
		_duration = DateTime.Now - start;
		_fromItem = _startAt + 1;
		_toItem = Math.Min(_startAt + this.ResultsPerPage, _totalItems);
	}
	#endregion

	#region Private Methods
	/// <summary>
	/// Initializes startAt value. Checks for bad values.
	/// </summary>
	/// <returns></returns>
	private int InitStartAt() {
		try {
			int sa = 0;
			if (HttpContext.Current.Request.Params["start"] != null) {
				Int32.TryParse(HttpContext.Current.Request.Params["start"].ToString(), out sa);
			}
			// too small starting item, return first page
			if (sa < 0) {
				return 0;
			}

			// too big starting item, return last page
			if (sa >= _totalItems - 1) {
				return this.LastPageStartsAt;
			}

			return sa;
		} catch {
			return 0;
		}
	}
	#endregion

	#region Public Properties

	/// <summary>
	/// How many pages are there in the results.
	/// </summary>
	public int PageCount {
		get {
			return (_totalItems - 1) / _resultsPerPage; // floor
		}
	}

	public DataTable ResultsTable {
		get { return _Results; }
	}
	public int ResultsPerPage {
		get { return _resultsPerPage; }
		set { _resultsPerPage = value; }
	}
	public string SimilarSuggestions {
		get {
			string ret = "";

			// create the spell checker
			var spell = new SpellChecker.Net.Search.Spell.SpellChecker(FSDirectory.Open(_spellDirectory));

			// get 2 similar words
			string[] similarWords = spell.SuggestSimilar(_query, 2);

			// show the similar words
			if (similarWords.Length > 0) {
				ret = "Did you mean ";
				for (int wordIndex = 0; wordIndex < similarWords.Length; wordIndex++) {
					ret += "<a href='?q=" + HttpContext.Current.Server.UrlEncode(similarWords[wordIndex]) + "'>" + similarWords[wordIndex] + "</a>";
					if (wordIndex + 2 < similarWords.Length) { ret += ", ";}
					if (wordIndex + 1 < similarWords.Length) { ret += " or ";}
				}
			}
			return ret;
		}
	}
	public int StartAt {
		get { return _startAt; }
	}

	/// <summary>
	/// Prepares the string with seach summary information.
	/// </summary>
	public string Summary {
		get {
			if (this.TotalItems > 0) {
				return "Results <b>" + _fromItem + " - " + _toItem + "</b> of <b>" + this.TotalItems + "</b> for <b>" + _query + "</b>. (" + _duration.TotalSeconds + " seconds)";
			} else {
				return "No results found";
			}
		}
	}

	public int TotalItems {
		get { return _totalItems; }
	}
	#endregion

	#region Private Properties

	/// <summary>
	/// First item of the last page
	/// </summary>
	private int LastPageStartsAt {
		get {
			return PageCount * _resultsPerPage;
		}
	}
	#endregion

}