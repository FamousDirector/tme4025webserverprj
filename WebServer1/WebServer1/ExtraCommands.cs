using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebServer1
{
    public class ExtraCommands
    {        public static int GetTimeZoneOffsetMinutes(HttpRequest Request)
        {
            int result = 1;
            // check for client time zone (minutes) in a cookie
            HttpCookie cookie = Request.Cookies["timezoneoffset"];
            if (cookie != null)
            {
                int clientTimeZone;
                if (int.TryParse(cookie.Value, out clientTimeZone))
                    result = clientTimeZone;
            }
            return -result;
        }
    }
}