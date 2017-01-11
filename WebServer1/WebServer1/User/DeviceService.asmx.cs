using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Security.Principal;
using System.Web.Script.Services;

namespace WebServer1.User
{
    /// <summary>
    /// Summary description for DeviceService
    /// </summary>
    [WebService(Namespace = "WebServer1")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class DeviceService : System.Web.Services.WebService
    {
        [WebMethod]
        public List<object> fillTemperatureChart(string tempdate, string devicename, string timzoneoffset)
        {
            int offset = 0;
            try
            {
                offset = int.Parse(timzoneoffset);
            }
            catch
            {

            }


            //fill Chart (ref:http://www.c-sharpcorner.com/UploadFile/0c1bb2/spline-and-line-chart-in-Asp-Net/)
            DataSet ds = DatabaseCalls.GetTemperatureDataForChart(devicename, User.Identity.Name, tempdate);

            DataTable chartData = ds.Tables[0];

            List<string> labels = new List<string>();
            List<int> temperature = new List<int>();

            for (int count = 0; count < chartData.Rows.Count; count++)
            {
                //storing Values for X axis  
                DateTime time = (DateTime)chartData.Rows[count]["EntryTime"];                
                labels.Add(time.AddMinutes(offset).ToShortTimeString());

                //storing values for Y Axis  
                temperature.Add(Convert.ToInt32(chartData.Rows[count]["Temperature"]));
            }
            List<object> iData = new List<object>();

            iData.Add(labels);
            iData.Add(temperature);
            return iData;
        }
    }
}
