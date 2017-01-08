using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebServer1
{
    public class ExtraCommands
    {        public static int GetTimeZoneOffset(HttpRequest Request)
        {
            // Default to the server time zone
            TimeZone tz = TimeZone.CurrentTimeZone;
            TimeSpan ts = tz.GetUtcOffset(DateTime.Now);
            int result = (int)ts.TotalMinutes;
            // Then check for client time zone (minutes) in a cookie
            HttpCookie cookie = Request.Cookies["ClientTimeZone"];
            if (cookie != null)
            {
                int clientTimeZone;
                if (int.TryParse(cookie.Value, out clientTimeZone))
                    result = clientTimeZone;
            }
            return result;
        }
    }
}