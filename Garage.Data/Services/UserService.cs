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
 
    }

}
