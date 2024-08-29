using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DriversSystem
{
    
    
        public partial class AdminPortal_IncomePerTimePeriod : Page
        {
            protected void Page_Load(object sender, EventArgs e)
            {
                if (!IsPostBack)
                {
                    //lblDateTime.Text = DateTime.Now.ToString("MMMM dd, yyyy HH:mm:ss");
                    //BindData();
                }
            }

            protected void FilterButton_Click(object sender, EventArgs e)
            {
                BindData();
            }

            protected void BindData()
            {
                
            }

            //private DataTable GetIncomeData(DateTime startDate, DateTime endDate)
            //{
               
            //}

            protected void gvIncomeReport_RowDataBound(object sender, GridViewRowEventArgs e)
            {
                
            }

            protected void gvIncomeReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
            {
                
            }
        }
 
}
