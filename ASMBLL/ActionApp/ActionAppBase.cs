using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public abstract class ActionAppBase<T> :IActionApp<T>
    {
        private readonly string _objName = typeof(T).Name;
        private string _sp = MapClass<T>.SPName("Read");
        private readonly string _invalidMessage = "Invalid Apps ID";
        private readonly IDataOperateService<T> _dataOperate;
        public ActionAppBase()
        {
             this._dataOperate = MapClassForDB<T>.DBSource();
        }
        public ActionAppBase(string dataSource)
        {
             this._dataOperate = MapClassForDB<T>.DBSource(dataSource);
        }

        public string GetSPName(string action)
        {
            return MapClass<T>.SPName(action);
        }
    
        public List<T> GetObjList(object parameter)
        {
            return _dataOperate.ListOfT( _sp, parameter,"SP");
        }
        public List<T> GetObjList(string dataSource, object parameter)
        {
            if (dataSource == "ClassCall") dataSource = MapClass<T>.SPName("Read");
            return _dataOperate.ListOfT(dataSource, parameter,"SP");
        }

        public List<T> GetObjByID(string dataSource, int id)
        {
            if (dataSource == "ClassCall") dataSource = MapClass<T>.SPName("Read");
            return _dataOperate.ListOfT(dataSource, id);
        }
        public List<T> GetObjByID(int id)
        {
            if (id <= 0) return null;

            var para = new { Operate = "Get", UserID = "admin", IDs = id.ToString() };
            _sp = MapClass<T>.SPName("Edit");   //  CheckStoreProcedureParameters.GetParamerters(_spRead, para);

            return _dataOperate.ListOfT( _sp, para,"SP");
        }
        public string GetValue(object parameter)
        {
            return _dataOperate.EditResult( _sp, parameter,"SP");
        }

        public string AddObj(T parameter)
        {
            if (parameter  == null   ) return _invalidMessage;

            return ObjOperation("Add", parameter);
        }

        public string EditObj(T parameter)
        {
            if (parameter  == null  ) return _invalidMessage;

            return ObjOperation("Edit", parameter);
        }

        public string RemoveObj(T parameter)
        {
            if (parameter == null  ) return _invalidMessage;
            return ObjOperation("Remove", parameter);
        }

        public string DeleteObj(int id)
        {
            if (id <= 0) return _invalidMessage;

            var para = new { Operate = "Delete", UserID = "tester", IDs = id.ToString() };
            _sp = MapClass<T>.SPName("Edit");
            return _dataOperate.EditResult( _sp, para,"SP");

        }
        private string ObjOperation(string action, T parameter)
        {
            var para = GetParameter(action, parameter);
            _sp = MapClass<T>.SPName("Edit");//  CheckStoreProcedureParameters.GetParamerters(_spEdit, para);// "dbo.SIC_asm_AppsEdit @Operate,@UserID,@IDs,@RoleID,@RoleName";

            return _dataOperate.EditResult( _sp, para);
        }

        public virtual object GetParameter(string operate, T paraObj)
        {
            var parameter = new
            {
                Operate = operate
            };
            return parameter;
        }

        public List<T> GetListOfT(object parameter)
        {
            return _dataOperate.ListOfT(_sp, parameter, "SP");
        }
        public T GetValueOfT( object parameter)
        {
             _sp = MapClass<T>.SPName("Edit"); 

            return _dataOperate.ValueOfT(_sp, parameter, "SP");
        }
    }
 
}
