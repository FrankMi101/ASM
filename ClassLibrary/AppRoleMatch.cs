using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class AppRoleMatch
    {
        public string RoleType { get; set; }
        public string MatchRole { get; set; }
        public string MatchScope { get; set; }
        public string MatchDesc { get; set; }
        public string RoleID { get; set; }

    }
    public class AppRoleMatchOperation : AppRoleMatch
    {
        public string Operate { get; set; }
        public string UserID { get; set; }
        public string UserRole { get; set; }
    }
}
