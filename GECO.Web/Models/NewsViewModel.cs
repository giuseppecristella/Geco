using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace GECO.Web.Models
{
  public class NewsViewModel
  {
    [Display(Name = "Titolo")]
    public string Name { get; set; }
    public string ShortDescription { get; set; }
    public string Text { get; set; }
    public AlbumViewModel Album { get; set; }
  }
}  