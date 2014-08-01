using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GECO.DomainClasses
{
  public interface IObjectState
  {
    ObjectState State { get; set; }
  }
}
