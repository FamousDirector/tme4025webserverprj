using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebServer1
{
    public partial class Devices : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //determine route
            string path = HttpContext.Current.Request.Url.AbsolutePath;
            string route = path.Remove(0,path.LastIndexOf('/')+1);

            switch (route) //show view based on route
            {
                case "Devices":
                    MainMultiView.ActiveViewIndex = 0;
                    break;
                case "Add":
                    MainMultiView.ActiveViewIndex = 2;
                    break;
                case "Remove":
                    MainMultiView.ActiveViewIndex = 3;
                    break;
                default:
                    MainMultiView.ActiveViewIndex = 1;
                    UpdateDeviceView(sender, e);
                    break;
            }
            
        }
        protected void AddNewDeviceViewButton_Click(Object sender, EventArgs e)
        {
           Response.RedirectToRoute("DeviceRoute", new { device = "Add" });
        }
        protected void ShowThisDevice_Click(Object sender, EventArgs e)
        {
            string devicename = (sender as Button).Text;
            
            Response.RedirectToRoute("DeviceRoute", new { device = devicename });

        }
        protected void RemoveDeviceViewButton_Click(Object sender, EventArgs e)
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

            DatabaseCalls.AddNewDeviceToDatabase(User.Identity.Name,uid,name);

            Response.RedirectToRoute("DeviceRoute", new { device = name });
        }
        protected void RemoveDeviceButton_Click(object sender, EventArgs e)
        {
            string text = (sender as Button).Text;
            string name = text.Remove(0, text.LastIndexOf('-') + 2);

            //TODO Check if that Name exists

            DatabaseCalls.RemoveDeviceFromDatabase(name, User.Identity.Name);

            Response.Redirect(Request.RawUrl); //refresh page

        }
        protected void UpdateDeviceView(object sender, EventArgs e)
        {

        }
    }
}