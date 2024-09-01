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
    public partial class ClientPortal_ViewDocument : System.Web.UI.Page
    {
        DatabaseHelper dbHelper = new DatabaseHelper();
        int id = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["Client_ID"] != null)
            {
                id = Convert.ToInt32(Session["Client_ID"].ToString());

            }
            if (!IsPostBack)
            {
                populateClient();
                populateApplication();
            }
        }

        protected void populateClient()
        {
            // populate client info
            String query = "SELECT IDNum, Name, Surname FROM Client WHERE Client_ID = @ID";

            SqlParameter[] param =
            {
                    new SqlParameter("@ID", SqlDbType.Int) { Value = id}
                };

            using (SqlDataReader reader = dbHelper.ExecuteReader(query, param))
            {
                if (reader.Read())
                {
                    IDNumberLabel.Text = reader["IDNum"].ToString();
                    NameLabel.Text = reader["Name"].ToString();
                    SurnameLabel.Text = reader["Surname"].ToString();
                }
            }
        }
        protected void populateApplication()
        {

            // populate application info
            string query = @"
                SELECT 
                    S.Service_Descr,FORMAT(T.Date, 'yyyy-MM-dd') AS Date, CONCAT(CAST(StartTime AS VARCHAR(5)),' - ',CAST(EndTime AS VARCHAR(5))) AS TimeSlot
                FROM 
                    Application A
                JOIN 
                    Service S ON A.Service_ID = S.Service_ID
                JOIN 
                    Available_Time T ON A.Time_ID = T.Time_ID
                WHERE 
                    A.Client_ID = @ID";
            SqlParameter[] param =
           {
                    new SqlParameter("@ID", SqlDbType.Int) { Value = id}
           };

            using (SqlDataReader reader = dbHelper.ExecuteReader(query, param))
            {
                if (reader.Read())
                {
                    ServiceLabel.Text = reader["Service_Descr"].ToString();
                    DateLabel.Text = reader["Date"].ToString();
                    TimeslotLabel.Text = reader["TimeSlot"].ToString();
                }
            }
        }
        protected void continueButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("ClientPortal_Menu.aspx");
        }
    }
}
