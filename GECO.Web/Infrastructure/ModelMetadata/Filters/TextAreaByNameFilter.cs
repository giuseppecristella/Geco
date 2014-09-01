using System;
using System.Collections.Generic;

namespace GECO.Web.Infrastructure.ModelMetadata.Filters
{
  public class TextAreaByNameFilter : IModelMetadataFilter
  {
    private static readonly HashSet<string> TextAreaFieldNames =
        new HashSet<string>
						{
							"text",
							"comments"
						};

    public void TransformMetadata(System.Web.Mvc.ModelMetadata metadata,
      IEnumerable<Attribute> attributes)
    {
      if (!string.IsNullOrEmpty(metadata.PropertyName) &&
        string.IsNullOrEmpty(metadata.DataTypeName) &&
        TextAreaFieldNames.Contains(metadata.PropertyName.ToLower()))
      {
        metadata.DataTypeName = "MultilineText";
      }
    }
  }
}