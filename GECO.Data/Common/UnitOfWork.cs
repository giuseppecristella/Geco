using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GECO.DomainClasses;
using GECO.Model.Data;

namespace GECO.Data.Common
{
  public class UnitOfWork : IUnitOfWork
  {

    private readonly GecoModelContainer _context;
    
    private Repository<Content> contentRepository;


    public Repository<Content> ContentRepository
    {
      get
      {
        if (contentRepository != null)
        {
          contentRepository = new Repository<Content>(this);
        }
        return contentRepository;
      }
    }


    public UnitOfWork()
    {
      _context = new GecoModelContainer();
    }

    public UnitOfWork(GecoModelContainer context)
    {
      _context = context;
    }
    public int Save()
    {
      return _context.SaveChanges();
    }

    public GecoModelContainer Context
    {
      get { return _context; }
    }

    public void Dispose()
    {
      _context.Dispose();
    }
  }
}
