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
    public partial class ClientPortal_MaintainClients : System.Web.UI.Page
    {
        DatabaseHelper dbHelper = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {   
                // Get clients ID from session
                if (Session["IDNumber"] != null)
                {
                    String id = Session["IDNumber"].ToString();
                    IDNumber.Text = id;
                    populateDropdown();
                    populateForm(id);
                }
                // Enable client-side validation
                ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.WebForms;
            }
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
                string id = "";
                // update client in database
                if (Session["IDNumber"] != null)
                {
                    id = Session["IDNumber"].ToString();
                }
               
                Name.Enabled = true;
                Surname.Enabled = true;
                PhoneNumber.Enabled = true;
                AddressNumber.Enabled = true;
                AddressStreet.Enabled = true;
                City.Enabled = true;
                DeleteButton.Visible = false;
                UpdateButton.Visible = false;
                SaveButton.Visible = true;


        }
        protected void SaveButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string id = Session["IDNumber"].ToString();
                string name = Name.Text.Trim();
                string surname = Surname.Text.Trim();
                string phone = PhoneNumber.Text.Trim();
                string addressnum = AddressNumber.Text.Trim();
                string street = AddressStreet.Text.Trim();
                string cityID = City.SelectedValue;

                string query = "UPDATE Client SET Name=@name, Surname=@surname, Phone_Number=@phone, Address_Num=@addressnum, Address_Street=@street, City_ID=@cityID WHERE IDNum=@id";

                SqlParameter[] param =
                {
                    new SqlParameter("@name", SqlDbType.VarChar, 35) { Value = name },
                    new SqlParameter("@surname", SqlDbType.VarChar, 35) { Value = surname },
                    new SqlParameter("@phone", SqlDbType.Char, 10) { Value = phone },
                    new SqlParameter("@addressnum", SqlDbType.Char, 10) { Value = addressnum },
                    new SqlParameter("@street", SqlDbType.VarChar, 50) { Value = street },
                    new SqlParameter("@cityID", SqlDbType.Int) { Value = cityID },
                    new SqlParameter("@id", SqlDbType.Char, 13) { Value = id }
                };

                dbHelper.ExecuteNonQuery(query, param);

                // Optionally, redirect or display a success message
                Response.Redirect("ClientPortal_MaintainClients.aspx");
            }
        }
        protected void DeleteButton_Click(Object sender, EventArgs e)
        {
            // Delete client

        }

        private void populateForm(String id)
        {
            string query = "SELECT * FROM Client WHERE IDNum = @ID";
            SqlParameter[] param =
            {
                new SqlParameter("@ID", SqlDbType.Char, 13) { Value = id }
            };

            using (SqlDataReader reader = dbHelper.ExecuteReader(query, param))
            {
                if (reader.Read())
                {
                    Name.Text = reader["Name"].ToString();
                    Surname.Text = reader["Surname"].ToString();
                    PhoneNumber.Text = reader["Phone_Number"].ToString();
                    AddressNumber.Text = reader["Address_Num"].ToString();
                    AddressStreet.Text = reader["Address_Street"].ToString();
                    City.SelectedValue = reader["City_ID"].ToString();
                }
            }
        }

        
        private void populateDropdown()
        {
            // Populate city drop down
            String query = "SELECT City_ID, Name FROM City ORDER BY Name ASC";

            using (SqlDataReader reader = dbHelper.ExecuteReader(query))
            {
                while (reader.Read())
                {
                    // Get city name and ID
                    String cityName = reader["Name"].ToString();
                    String cityId = reader["City_ID"].ToString();

                    // Add city name to dropdown with city ID as the value
                    City.Items.Add(new ListItem(cityName, cityId));
                }
            }
        }

    }
}
