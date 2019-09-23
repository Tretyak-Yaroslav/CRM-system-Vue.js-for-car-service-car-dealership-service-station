using Microsoft.AspNetCore.Mvc;
using Garage.API.Controllers;
using Xunit;
using Garage.Data.Services;

namespace Garage.API.Tests
{
    public class AuthControllerTests
    {
        AuthController controller { get; set; }

        public AuthControllerTests()
        {
            controller = new AuthController(new UserService("Server=gsqldev;Database=Garage-Dev;User Id=appLogin;Password = Pa$$W0rd!"));
        }

        [Theory]
        [InlineData(1, "developer", "developer")]
        public async void Return200Login(int workShopID, string login, string pass)
        {

            // Act
            var result = await controller.Login(workShopID, login, pass) as OkObjectResult;

            // Assert
            Assert.Equal(200, result.StatusCode);
        }

       /* [Theory]
        [InlineData("aers@ukr.net")]
        public async void GeneratePassword(string email)
        {

            // Act
            var result = await controller.GeneratePassword(email) as OkObjectResult;

            // Assert
            Assert.Equal(200, result.StatusCode);
        } */
    }
}
