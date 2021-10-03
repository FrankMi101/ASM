using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using WebAPI.Models;

namespace WebAPI.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class WorkingSchoolController : ApiController
    {
        private readonly static string _dataSource = DataSource.Type();
        private IActionApp<StaffWorkingSchools> _action = new ActionAppStaffWorkingSchools(_dataSource);

        // GET: api/WorkingSchoolSelected?
        [HttpGet]
        [Route("api/WorkingSchool/list/{schoolyear}/{schoolcode}/{StaffUserID}")]
        public IHttpActionResult Get(string SchoolYear, string SchoolCode,string StaffUserID)
        {
            var para = new { Operate = "GetList", UserID = "asm", UserRole = "Admin",SchoolYear, SchoolCode, StaffUserID };
            var result = _action.GetObjList(para);

            return CheckGetResult(result);
        }
        // GET: api/SchoolSelected/5
        [HttpGet]
        [Route("api/WorkingSchool/{id}")]
        public IHttpActionResult Get(int id)
        {
            var result = _action.GetObjByID(id);

            return CheckGetResult(result);
        }


        // POST: api/usergroup
        [HttpPost]
        [Route("api/WorkingSchool")]
        public IHttpActionResult Post([FromBody] StaffWorkingSchools para)
        {        
            var result = _action.EditObj(para);
            return CheckActionResult(result);
        }

        private IHttpActionResult CheckGetResult(IList<StaffWorkingSchools> result)
        {
            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }
        private IHttpActionResult CheckActionResult(string result)
        {
            if (result == "Failed")
                return new ReturnMessage(result, Request);
            else
                return Ok(result);
        }
    }
}
