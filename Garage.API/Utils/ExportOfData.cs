using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Garage.Data.Servises;
using Garage.Data.Entities;
using System.Text;
using System.Data;
using System.IO;
using System.Text.RegularExpressions;
using System.Data.SqlClient;
using Dapper;

namespace Garage.API.Utils
{
    public static class ExportOfData
    {
        public const string AccessToken = "uEGGTVVtLggFTizCsMtwOJnRhjaQ2BMUQhcY";
        public static async Task Export(string destFilePath, DateTime from, DateTime to, int workShopID, int queryStatusID, int notShortQuery, int queryID)
        {
            // Initilization  
            StreamWriter sw = null;
            string connString = Startup.AppSettings.connString;
            Regex rgx = new Regex("[#,]");

            string sql = "select q.QueryID, q.WorkShopID, q.StartTime, q.EndTime, q.CreateDate, q.ModificationDate, q.QueryStatusID," +
                "q.EmployeeMasterID, q.EmployeeID, q.WorkPlaceID, q.ItemID, q.QuerySource, q.QueryDescription," +
                "c.ID as CustomerID, c.ExternalCode, c.CustomerShortName, c.CustomerFullName, c.IndividualOrEntityPerson, c.INN, c.CodeEDRPOU," +
                "c.EntityPersonNumber, c.CustomerPhoneNumber from Shop.Query q LEFT JOIN Client.Customer c ON q.CustomerID = c.ID WHERE q.QueryID = " + queryID;


            try
            {
                using (var connection = new SqlConnection(connString))
                {
                    var queryList = await connection.QueryAsync<EntityCSV>(sql);

                    //Initialization.
                    StringBuilder stringBuilder = new StringBuilder();
                    StringBuilder stringBuilderForRows = new StringBuilder();

                    // Saving Column header.  
                    stringBuilder.Append(string.Join(";", typeof(EntityCSV).GetProperties().Select(name => name.Name).ToList()) + "\n");

                    // Saving rows.  
                    foreach (EntityCSV item in queryList)
                    {
                        stringBuilderForRows.Append(string.Join(";", typeof(EntityCSV).GetProperties().Select(name => name.GetValue(item)).ToList()) + "\n");
                    }

                    //Delete specific symbols
                    string cleanRowValues = rgx.Replace(stringBuilderForRows.ToString(), "");
                    stringBuilder.Append(string.Join(";", cleanRowValues));

                    // Getting id.
                    int id = queryList.Select(item => item.ItemID).FirstOrDefault();

                    // Initialization.  
                    string fileContent = stringBuilder.ToString();
                    string fileName = destFilePath + "\\" + id + "_" + DateTime.Now.ToString().Replace(" ", "").Replace(".", "").Replace(":", "").Replace("/", "") + ".csv";
                    sw = new StreamWriter(new FileStream(fileName, FileMode.Create, FileAccess.Write), Encoding.UTF8);

                    // Saving.  
                    sw.Write(fileContent);
                }

            }
            catch (Exception ex)
            {
                // Info.  
                throw ex;
            }
            finally
            {
                // Closing.  
                sw.Flush();
                sw.Dispose();
                sw.Close();
            }

        }

        public static async Task<int> UpdateCustomerExCode(int customerId, int externalCode, string token)
        {
            string sql = "UPDATE Client.Customer SET ExternalCode = " + externalCode + " WHERE ID = " + customerId;

            try
            {
                if (AccessToken.Equals(token))
                {
                    using (var db = new SqlConnection(Startup.AppSettings.connString))
                    {
                        return await db.ExecuteScalarAsync<int>(sql);
                    }
                }
                else
                {
                    throw new UnauthorizedAccessException();
                }
            }
            catch (Exception ex)
            {
                // Info.  
                throw ex;
            }
        }

        public static async Task<int> UpdateVehicleExCode(int vehicleId, int externalCode, string token)
        {
            string sql = "UPDATE Client.Vehicle SET ExternalCode = " + externalCode + " WHERE ID = " + vehicleId;

            try
            {
                if (AccessToken.Equals(token))
                {
                    using (var db = new SqlConnection(Startup.AppSettings.connString))
                    {
                        return await db.ExecuteScalarAsync<int>(sql);
                    }
                }
                else
                {
                    throw new UnauthorizedAccessException();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static async Task<int> UpdateOrder(int queryId,bool status, string token)
        {
            string sql = "UPDATE Shop.Query SET ExternalStatus = '" + status + "' WHERE QueryID = " + queryId;

            try
            {
                if (AccessToken.Equals(token))
                {
                    using (var db = new SqlConnection(Startup.AppSettings.connString))
                    {
                       return await db.ExecuteScalarAsync<int>(sql);
                    }
                }
                else
                {
                    throw new UnauthorizedAccessException();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static async Task<IEnumerable<Order>> GetRawOrders(string token)
        {
            string sql = "SELECT QueryID as ID, CustomerID, VehicleID FROM Shop.Query WHERE ExternalStatus = 0";
       
            try
            {
                if (AccessToken.Equals(token))
                {
                    using (var db = new SqlConnection(Startup.AppSettings.connString))
                    {
                        return await db.QueryAsync<Order>(sql);
                    }
                }
                else
                {
                    throw new UnauthorizedAccessException();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }

    public class EntityCSV
    {
        public int QueryID { get; set; }
        public int VehicleID { get; set; }
        public int WorkShopID { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime ModificationDate { get; set; }
        public int QueryStatusID { get; set; }
        public int EmployeeMasterID { get; set; }
        public int EmployeeID { get; set; }
        public int WorkPlaceID { get; set; }
        public int ItemID { get; set; }
        public string QuerySource { get; set; }
        public string QueryDescription { get; set; }
        public int CustomerId { get; set; }
        public int ExternalCode { get; set; }
        public string CustomerShortName { get; set; }
        public string CustomerFullName { get; set; }
        public string IndividualOrEntityPerson { get; set; }
        public string INN { get; set; }
        public string CodeEDRPOU { get; set; }
        public string EntityPersonNumber { get; set; }
        public string CustomerPhoneNumber { get; set; }

    }

    public class Order
    {
        public int ID { get; set; }

        public int customerID { get; set; }

        public int vehicleID { get; set; }

        public bool ExternalStatus { get; set; }
    }

}

