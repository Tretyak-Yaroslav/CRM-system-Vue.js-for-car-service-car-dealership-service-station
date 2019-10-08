using System;
using System.Collections.Generic;
using System.Text;

namespace Garage.Data.Entities
{
    public class Customer
    {
        public int ExternalCode { get; set; }
        public string ShortName { get; set; }
        public string IndividualOrEntityPerson { get; set; }
        public string INN { get; set; }
        public string CodeEDRPOU { get; set; }
        public string EntityPersonNumber { get; set; }
    }
}
