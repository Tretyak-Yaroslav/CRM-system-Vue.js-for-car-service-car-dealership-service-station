using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Garage.Data.Entities;

namespace Garage.Data.Services
{
    public interface IUserService
    {
        Task<EmployeeUser> GetEmployeeUserList(int workShopID, string employeeLogin, string employeePwd);
        Task<IEnumerable<string>> GetRoleOneFildList(int employeeID);
        Task<EmployeeUser> GetEmployeeByEmail(string email);
        Task SetEmployeePassword(int employeeID, string password);
    }

    public class UserService : IUserService
    {
        string connStr = null;

        public UserService(string conn)
        {
            connStr = conn;
        }
        public async Task<EmployeeUser> GetEmployeeUserList(int workShopID, string employeeLogin, string employeePwd)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {
                    return await db.QueryFirstOrDefaultAsync<EmployeeUser>("spGetEmployeeUser", new { workShopID, employeeLogin,employeePwd}, commandType: CommandType.StoredProcedure);
                }
            }
        }
        public async Task<IEnumerable<string>> GetRoleOneFildList(int employeeID)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {
                    return await db.QueryAsync<string>("spGetRoleOneFild", new { employeeID }, commandType: CommandType.StoredProcedure);
                }
            }
        }

        public async Task<EmployeeUser> GetEmployeeByEmail(string email)
        {
            {
                using (IDbConnection db = new SqlConnection(connStr))
                {
                    var x = await db.QueryFirstOrDefaultAsync<EmployeeUser>("spGetEmployeeByEmail", new { email }, commandType: CommandType.StoredProcedure);
                    return x;

                }
            }
        }

        public async Task SetEmployeePassword(int employeeID, string password)
        {
            using (IDbConnection db = new SqlConnection(connStr))
            {
                await db.QueryAsync("spSetEmployeePassword", new { employeeID, password }, commandType: CommandType.StoredProcedure);
            }
        }
    }

}
