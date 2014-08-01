using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GECO.DomainClasses;
using GECO.Model.Data;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Linq.Expressions;

namespace GECO.Data.Common
{
  public class Repository<TEntity> : GECO.Data.Common.IRepository<TEntity> where TEntity : class
  {

    private ObjectSet<TEntity> _objectSet;
    internal DbSet<TEntity> dbSet;

    private readonly GecoModelContainer _context;
    public Repository(UnitOfWork uow)
    {
      _context = uow.Context;
    }

    public IQueryable<TEntity> All(params string[] paths)
    {

      if (paths == null || paths.Length == 0)
        return _objectSet.AsQueryable();
      else
      {
        object retval = _objectSet;
        foreach (string path in paths)
        {
          if (retval is ObjectSet<TEntity>)
            retval = (retval as ObjectSet<TEntity>).Include(path);
          else if (retval is ObjectQuery<TEntity>)
            retval = (retval as ObjectQuery<TEntity>).Include(path);
        }
        return (retval as ObjectQuery<TEntity>).AsQueryable();
      }
    }


    public virtual IEnumerable<TEntity> Get(
         Expression<Func<TEntity, bool>> filter = null,
         Func<IQueryable<TEntity>, IOrderedQueryable<TEntity>> orderBy = null,
         string includeProperties = "")
    {
      IQueryable<TEntity> query = dbSet;

      if (filter != null)
      {
        query = query.Where(filter);
      }

      foreach (var includeProperty in includeProperties.Split
          (new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries))
      {
        query = query.Include(includeProperty);
      }

      if (orderBy != null)
      {
        return orderBy(query).ToList();
      }
      else
      {
        return query.ToList();
      }
    }


    //public TEntity Find(int id)
    //{
    //  return _context.TEntitys.Find(id);
    //}

    //public void InsertOrUpdateGraph(TEntity customerGraph)
    //{
    //  if (customerGraph.State == ObjectState.State.Added)
    //  {
    //    _context.Customers.Add(customerGraph);
    //  }
    //  else
    //  {
    //    _context.Customers.Add(customerGraph);
    //    _context.ApplyStateChanges();
    //  }
    //}

    //public void InsertOrUpdate(Customer customer)
    //{
    //  if (customer.Id == default(int)) // New entity
    //  {
    //    _context.Entry(customer).State = EntityState.Added;
    //  }
    //  else        // Existing entity
    //  {
    //    _context.Entry(customer).State = EntityState.Modified;

    //  }
    //}

    //public void Delete(int id)
    //{
    //  var customer = _context.Customers.Find(id);
    //  _context.Customers.Remove(customer);
    //}

    public void Dispose()
    {
      _context.Dispose();
    }

  }
}
