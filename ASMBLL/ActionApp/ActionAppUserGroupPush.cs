using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppUserGroupPush : IActionApp<UserGroupPush> 
    {
        private string _sp = MapClass<UserGroupPush>.SPName("Push");
        private readonly string _invalidMessage = "Invalid Group ID";
        private readonly string _objName = typeof(UserGroupPush).Name;
        private readonly IDataOperateService<UserGroupPush> _dataOperate;//  = (IDataOperateService<UserGroupPush>)MapClass<UserGroupPush>.DBSource();  // new DataOperateService<UserGroupPush>(new DataOperateServiceSQL<UserGroupPush>());
        public ActionAppUserGroupPush()  //DataOperateService<T> iDos)
        {
            this._dataOperate = MapClassForDB<UserGroupPush>.DBSource();
        }
        public ActionAppUserGroupPush(string dataSource)  //DataOperateService<T> iDos)
        {
            this._dataOperate =  MapClassForDB<UserGroupPush>.DBSource(dataSource);
        }
        public string GetSPName(string action)
        {
            return _sp;
        }
        public List<UserGroupPush> GetObjList(object parameter)
        {
            throw new NotImplementedException();
        }
        public List<UserGroupPush> GetObjByID(int id)
        {
            throw new NotImplementedException();
        }
        public string AddObj(UserGroupPush parameter)
        {
            if (parameter.GroupID == null || parameter.GroupID == "") return _invalidMessage;
            var para = GetParameter("Push", parameter);
            return _dataOperate.EditResult(_objName, _sp, para);
        }

        public string EditObj(UserGroupPush parameter)
        {
            throw new NotImplementedException();
        }
        public string RemoveObj(UserGroupPush parameter)
        {
            throw new NotImplementedException();
        }
        public string DeleteObj(int id)
        {
            throw new NotImplementedException();
        }
        private object GetParameter(string operate, UserGroupPush paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.SchoolCode,
                paraObj.AppID,
                paraObj.GroupID,
                paraObj.AppIDTo,
                paraObj.IncludeStudent,
                paraObj.IncludeTeacher
            };
            return parameter;
        }


    }
}
