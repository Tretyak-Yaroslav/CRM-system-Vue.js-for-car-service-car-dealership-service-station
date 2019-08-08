using System;
using System.Collections.Generic;
using System.Text;

namespace Garage.Data.Models
{
    public class ShortOrderModel
    {
        public int OrderId { get; set; }
        public int serviceID { get; set; }
        public int vehicleModelID { get; set; }
        public int vehicleBrandID { get; set; }
        public string CustomerFullName { get;set; }
        public string CustomerPhoneNumber { get; set; }
        public string OrderDescription { get; set; }
        public string VehicleModelName { get; set; }
        public string VehicleBrandName { get; set; }
    }
}
