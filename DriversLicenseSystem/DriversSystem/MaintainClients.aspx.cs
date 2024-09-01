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
    public partial class MaintainClients : System.Web.UI.Page
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
            search();
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            search();
        }

        protected void search()
        {
            string userSearch = SearchTextBox.Text.Trim();

            string query = "SELECT * FROM Client WHERE Name LIKE @userSearch + '%'";
            SqlParameter[] param =
            {
                new SqlParameter("@userSearch", SqlDbType.VarChar, 35) { Value = userSearch }
            };

            ClientsGridView.DataSource = dbHelper.ExecuteQuery(query, param);
            ClientsGridView.DataBind();
        }

        protected void AddApplicationButton_Click(Object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string clientId = btn.CommandArgument;
            Session["ClientID_Admin"] = clientId;
            Response.Redirect("Admin_MaintainUser.aspx");
        }
        protected void AddClientButton_Click(Object sender, EventArgs e)
        {
            Response.Redirect("Admin_AddUser.aspx");
        }

        protected void SaveClientButton_Click(object sender, EventArgs e)
        {

        }

        protected void UpdateClientButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string clientId = btn.CommandArgument;
            Session["ClientID_Admin"] = clientId;
            Response.Redirect("Admin_MaintainUser.aspx");
        }

        protected void DeleteClientButton_Click(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse(HiddenDelClientID.Value);

                string query = "DELETE FROM Service WHERE Service_ID = @ID";
                SqlParameter[] param =
                {
                    new SqlParameter("@ID", SqlDbType.Int) { Value = id}
                };

                int result = dbHelper.ExecuteNonQuery(query, param);

                // repopulate gridview and success message
                if (result > 0)
                {
                    successAlert.Visible = true;
                    successAlert.Controls.Add(new Literal { Text = "Service deleted successfully!" });
                    populateGridView();
                }
            }
            catch (Exception)
            {
                successAlert.Visible = false;
                errorAlert.Visible = true;
                errorAlert.Controls.Add(new Literal { Text = "Failed to delete service" });
            }
        }

        protected void populateGridView()
        {
            string query = @"
                SELECT Client.Client_ID, Client.IDNum, Client.Name, Client.Surname, 
                       Client.Phone_Number, Client.Address_Num, Client.Address_Street, 
                       City.Name AS CityName
                FROM Client
                JOIN City ON Client.City_ID = City.City_ID
                ORDER BY Client.Name ASC";
            try
            {
                ClientsGridView.DataSource = dbHelper.ExecuteQuery(query);
                ClientsGridView.DataBind();
            }
            catch (SqlException ex)
            {
                errorAlert.Visible = true;
                errorAlert.Controls.Add(new Literal { Text = "Failed to connect to database" + ex });
            }

        }
    }
}