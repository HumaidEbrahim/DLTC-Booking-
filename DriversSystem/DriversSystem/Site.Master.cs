using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DriversSystem
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            // Implement your search logic here
            string query = SearchBox.Text.Trim(); // Retrieve the text from the search box
            if (!string.IsNullOrEmpty(query))
            {
                // Redirect to a search results page, passing the query as a query string parameter
                Response.Redirect($"~/SearchResults.aspx?q={Server.UrlEncode(query)}");
            }
        }
    }
}