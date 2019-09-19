using System;
using System.Collections.Generic;
using System.Text;


namespace Garage.Data.Entities
{
    public class Employee
    {
        public int EmployeeID { get; set; }
        public string EmployeeFirstName { get; set; }
        public string EmployeeLastName { get; set; }
        public int EmployeePostID { get; set; }
        public string EmployeePostName { get; set; }
        public int WorkShopID { get; set; }
        public string EmployeeColor { get; set; }
    }
    public class EmployeeUser
    {
        public int EmployeeID { get; set; }
        public string EmployeeFirstName { get; set; }
        public string EmployeeLastName { get; set; }
        public int WorkShopID { get; set; }
        public string EmployeeLogin { get; set; }
        public string EmployeePwd { get; set; }
        public string EmployeePhone { get; set; }
        public string EmployeeEMail { get; set; }
        public bool EmployeeEMailConfirmed { get; set; }
        public bool EmployeeBlocked { get; set; }
        public DateTime EmployeeLastLogined { get; set; }
        public DateTime EmployeeCreatedDate { get; set; }
    }

    public class Role
    {
        public string RoleGroup { get; set; }
        public string RoleName { get; set; }
        public string RoleDescription { get; set; }
        public string RoleLevel { get; set; }
    }
}
