using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class UserGroup : AppClass
    {

        public string GroupID { get; set; }
        public string GroupName { get; set; }
        public string GroupType { get; set; }
        public string Permission { get; set; }
        public string IsActive { get; set; }
        public string SchoolCode { get; set; }
        public string HasMemberT { get; set; }
        public string MemberID { get; set; }

    }
    public class UserGroupMember : UserGroup
    {
        public string StartDate { get; set; }
        public string EndDate { get; set; }

    }
    public class UserGroupMemberStudent : UserGroupMember
    {
    }

    [StructLayout(LayoutKind.Sequential)]
    public class UserGroupMemberStudent1 : UserGroupMember
    {
    }
    public class UserGroupMemberTeacher : UserGroupMember
    {
    }
    public class UserGroupPush : UserGroup
    {
        public string AppIDTo { get; set; }
        public string IncludeStudent { get; set; }
        public string IncludeTeacher { get; set; }
    }
   
}
