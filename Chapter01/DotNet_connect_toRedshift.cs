using System;
using System.Data;
using System.Data.Odbc;
namespace ConnectToRedshift
{
    class Program
    {
        public static void Main(string[] args)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            // Amazon Redshift cluster end point
            string server = "cookbookcluster-2ee55abd.cvqfeilxsadl.us-west-2.redshift.amazonaws.com";
            // Port, e.g. "5439"
            string port = "5439";
            // database user.
            string masterUsername = "dbuser";
            // database password.
            string masterUserPassword = "yourPassword";
            // database name, e.g. "dev"
            string DBName = "dev";
            string query = "select * from information_schema.tables where table_schema = 'pg_catalog';";

            try
            {
                // Create the ODBC connection string.
                //Redshift ODBC Driver - 64 bits
                /*
                string connString = "Driver={Amazon Redshift (x64)};" +
                    String.Format("Server={0};Database={1};" +
                    "UID={2};PWD={3};Port={4};SSL=true;Sslmode=Require",
                    server, DBName, masterUsername,
                    masterUserPassword, port);
                */

                //Redshift ODBC Driver - 32 bits
                string connString = "Driver={Amazon Redshift (x86)};" +
                    String.Format("Server={0};Database={1};" +
                    "UID={2};PWD={3};Port={4};SSL=true;Sslmode=Require",
                    server, DBName, masterUsername,
                    masterUserPassword, port);

                // Make a connection using the psqlODBC provider.
                OdbcConnection conn = new OdbcConnection(connString);
                conn.Open();

                // Execute the query.
                string sql = query;
                OdbcDataAdapter da = new OdbcDataAdapter(sql, conn);
                da.Fill(ds);
                dt = ds.Tables[0];
                foreach (DataRow row in dt.Rows)
                {
                    Console.WriteLine(row["table_catalog"] + ", " + row["table_name"]);
                }

                conn.Close();
                Console.ReadKey();
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine(ex.Message);
            }

        }
    }
}
