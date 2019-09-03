using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Garage.Data.Entities;
using Garage.Data.Models;
using Garage.Data.Servises;
using Microsoft.AspNetCore.Authorization;

namespace Garage.API.Controllers
{
    [Authorize]
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class OrderController : Controller
    {
        private IOrderService OrderService { get; set; }

        public OrderController(IOrderService orderService)
        {
            OrderService = orderService;
        }

        // POST /api/order/GetOrder   from=2019-01-01&to=2020-01-01&workShopID=1
        [HttpPost]
        public async Task<ActionResult> PostOrder(DateTime from, DateTime to, int workShopID, int orderStatusID, int notShortOrder)
        {
            try
            {
                return Ok(await OrderService.GetOrderList(from, to, workShopID, orderStatusID, notShortOrder));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }

        // Get /api/order/GetOrder   from=2019-01-01&to=2020-01-01&workShopID=1
        [HttpGet]
        public async Task<ActionResult> GetOrder(DateTime from, DateTime to, int workShopID, int orderStatusID, int notShortOrder)
        {
            try
            {
                return Ok(await OrderService.GetOrderList(from, to, workShopID, orderStatusID, notShortOrder));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
 
        }

        // POST api/SetShortOrder 
        [HttpPost]
        public async Task<ActionResult> SetShortOrderObj([FromBody] ShortOrderModel shortOrderModel)
        {
            try
            {
                return Ok(await OrderService.CreateShortOrder(shortOrderModel));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }
        // POST api/SetShortOrder 
        [HttpPost]
        public async Task<ActionResult> SetShortOrder(int workShopID, string customerFullName, string customerPhoneNumber, int itemID, string orderDescription, string vehicleRegistrationNumber, int vehicleModelID, int vendorID)
        {
            try
            {
                return Ok(await OrderService.CreateShortOrder(workShopID, customerFullName, customerPhoneNumber, itemID, orderDescription, vehicleRegistrationNumber, vehicleModelID));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }
        [HttpPost]
        public async Task<ActionResult> SetOrder(int orderID, int workShopID, string customerFullName,
            string customerPhoneNumber, int itemID, string orderDescription, int vehicleModelID,
            int vehicleModificationID,
            string vehicleRegistrationNumber, int employeeID, int employeeCreateOrderID, int workPlaceID,
            DateTime startTime, DateTime endTime, int orderStatusID)
        {
            try
            {
                return Ok(await OrderService.SetOrder(orderID, workShopID, customerFullName, customerPhoneNumber, itemID, orderDescription, vehicleModelID,
                    vehicleRegistrationNumber, employeeID, employeeCreateOrderID, workPlaceID, startTime, endTime, orderStatusID));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }
    }
}