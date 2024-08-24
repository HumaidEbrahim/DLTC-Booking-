﻿using System;
using System.Collections.Generic;
using System.Configuration;
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
            // Get clients ID from session
            if (Session["IDNumber"] != null)
            {
                String id = Session["IDNumber"].ToString();
                IDNumber.Text = id;
            }

            // Populate city drop down
            String query = "SELECT Name FROM City ORDER BY Name ASC";

            using (SqlDataReader reader = dbHelper.ExecuteReader(query))
            {
                while (reader.Read())
                {
                    String cityName = reader["Name"].ToString();  
                    City.Items.Add(cityName);
                }
            }
            if (!IsPostBack)
            {
                // Enable client-side validation
                ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.WebForms;
            }

        }

        protected void ContinueButton_Click(object sender, EventArgs e)
        {

            // Check if valid
            if(Page.IsValid)
            {
                Response.Redirect("ClientPortal_Menu.aspx");
            }
             
            

            // add new client to database

            // redirect to client main menu

        }
    }
}