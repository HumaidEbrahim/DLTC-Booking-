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

            string query = @"
            SELECT 
                CONCAT(CAST(StartTime AS VARCHAR(5)),' - ',CAST(EndTime AS VARCHAR(5))) AS TimeSlot,
                SUM(CASE WHEN DATEPART(WEEK, t.Date) = DATEPART(WEEK, @StartDate) THEN 1 ELSE 0 END) AS Week1,
                SUM(CASE WHEN DATEPART(WEEK, t.Date) = DATEPART(WEEK, @StartDate) + 1 THEN 1 ELSE 0 END) AS Week2,
                SUM(CASE WHEN DATEPART(WEEK, t.Date) = DATEPART(WEEK, @StartDate) + 2 THEN 1 ELSE 0 END) AS Week3,
                SUM(CASE WHEN DATEPART(WEEK, t.Date) = DATEPART(WEEK, @StartDate) + 3 THEN 1 ELSE 0 END) AS Week4,
                SUM(CASE WHEN DATEPART(WEEK, t.Date) = DATEPART(WEEK, @StartDate) + 4 THEN 1 ELSE 0 END) AS Week5,
                COUNT(a.Application_ID) AS TotalApplication
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
                t.StartTime;
            ";

            SqlParameter[] param =
             {
                 new SqlParameter("@StartDate", SqlDbType.Date) { Value = startDateString},
                 new SqlParameter("@EndDate", SqlDbType.Date) { Value = endDateString}
             };
            ApplicationGridView.DataSource = dbHelper.ExecuteQuery(query,param);
            ApplicationGridView.DataBind();
        }


    }
}