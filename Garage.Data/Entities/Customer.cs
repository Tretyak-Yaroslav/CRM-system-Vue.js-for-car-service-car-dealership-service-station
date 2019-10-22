using System;

namespace Garage.Data.Entities
{
    [Serializable]
    public class Customer
    {
        public int? workShopID { get; set; }
        public int? ID { get; set; }
        public string fullName { get; set; }
        public string shortName { get; set; }
        public string phoneNumber { get; set; }
        public string phoneCountryCode { get; set; }
        public string mail{ get; set; }
        public string individualOrEntityPerson { get; set; }
        public string inn { get; set; }
        public string codeEDRPOU { get; set; }
        public string entityPersonNumber { get; set; }
        public int? externalCode { get; set; }
        public bool? isDeleted { get; set; }

    }
}
