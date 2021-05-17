namespace ClassLibrary
{
    public class StaffList : Staff
    {
        public string Operate { get; set; }
        public string SchoolYear { get; set; }
        public int RowNo { get; set; }
        public string Actions { get; set; }
         



    }
    public class StaffListSearch : StaffList
    {
        public string UserRole { get; set; }
        public string SearchBy { get; set; }
        public string SearchValue { get; set; }
        public string Scope { get; set; }
    }

}
