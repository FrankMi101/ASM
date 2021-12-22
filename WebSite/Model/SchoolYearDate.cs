using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ASM.Model
{
    public class SchoolYearDate
    {
        private readonly string _dateStart;
        private readonly string _dateEnd;
        private readonly string _dateToday;
        public SchoolYearDate()
        {
            var parameter = new 
            {
                Operate = "SchoolYearDate",
                UserID = WorkingProfile.UserId,
                UserRole = WorkingProfile.UserRole,
                SchoolYear = WorkingProfile.SchoolYear,
                SchoolCode = WorkingProfile.SchoolCode,
            };
            var myDate = ListData.SearchGeneralList<SchoolDateStr>("SchoolDateList", parameter);

            _dateStart = myDate[0].StartDate.ToString();
            _dateEnd = myDate[0].EndDate.ToString();
            _dateToday = myDate[0].TodayDate.ToString();
        }

        public string StartDate()
        {
            return _dateStart;
        }
        public string EndDate()
        {
            return _dateEnd;
        }
       public string TodayDate()
        {
            return _dateToday;
        }
    }
}