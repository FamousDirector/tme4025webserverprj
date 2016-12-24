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
        protected void AddNewDeviceButton_Click(Object sender, EventArgs e)
        {

        }
        protected void ShowThisDevice_Click(Object sender, EventArgs e)
        {

        }
    }
}