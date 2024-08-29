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
    public partial class ClientPortal_Menu : System.Web.UI.Page
    {
        DatabaseHelper dbHelper = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            // Get clients ID from session
            if (Session["IDNumber"] != null)
            {
                string id = Session["IDNumber"].ToString();

                // Get Client db ID 
                string query = "SELECT Client_ID FROM CLIENT WHERE IDNum = @ID";
                SqlParameter[] param =
                {
                    new SqlParameter("@ID", SqlDbType.Char,13) { Value = id }
                };

                using (SqlDataReader reader = dbHelper.ExecuteReader(query, param))
                {
                    if (reader.Read())
                    {
                        // Store Client_ID in session
                        Session["Client_ID"] = reader["Client_ID"].ToString();
                    }
                }
            }
        }
    }
}