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
    public class StaffController : ApiController
    {
        private readonly string  _dataSource = DataSource.Type();
        
        // GET: api/UserGroup
        [HttpGet]
        [Route("api/staff/list/{schoolCode}/{searchBy}/{searchValue}/{scope}")]
        public IHttpActionResult Get(string SchoolCode, string Searchby, string SearchValue,string Scope)
        {
              var _action = new ActionAppList<StaffListSearch,StaffList>(_dataSource);

        IList<StaffListSearch> result = null;
            var para = new { Operate = "GetList", UserID = "asm", UserRole = "Admin", SchoolCode,Searchby,SearchValue, Scope };
            result = _action.GetObjList(para);

            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }
       
        // GET: api/StaffList
        [HttpGet]
        [Route("api/staff/SAP/{schoolCode}/{schoolyear}/{CPNum}")]
        public IHttpActionResult GetSAP(string SchoolCode, string SchoolYear, string CPNum)
        {
            var   _action = new ActionAppList<StaffList, StaffMemberOf>(_dataSource);
            IList<StaffList> result = null;
            var para = new { Operate = "SAP", UserID = "asm", UserRole = "Admin", SchoolCode, SchoolYear, CPNum };
            result = _action.GetObjList(para);

            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }

        // GET: api/StaffList
        [HttpGet]
        [Route("api/staff/SIS/{schoolCode}/{schoolyear}/{CPNum}")]
        public IHttpActionResult GetSIS(string SchoolCode, string SchoolYear, string CPNum)
        {
            var _action = new ActionAppList<ClassesList, StaffMemberOf>(_dataSource);
            IList<ClassesList> result = null;
            var para = new { Operate = "SIS", UserID = "asm", UserRole = "Admin", SchoolCode, SchoolYear, CPNum };
            result = _action.GetObjList(para);

            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }

        // GET: api/StaffList
        [HttpGet]
        [Route("api/staff/APP/{schoolCode}/{schoolyear}/{CPNum}")]
        public IHttpActionResult GetAPP(string SchoolCode, string SchoolYear, string CPNum)
        {
            var _action = new ActionAppList<GroupList, StaffMemberOf>(_dataSource);
            IList<GroupList> result = null;
            var para = new { Operate = "APP", UserID = "asm", UserRole = "Admin", SchoolCode, SchoolYear, CPNum };
            result = _action.GetObjList(para);

            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }
        // GET: api/StaffList
        [HttpGet]
        [Route("api/staff/Group/{schoolCode}/{appID}")]
        public IHttpActionResult GetGroup(string SchoolCode, string AppID)
        {
            var _action = new ActionAppList<GroupList, UserGroup>(_dataSource);
            IList<GroupList> result = null;
            var para = new { Operate = "GroupList", UserID = "asm", UserRole = "Admin", SchoolCode, AppID};
            result = _action.GetObjList(para);

            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }
    }
}
