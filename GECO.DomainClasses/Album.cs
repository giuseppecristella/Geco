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
    
    public partial class Album : Entity
    {
        public Album()
        {
            this.Contents = new HashSet<Content>();
            this.Photos = new HashSet<Photo>();
            this.AuthInfo = new AuthInfo();
        }
    
        public System.Guid Id { get; set; }
        public string Name { get; set; }
    
        public AuthInfo AuthInfo { get; set; }
    
        public virtual ICollection<Content> Contents { get; set; }
        public virtual ICollection<Photo> Photos { get; set; }
    }
}
