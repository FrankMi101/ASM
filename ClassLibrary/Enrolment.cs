using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class Enrolment : Student
    {
        public int RowNo { get; set; }
        public string EditAction { get; set; }
        public string Actions { get; set; }
        public string ActionType { get; set; }
        public string ActionName { get; set; }
        public string EffectiveDate { get; set; }
        public string SchoolYear { get; set; }
        public string SchoolYearTrack { get; set; }
        public string SchoolYearNext { get; set; }
        public string SchoolCode { get; set; }
        public string SchoolName { get; set; }
        public string SchoolNameNext { get; set; }
        public string SchoolCodeNext { get; set; }
        public string SchoolCodePre { get; set; }
        public string GradeNext { get; set; }
        public string ActiveFlag { get; set; }
        public string SchoolBrief { get; set; }
        public string SchoolBriefNext { get; set; }
        public string SchoolBriefPre { get; set; }
        public string SchoolBSID { get; set; }
        public string DemitNextBSID { get; set; }
        public string DemitNextSchoolCode { get; set; }
        public string SchoolBSIDPre { get; set; }

        public string CreatorUerID { get; set; }
        public string RegisterCode { get; set; }
        public string EnrolmentTypeID { get; set; }
        public string TransactionTypeID { get; set; }
        public string EnrolmentTypeName { get; set; }
        public string EntryTypeName { get; set; }
        public string FundingSourceType { get; set; }
        public string FundingPayerType { get; set; }
        public string FundingResidentFlag { get; set; }
        public string Remark { get; set; }

        public string LanguageInstruct { get; set; }
        public string DemitReasonName { get; set; }
        public string TransactionDateTime { get; set; }

        public string UpdateField { get; set; }
        public string UpdateValue { get; set; }
 
    }
}
