using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Configuration;

namespace DriversSystem
{
    public class DatabaseHelper
    {
        private static string connString;

         static DatabaseHelper()
        {
            connString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        }

        public DataTable ExecuteQuery(string query, SqlParameter[] param = null)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (param != null)
                    {
                        cmd.Parameters.AddRange(param);
                    }

                    conn.Open();

                    using (SqlDataAdapter adap = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adap.Fill(dt);
                        return dt;
                    }
                }
            }
        }

    }
}
        
