using System;
using System.Collections.Generic;
using System.Text;
using Garage.Data.Interfaces;
using Garage.Data.Entities;
using Dapper;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
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
