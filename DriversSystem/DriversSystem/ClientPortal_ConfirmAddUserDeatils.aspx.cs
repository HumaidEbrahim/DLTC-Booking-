using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DriversSystem
{
    public partial class ClientPortal_ConfirmAddUserDeatils : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Populate labels with the previously entered data
            ConfirmName.Text = Session["Name"]?.ToString();
            ConfirmSurname.Text = Session["Surname"]?.ToString();
            ConfirmPhoneNumber.Text = Session["PhoneNumber"]?.ToString();
            ConfirmAddressNumber.Text = Session["AddressNumber"]?.ToString();
            ConfirmAddressStreet.Text = Session["AddressStreet"]?.ToString();
            ConfirmCity.Text = Session["City"]?.ToString();
        }

        protected void ConfirmButton_Click(object sender, EventArgs e)
        {
            // Code to save the data to the database or another storage mechanism

            // Redirect to a success page or another relevant page
            // Response.Redirect("");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            // Return to the previous form
            Response.Redirect("ClientPortal_AddUserDetails.aspx");
        }
    }
}