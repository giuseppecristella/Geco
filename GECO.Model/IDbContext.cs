using System.Data.Entity;
using System.Data.Entity.Infrastructure;

namespace GECO.Model.Data
{
  public interface IDbContext
  {
    IDbSet<T> Set<T>() where T : class;
    int SaveChanges();
    DbEntityEntry Entry(object o);
    void Dispose();
  }
}
