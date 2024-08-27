using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DriversSystem
{
    public partial class ClientPortal1 : System.Web.UI.Page
    {
        const int ID_LENGTH = 13;
        DatabaseHelper dbHelper = new DatabaseHelper();
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void bttnIDEnter_Click(object sender, EventArgs e)
        {
            
            string id = clientId.Text;
            id = id.Trim();

            // Check if the ID is valid
            if (validateID(id))
            {
                // Store ID in Session

                Session["IDNumber"] = id;

                // Check if user exists in database
                if (existsID(id))
                {
                    Response.Redirect("ClientPortal_Menu.aspx");
                }
                else
                {
                    Response.Redirect("ClientPortal_AddUserDetails.aspx");
                }
                
            }
            else
            {
                idAlert.Visible = true;
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
            if(id.Length != ID_LENGTH)
            {
                return false;
            }

            // Luhns Algorithm
            int sum = 0;
            
            // loop through every 2nd digit
            for(int i = ID_LENGTH - 1; i >= 0; i--)
            {
                int digit = id[i] - '0' ;

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