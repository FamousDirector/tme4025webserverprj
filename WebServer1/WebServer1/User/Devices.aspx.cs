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
            Session["username"] = User.Identity.Name;
        }
        protected void AddNewDeviceViewButton_Click(Object sender, EventArgs e)
        {
            MainMultiView.ActiveViewIndex = 2;
        }
        protected void ShowThisDevice_Click(Object sender, EventArgs e)
        {
            MainMultiView.ActiveViewIndex = 1;
        }
        protected void UIDTextbox_TextChanged(object sender, EventArgs e)
        {
            //TODO Check if that UID exists
        }
        protected void NameTextBox_TextChanged(object sender, EventArgs e)
        {
            //TODO Check if that Name exists
        }
        protected void AddNewDeviceButton_Click(object sender, EventArgs e)
        {

        }
    }
}