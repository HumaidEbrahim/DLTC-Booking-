using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DriversSystem
{
    
    public partial class ClientPortal_AddUserDetails : System.Web.UI.Page
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
                }

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

                // Enable client-side validation
                ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.WebForms;
            }
        }

        protected void ContinueButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string id = "";
                // add new client to database
                if (Session["IDNumber"] != null)
                {
                    id = Session["IDNumber"].ToString();
                }
                string name = Name.Text.Trim();
                string surname = Surname.Text.Trim();
                string phone = PhoneNumber.Text.Trim();
                string addressnum = AddressNumber.Text.Trim();
                string street = AddressStreet.Text.Trim();
                string cityId = City.SelectedValue; // Get the selected city ID

                string query = "INSERT INTO Client(IDNum, Name, Surname, Phone_Number, Address_Num, Address_Street, City_ID) " +
                               "VALUES(@id, @name, @surname, @phone, @addressnum, @street, @cityId)";
                SqlParameter[] param =
                {
                    new SqlParameter("@id", SqlDbType.Char, 13) { Value = id },
                    new SqlParameter("@name", SqlDbType.VarChar, 35) { Value = name },
                    new SqlParameter("@surname", SqlDbType.VarChar, 35) { Value = surname },
                    new SqlParameter("@phone", SqlDbType.Char, 10) { Value = phone },
                    new SqlParameter("@addressnum", SqlDbType.Char, 10) { Value = addressnum },
                    new SqlParameter("@street", SqlDbType.VarChar, 50) { Value = street },
                    new SqlParameter("@cityId", SqlDbType.Int) { Value = cityId } // CityID as FK
                };

                dbHelper.ExecuteNonQuery(query, param);

                // Redirect
                Response.Redirect("ClientPortal_Menu.aspx");
            }
        }

    }
}