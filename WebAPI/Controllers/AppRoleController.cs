using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;

namespace WebAPI.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class AppRoleController : ApiController
    {
       private ActionAppRole _action = new ActionAppRole();
        
        // GET: api/AppRole
      
        public IEnumerable<AppRole> Get()
        {
             var para = new { Operate = "GetListAll" };
            return _action.GetObjList(para);
        }

        // GET: api/AppRole
        public IEnumerable<AppRole> Get(string roleType)
        {
             var para = new { Operate = "GetListbyType", IDs = "0", UserID = "asm", UserRole = "admin", RoleType = roleType };

            return _action.GetObjList(para);
        }

        // GET: api/AppRole/5
        public IEnumerable<AppRole> Get(int id)
        {
            return _action.GetObjByID(id);
        }

        // POST: api/AppRole
        public void Post([FromBody] AppRole appRole )
        {
          //  var parameter = new List<AppRole>() { appRole };
             _action.AddObj(appRole);  
        }

        // PUT: api/AppRole/5
        public void Put([FromBody] AppRole appRole)
        {
          //  var parameter = new List<AppRole>{appRole};
            _action.EditObj(appRole);
        }

        // DELETE: api/AppRole/5
        public void Delete(int id)
        {
            _action.DeleteObj(id);
        }
   
    }
}
