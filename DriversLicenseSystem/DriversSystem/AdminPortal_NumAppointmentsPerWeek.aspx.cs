using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DriversSystem
{
    public partial class AdminPortal_NumAppointmentsPerWeek : System.Web.UI.Page
    {
        DatabaseHelper dbHelper = new DatabaseHelper();
        int grandTotal;

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
            ApplicationGridView.Columns.Clear();

            DateTime startDate = DateTime.Parse(startDateString);
            DateTime endDate = DateTime.Parse(endDateString);

            int totalWeeks = (int)((endDate - startDate).TotalDays / 7) + 1;
            totalWeeks = Math.Min(totalWeeks, 8);

            // Sql
            string query = "SELECT CONCAT(CAST(StartTime AS VARCHAR(5)),' - ',CAST(EndTime AS VARCHAR(5))) AS TimeSlot,";

            for (int i = 0; i < totalWeeks; i++)
            {
                query += $"SUM(CASE WHEN DATEPART(WEEK, t.Date) = DATEPART(WEEK, @StartDate) + {i} THEN 1 ELSE 0 END) AS Week{i + 1},";
            }

            query += @"COUNT(a.Application_ID) AS TotalAppointments
               FROM 
                   Available_Time t
               LEFT JOIN 
                   Application a ON t.Time_ID = a.Time_ID
               WHERE 
                   t.Date BETWEEN @StartDate AND @EndDate
                   AND t.StartTime BETWEEN '08:00' AND '14:00'
               GROUP BY 
                   t.StartTime, t.EndTime
               ORDER BY 
                   t.StartTime";

         
            SqlParameter[] param =
            {
                new SqlParameter("@StartDate", SqlDbType.Date) { Value = startDateString },
                new SqlParameter("@EndDate", SqlDbType.Date) { Value = endDateString }
            };

            DataTable resultTable = dbHelper.ExecuteQuery(query, param);
            ApplicationGridView.DataSource = resultTable;

            // Dynamic Columns
            BoundField timeSlotColumn = new BoundField();
            timeSlotColumn.HeaderText = "Time Slot";
            timeSlotColumn.DataField = "TimeSlot";
            ApplicationGridView.Columns.Add(timeSlotColumn);

            for (int i = 1; i <= totalWeeks; i++)
            {
                BoundField weekColumn = new BoundField();
                weekColumn.HeaderText = $"Week {i}";
                weekColumn.DataField = $"Week{i}";
                ApplicationGridView.Columns.Add(weekColumn);
            }

            BoundField totalAppointmentsColumn = new BoundField();
            totalAppointmentsColumn.HeaderText = "Total Appointments";
            totalAppointmentsColumn.DataField = "TotalAppointments";
            ApplicationGridView.Columns.Add(totalAppointmentsColumn);

            ApplicationGridView.DataBind();
        }


        // Display the grand total
        protected void ApplicationGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int rowTotal = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalAppointments"));
                grandTotal += rowTotal;
            }
            else if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.Cells[e.Row.Cells.Count - 2].Text = "Grand Total:";
                e.Row.Cells[e.Row.Cells.Count - 2].Font.Bold = true;

                e.Row.Cells[e.Row.Cells.Count - 1].Text = grandTotal.ToString();
                e.Row.Cells[e.Row.Cells.Count - 1].Font.Bold = true;
            }
        }


    }
}