using System;

namespace Garage.Data.Entities
{
    [Serializable]
    public class Vehicle
    {
        public int? ID { get; set; }
        public int? CustomerVehicleBindID { get; set; }
        public int? vendorID { get; set; }
        public string vendorName { get; set; }
        public int? modelID { get; set; }
        public string modelName { get; set; }
        public int? modificationID { get; set; }
        public string registrationNumber { get; set; }
        public string vinNumber { get; set; }
        public string description { get; set; }
        public bool? isVisible { get; set; }
        public int? customerID { get; set; }
    }
}
