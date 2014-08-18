using System;
using System.Collections.Generic;
using GECO.DomainClasses;
using GECO.Model.Data;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Repository;
using System.Linq;

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
    public void AddBasicNews()
    {
      var Uow = new UnitOfWork(new GecoModelContainer());
      var expectedNews = NewsBuilder.DefaultNewsBuilder()
        .WithName("Test News base")
        .Build();

      Uow.Repository<News>().InsertGraph(expectedNews);
      Uow.Save();

      GetAndVerifySavedNews(Uow, expectedNews);
    }

    [TestMethod]
    public void AddNewsWithAlbumDocumentsAndVideo()
    {
      using (var Uow = new UnitOfWork(new GecoModelContainer()))
      {
        var expectedNews = NewsBuilder.DefaultNewsBuilder()
           .WithName("Test News completa 1")
           .WithAlbumAndPhotos(3)
           .WithDocuments(2)
           .WithVideo()
           .Build();

        Uow.Repository<News>().InsertGraph(expectedNews);
        Uow.Save();
        GetAndVerifySavedNews(Uow, expectedNews);
      }
    }

    [TestMethod]
    public void UpdateNewsWithAlbumDocumentsAndVideo()
    {
      var expectedNews = new News();

      var name = string.Format("Test News completa {0}", new Random().Next(500));
      using (var Uow = new UnitOfWork(new GecoModelContainer()))
      {
        expectedNews = NewsBuilder.DefaultNewsBuilder()
         .WithName(name)
         .WithAlbumAndPhotos(10)
         .WithDocuments(5)
         .WithVideo()
         .Build();

        Uow.Repository<News>().InsertGraph(expectedNews);
        Uow.Save();
        GetAndVerifySavedNews(Uow, expectedNews);
      }

      using (var Uow = new UnitOfWork(new GecoModelContainer()))
      {
        var dbNews = Uow.Repository<News>().Query()
                        .Filter(n => n.Name == name)
                        .All().FirstOrDefault();

        Assert.AreEqual(dbNews.Album.Photos.Count(), 10, "Il numero di foto non è corretto");
        Assert.AreEqual(dbNews.Documents.Count(), 5, "Il numero di documenti non è corretto");

        // Aggiorno la news letta dal DB
        dbNews.Text = string.Format("Modificato il testo per la news {0}", name);
        dbNews.Album.Name = string.Format("Album name modificato per la news {0}", name);

        var firstPhoto = dbNews.Album.Photos.ToList()[0];
        firstPhoto.State = ObjectState.Deleted;

        var secondPhoto = dbNews.Album.Photos.ToList()[1];
        secondPhoto.State = ObjectState.Deleted;

        var thirdPhoto = dbNews.Album.Photos.ToList()[2];
        thirdPhoto.Name = string.Format("Foto name modificata per la foto 3 news {0}", name);
        thirdPhoto.State = ObjectState.Modified;

        dbNews.State = ObjectState.Modified;
        dbNews.Album.State = ObjectState.Modified;

        foreach (var doc in dbNews.Documents)
        {
          doc.State = ObjectState.Deleted;
        }

        dbNews.Video.State = ObjectState.Deleted;

        Uow.Repository<News>().Update(dbNews);
        Uow.Save();

        var actualNews = Uow.Repository<News>()
                      .Query()
                      .Filter(n => n.ContentId == dbNews.ContentId)
                        .OrderBy(q => q.OrderBy(n => n.Date)).All().FirstOrDefault();
        Assert.AreEqual(dbNews.Text, actualNews.Text, "Il campo text non è stato modificato");
        Assert.AreEqual(8, actualNews.Album.Photos.Count(), "Il numero di foto non è corretto");
        Assert.AreEqual(thirdPhoto.Name, actualNews.Album.Photos.Where(p => p.Id == thirdPhoto.Id).FirstOrDefault().Name,
           "Non è stato modificato il nome della foto 3");
        Assert.AreEqual(0, actualNews.Documents.Count(), "Il numero di documenti non è corretto");
        Assert.IsNull(actualNews.Video, "La cancellazione del video non è stata eseguita in modo corretto");
      }
    }

    #region Helper methods

    private static void GetAndVerifySavedNews(UnitOfWork Uow, News expectedNews)
    {
      var actualNews = Uow.Repository<News>().Query()
                      .Filter(n => n.ContentId == expectedNews.ContentId)
                      .All().FirstOrDefault();

      Assert.IsNotNull(actualNews, "Trovato un valore null per una news salvata nel database");
      Assert.AreEqual(expectedNews.ContentId, actualNews.ContentId, "Id non corrispondente");
    }

    #endregion Helper methods
  }

}
