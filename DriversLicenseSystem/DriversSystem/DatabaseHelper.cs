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
            // gets conn string from web.config
            connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        }

        // Execute Query: sql select
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

        // Exectute non query: insert, update, delete
        public int ExecuteNonQuery(string query, SqlParameter[] param = null)
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
                    return cmd.ExecuteNonQuery();
                }
            }
        }

        //Execute reader
        public SqlDataReader ExecuteReader(string query, SqlParameter[] param = null)
        {
            SqlConnection conn = new SqlConnection(connString);
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                if (param != null)
                {
                    cmd.Parameters.AddRange(param);
                }

                conn.Open();
                return cmd.ExecuteReader(); 
            }
        }


    }
}
        
