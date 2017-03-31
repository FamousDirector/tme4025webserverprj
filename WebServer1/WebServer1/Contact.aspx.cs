using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
using System.Threading.Tasks;
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
            //TODO Implement Robot check

            string FROM = "inquiries@hybernate.ca";
            string TO = "james.cameron@hybernate.ca";  // Replace with a "To" address. If your account is still in the
                                                       // sandbox, this address must be verified.
            string NAME = Name.Text;
            string EMAIL = Email.Text;

            string SUBJECT = Subject.Text;
            string BODY = Body.Text;

            // Supply your SMTP credentials below. Note that your SMTP credentials are different from your AWS credentials.
            string SMTP_USERNAME = ConfigurationManager.AppSettings["SMTPUsername"];  // Replace with your SMTP username. 
            string SMTP_PASSWORD = ConfigurationManager.AppSettings["SMTPPassword"];  // Replace with your SMTP password.

            // Amazon SES SMTP host name. This example uses the US West (Oregon) region.
            string HOST = "email-smtp.us-east-1.amazonaws.com";

            // The port you will connect to on the Amazon SES SMTP endpoint. We are choosing port 587 because we will use
            // STARTTLS to encrypt the connection.
            int PORT = 587;

            SmtpClient smtpClient = new SmtpClient(HOST, PORT);

            smtpClient.Credentials = new System.Net.NetworkCredential(SMTP_USERNAME, SMTP_PASSWORD);
            //smtpClient.UseDefaultCredentials = true;
            //smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtpClient.EnableSsl = true;
            MailMessage mail = new MailMessage();

            //Setting From , To and CC
            mail.From = new MailAddress(FROM, NAME);
            mail.To.Add(new MailAddress(TO));
            mail.Subject = SUBJECT;
            mail.Body = EMAIL + " " +BODY;

            try
            {
                smtpClient.Send(mail);
                Server.Transfer("Default.aspx", true);
            }
            catch
            {

            }
        }
    }
}