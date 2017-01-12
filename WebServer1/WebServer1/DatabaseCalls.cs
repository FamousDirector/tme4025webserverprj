using System;
using System.Collections.Generic;
using System.Data;
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

        internal static DataSet GetPowerDataForChart(string devicename, string name, string date)
        {
            //TODO Add other variables to get more useable data
            string UID = getUIDFromDeviceName(devicename);
            DateTime daterangelower = new DateTime();
            try
            {
                daterangelower = DateTime.Parse(date).AddDays(-1);
            }
            catch
            {
                daterangelower = DateTime.Today;
            }
            DateTime daterangeup = daterangelower.AddDays(3);
            string date1 = daterangelower.ToString("yyyy-MM-dd h:mm tt");
            string date2 = daterangeup.ToString("yyyy-MM-dd h:mm tt");


            DataSet ds = new DataSet();
            using (SqlConnection myConnection = getDatabaseConnection())
            {
                using (SqlCommand myCommand = new SqlCommand())
                {
                    string cmdString = "SELECT Power,EntryTime FROM [ControllerDataTable] WHERE UID=@uid AND EntryTime>=@date1 AND EntryTime<@date2 ORDER BY EntryTime";
                    myCommand.Connection = myConnection;
                    myCommand.CommandText = cmdString;
                    myCommand.Parameters.AddWithValue("@uid", UID);
                    myCommand.Parameters.AddWithValue("@date1", date1);
                    myCommand.Parameters.AddWithValue("@date2", date2);

                    try
                    {
                        SqlDataAdapter da = new SqlDataAdapter(myCommand);
                        da.Fill(ds);
                    }
                    catch (SqlException error)
                    {
                        //TODO handle error properly
                    }
                }
            }
            return ds;
        }

        internal static DataSet GetTemperatureDataForChart(string devicename, string name, string date)
        {
            //TODO Add other variables to get more useable data
            string UID = getUIDFromDeviceName(devicename);
            DateTime daterangelower = new DateTime();
            try
            {
                daterangelower = DateTime.Parse(date).AddDays(-1);

            }
            catch
            {
                daterangelower = DateTime.Today;
            }
            DateTime daterangeup = daterangelower.AddDays(3);
            string date1 = daterangelower.ToString("yyyy-MM-dd h:mm tt");
            string date2 = daterangeup.ToString("yyyy-MM-dd h:mm tt");


            DataSet ds = new DataSet();
            using (SqlConnection myConnection = getDatabaseConnection())
            {
                using (SqlCommand myCommand = new SqlCommand())
                {
                    string cmdString = "SELECT Temperature,EntryTime FROM [ControllerDataTable] WHERE UID=@uid AND EntryTime>=@date1 AND EntryTime<@date2 ORDER BY EntryTime";
                    myCommand.Connection = myConnection;
                    myCommand.CommandText = cmdString;
                    myCommand.Parameters.AddWithValue("@uid", UID);
                    myCommand.Parameters.AddWithValue("@date1", date1);
                    myCommand.Parameters.AddWithValue("@date2", date2);

                    try
                    {
                        SqlDataAdapter da = new SqlDataAdapter(myCommand);
                        da.Fill(ds);
                    }
                    catch (SqlException error)
                    {
                        //TODO handle error properly
                    }
                }
            }
            return ds;
        }

        private static string getUIDFromDeviceName(string devicename)
        {
            string deviceuid = "";
            using (SqlConnection myConnection = getDatabaseConnection())
            {
                using (SqlCommand myCommand = new SqlCommand())
                {
                    string cmdString = "Select UID FROM [UserDevices] WHERE DeviceName=@devicename";
                    myCommand.Connection = myConnection;
                    myCommand.CommandText = cmdString;
                    myCommand.Parameters.AddWithValue("@devicename", devicename);

                    try
                    {
                        using (SqlDataReader myReader = myCommand.ExecuteReader())
                        {
                            if (myReader.Read())
                            {
                                deviceuid = (string.Format("{0}", myReader["UID"]));
                            }
                        }
                    }
                    catch (SqlException error)
                    {
                        //TODO handle error properly
                    }
                }
            }
            return deviceuid;
        }

        internal static DateTime GetNewestConnectionDate(string devicename)
        {
            DateTime maxdate = new DateTime();
            string deviceuid = getUIDFromDeviceName(devicename);
            using (SqlConnection myConnection = getDatabaseConnection())
            {
                using (SqlCommand myCommand = new SqlCommand())
                {
                    string cmdString = "SELECT MAX(EntryTime) FROM [ControllerDataTable] WHERE uid=@deviceuid";
                    myCommand.Connection = myConnection;
                    myCommand.CommandText = cmdString;
                    myCommand.Parameters.AddWithValue("@deviceuid", deviceuid);

                    try
                    {
                        maxdate = (DateTime)myCommand.ExecuteScalar();
                    }
                    catch (SqlException error)
                    {
                        //TODO handle error properly
                    }
                }
            }
            return maxdate;
        }
        internal static string GetNewestDeviceState(string devicename)
        {
            string state = "OFF";
            int st = 0;

            DateTime date = GetNewestConnectionDate(devicename);
            string deviceuid = getUIDFromDeviceName(devicename);
            
            using (SqlConnection myConnection = getDatabaseConnection())
            {
                using (SqlCommand myCommand = new SqlCommand())
                {
                    string cmdString = "SELECT RelayState FROM [ControllerDataTable] WHERE uid=@deviceuid AND EntryTime >= @date";
                    myCommand.Connection = myConnection;
                    myCommand.CommandText = cmdString;
                    myCommand.Parameters.AddWithValue("@deviceuid", deviceuid);
                    myCommand.Parameters.AddWithValue("@date", date.ToString("yyyy-MM-dd h:mm tt"));
                    try
                    {
                        st = (int)myCommand.ExecuteScalar();
                        if(st == 1)
                        {
                            state = "ON";
                        }
                        else
                        {
                            state = "OFF";

                        }
                    }
                    catch (SqlException error)
                    {
                        //TODO handle error properly
                    }
                }
            }
            return state;
        }
        internal static int GetNewestPowerValue(string devicename)
        {
            int power = 0;

            DateTime date = GetNewestConnectionDate(devicename);
            string deviceuid = getUIDFromDeviceName(devicename);

            using (SqlConnection myConnection = getDatabaseConnection())
            {
                using (SqlCommand myCommand = new SqlCommand())
                {
                    string cmdString = "SELECT Power FROM [ControllerDataTable] WHERE uid=@deviceuid AND EntryTime >= @date";
                    myCommand.Connection = myConnection;
                    myCommand.CommandText = cmdString;
                    myCommand.Parameters.AddWithValue("@deviceuid", deviceuid);
                    myCommand.Parameters.AddWithValue("@date", date.ToString("yyyy-MM-dd h:mm tt"));
                    try
                    {
                        power = (int)myCommand.ExecuteScalar();

                    }
                    catch (SqlException error)
                    {
                        //TODO handle error properly
                    }
                }
            }
            return power;
        }
        internal static int GetNewestTemperatureValue(string devicename)
        {
            int temperature = 0;

            DateTime date = GetNewestConnectionDate(devicename);
            string deviceuid = getUIDFromDeviceName(devicename);

            using (SqlConnection myConnection = getDatabaseConnection())
            {
                using (SqlCommand myCommand = new SqlCommand())
                {
                    string cmdString = "SELECT Temperature FROM [ControllerDataTable] WHERE uid=@deviceuid AND EntryTime >= @date";
                    myCommand.Connection = myConnection;
                    myCommand.CommandText = cmdString;
                    myCommand.Parameters.AddWithValue("@deviceuid", deviceuid);
                    myCommand.Parameters.AddWithValue("@date", date.ToString("yyyy-MM-dd h:mm tt"));
                    try
                    {
                        temperature = (int)myCommand.ExecuteScalar();

                    }
                    catch (SqlException error)
                    {
                        //TODO handle error properly
                    }
                }
            }
            return temperature;
        }
    }
}