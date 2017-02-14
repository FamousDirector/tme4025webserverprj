using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace WebServer1
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings);

            routes.MapPageRoute("DeviceRoute",
            "User/Devices/{device}",
            "~/User/Devices.aspx", true,
            new RouteValueDictionary {
                { "device", "^[a-zA-Z0-9]*$" } });

            routes.MapPageRoute("ContactRoute",
            "Contact/{subject}",
            "~/Contact.aspx", true,
            new RouteValueDictionary {
                { "subject", "^[a-zA-Z0-9]*$" } });
        }
    }
}
