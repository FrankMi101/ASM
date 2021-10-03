namespace ClassLibrary
{
    public class StaffList : Staff
    {
        public string Operate { get; set; }
        public string SchoolYear { get; set; }
        public int RowNo { get; set; }
        public string Actions { get; set; }
        public string SubAction { get; set; }
        public string ViewAction { get; set; }
        public string EditAction { get; set; }
        public string DeleteAction { get; set; }




    }
    public class StaffListSearch : StaffList
    {
        public string UserRole { get; set; }
        public string SearchBy { get; set; }
        public string SearchValue { get; set; }
        public string Scope { get; set; }
    }
    public class StaffMemberOf : StaffListSearch
    { }
}
