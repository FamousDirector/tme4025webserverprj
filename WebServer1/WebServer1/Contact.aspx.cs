using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebServer1
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string path = HttpContext.Current.Request.Url.AbsolutePath;
            string subject = path.Remove(0, path.LastIndexOf('/') + 1);

            if (subject == "Trial")
            {
                Subject.Text = "Request a Trial!";
                Body.Text = "I would love to try your product!";
            }
        }
        protected void SendMail_Click(object sender, EventArgs e)
        {

        }
    }
}