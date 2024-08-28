using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data;

namespace DriversSystem
{
    public partial class ClientPortal_AddApplicationDetails : System.Web.UI.Page
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

            //Populate ServiceDropDown
            ServiceDropdown.Items.Clear();
            String query = "SELECT Service_Descr FROM Service";
            using (SqlDataReader reader = dbHelper.ExecuteReader(query))
            {
                while (reader.Read())
                {
                    String Service = reader["Service_Descr"].ToString();
                    ServiceDropdown.Items.Add(Service);
                }
            }

        }

        protected void ContinueButton_Click(object sender, EventArgs e)
        {
            //Get ClientID
            int ClientID = 0;
            String query = "SELECT ID_Num,Client_ID FROM Client";
            using (SqlDataReader reader = dbHelper.ExecuteReader(query))
            {
                if (Session["IDNumber"] == reader["ID_Num"])
                {
                    ClientID = int.Parse(reader["Client_ID"].ToString());
                }
                else
                {
                    reader.Read();
                }
            }

            //Get ServiceID
            int ServiceID = 0;
            query = "SELECT Service_Descr, Service_ID FROM Service";
            using (SqlDataReader reader = dbHelper.ExecuteReader(query))
            {
                if (reader["Service_Descr"] == ServiceDropdown.SelectedItem.ToString())
                {
                    ServiceID = int.Parse(reader["Service_ID"].ToString());
                }
                else
                {
                    reader.Read();
                }
            }

            //Write to Application table
            query = "INSERT INTO Application(Client_ID, Service_ID, Time_ID, isPaid, isAttend) VALUES(@ClientID, @ServiceID, @Time, @Paid, @Attend)";
            SqlParameter[] param =
            {
                new SqlParameter("@ClientID", SqlDbType.Int) { Value = ClientID},
                new SqlParameter("@ServiceID", SqlDbType.Int) { Value =  ServiceID},
                new SqlParameter("@Time", SqlDbType.Int) { Value =  0},
                new SqlParameter("@Paid", SqlDbType.Bit) { Value =  0},
                new SqlParameter("@Attend", SqlDbType.Bit) { Value =  0},
            };

            dbHelper.ExecuteNonQuery(query, param);

            Response.Redirect("");
        }
    }
}