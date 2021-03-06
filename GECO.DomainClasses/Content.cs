//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace GECO.DomainClasses
{
    using System;
    using System.Collections.Generic;
    
    public partial class Content : Entity
    {
        public Content()
        {
            this.Documents = new HashSet<Document>();
            this.AuthInfo = new AuthInfo();
        }
    
        public System.Guid ContentId { get; set; }
        public string Name { get; set; }
        public string ShortDescription { get; set; }
        public string LongDescription { get; set; }
        public string Text { get; set; }
        public Nullable<System.Guid> VideoId { get; set; }
        public string MapUrl { get; set; }
        public Nullable<System.Guid> AlbumId { get; set; }
    
        public AuthInfo AuthInfo { get; set; }
    
        public virtual ICollection<Document> Documents { get; set; }
        public virtual Video Video { get; set; }
        public virtual Album Album { get; set; }
    }
}
