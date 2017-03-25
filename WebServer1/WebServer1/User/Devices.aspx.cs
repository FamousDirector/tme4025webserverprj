using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace WebServer1
{
    public partial class Devices : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //determine route
                string path = HttpContext.Current.Request.Url.AbsolutePath;
                string route = path.Remove(0, path.LastIndexOf('/') + 1);

                switch (route) //show view based on route
                {
                    case "Devices":
                        MainMultiView.ActiveViewIndex = 0;
                        break;
                    case "Add":
                        MainMultiView.ActiveViewIndex = 2;
                        break;
                    default:
                        MainMultiView.ActiveViewIndex = 1;
                        UpdateDeviceView(sender, e);
                        break;
                }
            }
        }
        protected void AddNewDeviceViewButton_Click(object sender, EventArgs e)
        {
            Response.RedirectToRoute("DeviceRoute", new { device = "Add" });
        }
        protected void ShowThisDevice_Click(object sender, EventArgs e)
        {
            string devicename = (sender as Button).Text;

            Response.RedirectToRoute("DeviceRoute", new { device = devicename });

        }
        protected void RemoveDeviceViewButton_Click(object sender, EventArgs e)
        {
            Response.RedirectToRoute("DeviceRoute", new { device = "Remove" });
        }
        protected void UIDTextbox_TextChanged(object sender, EventArgs e)
        {
            string uid = UIDTextbox.Text;
            //TODO Check if that UID exists
            //if it does not throw error
        }
        protected void NameTextBox_TextChanged(object sender, EventArgs e)
        {
            //TODO ensure name is alpha numeric
            //TODO Check if that Name exists for this user
            //if does throw error
        }

        protected void DeviceNameTextBox_TextChanged(object sender, EventArgs e)
        {
            //TODO Check if that Name exists for this user
            //if does not throw error
        }
        protected void AddNewDeviceButton_Click(object sender, EventArgs e)
        {
            string uid = UIDTextbox.Text;
            string name = NameTextbox.Text;

            //TODO Check if that UID exists
            //TODO Check if that Name exists
            //TODO Check if UID is already taken

            DatabaseCalls.AddNewDeviceToDatabase(User.Identity.Name, uid, name);

            Response.RedirectToRoute("DeviceRoute", new { device = name });
        }
        protected void RemoveDeviceButton_Click(object sender, EventArgs e)
        {
            string path = HttpContext.Current.Request.Url.AbsolutePath;
            string devicename = path.Remove(0, path.LastIndexOf('/') + 1);

            //TODO Check if that Name exists
            //TODO Validate they are sure

            DatabaseCalls.RemoveDeviceFromDatabase(devicename, User.Identity.Name);

            Response.Redirect(path.Remove(path.LastIndexOf('/'))); //refresh page

        }
        protected void UpdateDeviceView(object sender, EventArgs e)
        {
            //add device name
            string path = HttpContext.Current.Request.Url.AbsolutePath;
            string devicename = path.Remove(0, path.LastIndexOf('/') + 1);
            DeviceNameLabel.Text = devicename;

            //timezone offset
            int timezoneoffset = ExtraCommands.GetTimeZoneOffsetMinutes(Request);

            //TODO Validate if data exists

            try
            {

                //Last Update Time
                DateTime lastupdatetimeutc = DatabaseCalls.GetNewestConnectionDate(devicename);
                LastUpdatedTime.Text = "Last connected at " + lastupdatetimeutc.AddMinutes(timezoneoffset).ToShortTimeString() + " on " + lastupdatetimeutc.AddMinutes(timezoneoffset).ToShortDateString();

                //State
                if (!Page.IsPostBack)
                {
                    if (DatabaseCalls.GetNewestDeviceState(devicename) == "ON")
                    {
                        OnChangeControllerStateButton.CssClass = "btn btn-lg btn-on";
                        OffChangeControllerStateButton.CssClass = "btn btn-lg";
                    }
                    else
                    {
                        OnChangeControllerStateButton.CssClass = "btn btn-lg";
                        OffChangeControllerStateButton.CssClass = "btn btn-lg btn-off";
                    }
                }

                //Times
                try
                {
                    DateTime offtime = DatabaseCalls.GetOffTimeValue(devicename, timezoneoffset);
                    DateTime ontime = DatabaseCalls.GetOnTimeValue(devicename, timezoneoffset);

                    NextTime.Text = "Off from: " + offtime.ToShortTimeString() + " - " + ontime.ToShortTimeString();

                    newofftime.Text = offtime.ToString("HH:mm");
                    newontime.Text = ontime.ToString("HH:mm");
                }
                catch
                {
                    NextTime.Text = "- None";
                }


                //Power
                CurrentPower.Text = DatabaseCalls.GetNewestPowerValue(devicename).ToString() + " W";

                //Temperature
                CurrentTemperature.Text = DatabaseCalls.GetNewestTemperatureValue(devicename).ToString() + " °C";
            }
            catch
            {
                LastUpdatedTime.CssClass = "alert alert-warning";
                LastUpdatedTime.Text = "This device with UID: " + DatabaseCalls.GetUIDFromDeviceName(devicename) + " has not connected to our servers yet";
            }
        }

        protected void ChangeControllerStateOn_Click(object sender, EventArgs e)
        {
            string path = HttpContext.Current.Request.Url.AbsolutePath;
            string devicename = path.Remove(0, path.LastIndexOf('/') + 1);

            OnChangeControllerStateButton.CssClass = "btn btn-lg btn-on";
            OffChangeControllerStateButton.CssClass = "btn btn-lg";
            if (DatabaseCalls.GetNewestDeviceState(devicename) == "ON")
            {
                NewPowerStateHolder.Visible = false;
                DatabaseCalls.SetNewestDeviceState(devicename, 1);
            }
            else
            {
                NewPowerStateHolder.Visible = true;
                ChangeControllerStateLabel.Text = devicename + " will turn on after its next connection.";
                DatabaseCalls.SetNewestDeviceState(devicename, 1);
            }
        }
        protected void ChangeControllerStateOff_Click(object sender, EventArgs e)
        {
            string path = HttpContext.Current.Request.Url.AbsolutePath;
            string devicename = path.Remove(0, path.LastIndexOf('/') + 1);

            OnChangeControllerStateButton.CssClass = "btn btn-lg";
            OffChangeControllerStateButton.CssClass = "btn btn-lg btn-off";

            if (DatabaseCalls.GetNewestDeviceState(devicename) == "OFF")
            {
                NewPowerStateHolder.Visible = false;
                DatabaseCalls.SetNewestDeviceState(devicename, 0);
            }
            else
            {
                NewPowerStateHolder.Visible = true;
                ChangeControllerStateLabel.Text = devicename + " will turn off after its next connection.";
                DatabaseCalls.SetNewestDeviceState(devicename, 0);
            }
        }
        protected void ChangeScheduleButton_Click(object sender, EventArgs e)
        {
            if (SetNewScheduleButton.Visible == false)
            {
                ChangeScheduleButton.CssClass = "btn btn-sm btn-off inline-blocks pull-right";
                SetNewScheduleButton.Visible = true;
                newSchedule.Visible = true;
            }
            else
            {
                ChangeScheduleButton.CssClass = "btn btn-sm inline-blocks pull-right";
                SetNewScheduleButton.Visible = false;
                newSchedule.Visible = false;
            }
        }
        protected void SetNewScheduleButton_Click(object sender, EventArgs e)
        {
            string path = HttpContext.Current.Request.Url.AbsolutePath;
            string devicename = path.Remove(0, path.LastIndexOf('/') + 1);

            int timezoneoffset = ExtraCommands.GetTimeZoneOffsetMinutes(Request);

            ChangeScheduleButton.CssClass = "btn btn-sm inline-blocks pull-right";
            SetNewScheduleButton.Visible = false;

            newSchedule.Visible = false;

            string offtime = Request.Form[newofftime.UniqueID];
            string ontime = Request.Form[newontime.UniqueID];

            DatabaseCalls.SetOffTimeValue(offtime, devicename, timezoneoffset);
            DatabaseCalls.SetOnTimeValue(ontime, devicename, timezoneoffset);

        }
        protected void ShowTempStatsButton_Click(object sender, EventArgs e)
        {
            if (TemperatureChartHolder.Visible == false)
            {
                ShowTempStatsButton.CssClass = "btn btn-sm btn-off inline-blocks pull-right";
                TemperatureChartHolder.Visible = true;
            }
            else
            {
                ShowTempStatsButton.CssClass = "btn btn-sm inline-blocks pull-right";
                TemperatureChartHolder.Visible = false;
            }
        }
        protected void ShowPowerStatsButtonButton_Click(object sender, EventArgs e)
        {
            if (PowerChartHolder.Visible == false)
            {
                ShowPowerStatsButton.CssClass = "btn btn-sm btn-off inline-blocks pull-right";
                PowerChartHolder.Visible = true;
            }
            else
            {
                ShowPowerStatsButton.CssClass = "btn btn-sm inline-blocks pull-right";
                PowerChartHolder.Visible = false;
            }
        }
    }
}