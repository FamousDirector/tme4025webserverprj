using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebServer1
{
    public partial class Error1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int timezoneoffset = ExtraCommands.GetTimeZoneOffsetMinutes(Request);
            TimezoneDisplay.Text = timezoneoffset.ToString();
        }
    }
}