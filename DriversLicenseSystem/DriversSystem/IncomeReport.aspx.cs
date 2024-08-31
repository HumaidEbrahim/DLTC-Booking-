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
        int grandTotal = 0;

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
            string sort = sortOrder.SelectedValue;

            string query = "SELECT s.Service_Descr, s.Price,COUNT(a.Service_ID) AS Quantity, s.Price* COUNT(a.Service_ID) AS Total FROM Service s LEFT JOIN Application a ON s.Service_ID = a.Service_ID LEFT JOIN " +
                "Available_Time at ON a.time_id = at.time_id WHERE a.isPaid = 1 AND at.Date >= @StartDate AND at.Date <= @EndDate GROUP BY s.Service_ID, s.Service_Descr, s.Price ORDER BY Total " + sort;
            SqlParameter[] param =
            {
                 new SqlParameter("@StartDate", SqlDbType.Date) { Value = startDateString},
                 new SqlParameter("@EndDate", SqlDbType.Date) { Value = endDateString}
            };
            IncomeGridView.DataSource = dbHelper.ExecuteQuery(query,param);
            IncomeGridView.DataBind();
       }


        // Display the grand total
        protected void IncomeGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
              
                int rowTotal = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Total"));
                grandTotal += rowTotal;
            }
            else if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.Cells[2].Text = "Grand Total:";
                e.Row.Cells[3].Text = grandTotal.ToString("C0");   
            }
        }
    }
}
