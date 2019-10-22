using System.Collections.Generic;
using Garage.Data.Entities;
using Dapper;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using Garage.Data.Entities.Cars;
namespace Garage.Data.Servises
{
    public interface IСatalogueService
    {
        Task<IEnumerable<Employee>> GetEmployees(int workShopID, int employeePostID);
        Task<IEnumerable<VehicleModel>> GetVehicleModelList(int vendorID, int vehicleModelID);
        Task<IEnumerable<WorkPlace>> GetWorkPlaceList(int workShopID);
        Task<IEnumerable<Vendor>> GetVendorList(int vendorID, bool isVisible);
        Task<IEnumerable<Customer>> GetCustomerList(int ID, string searchChars);
        Task<IEnumerable<Customer>> GetCustomersByVehicle(int vehicleID);
        Task<IEnumerable<Vehicle>> GetVehicleList(int ID, string searchChars);
        Task<IEnumerable<Vehicle>> GetVehiclesByCustomer(int customerID);
        Task<IEnumerable<VehicleModification>> GetVehicleModificationList(int vehicleModificationID,int vehicleModelID);
        Task<IEnumerable<ItemList>> GetItemList(int itemCategoryID);
        Task<IEnumerable<QueryStatus>> GetQueryStatusList(int queryStatusID);
    }

    public class СatalogueService : IСatalogueService
    {
        string connStr = null;

        public СatalogueService(string conn)
        {
            connStr = conn;
        }
        public async Task<IEnumerable<Employee>> GetEmployees(int workShopID, int employeePostID)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {
                    return await db.QueryAsync<Employee>("spGetEmployee", new { workShopID, employeePostID }, commandType:CommandType.StoredProcedure);
                }
            }
        }
        public async Task<IEnumerable<VehicleModel>> GetVehicleModelList(int vendorID, int vehicleModelID)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {
                    return await db.QueryAsync<VehicleModel>("spGetVehicleModel", new { vendorID,vehicleModelID }, commandType: CommandType.StoredProcedure);
                }
            }
        }
        public async Task<IEnumerable<WorkPlace>> GetWorkPlaceList(int workShopID)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {
                    return await db.QueryAsync<WorkPlace>("spGetWorkPlace", new { workShopID }, commandType: CommandType.StoredProcedure);
                }
            }
        }
        public async Task<IEnumerable<Vendor>> GetVendorList(int vendorID, bool isVisible)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {
                    return await db.QueryAsync<Vendor>("spGetVendor", new { vendorID, isVisible }, commandType: CommandType.StoredProcedure);
                }
            }
        }

        public async Task<IEnumerable<Customer>> GetCustomerList(int ID, string searchChars)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {
                    return await db.QueryAsync<Customer>("spGetCustomer", new { ID, searchChars }, commandType: CommandType.StoredProcedure);
                }
            }
        }

        public async Task<IEnumerable<Customer>> GetCustomersByVehicle(int vehicleID)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {
                    return await db.QueryAsync<Customer>("spGetCustomersByVehicle", new { vehicleID }, commandType: CommandType.StoredProcedure);
                }
            }
        }

        public async Task<IEnumerable<Vehicle>> GetVehicleList(int ID, string searchChars)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {
                    return await db.QueryAsync<Vehicle>("spGetVehicle", new { ID, searchChars }, commandType: CommandType.StoredProcedure);
                }
            }
        }

        public async Task<IEnumerable<Vehicle>> GetVehiclesByCustomer(int customerID)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {
                    return await db.QueryAsync<Vehicle>("spGetVehiclesByCustomer", new { customerID }, commandType: CommandType.StoredProcedure);
                }
            }
        }

        public async Task<IEnumerable<VehicleModification>> GetVehicleModificationList(int vehicleModificationID, int vehicleModelID)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {

                    return await db.QueryAsync<VehicleModification>("spGetVehicleModification", new { vehicleModificationID, vehicleModelID }, commandType: CommandType.StoredProcedure);
                }
            }
        }
        public async Task<IEnumerable<ItemList>> GetItemList(int itemCategoryID)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {
                    return await db.QueryAsync<ItemList>("spGetItemList", new { itemCategoryID }, commandType: CommandType.StoredProcedure);
                }
            }
        }
        public async Task<IEnumerable<QueryStatus>> GetQueryStatusList(int queryStatusID)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {
                    return await db.QueryAsync<QueryStatus>("spGetQueryStatus", new { queryStatusID }, commandType: CommandType.StoredProcedure);
                }
            }
        }
    }
}
