using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DriversSystem
{
    public partial class MantainServices : System.Web.UI.Page
    {
        DatabaseHelper dbHelper = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            String query = "SELECT * FROM Service";
            ServicesGridView.DataSource = dbHelper.ExecuteQuery(query);
            ServicesGridView.DataBind();

        }
    }
}