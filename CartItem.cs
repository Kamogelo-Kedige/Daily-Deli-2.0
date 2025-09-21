using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace Daily_Deli_E_Commerce
{
    [DataContract]
    [Serializable]
    public class CartItem
    {
        [DataMember]
        public int Id { get; set; }
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public decimal Price { get; set; }
        [DataMember]
        public string ImageURL { get; set; }
        [DataMember]
        public string CategoryName { get; set; }
        [DataMember]
        public string Unit { get; set; }
        [DataMember]
        public int Quantity { get; set; } = 1;
    }
}