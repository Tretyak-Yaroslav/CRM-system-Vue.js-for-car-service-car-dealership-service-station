using System;
using System.Collections.Generic;
using System.Text;

namespace Garage.Data.Entities
{
    public class ItemList
    {
        public int ItemID { get; set; }
        public int ItemCategoryID { get; set; }
        public string ItemName { get; set; }
        public string ItemDescription { get; set; }
        public decimal ServicePrice { get; set; }
    }
}
