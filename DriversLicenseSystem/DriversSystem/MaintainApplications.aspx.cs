using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DriversSystem
{
    public partial class MaintainApplications : System.Web.UI.Page
    {
        DatabaseHelper dbHelper = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        private void BindData()
        {
            // Replace with actual data retrieval logic
            //var data = GetApplications();
            //ApplicationsGridView.DataSource = data;
            ApplicationsGridView.DataBind();
        }


        protected void ApplicationsGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            ApplicationsGridView.EditIndex = e.NewEditIndex;
            BindData();
        }

        protected void ApplicationsGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            ApplicationsGridView.EditIndex = -1;
            BindData();
        }

        protected void ApplicationsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = ApplicationsGridView.Rows[e.RowIndex];

            int applicationID = Convert.ToInt32(ApplicationsGridView.DataKeys[e.RowIndex].Value);
            bool isPaid = ((CheckBox)row.FindControl("IsPaidCheckBox")).Checked;
            bool isAttended = ((CheckBox)row.FindControl("IsAttendedCheckBox")).Checked;

            ApplicationsGridView.EditIndex = -1;
            BindData();
        }

        protected void ApplicationsGridView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void AddApplicationButton_Click(object sender, EventArgs e)
        {

        }
    }
}