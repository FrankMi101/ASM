using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class Group
    {
        public string AppID { get; set; }
        public string AppRole { get; set; }
        public string GroupID { get; set; }
        public string GroupName { get; set; }
        public string GroupType { get; set; }
        public string Permission { get; set; }
        public string MemberID { get; set; }
        public string MemberName { get; set; }
        public string IsActive { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string SchoolYear { get; set; }
        public string SchoolCode { get; set; }
        public string Comments { get; set; }
        public string IDs { get; set; }
        public string StudentMember { get; set; }
        public bool HasMemberT { get; set; }


    }
    public class GroupOperation : Group
    {
        public string Operate { get; set; }
        public string UserID { get; set; }
        public string UserRole { get; set; }
        public string CPNum { get; set; }

    }
    public class GroupCopyOperation : Group
    {
        public string Operate { get; set; }
        public string UserID { get; set; }

        public string AppIDTo { get; set; }
        public string IncludeMemberS { get; set; }
        public string IncludeMemberT { get; set; }

    }
}
