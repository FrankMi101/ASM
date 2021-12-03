using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionUserGroupPermission : ActionAppBase<UserGroupPermission>
    {
         public ActionUserGroupPermission()  //DataOperateService<T> iDos)
        {          
        }
        public ActionUserGroupPermission(string dataSource) : base(dataSource)
        {         
        }
        //  private AppClass myMap = MapClass<UserGroupPermission>.GetClass(); 

        public override object GetParameter(string Operate, UserGroupPermission paraObj)
        {
            var parameter = new
            {
                Operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.SchoolCode,
                paraObj.AppID,
                paraObj.ModelID,
                paraObj.GroupID,
                paraObj.Permission,
                paraObj.AccessScope,
                paraObj.Comments


            };
            return parameter;
        }
 
    }
}
