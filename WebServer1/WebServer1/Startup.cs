using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(WebServer1.Startup))]
namespace WebServer1
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
