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
    public partial class MantainServices : System.Web.UI.Page
    {
        DatabaseHelper dbHelper = new DatabaseHelper();
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                populateGridView();

        }

        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string userSearch = SearchTextBox.Text.Trim();
            
            string query = "SELECT * FROM SERVICE WHERE Service_Descr LIKE '%' + @userSearch + '%'";
            SqlParameter[] param =
            {
                new SqlParameter("@userSearch", SqlDbType.VarChar, 50) { Value = userSearch }
            };

            
            ServicesGridView.DataSource = dbHelper.ExecuteQuery(query, param);
            ServicesGridView.DataBind();
        }


        protected void SaveServiceButton_Click(object sender, EventArgs e)
        {
            // add to database
            String inputDescr = AddServiceDescr.Text;
            double inputPrice;

            try
            {
                inputPrice = double.Parse(AddPrice.Text); // Corrected parsing
                String query = "INSERT INTO Service(Service_Descr,Price) VALUES(@Descr, @Price)";
                SqlParameter[] param =
                {
                new SqlParameter("@Descr", SqlDbType.VarChar, 50) { Value = inputDescr},
                new SqlParameter("@Price", SqlDbType.SmallMoney) { Value =  inputPrice }
            };

                int result = dbHelper.ExecuteNonQuery(query, param);

                if (result > 0)
                {
                    // display Success Message
                    // display gridview with updated results
                    populateGridView();

                    // clear inputs
                    AddServiceDescr.Text = "";
                    AddPrice.Text = "";
                }
                else
                {
                    // display error message
                    AddServiceButton.Text = "Save failed";
                }
            }
            catch (SqlException sqlEx)
            {
                // Handle SQL exceptions
                AddServiceButton.Text = "SQL Error";
            }
            catch (Exception ex)
            {
                // Handle general exceptions
                AddServiceButton.Text = "Error occurred";
            }
        }

        

        protected void populateGridView(String query = "SELECT * FROM Service")
        {
            
            try
            {
                ServicesGridView.DataSource = dbHelper.ExecuteQuery(query);
                ServicesGridView.DataBind();
            }
            catch(SqlException ex) 
            { 

            }
           
        }
    }
}