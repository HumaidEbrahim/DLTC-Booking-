using System;
using System.Collections.Generic;
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                String id = "";

                if (Session["Client_ID"] == null)
                {
                    id = Session["Client_ID"].ToString();

                }
                String query = "SELECT ID_Num, Name, Surname FROM Client WHERE Client_ID = " + id;
                using (SqlDataReader reader = dbHelper.ExecuteReader(query))
                {
                    while (reader.Read())
                    {
                        String Name = reader["Name"].ToString();
                        String ID_Num = reader["ID_Num"].ToString();
                        String Surname = reader["Surname"].ToString();
                        NameLabel.Text = Name;
                        SurnameLabel.Text = Surname;
                        IDNumberLabel.Text = ID_Num;
                    }
                }

                query = "SELECT Client_ID, Time_ID, Service_ID, isAttended FROM Application WHERE Client_ID = " + Session["Client_ID"] + " ";
                using (SqlDataReader reader = dbHelper.ExecuteReader(query))
                {
                    while (reader.Read())
                    {
                        Session["Service_ID"] = reader["Service_ID"];
                        Session["Time_ID"] = reader["Time_ID"];
                    }
                }

                query = "SELECT Service_ID, Service_Descr FROM Service WHERE Service_ID = " + Session["Service_ID"] + " ";
                using (SqlDataReader reader = dbHelper.ExecuteReader(query))
                {
                    while (reader.Read())
                    {
                        String Service = reader["Service_Descr"].ToString();
                        ServiceLabel.Text = Service;
                    }
                }

                query = "SELECT Time_ID, Date, StartTime, EndTime FROM Available_Time WHERE Time_ID = " + Session["Time_ID"] + " ";
                using (SqlDataReader reader = dbHelper.ExecuteReader(query))
                {
                    while (reader.Read())
                    {
                        String StartTime = reader["StartTime"].ToString();
                        String EndTime = reader["EndTime"].ToString();
                        String Date = reader["Date"].ToString();
                        DateLabel.Text = Date;
                        TimeslotLabel.Text = StartTime + " - " + EndTime;
                    }
                }
            }
        }

        protected void PrintButton_Click(object sender, EventArgs e)
        {

        }
    }
}