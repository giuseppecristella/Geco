using System;
namespace GECO.Data.Common
{
  interface IUnitOfWork: IDisposable
  {
    int Save();
  }
}
