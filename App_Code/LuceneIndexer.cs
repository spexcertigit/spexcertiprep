/*
 * Copyright 2012 dotlucene.net
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

using System.IO;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using Lucene.Net.Analysis.Standard;
using Lucene.Net.Documents;
using Lucene.Net.Index;
using Lucene.Net.Store;
using Lucene.Net.Util;
using SpellChecker.Net.Search.Spell;


namespace Indexer
{
	/// <summary>
	/// Summary description for Indexer.
	/// </summary>
	public class LuceneIndexer
	{
		private IndexWriter writer;
		private string docRootDirectory;
		private string pattern;

		/// <summary>
		/// Creates a new index in <c>directory</c>. Overwrites the existing index in that directory.
		/// </summary>
		/// <param name="directory">Path to index (will be created if not existing).</param>
		public LuceneIndexer(string directory)
		{
			try {
				writer = new IndexWriter(FSDirectory.Open(directory), new StandardAnalyzer(Version.LUCENE_30), true, IndexWriter.MaxFieldLength.UNLIMITED);
			} catch (LockObtainFailedException ex) {
				DirectoryInfo indexDirInfo = new DirectoryInfo(directory);
				FSDirectory indexFSDir = FSDirectory.Open(indexDirInfo, new Lucene.Net.Store.SimpleFSLockFactory(indexDirInfo));
				IndexWriter.Unlock(indexFSDir);
				writer = new IndexWriter(FSDirectory.Open(directory), new StandardAnalyzer(Version.LUCENE_30), true, IndexWriter.MaxFieldLength.UNLIMITED);
			} 
			
			writer.UseCompoundFile = true;
		}

		/// <summary>
		/// Add HTML files from <c>directory</c> and its subdirectories that match <c>pattern</c>.
		/// </summary>
		/// <param name="directory">Directory with the HTML files.</param>
		/// <param name="pattern">Search pattern, e.g. <c>"*.html"</c></param>
		public void AddDirectory(DirectoryInfo directory, string pattern)
		{
			this.docRootDirectory = directory.FullName;
			this.pattern = pattern;

			addSubDirectory(directory);
		}

		private void addSubDirectory(DirectoryInfo directory)
		{
			foreach (FileInfo fi in directory.GetFiles(pattern))
			{
				AddHtmlDocument(fi.FullName);
			}
			foreach (DirectoryInfo di in directory.GetDirectories())
			{
				addSubDirectory(di);
			}
		}

		/// <summary>
		/// Loads, parses and indexes an HTML file.
		/// </summary>
		/// <param name="path"></param>
		public void AddHtmlDocument(string path) {
			Document doc = new Document();

			string html;
			using (StreamReader sr = new StreamReader(path, System.Text.Encoding.Default)) {
				html = sr.ReadToEnd();
			}

			int relativePathStartsAt = this.docRootDirectory.EndsWith("\\") ? this.docRootDirectory.Length : this.docRootDirectory.Length + 1;
			string relativePath = path.Substring(relativePathStartsAt);

			doc.Add(new Field("text", ParseHtml(html), Field.Store.YES, Field.Index.ANALYZED));
			doc.Add(new Field("path", relativePath, Field.Store.YES, Field.Index.NOT_ANALYZED));
			doc.Add(new Field("title", GetTitle(html), Field.Store.YES, Field.Index.ANALYZED));

			writer.AddDocument(doc);
		}

		/// <summary>
		/// Loads, parses and indexes a web page.
		/// </summary>
		/// <param name="url"></param>
		public void AddWebPage(string url) {
			WebClient myWebClient = new WebClient();
			byte[] myDataBuffer = myWebClient.DownloadData(url);
			string html = Encoding.ASCII.GetString(myDataBuffer);

			Document doc = new Document();
			doc.Add(new Field("text", ParseHtml(html), Field.Store.YES, Field.Index.ANALYZED));
			doc.Add(new Field("path", url, Field.Store.YES, Field.Index.NOT_ANALYZED));
			doc.Add(new Field("title", GetTitle(html), Field.Store.YES, Field.Index.ANALYZED));

			writer.AddDocument(doc);
		}

		/// <summary>
		/// Loads, parses and indexes a web page.
		/// </summary>
		/// <param name="url"></param>
		public void AddWebPage(string url, string title, string contents, string area) {
			Document doc = new Document();
			doc.Add(new Field("text", ParseHtml(contents), Field.Store.YES, Field.Index.ANALYZED));
			doc.Add(new Field("path", url, Field.Store.YES, Field.Index.NOT_ANALYZED));
			doc.Add(new Field("title", title, Field.Store.YES, Field.Index.ANALYZED));
			doc.Add(new Field("area", area, Field.Store.YES, Field.Index.NOT_ANALYZED));

			writer.AddDocument(doc);
		}

		public void IndexWords(string indexPath, string spellPath) {
			// open the index reader
			IndexReader indexReader = IndexReader.Open(FSDirectory.Open(indexPath), true);

			// create the spell checker
			var spell = new SpellChecker.Net.Search.Spell.SpellChecker(FSDirectory.Open(spellPath));

			// add all the words in the field description to the spell checker
			spell.IndexDictionary(new LuceneDictionary(indexReader, "text"));
		}

		/// <summary>
		/// Very simple, inefficient, and memory consuming HTML parser. Take a look at Demo/HtmlParser in DotLucene package for a better HTML parser.
		/// </summary>
		/// <param name="html">HTML document</param>
		/// <returns>Plain text.</returns>
		private static string ParseHtml(string html)
		{
			string temp = Regex.Replace(html, "<[^>]*>", "");
			return temp.Replace("&nbsp;", " ");
		}

		/// <summary>
		/// Finds a title of HTML file. Doesn't work if the title spans two or more lines.
		/// </summary>
		/// <param name="html">HTML document.</param>
		/// <returns>Title string.</returns>
		private static string GetTitle(string html)
		{
			Match m = Regex.Match(html, "<title>(.*)</title>");
			if (m.Groups.Count == 2)
				return m.Groups[1].Value;
			return "(unknown)";
		}

		/// <summary>
		/// Optimizes and save the index.
		/// </summary>
		public void Close()
		{
			writer.Optimize();
			writer.Dispose();
		}


	}
}
