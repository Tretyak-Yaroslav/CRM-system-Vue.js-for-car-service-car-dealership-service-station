using System;
using System.Runtime.Serialization;

namespace Garage.Data.Entities
{
    public class WorkPlace
    {
        public int WorkPlaceID { get; set; }
        public string CalendarPluginsCode { get; set; }
        public string WorkPlaceName { get; set; }
        public int WorkPlaceTypeID { get; set; }
        public string WorkPlaceTypeName { get; set; }
        public int WorkShopID { get; set; }
        public string WorkShopName { get; set; }
        public DateTime DoWorkFrom { get; set; }
        public DateTime DoWorkTo { get; set; }
    }
}