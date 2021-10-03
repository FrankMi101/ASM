using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Text;
using BLL;

namespace ASM  
{
    public class GetNoticeFile : AppsBase
    {
       
        public static string FileContentByType(string noticeType)
        {
            string bodyFile = "";
            string bodyContent = "";
            string fileName = GetHtmlFileName(noticeType);
            bodyFile = HttpContext.Current.Server.MapPath("..") + fileName;
            try
            {
                if (File.Exists(HttpContext.Current.Server.MapPath(fileName)))
                {
                    bodyContent = File.ReadAllText(bodyFile, Encoding.UTF8);
                }
            }

            catch
            {
                
            }
            return bodyContent;
        }
        private static string GetHtmlFileName(string noticeType)
        {
            string fileName = "";
            try
            {
                switch (noticeType)
                {
                    case "ALP":
                        fileName = "\\Template\\NoticeALP.htm";
                        break;
                    case "OBS":
                        fileName = "\\Template\\NoticeALP.htm";
                        break;
                    case "EPA":
                        fileName = "\\Template\\HtmlPage.html";
                        break;
                    default:
                        fileName = "\\Template\\NoticeALP.htm";
                        break;
                }
            }
            catch { }

            return fileName;
        }

        public static string EMailContentAppCategory(string action, string userId, string category, string noticeType, string noticeArea, string noticeGo, string noticeFrom, string purpose)
        {
           return  eMailNotification.NotificationeTemplate(action, userId, category, noticeType, noticeArea, noticeGo, noticeFrom, purpose);
        }
        public static string EMailContentByType(string action, string userId, string category, string noticeType, string noticeArea, string noticeGo, string noticeFrom,string purpose)
        {
            return eMailNotification.NotificationeTemplate(action, userId, category, noticeType, noticeArea, noticeGo, noticeFrom,purpose);
        }
        public static string EMailContentByType(string action, string userId, string category, string noticeType, string noticeArea, string noticeGo, string noticeFrom, string purpose, string noticdePurpose)
        {
            return eMailNotification.NotificationeTemplate(action, userId, category, noticeType, noticeArea,noticeGo, noticeFrom, purpose, noticdePurpose);
        }
        public static string EMailContentByType(string action, string userId, string category, string noticeType, string noticeArea, string noticeGo, string noticeFrom, string purpose,  string subject, string template)
        {
            return eMailNotification.NotificationeTemplate(action, userId, category, noticeType, noticeArea, noticeGo, noticeFrom,purpose,subject,template);
        }
        public static string EMailContentByTemplate(string action, string userId, string category, string noticeType, string noticeArea, string noticeGo, string noticeFrom, string purpose  )
        {
            return eMailNotification.NotificationeTemplatePersonal(action, userId, category, noticeType, noticeArea, noticeGo, noticeFrom, purpose );
        }
        public static string EMailContentByTemplate(string action, string userId, string category, string noticeType, string noticeArea, string noticeGo, string noticeFrom, string purpose, string templateType)
        {
            return eMailNotification.NotificationeTemplatePersonal(action, userId, category, noticeType, noticeArea, noticeGo, noticeFrom, purpose, templateType);
        }
        public static string EMailContentByTemplate(string action, string userId, string category, string noticeType, string noticeArea, string noticeGo, string noticeFrom, string purpose, string templateType, string subject, string template, string autoNotice)
        {
            return eMailNotification.NotificationeTemplatePersonal(action, userId, category, noticeType, noticeArea, noticeGo, noticeFrom, purpose, templateType, subject, template, autoNotice);
        }
    }
}
 