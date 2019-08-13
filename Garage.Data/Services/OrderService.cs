using System;
using System.Collections.Generic;
using Garage.Data.Interfaces;
using Garage.Data.Entities;
using Dapper;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Garage.Data.Models;

namespace Garage.Data.Servises
{
    public interface IOrderService
    {

        Task<IEnumerable<Order>> GetOrderList(DateTime from, DateTime to, int station, int orderStatusID, int notShortOrder);

        Task<int> CreateShortOrder(ShortOrderModel shortOrderModel);
        Task<int> CreateShortOrder(int workShopID, string customerFullName, string customerPhoneNumber, int itemID, string orderDescription, string vehicleRegistrationNumber, int vehicleModelID);
        Task<int> SetOrder(int orderID, int workShopID, string customerFullName, string customerPhoneNumber, int itemID, string orderDescription, int vehicleModelID, int vehicleModificationID,
            string vehicleRegistrationNumber, int employeeID, int employeeCreateOrderID, int workPlaceID, DateTime startTime, DateTime endTime, int orderStatusID);



    }
    public class OrderService : IOrderService
    {
        string connStr = null;

        public OrderService(string conn)
        {
            connStr = conn;
        }

        public async Task<IEnumerable<Order>> GetOrderList(DateTime from, DateTime to, int workShopID, int orderStatusID, int notShortOrder)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {
                    return await db.QueryAsync<Order>("spGetOrder", new {from,to,workShopID, orderStatusID, notShortOrder }, commandType: CommandType.StoredProcedure);
                }
            }
        }
        public async Task<int> CreateShortOrder(ShortOrderModel shortOrderModel)
        {
            using (IDbConnection db = new SqlConnection(connStr))
            {
                return await db.ExecuteScalarAsync<int>("spSetShortOrder", shortOrderModel, commandType: CommandType.StoredProcedure);
            }
        }
        public async Task<int> CreateShortOrder(int workShopID, string customerFullName, string customerPhoneNumber, int itemID, string orderDescription, string vehicleRegistrationNumber, int vehicleModelID)
        {
            using (IDbConnection db = new SqlConnection(connStr))
            {
                return await db.ExecuteScalarAsync<int>("spSetOrder", new {workShopID, customerFullName,customerPhoneNumber, itemID, orderDescription, vehicleRegistrationNumber, vehicleModelID }, commandType: CommandType.StoredProcedure);
            }
        }

        public async Task<int> SetOrder(int orderID, int workShopID, string customerFullName,
            string customerPhoneNumber, int itemID, string orderDescription, int vehicleModelID,
            int vehicleModificationID,
            string vehicleRegistrationNumber, int employeeID, int employeeCreateOrderID, int workPlaceID,
            DateTime startTime, DateTime endTime, int orderStatusID)
        {
            using (IDbConnection db = new SqlConnection(connStr))
            {
                return await db.ExecuteScalarAsync<int>("spSetOrder", new
                {
                    orderID, workShopID, customerFullName, customerPhoneNumber, itemID, orderDescription, vehicleModelID, vehicleModificationID,
                    vehicleRegistrationNumber, employeeID,employeeCreateOrderID, workPlaceID,startTime,endTime,orderStatusID
                }, commandType: CommandType.StoredProcedure);
            }
        }
    }
}