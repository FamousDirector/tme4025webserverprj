using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebServer1
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void MultiView1_ActiveViewChanged(object sender, EventArgs e)
        {

        }

        protected void NextView_Tick(object sender, EventArgs e)
        {
            // Determine which button was clicked
            // and set the ActiveViewIndex property to
            // the view selected by the user.
            if (MainMultiView.ActiveViewIndex == MainMultiView.Views.Count-1)
            {
                MainMultiView.ActiveViewIndex = 0;
            }
            else
            {
                MainMultiView.ActiveViewIndex += 1;
            }
            UpdateTimer.Interval = 5000; //reset timer after press
        }

        protected void NextButton_Click(object sender, EventArgs e)
        {
            // Determine which button was clicked
            // and set the ActiveViewIndex property to
            // the view selected by the user.
            if (MainMultiView.ActiveViewIndex == MainMultiView.Views.Count-1)
            {
                MainMultiView.ActiveViewIndex = 0;
            }
            else
            {
                MainMultiView.ActiveViewIndex += 1;
            }
            UpdateTimer.Interval = 30000; //make timer longer after press
        }
        protected void BackButton_Click(object sender, EventArgs e)
        {
            if (MainMultiView.ActiveViewIndex == 0)
            {
                MainMultiView.ActiveViewIndex = MainMultiView.Views.Count-1;
            }
            else
            {
                MainMultiView.ActiveViewIndex -= 1;
            }
            UpdateTimer.Interval = 30000; //make timer longer after press
        }

        protected void StartButtonNow_Click(object sender, EventArgs e)
        {
            Server.Transfer("Products.aspx", true);
        }

        protected void TrialButton_Click(object sender, EventArgs e)
        {
            Response.RedirectToRoute("ContactRoute", new { subject = "Trial" });
        }
    }
}