using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class UserGroupPermission : UserGroup
    {
        public string AccessScope { get; set; }
        public string ModelID { get; set; }
        public string AppName { get; set; }
    }

    public class UserGroupPermissionList : UserGroupList
    {
        public string AccessScope { get; set; }
        public string ModelID { get; set; }

        public string AppName { get; set; }

    }
}
