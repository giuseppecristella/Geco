using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GECO.DomainClasses;

namespace GECO.Test
{
  public class NewsBuilder
  {
    private string _name = "Name";

    public NewsBuilder()
    {
      _news = new News();
      _news.ContentId = Guid.NewGuid();
      _news.Name = _name;
      _news.LongDescription = string.Format("Testo descrittivo completo per la news {0}", _name);
      _news.ShortDescription = string.Format("Testo descrittivo breve per la news {0}", _name);
      _news.Text = string.Format("News {0}, <p>Lorem ipsum dolor sit amet, usu justo paulo errem ad."
                                 + "Congue accusamus laboramus no nam. Vero nobis eu est. Eu eos minim ornatus contentiones,"
                                 + "eum quaerendum conclusionemque ei. Ad usu efficiendi persequeris, eum stet nominavi complectitur an."
                                 + "Sit nominati scribentur eu.</p><p>Eum percipit insolens eu. Ridens quaerendum ne vim, est.</p>", _name);
      _news.Date = DateTime.Now;
      _news.AuthInfo = CreateAuthInfo();
      _news.State = ObjectState.Added;
    }

    public static NewsBuilder DefaultNewsBuilder()
    {
      return new NewsBuilder();
    }

    public NewsBuilder WithName(string name)
    {
      _news.Name = name;
      return this;
    }

    public NewsBuilder WithAlbumAndPhotos(int numberOfPhotos)
    {
      _news.Album = new Album()
      {
        Id = Guid.NewGuid(),
        AuthInfo = CreateAuthInfo(),
        Name = String.Format("Album {0}", _news.Name),
        Photos = new List<Photo>(),
        State = ObjectState.Added
      };

      for (int i = 0; i < numberOfPhotos; i++)
      {
        _news.Album.Photos.Add(new Photo() { Id = Guid.NewGuid(), Name = string.Format("Foto {0} - Album {1} ", i, _news.Name), Description = string.Format("Descrizione foto {0} ", i), Path = "/images/test/", State = ObjectState.Added });
      }
      return this;
    }

    public NewsBuilder WithDocuments(int numberOfDocuments)
    {

      for (int i = 0; i < numberOfDocuments; i++)
      {
        _news.Documents.Add(new Document() { Id = Guid.NewGuid(), Name = string.Format("Documento {0} - News {1} ", i, _news.Name), Description = "/documents/test/", Path = "/documents/test/", State = ObjectState.Added });
      }
      return this;
    }

    public NewsBuilder WithVideo()
    {
      // Aggiungere nome e descrizione alla tabella
      _news.Video = new Video()
      {
        Id = Guid.NewGuid(),
        Name = String.Format("Video {0}", _news.Name),
        Description = "Descrizione",
        EmbeddedCode = "<iframe width=\"420\" height=\"315\" src=\"//www.youtube.com/embed/47mfDUkTNRE\" frameborder=\"0\" allowfullscreen></iframe>",
        State = ObjectState.Added,
        Url = "/videos/test/"
      };
      return this;
    }

    public News Build()
    {
      return _news;
    }

    private News _news;

    private AuthInfo CreateAuthInfo()
    {
      return new AuthInfo()
      {
        Created = DateTime.Now,
        Modified = DateTime.Now,
        CreatedBy = "Test",
        ModifiedBy = "Test"
      };
    }

  }
}
