using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DriversSystem
{
    public partial class AdminPortal_NumAppointmentsPerWeek : System.Web.UI.Page
    {
        DatabaseHelper dbHelper = new DatabaseHelper();

        // Default time is current month
        static DateTime startDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
        static DateTime endDate = startDate.AddMonths(1).AddDays(-1);
        string startDateString = startDate.ToString("yyyy-MM-dd");
        string endDateString = endDate.ToString("yyyy-MM-dd");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                StartDateTextBox.Text = startDateString;
                EndDateTextBox.Text = endDateString;
                lblDateTime.Text = DateTime.Now.ToString("MMMM dd, yyyy HH:mm:ss");
                populateGridView();
            }
        }

        protected void FilterButton_Click(object sender, EventArgs e)
        {
            startDateString = StartDateTextBox.Text;
            endDateString = EndDateTextBox.Text;
            populateGridView();
        }

        protected void populateGridView()
        {

            ApplicationGridView.DataSource = null;
            ApplicationGridView.DataBind();

            //ApplicationGridView.DataSource = dbHelper.ExecuteQuery(query,param);
            //ApplicationGridView.DataBind();
        }


    }
}