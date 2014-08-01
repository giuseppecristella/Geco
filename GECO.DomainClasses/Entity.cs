using System.ComponentModel.DataAnnotations.Schema;

namespace GECO.DomainClasses
{
  public abstract class Entity: IObjectState
  {
    [NotMapped]
    public ObjectState State { get; set; }
  }
}
