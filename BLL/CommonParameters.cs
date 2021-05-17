using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class CommonParameters
    {
        public static CommonListParameter GetListParameters(string operate, string userId, string para1, string para2, string para3)
        {
            var parameters = new CommonListParameter()
            {
                Operate = operate,
                UserID = userId,
                Para1 = para1,
                Para2 = para2,
                Para3 = para3,
            };
            return parameters;
        }

        public static EmailNotice GetEmailNoticeParamemeter(string emailTypemail, string emailTo, string emailCC, string emailBcc, string emailFrom, string emailFormat, string emailSubject, string emailBody, string att1, string att2, string att3)
        {
            EmailNotice parameters = new EmailNotice()
            {
                EmailType = emailTypemail,
                EmailTo = emailTo,
                EmailCC = emailCC,
                EmailBcc = emailBcc,
                EmailFrom = emailFrom,
                EmailFormat = emailFormat,
                EmailSubject = emailSubject,
                EmailBody = emailBody,
                Attachment1 = att1,
                Attachment2 = att2,
                Attachment3 = att3,
            };

            return parameters;
        }

    }  
}
