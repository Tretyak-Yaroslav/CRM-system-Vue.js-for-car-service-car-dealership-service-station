using Garage.Data.Servises;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;

namespace Garage.API.Controllers
{
    [Authorize]
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class CatalogueController : ControllerBase
    {
        private IСatalogueService СatalogueService { get; set; }

        public CatalogueController(IСatalogueService catalogueService)
        {
            СatalogueService = catalogueService;
        }
        [HttpPost]
        public async Task<ActionResult> GetVehicleModel(int vendorID, int vehicleModelID)
        {
            try
            {
                return Ok(await СatalogueService.GetVehicleModelList(vendorID,vehicleModelID));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }
        [HttpPost]
        public async Task<ActionResult> GetWorkPlace(int workShopeID)
        {
            try
            {
                return Ok(await СatalogueService.GetWorkPlaceList(workShopeID));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }
        [HttpPost]
        public async Task<ActionResult> GetVendor(int vendorID, bool isVisible)
        {
            try
            {
                return Ok(await СatalogueService.GetVendorList(vendorID, isVisible));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }
        [HttpPost]
        public async Task<ActionResult> GetVehicleModification(int vehicleModificationID, int vehicleModelID)
        {
            try
            {
                return Ok(await СatalogueService.GetVehicleModificationList(vehicleModificationID,vehicleModelID));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }
        [HttpPost]
        public async Task<ActionResult> GetItem(int itemCategoryID)
        {
            try
            {
                return Ok(await СatalogueService.GetItemList(itemCategoryID));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }
        [HttpPost]
        public async Task<ActionResult> GetEmployees(int workShopID, int employeePostID)
        {
            try
            {
                return Ok(await СatalogueService.GetEmployees(workShopID,employeePostID));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }
        [HttpPost]
        public async Task<ActionResult> GetQueryStatus(int queryStatusID)
        {
            try
            {
                return Ok(await СatalogueService.GetQueryStatusList(queryStatusID));
            }
            catch (Exception e)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);
            }
        }
    }
}
