using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;

namespace GECO.Data.Common
{
  interface IRepository<TEntity>
   where TEntity : class
  {
    IQueryable<TEntity> All(params string[] paths);
    IEnumerable<TEntity> Get(Expression<Func<TEntity, bool>> filter = null, Func<IQueryable<TEntity>, IOrderedQueryable<TEntity>> orderBy = null, string includeProperties = "");
    void Dispose();
  }
}
