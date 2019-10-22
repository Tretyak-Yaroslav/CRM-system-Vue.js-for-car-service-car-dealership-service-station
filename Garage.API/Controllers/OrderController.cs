using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Garage.Data.Servises;
using Microsoft.AspNetCore.Authorization;
using Garage.API.Utils;
using Garage.Data.Entities;

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
        [Authorize(Roles = "Shop.Disposition")]
        public async Task<ActionResult> PostQuery(DateTime from, DateTime to, int workShopID, int queryStatusID, int notShortQuery)
        {
            try
            {
                return Ok(await OrderService.GetQueryList(from, to, workShopID, queryStatusID, notShortQuery, 0));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }

        // Get /api/order/GetOrder   from=2019-01-01&to=2020-01-01&workShopID=1
        [Authorize(Roles = "Shop.Disposition")]
        [HttpGet]
        public async Task<ActionResult> GetQuery(DateTime from, DateTime to, int workShopID, int statusID, int notShortQuery)
        {
            try
            {
                return Ok(await OrderService.GetQueryList(from, to, workShopID, statusID, notShortQuery, 0));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
 
        }

        // Get /api/order/GetOrder   from=2019-01-01&to=2020-01-01&workShopID=1
        [Authorize(Roles = "Shop.Disposition")]
        [HttpGet]
        public async Task<ActionResult> GetQueryOne(DateTime from, DateTime to, int workShopID, int queryStatusID, int notShortQuery, int queryID)
        {
            try
            {
                return Ok(await OrderService.GetQueryList(from, to, workShopID, queryStatusID, notShortQuery, queryID));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }

        }

        // POST api/SetShortOrder 
        //[HttpPost]
        //public async Task<ActionResult> SetShortOrderObj([FromBody] ShortOrderModel shortOrderModel)
        //{
        //    try
        //    {
        //        return Ok(await OrderService.CreateShortOrder(shortOrderModel));
        //    }
        //    catch (Exception e)
        //    {
        //        return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
        //    }
        //}
        // POST api/SetShortOrder 
        [HttpPost]
        public async Task<ActionResult> SetShortQuery(int workShopID, string customerFullName, string customerPhoneNumber, int itemID, string queryDescription, string vehicleRegistrationNumber, int vehicleModelID, int vendorID, int queryStatusID)
        {
            try
            {
                return Ok(await OrderService.CreateShortQuery(workShopID, customerFullName, customerPhoneNumber, itemID, queryDescription, vehicleRegistrationNumber, vehicleModelID, queryStatusID));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }
        /*
         * int queryID, int workShopID, int itemID, string queryDescription,
           int employeeID, int employeeMasterID, int workPlaceID,
            DateTime startTime, DateTime endTime, int queryStatusID, int vehicleID, int customerID, bool isDeleted
         
             
             */
        [HttpPost]
        [Authorize(Roles = "Shop.DispositionEdit")]
        public async Task<ActionResult> SetQuery([FromBody] Query query)
        {
            try
            {
                return Ok(await OrderService.SetQuery(query));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }

        [HttpPost]
        [Authorize(Roles = "Shop.DispositionEdit")]
        public async Task<ActionResult> SetCustomer([FromBody] Customer customer)
        {
            try
            {
                return Ok(await OrderService.SetCustomer(customer));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }

        [HttpPost]
        [Authorize(Roles = "Shop.DispositionEdit")]
        public async Task<ActionResult> SetVehicle ([FromBody]Vehicle vehicle)
        {
            try
            {
                return Ok(await OrderService.SetVehicle(vehicle));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }

    

    

    }
}