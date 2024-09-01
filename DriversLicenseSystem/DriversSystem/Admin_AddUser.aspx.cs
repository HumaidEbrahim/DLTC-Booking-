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
    public partial class Admin_AddUser : System.Web.UI.Page
    {
        const int ID_LENGTH = 13;
        DatabaseHelper dbHelper = new DatabaseHelper();
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
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

                // Enable client-side validation
                ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.WebForms;
            }
        }

        protected void ContinueButton_Click(object sender, EventArgs e)
        {
            string id = IDNumber.Text.Trim();
            if(existsID(id) || !validateID(id))
            {
                ErrorMessage.Text = "Invalid ID number or ID number already exists!";
                ErrorMessage.Visible = true;
            }
            else
            {
                ErrorMessage.Visible = false;
            }
          

            if (Page.IsValid)
            {

                // add new client to database
               
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
                    new SqlParameter("@addressnum", SqlDbType.VarChar, 10) { Value = addressnum },
                    new SqlParameter("@street", SqlDbType.VarChar, 50) { Value = street },
                    new SqlParameter("@cityId", SqlDbType.Int) { Value = cityId } // CityID as FK
                };

                dbHelper.ExecuteNonQuery(query, param);

                // Redirect
                Response.Redirect("MaintainClients.aspx");
            }
        }

        protected bool existsID(String id)
        {
            String query = "SELECT IDNum FROM Client WHERE IDNum = @ID";

            SqlParameter[] param =
            {
               new SqlParameter("@ID", SqlDbType.Char,13) { Value = id }
            };

            dt = dbHelper.ExecuteQuery(query, param);

            // if dt not empty 
            return dt.Rows.Count > 0;
        }

        protected bool validateID(string id)
        {
            // Id number should be 13 digits
            if (id.Length != ID_LENGTH)
            {
                return false;
            }

            // Luhns Algorithm
            int sum = 0;

            // loop through every 2nd digit
            for (int i = ID_LENGTH - 1; i >= 0; i--)
            {
                int digit = id[i] - '0';

                // double every second digit
                if (i % 2 != 0)
                {
                    digit = digit * 2;

                    // add sum of both digits to total sum
                    sum += digit / 10;
                    sum += digit % 10;
                }
                else
                {
                    sum += digit;
                }

            }

            // validate total sum
            return (sum % 10 == 0); ;

        }
    }

}

