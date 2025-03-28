﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DriversSystem
{
    public partial class Admin_MaintainApplications : System.Web.UI.Page
    {
        int id;
        DatabaseHelper dbHelper = new DatabaseHelper();
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            // Get Client details from session
            if (Session["ApplicationID"] != null)
            {
                id = Convert.ToInt32(Session["ApplicationID"]);
            }
            
            if (!IsPostBack)
            {
                ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.WebForms;
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

            }
            else
            {
                TimeslotRadioButtonList.Visible = false;
                NoTimes.Visible = true;

            }
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            DeleteButton.Visible = false;
            UpdateButton.Visible = false;
            SaveButton.Visible = true;
            FormState.Enabled = true;
        }

        protected void DeleteConfirmButton_Click(object sender, EventArgs e)
        {
            string query = "DELETE FROM Application WHERE Application_ID = @ID";
            SqlParameter[] param =
            {
                    new SqlParameter("@ID", SqlDbType.Int) { Value = id}
                };

            int result = dbHelper.ExecuteNonQuery(query, param);

            if (result > 0)
            {
                Response.Redirect("ClientPortal_Menu.aspx");
            }
            else
            {
                errorAlert.Controls.Add(new Literal { Text = "Failed to delete application" });
                errorAlert.Visible = true;
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            try
            {
                //Update Application table
                string query = "UPDATE Application SET Service_ID=@ServiceID, Time_ID=@Time WHERE Application_ID = @ID";
                SqlParameter[] param =
                {
                    new SqlParameter("@ID", SqlDbType.Int) { Value = id},
                    new SqlParameter("@ServiceID", SqlDbType.Int) { Value =  ServiceDropdown.SelectedValue},
                    new SqlParameter("@Time", SqlDbType.Int) { Value =  TimeslotRadioButtonList.SelectedValue}
                 };

                int result = dbHelper.ExecuteNonQuery(query, param);

                if (result > 0)
                {
                    errorAlert.Visible = false;
                    Response.Redirect("MaintainApplications.aspx");
                }

                else
                {
                    errorAlert.Controls.Add(new Literal { Text = "Failed to update application" });
                    errorAlert.Visible = true;
                }

            }
            catch (Exception)
            {
                errorAlert.Controls.Add(new Literal { Text = "Failed to update application" });
                errorAlert.Visible = true;
            }


        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            string query = "DELETE FROM Application WHERE Application_ID = @ID";
            SqlParameter[] param =
            {
                    new SqlParameter("@ID", SqlDbType.Int) { Value = id}
                };

            int result = dbHelper.ExecuteNonQuery(query, param);

            if (result > 0)
            {
                Response.Redirect("MaintainApplications.aspx");
            }
            else
            {
                errorAlert.Controls.Add(new Literal { Text = "Failed to delete application" });
                errorAlert.Visible = true;
            }
        }
    }
}
