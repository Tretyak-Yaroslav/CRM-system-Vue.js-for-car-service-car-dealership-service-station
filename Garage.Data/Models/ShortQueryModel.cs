using System;
using System.Collections.Generic;
using System.Text;

namespace Garage.Data.Models
{
    public class ShortQueryModel
    {
        public int QueryId { get; set; }
        public int ItemID { get; set; }
        public int vehicleModelID { get; set; }
        public int VendorID { get; set; }
        public string CustomerFullName { get;set; }
        public string CustomerPhoneNumber { get; set; }
        public string QueryDescription { get; set; }
        public string VehicleModelName { get; set; }
        public string VendorName { get; set; }
    }
}
