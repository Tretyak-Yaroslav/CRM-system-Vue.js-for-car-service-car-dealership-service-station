using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Garage.Data.Entities;
using Garage.Data.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.IdentityModel.Tokens;

namespace Garage.API.Controllers
{
    [Authorize]
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private IUserService UserService { get; set; }
        public AuthController(IUserService userService)
        {
            UserService = userService;
        }
        private ClaimsIdentity GetIdentity(EmployeeUser user)
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimsIdentity.DefaultNameClaimType, user.EmployeeLogin),
                new Claim(ClaimsIdentity.DefaultRoleClaimType,"role"),
                new Claim("WorkShopID", user.WorkShopID.ToString())
            };
            var claimsIdentity = new ClaimsIdentity(claims, "Token", ClaimsIdentity.DefaultNameClaimType, ClaimsIdentity.DefaultRoleClaimType);

            return claimsIdentity;
        }

        [HttpPost]
        [AllowAnonymous]
        [ProducesResponseType(typeof(object), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(string), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(string), StatusCodes.Status500InternalServerError)]
        [ProducesDefaultResponseType]
        public async Task<ActionResult> Login(int workShopID, string employeeLogin, string employeePwd)
        {
            try
            {
                var msg = "";
                var user = await UserService.GetEmployeeUserList(workShopID,employeeLogin,employeePwd);
                if (user == null)
                {
                    msg = "Invalid username or password.";
                    return BadRequest(msg);
                }

                if (user.EmployeeBlocked)
                {
                    msg = "Your account is locked! Contact your manager.";
                    return BadRequest(msg);
                }
                var identity = GetIdentity(user);

                var now = DateTime.UtcNow;
                // создаем JWT-токен
                var jwt = new JwtSecurityToken(
                    issuer: Startup.AuthOptions.ISSUER,
                    audience: Startup.AuthOptions.AUDIENCE,
                    notBefore: now,
                    claims: identity.Claims,
                    expires: now.Add(TimeSpan.FromMinutes(Startup.AuthOptions.LIFETIME)),
                    signingCredentials: new SigningCredentials(Startup.AuthOptions.GetSymmetricSecurityKey(), SecurityAlgorithms.HmacSha256));

                var encodedJwt = new JwtSecurityTokenHandler().WriteToken(jwt);

                var response = new
                {
                    token = encodedJwt,
                    userName = identity.Name,
                    workShopID = user.WorkShopID,
                    employeeFirstName = user.EmployeeFirstName,
                    employeeLastName =user.EmployeeLastName
                };
                // сериализация ответа

                return Ok(response);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }

    }
}