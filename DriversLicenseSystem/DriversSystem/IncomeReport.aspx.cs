using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Runtime.InteropServices.ComTypes;
using System.Text.RegularExpressions;

namespace DriversSystem
{
     public partial class IncomeReport : System.Web.UI.Page
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

                    IncomeGridView.DataSource = null;
                    IncomeGridView.DataBind();
          
            SqlParameter[] param =
            {
         new SqlParameter("@StartDate", SqlDbType.Date) { Value = startDateString},
         new SqlParameter("@EndDate", SqlDbType.Date) { Value = endDateString}
};
            //IncomeGridView.DataSource = dbHelper.ExecuteQuery(query,param);
            IncomeGridView.DataBind();
        }

        }
 
}
