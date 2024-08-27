using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DriversSystem
{
    public partial class MantainAvailableTimes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string searchTerm = SearchTextBox.Text.Trim();

            // Implement your search logic here
            // For example, filter the GridView data based on the search term

            // Assuming you have a method to bind the GridView data
            BindAvailableTimesGrid(searchTerm);
        }

        private void BindAvailableTimesGrid(string searchTerm)
        {
            // Implement your data binding logic here
            // Filter the available times based on the searchTerm

            // Example:
            // var filteredData = GetData().Where(x => x.AvailableDate.Contains(searchTerm) || x.AvailableTime.Contains(searchTerm)).ToList();
            // AvailableTimesGridView.DataSource = filteredData;
            // AvailableTimesGridView.DataBind();
        }

    }
}