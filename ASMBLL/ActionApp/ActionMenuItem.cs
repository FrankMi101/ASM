using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionMenuItem : ActionAppBase<MenuItems> // IActionGet<MenuItems>
    {
         
        public ActionMenuItem()
        {
        }
        public ActionMenuItem(string dataSource) : base(dataSource)
        {
        }
    }

    //public class ActionMenuItem : IActionGet<MenuItems>
    //{
    //    private readonly IDataOperateService<MenuItems> _dataOperate = MapClassForDB<MenuItems>.DBSource(); // new DataOperateService<AppRole>(new DataOperateServiceSQL<AppRole>());
 
    //    private string _sp = "dbo.SIC_sys_ActionMenuList @Operate, @UserID,@UserRole,@SchoolYear,@SchoolCode,@TabID,@ObjID,@AppID";

    //    public List<MenuItems> GetObjByID(int id)
    //    {
    //        throw new NotImplementedException();
    //    }

    //    public List<MenuItems> GetObjByID(string dataSource, int id)
    //    {
    //        throw new NotImplementedException();
    //    }

    //    public List<MenuItems> GetObjList(object parameter)
    //    {
    //        return _dataOperate.ListOfT(_sp, parameter);

    //    }

    //    public List<MenuItems> GetObjList(string dataSource, object parameter)
    //    {
    //        throw new NotImplementedException();
    //    }

    //    public string GetSPName(string action)
    //    {
    //        return _sp;
    //    }

    //}
}
