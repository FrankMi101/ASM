namespace ClassLibrary
{
    public class StudentList : Student
    {
        public string Operate { get; set; }
        public string UserID { get; set; }
        public string SchoolYear { get; set; }
        public string SchoolCode { get; set; }
        public string SchoolName { get; set; }
        public int RowNo { get; set; }
        public string Actions { get; set; }

        public string Term { get; set; }
        public string Semester { get; set; }
        public string IsGift { get; set; }
        public string IsIEP { get; set; }
        public string IsIPRC { get; set; }
        public string IsAlternative { get; set; }
        public string IsSSN { get; set; }
        public string IsESL { get; set; }



    }
    public class StudentListSearch : StudentList
    {
        public string UserRole { get; set; }
        public string SearchBy { get; set; }
        public string SearchValue { get; set; }
    }

}
