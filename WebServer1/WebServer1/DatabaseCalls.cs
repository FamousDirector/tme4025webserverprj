using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WebServer1
{
    public class DatabaseCalls
    {
        public static void AddNewDeviceToDatabase(string user, string uid, string name)
        {
            using (SqlConnection myConnection = getDatabaseConnection())
            {
                using (SqlCommand myCommand = new SqlCommand())
                {
                    string cmdString = "INSERT INTO [UserDevices]" +
                        "(UserName,UID,DeviceName) VALUES (@user, @uid, @name)";
                    myCommand.Connection = myConnection;
                    myCommand.CommandText = cmdString;
                    myCommand.Parameters.AddWithValue("@user", user);
                    myCommand.Parameters.AddWithValue("@uid", uid);
                    myCommand.Parameters.AddWithValue("@name", name);

                    try
                    {
                        myCommand.ExecuteNonQuery();
                    }
                    catch (SqlException error)
                    {
                        //TODO handle error properly
                    }
                }
            }
        }

        public static void RemoveDeviceFromDatabase(string name, string user)
        {
            using (SqlConnection myConnection = getDatabaseConnection())
            {
                using (SqlCommand myCommand = new SqlCommand())
                {
                    string cmdString = "DELETE FROM [UserDevices]" +
                        "WHERE DeviceName=@name AND UserName=@user";
                    myCommand.Connection = myConnection;
                    myCommand.CommandText = cmdString;
                    myCommand.Parameters.AddWithValue("@name", name);
                    myCommand.Parameters.AddWithValue("@user", user);

                    try
                    {
                        myCommand.ExecuteNonQuery();
                    }
                    catch (SqlException error)
                    {
                        //TODO handle error properly
                    }
                }
            }
        }

        private static SqlConnection getDatabaseConnection()
        {
            //store entries in HourlyBilling DB           
            string databaseName = "HybernateDatabase";
            string server = "JAMESADCAMERON\\SQLEXPRESS";

            //create connectionString 
            string connectionString = "server =" + server + "; " +
                                       "Trusted_Connection=sspi;" + //uses the applications users credientials                                      
                                       "database=" + databaseName + "; " +
                                       "connection timeout=30";

            SqlConnection myConnection = new SqlConnection(connectionString);
            try
            {
                myConnection.Open();
                return myConnection;
            }

            catch (Exception ex)
            {
                throw new Exception("Could not connect to the database: " + ex.Message);
            }
        }
    }
}