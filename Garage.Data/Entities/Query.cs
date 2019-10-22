using System;

namespace Garage.Data.Entities
{
    [Serializable]
    public class Query
    {
        public int? ID { get; set; }
        public DateTime startTime { get; set; }
        public DateTime endTime { get; set; }
        public int? statusID { get; set; }
        public string description { get; set; }
        public DateTime createDate { get; set; }
        public DateTime modificationDate { get; set; }
        public string statusName { get; set; }
        public string statusColor { get; set; }
        public int? employeeID { get; set; }
        public string employeeLastName { get; set; }
        public string employeeFirstName { get; set; }
        public string employeeColor { get; set; }
        public string employeePostName { get; set; }
        public int? employeeMasterID { get; set; }
        public string employeeMasterLastName { get; set; }
        public string employeeMasterFirstName { get; set; }
        public string employeeMasterColor { get; set; }
        public int? vehicleID { get; set; }
        public string vehicleRegistrationNumber { get; set; }
        public string vehicleVinNumber { get; set; }
        public int vehicleModelID { get; set; }
        public string vehicleModelName { get; set; }
        public string vehicleModelRange { get; set; }
        public int? vendorID { get; set; }
        public string vendorName { get; set; }
        public int? customerID { get; set; }
        public string customerFullName { get; set; }
        public string customerPhoneNumber { get; set; }
        public string phoneCountryCode { get; set; }
        public int? workPlaceID { get; set; }
        public string valendarPluginsCode{ get; set; }
        public string workPlaceName { get; set; }
        public string workPlaceTypeName { get; set; }
        public int? workShopID { get; set; }
        public string workShopName { get; set; }
        public int? itemID { get; set; }
        public string itemName { get; set; }
        public bool? isDeleted { get; set; }
    }
}