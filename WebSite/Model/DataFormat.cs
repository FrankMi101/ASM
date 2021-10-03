using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ASM 
{
    
    public class DateFC
    {
        public DateFC()
        { }
        public static string Format(DateTime pDate, string pFormat)
        {
            return BLL.DateFC.Format(pDate, pFormat);   
        }

        public static DateTime YMD(string eDate)
        {
            return BLL.DateFC.YMD(eDate);
        }

        public static string YMD(DateTime vDate)
        {
            return BLL.DateFC.YMD(vDate);
        }

        public static int Age(DateTime birthdate)
        {
            return BLL.DateFC.Age(birthdate);
        }
        public static int Age(DateTime birthdate, DateTime comparedate)
        {
            return BLL.DateFC.Age(birthdate, comparedate);
        }

        public static string SchoolYearFrom(string strType, string cSchoolYear)
        {
            return BLL.DateFC.SchoolYearFrom(strType, cSchoolYear);
        }

        public static string SchoolYearNext(string strType, string cSchoolYear)
        {
            return BLL.DateFC.SchoolYearNext(strType, cSchoolYear);
        }

        public static string SchoolYearPrevious(string strType, string cSchoolYear)
        {
            return BLL.DateFC.SchoolYearPrevious(strType, cSchoolYear);
        }

        public static string YearTOGO(string strType, string cSchoolYear)
        {
            return BLL.DateFC.YearTOGO(strType, cSchoolYear);
        }
  
    }
}