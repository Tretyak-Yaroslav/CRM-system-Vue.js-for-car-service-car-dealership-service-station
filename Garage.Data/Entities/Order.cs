using System;

namespace Garage.Data.Entities
{
    public class Order
    {
        public int OrderID { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public int OrderStatusID { get; set; }
        public string OrderDescription { get; set; }
        public DateTime CreateDate { get; set; }
        public string OrderStatusName { get; set; }
        public int EmployeeID { get; set; }
        public string EmployeeLastName { get; set; }
        public string EmployeeFirstName { get; set; }
        public string EmployeePostName { get; set; }
        public int EmployeeCreateOrderID { get; set; }
        public string EmployeeCreateLastName { get; set; }
        public string EmployeeCreateFirstName { get; set; }
        public int VehicleID { get; set; }
        public string VehicleRegistrationNumber { get; set; }
        public string VehicleVinNumber { get; set; }
        public int VehicleModificationID { get; set; }
        public string TypeName { get; set; }
        public string TypeRange { get; set; }
        public int VehicleModelID { get; set; }
        public string VehicleModelName { get; set; }
        public string VehicleModelRange { get; set; }
        public int VendorID { get; set; }
        public string VendorName { get; set; }
        public int CustomerID { get; set; }
        public string CustomerFullName { get; set; }
        public string CustomerPhoneNumber { get; set; }
        public int WorkPlaceID { get; set; }
        public string CalendarPluginsCode{ get; set; }
        public string WorkPlaceName { get; set; }
        public string WorkPlaceTypeName { get; set; }
        public int WorkShopID { get; set; }
        public string WorkShopName { get; set; }
        public int ItemID { get; set; }
        public string ItemName { get; set; }
    }
}