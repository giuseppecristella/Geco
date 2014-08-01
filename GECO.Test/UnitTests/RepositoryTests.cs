using System;
using GECO.DomainClasses;
using GECO.Model.Data;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Repository;

namespace GECO.Test
{
  [TestClass]
  public class RepositoryTests
  {


    [TestInitialize]
    public void TestInitialize()
    {

    }

    [TestCleanup]
    public void TestCleanup()
    {
      // todo: delete NorthwindTest.mfd (LocalDb)
      // cleanup all the infrastructure that was needed for our tests.
    }

    [TestMethod]
    public void InsertNewContent()
    {
      var authInfo = new AuthInfo()
      {
        Created = DateTime.Now,
        Modified = DateTime.Now,
        CreatedBy = "Test",
        ModifiedBy = "Test"
      };

      var content = new Content()
      {
        ContentId = Guid.NewGuid(),
        Name = "Name",
        LongDescription = "this is a long description",
        ShortDescription = "this is a short description",
        Text = "this is a sample text",
        AuthInfo = authInfo,
        State = ObjectState.Added
      };

      //var context = new GecoModelContainer();
      //context.Contents.Add(content);
      //context.SaveChanges();

      var Uow = new UnitOfWork(new GecoModelContainer());

      Uow.Repository<Content>().InsertGraph(content);
      Uow.Save();
    }
  }
}
