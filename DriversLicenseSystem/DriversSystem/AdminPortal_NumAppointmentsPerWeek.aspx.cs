using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DriversSystem
{
    public partial class AdminPortal_NumAppointmentsPerWeek : System.Web.UI.Page
    {


        private int totalAppointments = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblDateTime.Text = DateTime.Now.ToString("MM/dd/yyyy hh:mm tt");
                BindGridView();
            }
        }

        private void BindGridView(string startDate = null, string endDate = null, int pageIndex = 0)
        {

        }

        protected void gvAppointmentsReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void gvAppointmentsReport_RowDataBound(object sender, GridViewRowEventArgs e)
        {








        }

        protected void FilterButton_Click(object sender, EventArgs e)
        {

        }

        protected void gvAppointmentsReport_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}