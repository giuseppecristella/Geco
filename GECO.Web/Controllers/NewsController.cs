using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GECO.DomainClasses;
using GECO.Web.Models;
using Repository;

namespace GECO.Web.Controllers
{
  public class NewsController : Controller
  {

    private readonly IUnitOfWork _uow;
    private List<PhotoViewModel> _photos;

    public NewsController(IUnitOfWork uow)
    {
      _uow = uow;
    }

    // GET: News
    public ActionResult Index()
    {
      return View();
    }

    public ActionResult Add()
    {
      // Refactoring : Service layer, Automapping
      // TODO: verificare che venga eseguita la dispose della uow; scenario di update
      var query = _uow.Repository<News>().Query().All().FirstOrDefault();
      var model = new NewsViewModel();

      model.Name = query.Name;
      model.ShortDescription = string.Empty;// query.ShortDescription;
      model.Text = query.Text;
      model.Album = new AlbumViewModel();
      model.Album.Name = query.Album.Name;

      var photos = query.Album.Photos.ToList();
      //model.Album.Photos = new List<PhotoViewModel>();
      _photos = new List<PhotoViewModel>();
      for (int i = 0; i < photos.Count(); i++)
      {
        //model.Album.Photos.Add(new PhotoViewModel { Name = photos[i].Name, Description = photos[i].Description, Path = photos[i].Path });
        _photos.Add(new PhotoViewModel { Name = photos[i].Name, Description = photos[i].Description, Path = photos[i].Path });
      }

      return View(model);
    }

    [ChildActionOnly]
    public ActionResult PhotosWidget()
    {
      //var photos = _uow.Repository<Photo>().Query().All().ToList();
      //var model = new List<PhotoViewModel>();
      //for (int i = 0; i < photos.Count(); i++)
      //{
      //  model.Add(new PhotoViewModel { Name = photos[i].Name, Description = photos[i].Description, Path = photos[i].Path });
      //}
      return PartialView(_photos);
    }

    // GET: News/Details/5
    public ActionResult Details(int id)
    {
      return View();
    }

    // GET: News/Create
    public ActionResult Create()
    {
      return View();
    }

    // POST: News/Create
    [HttpPost]
    public ActionResult Create(FormCollection collection)
    {
      try
      {
        // TODO: Add insert logic here

        return RedirectToAction("Index");
      }
      catch
      {
        return View();
      }
    }

    // GET: News/Edit/5
    public ActionResult Edit(int id)
    {
      return View();
    }

    // POST: News/Edit/5
    [HttpPost]
    public ActionResult Edit(int id, FormCollection collection)
    {
      try
      {
        // TODO: Add update logic here

        return RedirectToAction("Index");
      }
      catch
      {
        return View();
      }
    }

    // GET: News/Delete/5
    public ActionResult Delete(int id)
    {
      return View();
    }

    // POST: News/Delete/5
    [HttpPost]
    public ActionResult Delete(int id, FormCollection collection)
    {
      try
      {
        // TODO: Add delete logic here

        return RedirectToAction("Index");
      }
      catch
      {
        return View();
      }
    }
  }
}
