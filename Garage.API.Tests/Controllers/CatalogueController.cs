using Microsoft.AspNetCore.Mvc;
using Garage.API.Controllers;
using Xunit;
using Garage.Data.Servises;

namespace Garage.API.Tests
{
    public class CatalogueControllerTests
    {
        CatalogueController controller { get; set; }

        public CatalogueControllerTests()
        {
            controller = new CatalogueController(new СatalogueService("Server=gsqldev;Database=Garage-Dev;User Id=appLogin;Password = Pa$$W0rd!"));
        }

        [Theory]
        [InlineData(1, 1)]
        public async void GetVehicleModel(int vendorID, int vehicleModelID)
        {
            // Act
            var result = await controller.GetVehicleModel(vendorID, vehicleModelID) as OkObjectResult;

            // Assert
            Assert.Equal(200, result.StatusCode);
        }

        [Theory]
        [InlineData(1)]
        public async void GetWorkPlace(int workShopID)
        {
            // Act
            var result = await controller.GetWorkPlace(workShopID) as OkObjectResult;

            // Assert
            Assert.Equal(200, result.StatusCode);
        }

        [Theory]
        [InlineData(1)]
        public async void GetVendor(int vendorID)
        {
            // Act
            var result = await controller.GetVendor(vendorID) as OkObjectResult;

            // Assert
            Assert.Equal(200, result.StatusCode);
        }

        [Theory]
        [InlineData(1, 1)]
        public async void GetVehicleModification(int vehicleModificationID, int vehicleModelID)
        {
            // Act
            var result = await controller.GetVehicleModification(vehicleModificationID, vehicleModelID) as OkObjectResult;

            // Assert
            Assert.Equal(200, result.StatusCode);
        }

        [Theory]
        [InlineData(1)]
        public async void GetItem(int itemCategoryID)
        {
            // Act
            var result = await controller.GetItem(itemCategoryID) as OkObjectResult;

            // Assert
            Assert.Equal(200, result.StatusCode);
        }

        [Theory]
        [InlineData(1, 1)]
        public async void GetEmployees(int workShopID, int employeePostID)
        {
            // Act
            var result = await controller.GetEmployees(workShopID, employeePostID) as OkObjectResult;

            // Assert
            Assert.Equal(200, result.StatusCode);
        }

        [Theory]
        [InlineData(1)]
        public async void GetQueryStatus(int queryStatusID)
        {
            // Act
            var result = await controller.GetQueryStatus(queryStatusID) as OkObjectResult;

            // Assert
            Assert.Equal(200, result.StatusCode);
        }

    }
}
