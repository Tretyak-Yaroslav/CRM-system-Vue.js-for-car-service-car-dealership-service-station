using Microsoft.AspNetCore.Mvc;
using Garage.API.Controllers;
using Xunit;
using Garage.Data.Servises;
using System;

namespace Garage.API.Tests
{
    public class OrderControllerTests
    {
        OrderController controller { get; set; }

        public OrderControllerTests()
        {
            controller = new OrderController(new OrderService("Server=gsqldev;Database=Garage-Dev;User Id=appLogin;Password = Pa$$W0rd!"));
        }

        [Theory]
        [InlineData(3, 4, 5)]
        public async void PostQuery(int workShopID, int queryStatusID, int notShortQuery)
        {
            // Act
            var result = await controller.PostQuery(new DateTime(2019, 9, 9), new DateTime(2019, 9, 9), workShopID, queryStatusID, notShortQuery) as OkObjectResult;

            // Assert
            Assert.Equal(200, result.StatusCode);
        }

        [Theory]
        [InlineData(3, 4, 5)]
        public async void GetQuery(int workShopID, int queryStatusID, int notShortQuery)
        {
            // Act
            var result = await controller.GetQuery(new DateTime(2019, 9, 9), new DateTime(2019, 9, 9), workShopID, queryStatusID, notShortQuery) as OkObjectResult;

            // Assert
            Assert.Equal(200, result.StatusCode);
        }

        [Theory]
        [InlineData(1, "Test test", "099", 1, "Test Test test", "testRegNumber", 1, 1, 1)]
        public async void SetShortQuery(int workShopID, string customerFullName, string customerPhoneNumber, int itemID, string queryDescription, string vehicleRegistrationNumber, int vehicleModelID, int vendorID, int queryStatusID)

        {
            // Act
            var result = await controller.SetShortQuery(workShopID, customerFullName, customerPhoneNumber, itemID, queryDescription, vehicleRegistrationNumber, vehicleModelID, vendorID, queryStatusID) as OkObjectResult;

            // Assert
            Assert.Equal(200, result.StatusCode);
        }


        [Theory]
        [InlineData(1, 1, "test", "test", 1, "testRegNumber", 1, 1, "test",1,1,1,1,1,1,false)]
        public async void SetQuery(
            int queryID, 
            int workShopID, 
            string customerFullName,
            string customerPhoneNumber,
            int itemID, 
            string queryDescription, 
            int vehicleModelID,
            int vehicleModificationID,
            string vehicleRegistrationNumber, 
            int employeeID, 
            int employeeMasterID, 
            int workPlaceID,
          //  DateTime startTime,
          //  DateTime endTime, 
            int queryStatusID,
            int vehicleID, 
            int customerID,
            bool isDeleted)

        {
            // Act
       //     var result = await controller.SetQuery(queryID,workShopID, customerFullName, customerPhoneNumber, itemID, queryDescription, vehicleModelID,vehicleModificationID,vehicleRegistrationNumber, employeeID, employeeMasterID, workPlaceID, new DateTime(2019, 9, 9), new DateTime(2019, 9, 9), queryStatusID, vehicleID, customerID, isDeleted) as OkObjectResult;

            // Assert
         //   Assert.Equal(200, result.StatusCode);
        }
    }
}
