using System;
using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
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

            string query = "SELECT * FROM AVAILABLETIME WHERE AvailableTime_Date LIKE '%' + @userSearch + '%'";
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

                string query = "DELETE FROM AvailalbleTime WHERE AvailableTime_ID = @ID";
                SqlParameter[] param =
                {
                    new SqlParameter("@ID", SqlDbType.Int) { Value = id}
                };

                int result = dbHelper.ExecuteNonQuery(query, param);

                if (result > 0)
                {
                    successAlert.Visible = true;
                    successAlert.Controls.Add(new Literal { Text = "Available Time deleted successfully!" });
                    populateGridView();
                }
            }
            catch (Exception)
            {
                successAlert.Visible = false;
                errorAlert.Visible = true;
                errorAlert.Controls.Add(new Literal { Text = "Failed to delete Available Time" });
            }
        }

        protected void UpdateTimeButton_Click(Object sender, EventArgs e)

        {
            string inputDate = UpdateDate.Text;
            double inputTime;

            try
            {
                int id = int.Parse(HiddenUpdateTimeID.Value);
                inputTime = double.Parse(UpdateTimeID.Text);

                string query = "UPDATE Service SET Service_Descr = @Descr, Price = @Price WHERE Service_ID = @ID";

                SqlParameter[] param =
                {
                    new SqlParameter("@Descr", SqlDbType.VarChar, 50) { Value = inputDate},
                    new SqlParameter("@Price", SqlDbType.SmallMoney) { Value =  inputTime },
                    new SqlParameter("@ID", SqlDbType.Int) { Value = id}
                 };

                int result = dbHelper.ExecuteNonQuery(query, param);

                if (result > 0)
                {
                    populateGridView();
                    errorAlert.Visible = false;
                    successAlert.Visible = true;
                    successAlert.Controls.Add(new Literal { Text = "Available time updated successfully!" });
                }
            }
            catch (Exception)
            {
                successAlert.Visible = false;
                errorAlert.Visible = true;
                errorAlert.Controls.Add(new Literal { Text = "Failed to update Available Time" });
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
                    string insertQuery = "INSERT INTO AvailableTimes(Date, StartTime, EndTime, NumPeopleAllowed) VALUES (@Date, @StartTime, @EndTime, @NumPeopleAllowed)";
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
                        successAlert.Visible = true;
                        successAlert.Controls.Add(new Literal { Text = "Time slot added successfully!" });
                        populateGridView();
                    }
                    else
                    {
                        successAlert.Visible = false;
                        errorAlert.Visible = true;
                        errorAlert.Controls.Add(new Literal { Text = "Failed to add time slot." });
                    }
                }
                catch (Exception ex)
                {
                    successAlert.Visible = false;
                    errorAlert.Visible = true;
                    errorAlert.Controls.Add(new Literal { Text = "Failed to add time slot: " + ex.Message });
                }
            }
            else
           {
                successAlert.Visible = false;
                errorAlert.Visible = true;
                errorAlert.Controls.Add(new Literal { Text = "Please enter valid data for all fields." });
            }
        }


        protected void populateGridView()
        {

            string query = "SELECT * FROM Available_Time";
            try
            {
                TimesGridView.DataSource = dbHelper.ExecuteQuery(query);
                TimesGridView.DataBind();
            }
            catch (SqlException)
            {
                errorAlert.Visible = true;
                errorAlert.Controls.Add(new Literal { Text = "Failed to connect to database" });
            }





        }
    }
}