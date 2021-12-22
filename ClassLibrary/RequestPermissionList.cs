using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class RequestPermissionList : RequestPermission
    {
        public int RowNo { get; set; }
        public string Actions { get; set; }
        public string ViewAction { get; set; }
        public string EditAction { get; set; }
        public string DeleteAction { get; set; }

    }
}