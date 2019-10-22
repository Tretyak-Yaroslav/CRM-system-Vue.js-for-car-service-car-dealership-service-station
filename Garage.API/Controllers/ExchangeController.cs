using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Garage.API.Utils;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Garage.API.Controllers
{
    [Authorize]
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class ExchangeController : ControllerBase
    {

        [HttpPost]
        [Authorize(Roles = "Shop.DispositionEdit")]
        public async Task<ActionResult> ExportQueryToFile(DateTime from, DateTime to, int workShopID, int queryStatusID, int notShortQuery, int id)
        {
            try
            {
                await ExportOfData.Export(Startup.AppSettings.ExportCsvPath, from, to, workShopID, queryStatusID, notShortQuery, id);

                return Ok(true);
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }

        [HttpPost]
        [AllowAnonymous]
        public async Task<ActionResult> UpdateCustomerExternalCode(int customerId, int externalCode, string token)
        {
            try
            {
                return Ok(await ExportOfData.UpdateCustomerExCode(customerId, externalCode, token));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }

        [HttpPost]
        [AllowAnonymous]
        public async Task<ActionResult> UpdateVehicleExternalCode(int vehicleId, int externalCode, string token)
        {
            try
            {

                return Ok(await ExportOfData.UpdateVehicleExCode(vehicleId, externalCode, token));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }

        [HttpPost]
        [AllowAnonymous]
        public async Task<ActionResult> UpdateOrder(int queryId, bool status, string token)
        {
            try
            {

                return Ok(await ExportOfData.UpdateOrder(queryId, status, token));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }

        [HttpPost]
        [AllowAnonymous]
        public async Task<ActionResult> GetRawOrders(string token)
        {
            try
            {
                return Ok(await ExportOfData.GetRawOrders(token));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }

    }
}