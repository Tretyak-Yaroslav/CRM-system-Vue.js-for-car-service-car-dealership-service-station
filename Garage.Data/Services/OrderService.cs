using System;
using System.Collections.Generic;
using Garage.Data.Entities;
using Dapper;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace Garage.Data.Servises
{
    public interface IOrderService
    {

        Task<IEnumerable<Query>> GetQueryList(DateTime from, DateTime to, int station, int queryStatusID, int notShortQuery, int queryID);

        //Task<int> CreateShortQuery(ShortQueryModel shortQueryModel);
        Task<int> CreateShortQuery(int workShopID, string customerFullName, string customerPhoneNumber, int itemID, string queryDescription, string vehicleRegistrationNumber, int vehicleModelID, int queryStatusID);
        Task<int> SetQuery(int queryID, int workShopID, string customerFullName, string customerPhoneNumber, int itemID, string queryDescription, int vehicleModelID,
            string vehicleRegistrationNumber, int employeeID, int employeeCreateOrderID, int workPlaceID, DateTime startTime, DateTime endTime, int orderStatusID, int vehicleID, int customerID, bool isDeleted);



    }
    public class OrderService : IOrderService
    {
        string connStr = null;

        public OrderService(string conn)
        {
            connStr = conn;
        }

        public async Task<IEnumerable<Query>> GetQueryList(DateTime from, DateTime to, int workShopID, int queryStatusID, int notShortQuery, int queryID)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {
                    return await db.QueryAsync<Query>("spGetQuery", new {from,to,workShopID, queryStatusID, notShortQuery, queryID }, commandType: CommandType.StoredProcedure);
                }
            }
        }
        //public async Task<int> CreateShortOrder(ShortQueryModel shortQueryModel)
        //{
        //    using (IDbConnection db = new SqlConnection(connStr))
        //    {
        //        return await db.ExecuteScalarAsync<int>("spSetShortOrder", shortQueryModel, commandType: CommandType.StoredProcedure);
        //    }
        //}
        public async Task<int> CreateShortQuery(int workShopID, string customerFullName, string customerPhoneNumber, int itemID, string queryDescription, string vehicleRegistrationNumber, int vehicleModelID, int queryStatusID)
        {
            using (IDbConnection db = new SqlConnection(connStr))
            {
                return await db.ExecuteScalarAsync<int>("spSetQuery", new {workShopID, customerFullName,customerPhoneNumber, itemID, queryDescription, vehicleRegistrationNumber, vehicleModelID, queryStatusID}, commandType: CommandType.StoredProcedure);
            }
        }

        public async Task<int> SetQuery(int queryID, int workShopID, string customerFullName,
            string customerPhoneNumber, int itemID, string queryDescription, int vehicleModelID,
            string vehicleRegistrationNumber, int employeeID, int employeeMasterID, int workPlaceID,
            DateTime startTime, DateTime endTime, int queryStatusID, int vehicleID , int customerID, bool isDeleted)
        {
            using (IDbConnection db = new SqlConnection(connStr))
            {
                return await db.ExecuteScalarAsync<int>("spSetQuery", new
                {
                    queryID, workShopID, customerFullName, customerPhoneNumber, itemID, queryDescription, vehicleModelID, 
                    vehicleRegistrationNumber, employeeID,employeeMasterID, workPlaceID,startTime,endTime,queryStatusID,isDeleted
                }, commandType: CommandType.StoredProcedure);
            }
        }
    }
}