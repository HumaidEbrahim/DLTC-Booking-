using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DriversSystem
{
    public partial class MantainAvailableTimes : System.Web.UI.Page
    {
        DatabaseHelper dbHelper = new DatabaseHelper();
        DataTable dt = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                populateGridView();
        }

        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string userSearch = SearchTextBox.Text.Trim();

            string query = "SELECT * FROM AVAILABLE_TIME WHERE AvailableTime_Date LIKE '%' + @userSearch + '%'";
            SqlParameter[] param =
            {
                new SqlParameter("@userSearch", SqlDbType.VarChar, 50) { Value = userSearch }
            };

            TimesGridView.DataSource = dbHelper.ExecuteQuery(query, param);
            TimesGridView.DataBind();
        }

        protected void DeleteTimeButton_Click(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse(HiddenDelTimeID.Value);

                // First, delete related records in the Application table
                string deleteApplicationsQuery = "DELETE FROM Application WHERE Time_ID = @ID";
                SqlParameter[] deleteAppParams =
                {
            new SqlParameter("@ID", SqlDbType.Int) { Value = id }
        };
                dbHelper.ExecuteNonQuery(deleteApplicationsQuery, deleteAppParams);

                // Then, delete the record from Available_Time
                string deleteTimeQuery = "DELETE FROM Available_Time WHERE Time_ID = @ID";
                SqlParameter[] deleteTimeParams =
                {
            new SqlParameter("@ID", SqlDbType.Int) { Value = id }
        };
                int result = dbHelper.ExecuteNonQuery(deleteTimeQuery, deleteTimeParams);

                if (result > 0)
                {
                    populateGridView(); // Refresh the GridView
                    successAlert.Visible = true;
                    successAlert.Controls.Clear(); // Clear previous messages
                    successAlert.Controls.Add(new Literal { Text = "Available Time deleted successfully!" });
                }
                else
                {
                    errorAlert.Visible = true;
                    errorAlert.Controls.Clear(); // Clear previous messages
                    errorAlert.Controls.Add(new Literal { Text = "Failed to delete Available Time." });
                }
            }
            catch (Exception ex)
            {
                successAlert.Visible = false;
                errorAlert.Visible = true;
                errorAlert.Controls.Clear(); // Clear previous messages
                errorAlert.Controls.Add(new Literal { Text = "Failed to delete Available Time: " + ex.Message });
            }
        }


        protected void UpdateTimeButton_Click(Object sender, EventArgs e)
        {
            // Get the input values
            string date = AddDate.Text.Trim();
            string startTime = AddStartTime.Text.Trim();
            string endTime = AddEndTime.Text.Trim();
            string numPeopleAllowedStr = AddNumPeopleAllowed.Text.Trim();

            // Parse the inputs
            if (DateTime.TryParse(date, out DateTime parsedDate) &&
                TimeSpan.TryParse(startTime, out TimeSpan parsedStartTime) &&
                TimeSpan.TryParse(endTime, out TimeSpan parsedEndTime) &&
                int.TryParse(numPeopleAllowedStr, out int numPeopleAllowed))
            {
                try
                {
                    // Get the ID of the record to update
                    int id = int.Parse(HiddenUpdateTimeID.Value);

                    // Update query
                    string query = "UPDATE Available_Time SET Date = @Date, StartTime = @StartTime, EndTime = @EndTime, NumPeopleAllowed = @NumAllow WHERE Time_ID = @ID";

                    // Parameters for the update query
                    SqlParameter[] param =
                    {
                new SqlParameter("@Date", SqlDbType.Date) { Value = parsedDate },
                new SqlParameter("@StartTime", SqlDbType.Time) { Value = parsedStartTime },
                new SqlParameter("@EndTime", SqlDbType.Time) { Value = parsedEndTime },
                new SqlParameter("@NumAllow", SqlDbType.Int) { Value = numPeopleAllowed },
                new SqlParameter("@ID", SqlDbType.Int) { Value = id }
            };

                    // Execute the update
                    int result = dbHelper.ExecuteNonQuery(query, param);

                    if (result > 0)
                    {
                        populateGridView(); 
                        errorAlert.Visible = false;
                        successAlert.Visible = true;
                        successAlert.Controls.Clear(); 
                        successAlert.Controls.Add(new Literal { Text = "Available time updated successfully!" });
                    }
                    else
                    {
                        errorAlert.Visible = true;
                        errorAlert.Controls.Clear(); 
                        errorAlert.Controls.Add(new Literal { Text = "Failed to update Available Time." });
                    }
                }
                catch (Exception ex)
                {
                    successAlert.Visible = false;
                    errorAlert.Visible = true;
                    errorAlert.Controls.Clear(); 
                    errorAlert.Controls.Add(new Literal { Text = "Failed to update Available Time: " + ex.Message });
                }
            }
            else
            {
                successAlert.Visible = false;
                errorAlert.Visible = true;
                errorAlert.Controls.Clear();
                errorAlert.Controls.Add(new Literal { Text = "Please enter valid data for all fields." });
            }
        }


        protected void SaveTimeButton_Click(object sender, EventArgs e)
        {
            string date = AddDate.Text;
            string startTime = AddStartTime.Text;
            string endTime = AddEndTime.Text;
            int numPeopleAllowed;

            if (DateTime.TryParse(date, out DateTime parsedDate) &&
                TimeSpan.TryParse(startTime, out TimeSpan parsedStartTime) &&
                TimeSpan.TryParse(endTime, out TimeSpan parsedEndTime) &&
                int.TryParse(AddNumPeopleAllowed.Text, out numPeopleAllowed))
            {
                try
                {
                    string insertQuery = "INSERT INTO Available_Time(Date, StartTime, EndTime, NumPeopleAllowed) VALUES (@Date, @StartTime, @EndTime, @NumPeopleAllowed)";
                    SqlParameter[] parameters =
                    {
                        new SqlParameter("@Date", SqlDbType.Date) { Value = parsedDate },
                        new SqlParameter("@StartTime", SqlDbType.Time) { Value = parsedStartTime },
                        new SqlParameter("@EndTime", SqlDbType.Time) { Value = parsedEndTime },
                        new SqlParameter("@NumPeopleAllowed", SqlDbType.Int) { Value = numPeopleAllowed }
                    };

                    int result = dbHelper.ExecuteNonQuery(insertQuery, parameters);

                    if (result > 0)
                    {
                        populateGridView(); 
                        successAlert.Visible = true;
                        successAlert.Controls.Clear(); 
                        successAlert.Controls.Add(new Literal { Text = "Time slot added successfully!" });
                    }
                    else
                    {
                        errorAlert.Visible = true;
                        errorAlert.Controls.Clear();
                        errorAlert.Controls.Add(new Literal { Text = "Failed to add time slot." });
                    }
                }
                catch (Exception ex)
                {
                    successAlert.Visible = false;
                    errorAlert.Visible = true;
                    errorAlert.Controls.Clear();
                    errorAlert.Controls.Add(new Literal { Text = "Failed to add time slot: " + ex.Message });
                }
            }
            else
            {
                successAlert.Visible = false;
                errorAlert.Visible = true;
                errorAlert.Controls.Clear();
                errorAlert.Controls.Add(new Literal { Text = "Please enter valid data for all fields." });
            }
        }

        protected void populateGridView()
        {
            string query = "SELECT Time_ID, FORMAT(Date, 'yyyy-MM-dd') AS Date, StartTime, EndTime, NumPeopleAllowed FROM Available_Time";

            try
            {
                TimesGridView.DataSource = dbHelper.ExecuteQuery(query);
                TimesGridView.DataBind();
            }
            catch (SqlException)
            {
                errorAlert.Visible = true;
                errorAlert.Controls.Clear(); 
                errorAlert.Controls.Add(new Literal { Text = "Failed to connect to database." });
            }
        }
    }
}
