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
        int ClientID;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {   
                // Get clients ID from session
                if (Session["Client_ID"] != null)
                {
                    ClientID = Convert.ToInt32(Session["Client_ID"]);
                    populateDropdown();
                    populateForm();
                    //TextBox1.Text = ClientID.ToString();
                }
                FormState.Enabled = false;
                // Enable client-side validation
                ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.WebForms;
            }
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            FormState.Enabled = true;

            DeleteButton.Visible = false;
            UpdateButton.Visible = false;
            SaveButton.Visible = true;
        }
        protected void SaveButton_Click(object sender, EventArgs e)
        {
              if(Page.IsValid)
                {
                ClientID = Convert.ToInt32(Session["Client_ID"]);
                string name = Name.Text.Trim();
                string surname = Surname.Text.Trim();
                string phone = PhoneNumber.Text.Trim();
                string addressnum = AddressNumber.Text.Trim();
                string street = AddressStreet.Text.Trim();
                string cityID = City.SelectedValue;

                string query = "UPDATE Client SET Name=@name, Surname=@surname, Phone_Number=@phone, Address_Num=@addressnum, Address_Street=@street, City_ID =@cityID WHERE Client_ID=@ID";

                SqlParameter[] param =
                {
                    new SqlParameter("@name", SqlDbType.VarChar, 35) { Value = name },
                    new SqlParameter("@surname", SqlDbType.VarChar, 35) { Value = surname },
                    new SqlParameter("@phone", SqlDbType.Char, 10) { Value = phone },
                    new SqlParameter("@addressnum", SqlDbType.Char, 10) { Value = addressnum },
                    new SqlParameter("@street", SqlDbType.VarChar, 50) { Value = street },
                    new SqlParameter("@cityID", SqlDbType.Int) { Value = cityID },
                    new SqlParameter("@ID", SqlDbType.Int) { Value = ClientID}
                };

                int result = dbHelper.ExecuteNonQuery(query, param);

                if (result > 0)
                {
                    populateForm();
                    SaveButton.Visible = false;
                    UpdateButton.Visible = true;
                    DeleteButton.Visible = true;
                    FormState.Enabled = false;
                }
            }
               
            
        }
        protected void DeleteButton_Click(Object sender, EventArgs e)
        {
            ClientID = Convert.ToInt32(Session["Client_ID"]);
            string query = "DELETE FROM Client WHERE Client_ID = @ID";
            SqlParameter[] param =
            {
                    new SqlParameter("@ID", SqlDbType.Int) { Value = ClientID}
                };

            int result = dbHelper.ExecuteNonQuery(query, param);

            if(result > 0)
            {
                Response.Redirect("ClientPortal.aspx");
            }
        }

        private void populateForm()
        {
            string query = "SELECT * FROM Client WHERE CLient_ID = @ID";
            SqlParameter[] param =
            {
                new SqlParameter("@ID", SqlDbType.Int) { Value = ClientID}
            };

            using (SqlDataReader reader = dbHelper.ExecuteReader(query, param))
            {
                if (reader.Read())
                {
                    IDNumber.Text = reader["IDNum"].ToString();
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
