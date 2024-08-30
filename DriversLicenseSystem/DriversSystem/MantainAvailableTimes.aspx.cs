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

            AvailableTimesGridView.DataSource = dbHelper.ExecuteQuery(query, param);
            AvailableTimesGridView.DataBind();
        }



        protected void ConfirmDeleteButton_Click(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse(HiddenDelAvailableTimeID.Value);

                string query = "DELETE FROM AvailalbleTime WHERE AvailableTime_ID = @ID";
                SqlParameter[] param =
                {
                    new SqlParameter("@ID", SqlDbType.Int) { Value = id}
                };

                int result = dbHelper.ExecuteNonQuery(query, param);

                // repopulate gridview and success message
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

        protected void ConfirmUpdateButton_Click(Object sender, EventArgs e)

        {
            string inputDate = UpdateAvailableDate.Text;
            double inputTime;

            try
            {
                int id = int.Parse(HiddenUpdateAvailableTimeID.Value);
                inputTime = double.Parse(UpdateAvailableTime.Text);

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
                    // repopulate gridview and success message
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




        protected void populateGridView()
        {

            string query = "SELECT * FROM Service";
            try
            {
                AvailableTimesGridView.DataSource = dbHelper.ExecuteQuery(query);
                AvailableTimesGridView.DataBind();
            }
            catch (SqlException)
            {
                errorAlert.Visible = true;
                errorAlert.Controls.Add(new Literal { Text = "Failed to connect to database" });
            }




        }
    }
}