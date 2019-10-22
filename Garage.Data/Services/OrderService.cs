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

        Task<IEnumerable<Query>> GetQueryList(DateTime from, DateTime to, int station, int statusID, int notShortQuery, int ID);

        //Task<int> CreateShortQuery(ShortQueryModel shortQueryModel);
        Task<int> CreateShortQuery(int workShopID, string customerFullName, string customerPhoneNumber, int itemID, string queryDescription, string vehicleRegistrationNumber, int vehicleModelID, int queryStatusID);
        Task<int> SetQuery(Query query);
        Task<int> SetCustomer(Customer customer);
        Task<int> SetVehicle(Vehicle vehicle);//(int vehicleID, int vendorID, int modelID, int modificationID, string regNumber, string vin,string description, bool isDeleted);

        //int queryID, int workShopID, int itemID, string queryDescription, int employeeID, int employeeMasterID, int workPlaceID, DateTime startTime, DateTime endTime, int orderStatusID, int vehicleID, int customerID, bool isDeleted
    }
    public class OrderService : IOrderService
    {
        string connStr = null;

        public OrderService(string conn)
        {
            connStr = conn;
        }

        public async Task<IEnumerable<Query>> GetQueryList(DateTime from, DateTime to, int workShopID, int statusID, int notShortQuery, int ID)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {
                    return await db.QueryAsync<Query>("spGetQuery", new {from,to,workShopID, statusID, notShortQuery, ID }, commandType: CommandType.StoredProcedure);
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

        public async Task<int> SetQuery(Query q)
        {
            using (IDbConnection db = new SqlConnection(connStr))
            {
                return await db.ExecuteScalarAsync<int>("spSetQuery", new
                {
                   q.ID,
                   q.workShopID,
                   q.itemID,
                   q.description,
                   q.employeeID,
                   q.employeeMasterID,
                   q.workPlaceID,
                   q.startTime,
                   q.endTime,
                   q.statusID,
                   q.vehicleID,
                   q.customerID,
                   q.isDeleted }, commandType: CommandType.StoredProcedure);
            }
        }

        public async Task<int> SetCustomer(Customer c)
        {
            using (IDbConnection db = new SqlConnection(connStr))
            {
                return await db.ExecuteScalarAsync<int>("spSetCustomer", new
                {
                    c.workShopID,
                    c.ID,
                    c.fullName,
                    c.shortName,
                    c.phoneNumber,
                    c.phoneCountryCode,
                    c.mail,
                    c.individualOrEntityPerson,
                    c.inn,
                    c.codeEDRPOU,
                    c.entityPersonNumber,
                    c.isDeleted
                }, commandType: CommandType.StoredProcedure);
            }
        }

        public async Task<int> SetVehicle(Vehicle v)
        {
            using (IDbConnection db = new SqlConnection(connStr))
            {
                return await db.ExecuteScalarAsync<int>("spSetVehicle", new { v.ID, v.vendorID, v.modelID, v.modificationID, v.registrationNumber, v.vinNumber, v.description, v.isVisible} , commandType: CommandType.StoredProcedure);
            }
        }
    }
}