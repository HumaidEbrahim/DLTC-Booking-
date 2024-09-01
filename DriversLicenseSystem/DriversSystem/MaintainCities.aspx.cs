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
    public partial class MaintainCities : System.Web.UI.Page
    {
        DatabaseHelper dbHelper = new DatabaseHelper();
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                populateGridView();
        }

        protected void DeleteCityButton_Click(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse(HiddenDelCityID.Value);

                string query = "DELETE FROM City WHERE City_ID = @ID";
                SqlParameter[] param =
                {
                    new SqlParameter("@ID", SqlDbType.Int) { Value = id }
                };

                int result = dbHelper.ExecuteNonQuery(query, param);

                if (result > 0)
                {
                    successAlert.Visible = true;
                    successAlert.Controls.Add(new Literal { Text = "City deleted successfully!" });
                    populateGridView();
                }
            }
            catch (Exception)
            {
                successAlert.Visible = false;
                errorAlert.Visible = true;
                errorAlert.Controls.Add(new Literal { Text = "Failed to delete city" });
            }
        }

        protected void UpdateCityButton_Click(object sender, EventArgs e)
        {
            string inputName = UpdateCityName.Text;
            if (!string.IsNullOrEmpty(inputName))
            {
                try
                {
                    int id = int.Parse(HiddenUpdateCityID.Value);

                    string query = "UPDATE City SET Name = @Name WHERE City_ID = @ID";
                    SqlParameter[] param =
                    {
                        new SqlParameter("@Name", SqlDbType.VarChar, 50) { Value = inputName },
                        new SqlParameter("@ID", SqlDbType.Int) { Value = id }
                    };

                    int result = dbHelper.ExecuteNonQuery(query, param);

                    if (result > 0)
                    {
                        populateGridView();
                        errorAlert.Visible = false;
                        successAlert.Visible = true;
                        successAlert.Controls.Add(new Literal { Text = "City updated successfully!" });
                    }
                }
                catch (Exception ex)
                {
                    successAlert.Visible = false;
                    errorAlert.Visible = true;
                    errorAlert.Controls.Add(new Literal { Text = "Failed to update city: " + ex.Message });
                }
            }
        }

        protected void SaveCityButton_Click(object sender, EventArgs e)
        {
            string inputName = AddCityName.Text;
            if (!string.IsNullOrEmpty(inputName))
            {
                try
                {
                    string query = "INSERT INTO City(Name) VALUES (@Name)";
                    SqlParameter[] param =
                    {
                        new SqlParameter("@Name", SqlDbType.VarChar, 50) { Value = inputName }
                    };

                    int result = dbHelper.ExecuteNonQuery(query, param);

                    if (result > 0)
                    {
                        populateGridView();
                        errorAlert.Visible = false;
                        successAlert.Visible = true;
                        successAlert.Controls.Add(new Literal { Text = "City added successfully!" });
                    }
                }
                catch (Exception ex)
                {
                    successAlert.Visible = false;
                    errorAlert.Visible = true;
                    errorAlert.Controls.Add(new Literal { Text = "Failed to add city: " + ex.Message });
                }
            }
        }

        protected void populateGridView()
        {
            string query = "SELECT * FROM City";
            try
            {
                CitiesGridView.DataSource = dbHelper.ExecuteQuery(query);
                CitiesGridView.DataBind();
            }
            catch (SqlException)
            {
                errorAlert.Visible = true;
                errorAlert.Controls.Add(new Literal { Text = "Failed to connect to database" });
            }
        }

        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            Search();
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            Search();
        }

        protected void Search()
        {
            string userSearch = SearchTextBox.Text.Trim();

            string query = "SELECT * FROM City WHERE Name LIKE '%' + @userSearch + '%'";
            SqlParameter[] param =
            {
                new SqlParameter("@userSearch", SqlDbType.VarChar, 50) { Value = userSearch }
            };

            CitiesGridView.DataSource = dbHelper.ExecuteQuery(query, param);
            CitiesGridView.DataBind();
        }
    }
}
