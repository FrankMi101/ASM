using ASMBLL;
using ClassLibrary;
using Newtonsoft.Json;
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
    public class CommonController : ApiController
    {
      //  private readonly static string _dataSource = DataSource.Type();

        // GET: api/Common
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }


        // GET: api/UserGroup
        [HttpGet]
        [Route("api/common/grouplist/{schoolCode}/{appID}")]
        public IHttpActionResult Get(string SchoolCode, string AppID)
        {
            var action = new ActionAppList<GroupList, UserGroup>();
            IList<GroupList> result = null;
            var para = new { Operate = "GroupList", UserID = "asm", UserRole = "Admin", SchoolCode, AppID };
            result = action.GetObjList(para);

            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }

        [HttpGet]
        [Route("api/common/stafflist/{schoolCode}/{searchBy}/{searchValue}/{scope}")]
        public IHttpActionResult Get(string SchoolCode, string Searchby, string SearchValue, string Scope)
        {
            var action = new ActionAppList<StaffListSearch, StaffList>();
            IList<StaffListSearch> result = null;
            var para = new { Operate = "GetList", UserID = "asm", UserRole = "Admin", SchoolCode, Searchby, SearchValue, Scope };
            result = action.GetObjList(para);

            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }

        // GET: api/usergroup/5
        [HttpGet]
        [Route("api/common/{id}/{type}")]
        public IHttpActionResult Get(int id, string type)
        {
            var action = new ActionAppList<GroupList, UserGroup>();
            var result = action.GetObjByID(id);

            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }

        // POST: api/usergroup
        [HttpPost]
        [Route("api/common")]
        public IHttpActionResult Post([FromBody] object parameter)
        {
            // object does not work 

            //var anonyType = new { };
            //string resultBody = JsonConvert.SerializeObject(parameter);
            //resultBody = resultBody.Replace("{", "");
            //resultBody = resultBody.Replace("}", "");
            //var para = JsonConvert.DeserializeAnonymousType(resultBody, anonyType);
 
            // must include a ObjType = "UserGroup" in parameter object
            string objType = MapClass<AppClass>.ObjType(parameter);
            if (objType == "") return BadRequest("Object is null.");

            var action = new ActionApp<AppClass>();
            string result = action.ActionsObj(objType, parameter);


            if (result == "Failed")
                return new ReturnMessage("Add Object Content to Database Failed", Request);
            else
                return Ok(result);

        }

        // PUT: api/usergroup/
        [HttpPut]
        [Route("api/common")]
        public IHttpActionResult Put([FromBody] object parameter)
        {
            // object does not work 
            // must include a ObjType = "UserGroup" in parameter object
            string objType = MapClass<AppClass>.ObjType(parameter);
            if (objType == "") return BadRequest("Object is null.");

            var action = new ActionApp<AppClass>();
            string result = action.ActionsObj(objType, parameter);


            if (result == "Failed")
                return new ReturnMessage("Edit Object Content in Database Failed", Request);
            else
                return Ok(result); 

        }

        // DELETE: api/usergroup/5
        [HttpDelete]
        [Route("api/common")]
        public IHttpActionResult Delete([FromBody] object parameter)
        {
            // object does not work 
            // must include a ObjType = "UserGroup" in parameter object
            string objType = MapClass<AppClass>.ObjType(parameter);
            if (objType == "") return BadRequest("Object is null.");

            var action = new ActionApp<AppClass>();
            string result = action.ActionsObj(objType, parameter);


            if (result == "Failed")
                return new ReturnMessage("Delete Object Content in Database Failed", Request);
            else
                return Ok(result);
        }

    }
}
