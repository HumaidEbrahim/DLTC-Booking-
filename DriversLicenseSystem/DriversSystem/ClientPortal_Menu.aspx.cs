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
        DataTable dt = new DataTable();
        int client_id;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Get clients ID from session
            if (Session["IDNumber"] != null)
            {
                string id = Session["IDNumber"].ToString();

                // Get Client db ID 
                string query = "SELECT Client_ID,Name FROM CLIENT WHERE IDNum = @ID";
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
                        client_id = Convert.ToInt32(reader["Client_ID"].ToString());
                        // welcome user
                        welcomemessage.Text = "Welcome " + reader["Name"].ToString();
                    }
                }
            }

            // check if application exists
            if (existsApplication())
            {
                viewApplicationButton.Visible = true;
                maintainApplicationButton.Visible = true;
                createApplicationButton.Visible = false;
            }
            else
            {
                viewApplicationButton.Visible = false;
                maintainApplicationButton.Visible = false;
                createApplicationButton.Visible = true;

            }

        }
        private bool existsApplication()
        {
            string query = "SELECT * FROM Application WHERE CLient_ID = @ID AND isAttended=0";
            SqlParameter[] param =
            {
                new SqlParameter("@ID", SqlDbType.Int) { Value = client_id},

            };

            dt = dbHelper.ExecuteQuery(query, param);
            // if dt not empty 
            return dt.Rows.Count > 0;
        }


    }
}
