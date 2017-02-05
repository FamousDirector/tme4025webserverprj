using System;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

namespace WebServer1
{
    public partial class Site_Mobile : System.Web.UI.MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;

        protected void Page_Init(object sender, EventArgs e)
        {
            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["username"] = Page.User.Identity.Name;

            if ((System.Web.HttpContext.Current.User != null) && System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
            {
                ManagerNav.Visible = true;
                LogoutNav.Visible = true;
                DevicesNav.Visible = true;

                RegisterNav.Visible = false;
                LoginNav.Visible = false;
            }
            else
            {
                RegisterNav.Visible = true;
                LoginNav.Visible = true;

                ManagerNav.Visible = false;
                LogoutNav.Visible = false;
                DevicesNav.Visible = false;
            }

            string path = HttpContext.Current.Request.Url.AbsolutePath.ToString();
            string item = path.Remove(0, path.LastIndexOf('/') + 1);

            switch (item)
            {
                case "About":
                    AboutNav.Attributes["class"] = AboutNav.Attributes["class"] + " active";
                    break;
                case "Products":
                    ProductsNav.Attributes["class"] = ProductsNav.Attributes["class"] + " active";
                    break;
                case "Register":
                    RegisterNav.Attributes["class"] = RegisterNav.Attributes["class"] + " active";
                    break;
                case "Devices":
                    DevicesNav.Attributes["class"] = DevicesNav.Attributes["class"] + " active";
                    break;
                case "Login":
                    LoginNav.Attributes["class"] = LoginNav.Attributes["class"] + " active";
                    break;
                case "Manage":
                    ManagerNav.Attributes["class"] = ManagerNav.Attributes["class"] + " active";
                    break;
                default:
                    if (path.StartsWith("/User/Devices"))
                    {
                        DevicesNav.Attributes["class"] = DevicesNav.Attributes["class"] + " active";
                    }
                    break;
            }

        }

        protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
        }
        protected string DetermineIfActiveTab(string path, string page)
        {
            if (path == page)
            {
                return "active";
            }
            return "";
        }
    }
}