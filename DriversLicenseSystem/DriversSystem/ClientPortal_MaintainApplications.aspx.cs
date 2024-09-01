using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Collections;

namespace DriversSystem
{
    public partial class ClientPortal_MaintainApplications : System.Web.UI.Page
    {
        int AppID;
        DatabaseHelper dbHelper = new DatabaseHelper();
        int ClientID;
        protected void Page_Load(object sender, EventArgs e)
        {
            Service.Items.Clear();
                String query = "SELECT Service_ID, Service_Descr FROM Service ORDER BY Service_Descr ASC";
                using (SqlDataReader reader = dbHelper.ExecuteReader(query))
                {
                    while (reader.Read())
                    {
                        String Service_id = reader["Service_ID"].ToString();
                        String Service_descr = reader["Service_Descr"].ToString();
                        Service.Items.Add(new ListItem(Service_descr, Service_id));
                    }
                }
        }

        protected void DeleteConfirmButton_Click(object sender, EventArgs e)
        {
            AppID = Convert.ToInt32(ApplicationID.Text);
            string query = "DELETE FROM Application WHERE AppID = @ID";
            SqlParameter[] param =
            {
                new SqlParameter("@ID", SqlDbType.Int) { Value = ClientID}
            };

            int result = dbHelper.ExecuteNonQuery(query, param);

            if (result > 0)
            {
                Response.Redirect("ClientPortal.aspx");
            }
        }

        protected void DeleteButton_click(object sender, EventArgs e)
        {

        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {


            if (Page.IsValid)
            {
                SaveButton.Visible = true;

            }
        }
        protected void SaveButton_Click(object sender, EventArgs e)
        {
            ClientID = Convert.ToInt32(Session["Client_ID"]);
            String service = Service.SelectedItem.ToString();
            String date = ApplicationDate.Text;
            String Time = ApplicationTime.Text;

            //gets new service id from service list
            String query = "SELECT Service_ID, Service_Descr FROM Service WHERE Service_Descr = " + Service.SelectedItem.ToString();
            using (SqlDataReader reader = dbHelper.ExecuteReader(query))
            {
                while (reader.Read())
                {
                    Session["Service_ID"] = reader["Service_ID"];
                }
            }

            query = "UPDATE Application SET Service_ID=@service, Time_ID = ... WHERE Client_ID= " + Session["Client_ID"];

            SqlParameter[] param =
            {
                    new SqlParameter("@service", SqlDbType.VarChar, 35) { Value = Session["Service_ID"] },
                    new SqlParameter("@date", SqlDbType.VarChar, 35) { Value = date },
                    new SqlParameter("@Time", SqlDbType.Char, 10) { Value = Time },
                };
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {

        }
    }
}