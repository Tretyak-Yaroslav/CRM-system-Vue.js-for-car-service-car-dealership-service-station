using System;
using System.Collections.Generic;
using System.Text;

namespace Garage.Data.Entities.Cars
{
    public class VehicleModel
    {
        public int VendorID { get; set; }
        public int VehicleModelID { get; set; }
        public string VehicleModelName { get; set; }
        public string VehicleModelRange { get; set; }
    }
}
