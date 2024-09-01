using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace DriversSystem
{
    public partial class Admin_AddApplication : System.Web.UI.Page
    {
        int clientID;
        DatabaseHelper dbHelper = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            // Get Client details from session
            if (Session["ClientID_Admin"] != null)
            {
                clientID = Convert.ToInt32(Session["ClientID_Admin"]);
            }
            populateID();

            if (!IsPostBack)
            {   
                //Populate ServiceDropDown
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
                populateTimeSlot();
               
            }

        }

        protected void calendar_SelectionChanged(object sender, EventArgs e)
        {
            populateTimeSlot();
        }

        protected void populateTimeSlot()
        {

            // Get date
            string selectdate = calendar.SelectedDate.ToString("yyyy-MM-dd");

            // Query and populate
            string query = "SELECT Time_ID,CONCAT(CAST(StartTime AS VARCHAR(5)),' - ',CAST(EndTime AS VARCHAR(5))) AS TimeSlot FROM Available_Time WHERE Date = @SelectedDate AND NumPeopleAllowed > 0";

            SqlParameter[] param =
            {
                new SqlParameter("@SelectedDate", SqlDbType.Date) { Value = selectdate }
            };


            DataTable dt = dbHelper.ExecuteQuery(query, param);
            if (dt.Rows.Count > 0)
            {

                TimeslotRadioButtonList.DataSource = dt;
                TimeslotRadioButtonList.DataTextField = "TimeSlot";
                TimeslotRadioButtonList.DataValueField = "Time_ID";
                TimeslotRadioButtonList.DataBind();
                TimeslotRadioButtonList.Visible = true;
                NoTimes.Visible = false;
                TimeslotRadioButtonList.SelectedIndex = 0;
                ContinueButton.Enabled = true;
            }
            else
            {
                TimeslotRadioButtonList.Visible = false;
                NoTimes.Visible = true;
                ContinueButton.Enabled = false;
            }
        }
        protected void populateID()
        {
            string query = "SELECT IDNum FROM Client WHERE CLient_ID = @ID";
            SqlParameter[] param =
           {
                new SqlParameter("@ID", SqlDbType.Int) { Value = clientID}
            };
            using (SqlDataReader reader = dbHelper.ExecuteReader(query, param))
            {
                if (reader.Read())
                {
                    IDNumber.Text = reader["IDNum"].ToString();
                }
            }
        }

        protected void ContinueButton_Click(object sender, EventArgs e)
        {
            
            try
            {
                //Write to Application table
                string query = "INSERT INTO Application(Client_ID, Service_ID, Time_ID, isPaid, isAttended) VALUES(@clientID, @ServiceID, @Time, @Paid, @Attend)";
                SqlParameter[] param =
                {
                    new SqlParameter("@clientID", SqlDbType.Int) { Value = clientID},
                    new SqlParameter("@ServiceID", SqlDbType.Int) { Value =  ServiceDropdown.SelectedValue},
                    new SqlParameter("@Time", SqlDbType.Int) { Value =  TimeslotRadioButtonList.SelectedValue},
                    new SqlParameter("@Paid", SqlDbType.Bit) { Value =  0},
                    new SqlParameter("@Attend", SqlDbType.Bit) { Value =  0},
                 };

                int result = dbHelper.ExecuteNonQuery(query, param);

                if (result > 0)
                {
                    errorAlert.Visible = false;
                    Response.Redirect("ClientPortal_ViewDocument.aspx");
                }

                else
                {
                    errorAlert.Controls.Add(new Literal { Text = "Failed to create application" });
                    errorAlert.Visible = true;
                }

            }
            catch (Exception ex) { }
            {
                errorAlert.Controls.Add(new Literal { Text = "Failed to create application" });
                errorAlert.Visible = true;
            }

        }
    }
}