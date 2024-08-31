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
        int clientID;
        DatabaseHelper dbHelper = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            // Get Client details from session
            if (Session["Client_ID"] != null)
            {
               clientID = Convert.ToInt32(Session["Client_ID"]);
            }
            if (Session["IDNumber"] != null)
            {
                IDNumber.Text = Session["IDNumber"].ToString();
            }

             //Populate ServiceDropDown
             ServiceDropdown.Items.Clear();
            String query = "SELECT Service_ID, Service_Descr FROM Service ORDER BY Service_Descr ASC";
            using (SqlDataReader reader = dbHelper.ExecuteReader(query))
            {
                while (reader.Read())
                {
                    String Service_id = reader["Service_ID"].ToString();
                    String Service_descr = reader["Service_Descr"].ToString();
                    ServiceDropdown.Items.Add(new ListItem(Service_descr, Service_id));
                }
            }
        }

        protected void calendar_SelectionChanged(object sender, EventArgs e)
        {
            populateTimeSlot();
        }

        protected void populateTimeSlot()
        {
            TimeslotRadioButtonList.DataSource = null;
            TimeslotRadioButtonList.DataBind();
            // Get date
            string selectdate = calendar.SelectedDate.ToString("yyyy-MM-dd");

            ContinueButton.Text = selectdate;

            string query = "SELECT Time_ID,StartTime FROM Available_Time WHERE Date = @SelectedDate AND NumPeopleAllowed > 0";

            SqlParameter[] param =
            {
                new SqlParameter("@SelectedDate", SqlDbType.Date) { Value = selectdate }
            };

            DataTable dt = dbHelper.ExecuteQuery(query, param);
            if (dt.Rows.Count > 0)
            {
                TimeslotRadioButtonList.DataSource = dt;
                TimeslotRadioButtonList.DataTextField = "StartTime"; 
                TimeslotRadioButtonList.DataValueField = "Time_ID";
                TimeslotRadioButtonList.DataBind();
            }
            else
            {
                TimeslotRadioButtonList.Visible = false;
                ContinueButton.Text = "No available times for the selected date.";
            }
        }
        
         protected void ContinueButton_Click(object sender, EventArgs e)
        {
            


                //Write to Application table
                string query = "INSERT INTO Application(Client_ID, Service_ID, Time_ID, isPaid, isAttend) VALUES(@clientID, @ServiceID, @Time, @Paid, @Attend)";
                SqlParameter[] param =
                {
                new SqlParameter("@clientID", SqlDbType.Int) { Value = clientID},
                new SqlParameter("@ServiceID", SqlDbType.Int) { Value =  ServiceDropdown.SelectedValue},
                new SqlParameter("@Time", SqlDbType.Int) { Value =  0},
                new SqlParameter("@Paid", SqlDbType.Bit) { Value =  0},
                new SqlParameter("@Attend", SqlDbType.Bit) { Value =  0},
                 };

                dbHelper.ExecuteNonQuery(query, param);

                Response.Redirect("ClientPortal_ViewDocument.aspx");
            
        }
    }
}