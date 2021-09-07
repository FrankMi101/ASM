using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class AppRoleList : AppRole
    {
        public int RowNo { get; set; }
        public string Actions { get; set; }
        public string DeleteAction { get; set; }
        public string EditAction { get; set; }
        public string SubActions { get; set; }
       // public ItemsOnList Actions {get; set;}
    }
    public class AppRolePermissionList : AppRoleList
    {
        public string AppName { get; set; }
    }
}
