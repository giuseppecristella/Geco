using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GECO.Web.Models
{
  public class AlbumViewModel
  {
    public string Name { get; set; }
    public List<PhotoViewModel> Photos { get; set; }
  }

  public class PhotoViewModel
  {
    public string Name { get; set; }
    public string Path { get; set; }
    public string Description { get; set; }

  }
}