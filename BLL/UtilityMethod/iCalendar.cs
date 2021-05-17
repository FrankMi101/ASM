using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;
using System.IO;

namespace BLL
{
    public class iCalendar
    {
        public iCalendar()
        { }
        
        public static byte[]  getiCalendarbyStringBuiding(string userID, DateTime sDate, DateTime eDate, string teacherName, string subject, string description, string location, string toMail, string appraiser)
        {
            try
            {
              
                DateTime beginDate = sDate; // _sD '#5/7/2005 4:00:00 PM#  '_sD '
                DateTime endDate = eDate;

                StringBuilder sb = new StringBuilder();
                string DateFormat = "yyyyMMddTHHmmssZ";
                string now = DateTime.Now.ToUniversalTime().ToString(DateFormat);
                sb.AppendLine("BEGIN:VCALENDAR");
                sb.AppendLine("PRODID:-//Compnay Inc//Product Application//EN");
                sb.AppendLine("VERSION:2.0");
                sb.AppendLine("METHOD:REQUEST");// ("METHOD:PUBLISH");    
                                                //foreach (var res in reg.Reservations)  {    }
                DateTime dtStart = Convert.ToDateTime(beginDate);
                DateTime dtEnd = Convert.ToDateTime(endDate);
                sb.AppendLine("BEGIN:VEVENT");
                sb.AppendLine("DTSTART:" + dtStart.ToUniversalTime().ToString(DateFormat));
                sb.AppendLine("DTEND:" + dtEnd.ToUniversalTime().ToString(DateFormat));
                sb.AppendLine("DTSTAMP:" + now);
                sb.AppendLine("UID:" + Guid.NewGuid());
                sb.AppendLine("CREATED:" + now);
                // sb.AppendLine("X-ALT-DESC;FMTTYPE=text/html:" + res.DetailsHTML);
                sb.AppendLine("DESCRIPTION:" + description); // res.Details);
                sb.AppendLine("LAST-MODIFIED:" + now);
                sb.AppendLine("LOCATION:" + location);  // res.Location);
                sb.AppendLine("SEQUENCE:0");
                sb.AppendLine("STATUS:CONFIRMED");
                sb.AppendLine("SUMMARY:" + subject);// res.Summary);
                sb.AppendLine("TRANSP:OPAQUE");
                sb.AppendLine("END:VEVENT");

                sb.AppendLine("END:VCALENDAR");
                var calendarBytes = Encoding.UTF8.GetBytes(sb.ToString());
                return calendarBytes;   

            }
            catch  
            {
                return new Byte[0];

            }

        }
        public static MemoryStream getiCalendarbySteamMemory(string userID, DateTime sDate, DateTime eDate, string teacherName, string subject, string description, string location, string toMail, string appraiser)
        {
                MemoryStream mStream = new MemoryStream();

                DateTime beginDate = sDate; // _sD '#5/7/2005 4:00:00 PM#  '_sD '
                DateTime endDate = eDate;
            try
            {
                 StreamWriter sw = new StreamWriter(mStream);
                sw.AutoFlush = true;

                sw.WriteLine("BEGIN:VCALENDAR");
                sw.WriteLine("PRODID:-//Microsoft Corporation//Outlook 11.0 MIMEDIR//EN");
                sw.WriteLine("VERSION:2.0");
                sw.WriteLine("METHOD:REQUEST");
                sw.WriteLine("BEGIN:VEVENT");
                sw.WriteLine("ATTENDEE;CN=" + teacherName + ";ROLE=REQ-PARTICIPANT;RSVP=TRUE:MAILTO:" + toMail);

                sw.WriteLine("ORGANIZER:MAILTO:" + appraiser);
                sw.WriteLine("DTSTART:" + beginDate.ToUniversalTime()); //.ToString("yyyyMMdd\\THHmmss\\Z"));
                sw.WriteLine("DTEND:" + endDate.ToUniversalTime()); //.ToString("yyyyMMdd\\THHmmss\\Z")); 
                sw.WriteLine("LOCATION:" + location);
                sw.WriteLine("TRANSP:OPAQUE");
                sw.WriteLine("SEQUENCE:0");
                sw.WriteLine("UID:SV0001");
                sw.WriteLine("DTSTAMP:20060901T223836Z");
                sw.WriteLine("SUMMARY:" + subject);
                sw.WriteLine("PRIORITY:1");
                sw.WriteLine("X-MICROSOFT-CDO-IMPORTANCE:1");
                sw.WriteLine("CLASS:PUBLIC");
                sw.WriteLine("BEGIN:VALARM");
                sw.WriteLine("TRIGGER:-PT15M");
                sw.WriteLine("ACTION:DISPLAY");
                sw.WriteLine("DESCRIPTION:" + description);
                sw.WriteLine("END:VALARM");
                sw.WriteLine("END:VEVENT");
                sw.WriteLine("END:VCALENDAR");

                return mStream;

            }
            catch  
            {
                return mStream;

            }

        }
    }
    public class iCalendar2
    {
        public DateTime EventStartDateTime { get; set; }
        public DateTime EventEndDateTime { get; set; }
        public DateTime EventTimeStamp { get; set; }
        public DateTime EventCreatedDateTime { get; set; }
        public DateTime EventLastModifiedTimeStamp { get; set; }
        public string UID { get; set; }
        public string EventDescription { get; set; }
        public string EventLocation { get; set; }
        public string EventSummary { get; set; }
        public string AlarmTrigger { get; set; }
        public string AlarmRepeat { get; set; }
        public string AlarmDuration { get; set; }
        public string AlarmDescription { get; set; }
        public iCalendar2()
        {
            EventTimeStamp = DateTime.Now;
            EventCreatedDateTime = EventTimeStamp;
            EventLastModifiedTimeStamp = EventTimeStamp;
        }
    }

  
}
