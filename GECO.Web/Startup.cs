using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(GECO.Web.Startup))]
namespace GECO.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
