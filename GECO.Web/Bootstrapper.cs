using System.Web.Mvc;
using GECO.Web.Infrastructure.ModelMetadata;
using GECO.Web.Infrastructure.ModelMetadata.Filters;
using GECO.Model.Data;
using Microsoft.Practices.Unity;
using Repository;
using Unity.Mvc4;

namespace GECO.Web
{
  public static class Bootstrapper
  {
    public static IUnityContainer Initialise()
    {
      var container = BuildUnityContainer();

      DependencyResolver.SetResolver(new UnityDependencyResolver(container));

      return container;
    }

    private static IUnityContainer BuildUnityContainer()
    {
      var container = new UnityContainer();

      // Override di DataAnnotationModelMetadata
      IModelMetadataFilter[] modelMetadataFilter = new IModelMetadataFilter[] 
      {
        new LabelConventionFilter(), 
        new TextAreaByNameFilter() 
      };
      container.RegisterInstance(typeof(ModelMetadataProvider), new ExtensibleModelMetadataProvider(modelMetadataFilter));

      // register all your components with the container here
      // it is NOT necessary to register your controllers

      // e.g. container.RegisterType<ITestService, TestService>();    
      RegisterTypes(container);

      return container;
    }

    public static void RegisterTypes(IUnityContainer container)
    {
      container.RegisterType<IUnitOfWork, UnitOfWork>(new HierarchicalLifetimeManager());
      container.RegisterType<IDbContext, GecoModelContainer>();
    }
  }
}