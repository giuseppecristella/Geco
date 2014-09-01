using System;
using System.Collections.Generic;

namespace GECO.Web.Infrastructure.ModelMetadata
{
  public interface IModelMetadataFilter
  {
    void TransformMetadata(System.Web.Mvc.ModelMetadata metadata,
      IEnumerable<Attribute> attributes);
  }
}