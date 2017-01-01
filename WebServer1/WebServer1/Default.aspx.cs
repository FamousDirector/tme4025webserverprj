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

        protected void NextButton_Click(object sender, EventArgs e)
        {
            // Determine which button was clicked
            // and set the ActiveViewIndex property to
            // the view selected by the user.
            if (MainMultiView.ActiveViewIndex > -1 & MainMultiView.ActiveViewIndex <= 1)
            {
                // Increment the ActiveViewIndex property 
                // by one to advance to the next view.
                MainMultiView.ActiveViewIndex += 1;
            }
            else if (MainMultiView.ActiveViewIndex == 2)
            {
                //restart index
                MainMultiView.ActiveViewIndex = 0;
            }
            else
            {
                throw new Exception("An error occurred.");
            }
        }
        protected void BackButton_Click(object sender, EventArgs e)
        {
            if (MainMultiView.ActiveViewIndex > 0 & MainMultiView.ActiveViewIndex <= 2)
            {
                // Decrement the ActiveViewIndex property
                // by one to return to the previous view.
                MainMultiView.ActiveViewIndex -= 1;
            }
            else if (MainMultiView.ActiveViewIndex == 0)
            {
                MainMultiView.ActiveViewIndex = 2;
            }
            else
            {
                throw new Exception("An error occurred.");
            }
        }
    }
}