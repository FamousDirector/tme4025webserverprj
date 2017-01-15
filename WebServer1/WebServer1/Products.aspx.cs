using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebServer1
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void NextReivew_Tick(object sender, EventArgs e)
        {
            // Determine which button was clicked
            // and set the ActiveViewIndex property to
            // the view selected by the user.
            if (CustomerReviewMultiView.ActiveViewIndex == CustomerReviewMultiView.Views.Count-1)
            {
                CustomerReviewMultiView.ActiveViewIndex = 0;
            }
            else
            {
                CustomerReviewMultiView.ActiveViewIndex += 1;
            }
            CustomerReviewUpdateTimer.Interval = 5000; //reset timer after press
        }

        protected void NextReivewButton_Click(object sender, EventArgs e)
        {
            // Determine which button was clicked
            // and set the ActiveViewIndex property to
            // the view selected by the user.
            if (CustomerReviewMultiView.ActiveViewIndex == CustomerReviewMultiView.Views.Count-1)
            {
                CustomerReviewMultiView.ActiveViewIndex = 0;
            }
            else
            {
                CustomerReviewMultiView.ActiveViewIndex += 1;
            }
            CustomerReviewUpdateTimer.Interval = 30000; //make timer longer after press
        }
        protected void LastReivewButton_Click(object sender, EventArgs e)
        {
            if (CustomerReviewMultiView.ActiveViewIndex == 0)
            {
                CustomerReviewMultiView.ActiveViewIndex = CustomerReviewMultiView.Views.Count-1;
            }
            else
            {
                CustomerReviewMultiView.ActiveViewIndex -= 1;
            }
            CustomerReviewUpdateTimer.Interval = 30000; //make timer longer after press
        }
    }
}