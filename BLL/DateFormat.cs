using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
   public  class DateFormat
    {
        public static string DateF(DateTime datetime, string dFormat)
        {
            switch (dFormat)
            {
                case "YMD":
                    return datetime.ToString("yyyy-MM-dd");
                case "YMDH":
                    return datetime.ToString("yyyy-MM-dd HH:mm");
                case "MDY":
                    return datetime.ToString("d");
                default:
                    return datetime.ToString("MM/dd/yyyy");
            }
        }

        public static string Format(DateTime pDate, string pFormat)
        {
           
            try
            {
                string rValue = "";
                if (pDate.GetType() ==  typeof(DateTime?))
                {
                  
                    string vYY = pDate.Year.ToString();
                    string vMM = pDate.Month.ToString();
                    string vDD = pDate.Day.ToString();
                    int iMM = pDate.Month; //.ToString();
                    int iDD = pDate.Day; //.ToString();
                    if (iMM < 10)
                    { vMM += "0"; }
                    if (iDD < 10)
                    { vDD += "0"; }
                    switch (pFormat)
                    {
                        case "YYYYMMDD":
                            rValue = vYY + "/" + vMM + "/" + vDD;
                            break;
                        case "DDMMYYYY":
                            rValue = vYY + "/" + vMM + "/" + vDD;
                            break;
                        case "MMDDYYYY":
                            rValue = vYY + "/" + vMM + "/" + vDD;
                            break;
                        case "MMMDDYYYYY":
                            rValue = pDate.ToShortDateString();
                            break;
                        default:
                            rValue = vYY + "/" + vMM + "/" + vDD;
                            break;
                    }
                }
                else
                { rValue = pDate.ToString(); }
                return rValue;
            }
            catch (Exception ex)
            {
                var exm = ex.Message;
                return pDate.ToString();
            }
        }

        public static DateTime YMD(string eDate)
        {
            try
            {
                string[] format = new[] { "dd/MM/yyyy", "d/M/yyyy", "dd-MM-yyyy", "yyyy/MM/dd" };
                DateTime oDate = DateTime.ParseExact(eDate, format, System.Globalization.DateTimeFormatInfo.InvariantInfo, System.Globalization.DateTimeStyles.None);
                return oDate;
            }
            catch (Exception)
            {
                return DateTime.Now;
            }
        }

        public static string YMD(DateTime vDate)
        {
            string rDate = "";
            if (vDate == null)
            { rDate = ""; }
            else
            {
                string vYY = vDate.Year.ToString();
                string vMM = vDate.Month.ToString();
                string vDD = vDate.Day.ToString();
                if (vDate.Month < 10)
                { vMM = "0" + vMM; }
                if (vDate.Day < 10)
                { vDD = "0" + vDD; }
                rDate = vYY + "/" + vMM + "/" + vDD;

            }
            return rDate;
        }

        public static int Age(DateTime BirthDate)
        {
            DateTime now = DateTime.Today;
            return Age(BirthDate, now);


        }
        public static int Age(DateTime birthdate, DateTime comparedate)
        {

            int age = comparedate.Year - birthdate.Year;
            if (comparedate < birthdate.AddYears(age))
            { age--; }

            return age;
        }


        public static string SchoolYearFrom(string strType, string cSchoolYear)
        {
            string bYear = cSchoolYear.Substring(0, 4);
            string eYear = cSchoolYear.Substring(4, 4);
            return bYear + strType + eYear;
        }

        public static string SchoolYearNext(string strType, string cSchoolYear)
        {
            string bYear = cSchoolYear.Substring(4, 4);
            int iYear = int.Parse(bYear) + 1;
            string eYear = iYear.ToString();
            return bYear + strType + eYear;
        }

        public static string SchoolYearPrevious(string strType, string cSchoolYear)
        {
            string eYear = cSchoolYear.Substring(0, 4);
            int iYear = int.Parse(eYear) - 1;

            string bYear = iYear.ToString();
            return bYear + strType + eYear;
        }

        public static string YearTOGO(string strType, string cSchoolYear)
        {
            string rSchoolyear = "";
            int thisYear = int.Parse(cSchoolYear.Substring(0, 4));
            int goYear = 0;
            if (strType == "Next")
            {
                goYear = thisYear + 1;
                rSchoolyear = thisYear.ToString() + goYear.ToString();
            }
            else
            {
                goYear = thisYear - 1;
                rSchoolyear = goYear.ToString() + thisYear.ToString();
            }
            return rSchoolyear;
        }
    
    }

}
 
