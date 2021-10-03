﻿using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppRole : IActionApp<AppRole> 
    {
        private string _sp = MapClass<AppRole>.SPName("Read");
        //private readonly string _spRead = "dbo.SIC_asm_AppRole_Read";
        //private readonly string _spEdit = "dbo.SIC_asm_AppRole_Edit";
        private readonly string _invalidMessage = "Invalid Role ID";
        private readonly string _objName = typeof(AppRole).Name;
        private readonly IDataOperateService<AppRole> _dataOperate;  
        public ActionAppRole()   
        {
            this._dataOperate = MapClassForDB<AppRole>.DBSource();
        }
        public ActionAppRole(string dataSource)  //DataOperateService<T> iDos)
        {
            this._dataOperate =  MapClassForDB<AppRole>.DBSource(dataSource);
        }
        //  private AppClass myMap = MapClass<AppRole>.GetClass(); 
        public string GetSPName(string action)
        {
            return _sp;
        }
        public List<AppRole> GetObjList(object parameter)
        {
            return _dataOperate.ListOfT(_objName, _sp, parameter);
        }
        public List<AppRole> GetObjList(string dataSource, object parameter)
        {
            if (dataSource == "ClassCall") dataSource = MapClass<AppRole>.SPName("Read");
            return _dataOperate.ListOfT(dataSource, parameter);
        }

        public List<AppRole> GetObjByID(string dataSource, int id)
        {
            if (dataSource == "ClassCall") dataSource = MapClass<AppRole>.SPName("Read");
            return _dataOperate.ListOfT(dataSource, id);
        }
        public List<AppRole> GetObjByID(int id)
        {
            if (id <= 0) return null;

            var para = new { Operate = "Get",UserID ="admin", IDs = id.ToString() };
            _sp = MapClass<AppRole>.SPName("Edit");   //  CheckStoreProcedureParameters.GetParamerters(_spRead, para);

            return _dataOperate.ListOfT(_objName, _sp, para);


        }
        public string AddObj(AppRole parameter)
        {
            if (parameter.RoleID == null || parameter.RoleID == "") return _invalidMessage;

            return ObjOperation("Add", parameter);
        }

        public string EditObj(AppRole parameter)
        {
            if (parameter.RoleID == null || parameter.RoleID == "") return _invalidMessage;

            return ObjOperation("Edit", parameter);
        }

        public string RemoveObj(AppRole parameter)
        {
            if (parameter.RoleID == null || parameter.RoleID == "") return _invalidMessage;
            return ObjOperation("Remove", parameter);
        }

        public string DeleteObj(int id)
        {
            if (id <= 0) return _invalidMessage;

            var para = new {Operate = "Delete", UserID = "tester", IDs = id.ToString() };
            _sp = MapClass<AppRole>.SPName("Edit"); 
            return _dataOperate.EditResult(_objName, _sp, para);
       
        }
        private string ObjOperation(string action, AppRole parameter)
        {
            var para = GetParameter(action, parameter);
            _sp = MapClass<AppRole>.SPName("Edit");//  CheckStoreProcedureParameters.GetParamerters(_spEdit, para);// "dbo.SIC_asm_AppRoleEdit @Operate,@UserID,@IDs,@RoleID,@RoleName";

            return _dataOperate.EditResult(_objName, _sp, para);
        }

        private object GetParameter(string operate, AppRole paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.AppID,
                paraObj.RoleID,
                paraObj.RoleType,
                paraObj.RoleName,
                paraObj.RolePriority,
                paraObj.AccessScope,
                paraObj.Permission,
                paraObj.Comments
            };
            return parameter;
        }

        public string ActionsObj(object parameter)
        {
            throw new NotImplementedException();
        }
    }
}
