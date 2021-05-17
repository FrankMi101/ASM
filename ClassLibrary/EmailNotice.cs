using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class EmailNotice
    {
        public string EmailType { get; set; }
        public string EmailTo { get; set; }
        public string EmailCC { get; set; }
        public string EmailBcc { get; set; }
        public string EmailFrom { get; set; }
        public string EmailSubject { get; set; }
        public string EmailBody { get; set; }
        public string EmailFormat { get; set; }
        public string Attachment1 { get; set; }
        public string Attachment2 { get; set; }
        public string Attachment3 { get; set; }
        public string FileName { get; set; }
        public string FileType { get; set; }
        public byte[] FileMemory { get; set; }
    }
  
    public class EmailNoticePara
    {
        public string Operate { get; set; }
        public string UserID { get; set; }
        public string SchoolYear { get; set; }
        public string SchoolCode { get; set; }
        public string EmployeeID { get; set; }
        public string SessionID { get; set; }
        public string NoticeType { get; set; }
        public string NoticeArea { get; set; }
        public string NoticeDate { get; set; }
        public string DeadLineDate { get; set; }
        public string NoticeSubject { get; set; }
        public string Comments { get; set; }
        public string eMailAddress { get; set; }
        public string eMailSubject { get; set; }
        public string eMailBody { get; set; }
        public string Template { get; set; }
        public string TemplateType { get; set; }
        public string AutoNotice { get; set; }

    }

}
