using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DriversSystem
{
    public partial class MaintainApplications : System.Web.UI.Page
    {
        DatabaseHelper dbHelper = new DatabaseHelper();
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                populateGridView();
        }

        protected void populateGridView()
        {
            string query = @"SELECT 
                        a.Application_ID,
                        c.IDNum,
                        s.Service_Descr,
                        FORMAT(at.Date, 'yyyy-MM-dd') AS Date,
                        CONCAT(CAST(at.StartTime AS VARCHAR(5)), ' - ', CAST(at.EndTime AS VARCHAR(5))) AS TimeSlot,
                        a.IsPaid,
                        a.IsAttended
                    FROM 
                        Application a
                    JOIN 
                        Client c ON a.Client_ID = c.Client_ID
                    JOIN 
                        Service s ON a.Service_ID = s.Service_ID
                    JOIN 
                        Available_Time at ON a.Time_ID = at.Time_ID";
            try
            {
                DataTable dt = dbHelper.ExecuteQuery(query);
                ApplicationsGridView.DataSource = dt;
                ApplicationsGridView.DataBind();
            }
            catch (SqlException)
            {
                errorAlert.Visible = true;
                errorAlert.Controls.Add(new Literal { Text = "Failed to connect to database" });
            }


        }

        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string userSearch = SearchTextBox.Text.Trim();

            string query = "SELECT * FROM Application WHERE Service_Descr LIKE '%' + @userSearch + '%'";
            SqlParameter[] param =
            {
                new SqlParameter("@userSearch", SqlDbType.VarChar, 50) { Value = userSearch }
            };
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            
        }



        protected void ApplicationsGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            ApplicationsGridView.EditIndex = e.NewEditIndex;
            populateGridView();
        }

        protected void ApplicationsGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            ApplicationsGridView.EditIndex = -1;
            populateGridView();
        }

        protected void ApplicationsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Get the Application ID for the row being updated
            int applicationID = Convert.ToInt32(ApplicationsGridView.DataKeys[e.RowIndex].Value);

           
            CheckBox isPaidCheckBox = (CheckBox)ApplicationsGridView.Rows[e.RowIndex].FindControl("IsPaidCheckBox");
            CheckBox isAttendedCheckBox = (CheckBox)ApplicationsGridView.Rows[e.RowIndex].FindControl("IsAttendedCheckBox");

            // Get values from the CheckBoxes
            bool isPaid = isPaidCheckBox.Checked;
            bool isAttended = isAttendedCheckBox.Checked;

            string query = "UPDATE Application SET IsPaid = @IsPaid, IsAttended = @IsAttended WHERE Application_ID = @ApplicationID";

            SqlParameter[] parameters = 
                {
                new SqlParameter("@IsPaid", SqlDbType.Bit) { Value = isPaid },
                new SqlParameter("@IsAttended", SqlDbType.Bit) { Value = isAttended },
                new SqlParameter("@ApplicationID", SqlDbType.Int) { Value = applicationID }
            };

            int result = dbHelper.ExecuteNonQuery(query, parameters);

            
            if (result > 0)
            {
                // Exit edit mode
                ApplicationsGridView.EditIndex = -1;
                populateGridView();
            }
            else
            {
                errorAlert.Visible = true;
                errorAlert.Controls.Add(new Literal { Text = "Failed to update database" });
            }
        }


        protected void ApplicationsGridView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void maintainButton_Click(object sender, EventArgs e) 
        {
            // get application id and save in session
            //Response.Redirect();
        }
    }
}