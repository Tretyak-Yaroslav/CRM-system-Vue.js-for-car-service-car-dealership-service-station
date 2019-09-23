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
using Garage.API.Utils;

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
        private ClaimsIdentity GetIdentity(EmployeeUser user, IEnumerable<string> Role)
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimsIdentity.DefaultNameClaimType, user.EmployeeLogin),
                new Claim("WorkShopID", user.WorkShopID.ToString())
            };
            claims.AddRange(Role.Select(x => new Claim(ClaimsIdentity.DefaultRoleClaimType, x)));
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

                var role = await UserService.GetRoleOneFildList(user.EmployeeID);

                var identity = GetIdentity(user, role);

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
                    EmployeeID = user.EmployeeID,
                    employeeFirstName = user.EmployeeFirstName,
                    employeeLastName =user.EmployeeLastName,
                    role
                };
                // сериализация ответа

                return Ok(response);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }

        [HttpPost]
        [AllowAnonymous]
        public async Task<ActionResult> GeneratePassword(string email)
        {
            try
            {
                var msg = "";
                var user = await UserService.GetEmployeeByEmail(email);
                if (user == null)
                {
                    msg = "User with specific email not found.";
                    return Ok(false);
                }

                if (user.EmployeeBlocked)
                {
                    msg = "Your account is locked! Contact your manager.";
                    return BadRequest(msg);
                }

                var newPassword = new Random().Next(0, 999999).ToString("D6");

                await UserService.SetEmployeePassword(user.EmployeeID, newPassword);

                await EmailSender.SendEmailAsync(email, "Новый пароль Автотехникс", newPassword);

                return Ok(true);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }

    }
}