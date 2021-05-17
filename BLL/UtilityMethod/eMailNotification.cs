using ClassLibrary;
using System;
using System.IO;
using System.Net.Mail;
using System.Web;
using System.Web.Configuration;

namespace BLL
{
    public class eMailNotification
    {
        public eMailNotification()
        { }
        public static string SendMail(EmailNotice eNotice)
        {
            string result = "Failed";
            try
            {
                System.Net.Mail.SmtpClient myMail = new System.Net.Mail.SmtpClient();
                myMail.Host = WebConfigurationManager.AppSettings["SMTPServer"];

                var Mailmsg = new System.Net.Mail.MailMessage();
                Mailmsg = GetMailMsg(eNotice);
                try
                { myMail.Send(Mailmsg); }
                catch (Exception ex)
                {
                    string ms = ex.Message;
                }
                Mailmsg.Dispose();
                result = "Successfully";
            }
            catch (Exception ex)
            {
                string ms = ex.Message;
                result = "Failed";
            }
            return result;
        }
    
        public static string SendMailWithiCalendar(EmailNotice eNotice, System.Net.Mail.Attachment iCalendar)
        {


            string result = "Failed";
            try
            {
                System.Net.Mail.SmtpClient myMail = new System.Net.Mail.SmtpClient();
                myMail.Host = WebConfigurationManager.AppSettings["SMTPServer"];

                var Mailmsg = new System.Net.Mail.MailMessage();
                Mailmsg = GetMailMsg(eNotice);
                Mailmsg.Attachments.Add(iCalendar);
                try
                { myMail.Send(Mailmsg); }
                catch (Exception ex)
                {
                    string ms = ex.Message;
                }
                Mailmsg.Dispose();
                result = "Successfully";
            }
            catch (Exception ex)
            {
                string ms = ex.Message;
                result = "Failed";
            }
            return result;
        }
        public static string NoticeSave(EmailNoticePara eNorice)
        {
            return NotificationeMailSave(eNorice);
        }
        public static string NoticeSave(string operate, string userID, string schoolyear, string schoolcode, string employeeID, string sessionID, string noticeType, string noticeArea, string noticeDate, string deadlineDate, string subject, string eBody)
        {
            try
            {
                var parameter = new EmailNoticePara()
                {
                    Operate = operate,
                    UserID = userID,
                    SchoolYear = schoolyear,
                    SchoolCode = schoolcode,
                    EmployeeID = employeeID,
                    SessionID = sessionID,
                    NoticeType = noticeType,
                    NoticeArea = noticeArea,
                    NoticeDate = noticeDate,
                    DeadLineDate = deadlineDate,
                };
               return NoticeSave(parameter);

 

                //var eNotice = new EmailNotice
                //{
                //    EmailTo = NotificationeMail("NoticeUser", parameter),
                //    EmailCC = NotificationeMail("CCUser", parameter),
                //    EmailFrom = NotificationeMail("OperateUser", parameter),
                //    EmailBcc = "",
                //    EmailSubject = subject,
                //    EmailBody = eBody,
                //    EmailFormat = "HTML"
                //};

                //string result = SendMail(eNotice);
                //return result;
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }

        }
        private static void CheckTestMailBody(ref EmailNotice eNotice)
        {
            if (WebConfigurationManager.AppSettings["eMailTry"] == "Test")
            {
                eNotice.EmailBody = eNotice.EmailBody.Replace("{{PlaceHolder:TestEmailTo}}", "Email To: " + eNotice.EmailTo);
                eNotice.EmailBody = eNotice.EmailBody.Replace("{{PlaceHolder:TestEmailCC}}", "Email CC: " + eNotice.EmailCC);
                eNotice.EmailTo = eNotice.EmailFrom;
                eNotice.EmailCC = "frank_ml@hotmail.com";
                eNotice.EmailBcc = "";
            }
            else
            {
                eNotice.EmailBody = eNotice.EmailBody.Replace("{{PlaceHolder:TestEmailTo}}", "");
                eNotice.EmailBody = eNotice.EmailBody.Replace("{{PlaceHolder:TestEmailCC}}", "");
            }

            string applicationSite = WebConfigurationManager.AppSettings["ApplicationSite"];
            if (eNotice.EmailFormat == "HTML")
            {
                string appUrl = " <a href=' " + applicationSite + "' target='_blank'>  Teacher Performance Appraisal </a>";
                eNotice.EmailBody = eNotice.EmailBody.Replace("{{PlaceHolder:WebSite}}", appUrl);
                eNotice.EmailBody = eNotice.EmailBody.Replace("{{PlaceHolder:OneLine}}", "<br />");

            }
            else
            {
                eNotice.EmailBody = eNotice.EmailBody.Replace("{{PlaceHolder:WebSite}}", applicationSite);
                eNotice.EmailBody = eNotice.EmailBody.Replace("{{PlaceHolder:OneLine}}", "");
            }

        }
        private static System.Net.Mail.MailMessage GetMailMsg(EmailNotice eNotice)
        {
            try
            {
                CheckTestMailBody(ref eNotice);

                var Mailmsg = new System.Net.Mail.MailMessage();
                Mailmsg.To.Clear();
                LoopAddress("mailTo", eNotice.EmailTo, ref Mailmsg);
                LoopAddress("mailCC", eNotice.EmailCC, ref Mailmsg);
                LoopAddress("mailBcc", eNotice.EmailBcc, ref Mailmsg);
                LoopAddress("mailFrom", eNotice.EmailFrom, ref Mailmsg);
                Mailmsg.Subject = eNotice.EmailSubject;

                Mailmsg.Priority = MailPriority.High;
                if (eNotice.EmailFrom == "HTML")
                { Mailmsg.IsBodyHtml = true; }
                Mailmsg.Body = eNotice.EmailBody;

                if (!string.IsNullOrEmpty(eNotice.Attachment1)) AddAttachments(eNotice.Attachment1, ref Mailmsg);
                if (!string.IsNullOrEmpty(eNotice.Attachment2)) AddAttachments(eNotice.Attachment2, ref Mailmsg);
                if (!string.IsNullOrEmpty(eNotice.Attachment3)) AddAttachments(eNotice.Attachment3, ref Mailmsg);

                if (eNotice.FileMemory != null)
                {
                    MemoryStream attaStream = new MemoryStream(eNotice.FileMemory);
                    attaStream.Position = 0;
                    System.Net.Mime.ContentType contentType = new System.Net.Mime.ContentType(eNotice.FileType); // "application/pdf");
                    System.Net.Mail.Attachment attaFile = new Attachment(attaStream, contentType);
                    attaFile.ContentDisposition.FileName = eNotice.FileName;
                    Mailmsg.Attachments.Add(attaFile);
                }

                return Mailmsg;
            }
            catch (Exception ex)
            {
                string ms = ex.Message;
                return null;
            }
        }
       
        public static string SendMail(string eMailTo, string eMailCC, string eMailBcc, string eMailForm, string eMailSubject, string eMailBody, string eMailFormat, System.Net.Mail.Attachment iCal)
        {
            var eNotice = new EmailNotice
            {
                EmailTo = eMailTo,
                EmailCC =eMailCC,
                EmailFrom = eMailForm,
                EmailBcc = eMailBcc,
                EmailSubject = eMailSubject,
                EmailBody = eMailBody,
                EmailFormat = eMailFormat 
            };

            return SendMail(eNotice);

        }
        public static string SendMail(string eMailTo, string eMailCC, string eMailBcc, string eMailForm, string eMailSubject, string eMailBody, string eMailFormat)
        {
            var eNotice = new EmailNotice
            {
                EmailTo = eMailTo,
                EmailCC = eMailCC,
                EmailFrom = eMailForm,
                EmailBcc = eMailBcc,
                EmailSubject = eMailSubject,
                EmailBody = eMailBody,
                EmailFormat = eMailFormat
            };

            return SendMail(eNotice);

        }

        private static string AssemblingeMail(string eMailTo, string eMailCC, string eMailBCC, string eMailForm, string eMailSubject, string eMailBody, string eMailFormat)
        {
            string result = "Failed";
            try
            {
                System.Net.Mail.SmtpClient myMail = new System.Net.Mail.SmtpClient();
                myMail.Host = WebConfigurationManager.AppSettings["SMTPServer"];

                System.Net.Mail.MailMessage Mailmsg = new System.Net.Mail.MailMessage();
                Mailmsg.To.Clear();
                LoopAddress("mailTo", eMailTo, ref Mailmsg);
                LoopAddress("mailCC", eMailCC, ref Mailmsg);
                LoopAddress("mailBcc", eMailBCC, ref Mailmsg);
                LoopAddress("mailFrom", eMailForm, ref Mailmsg);


                Mailmsg.Subject = eMailSubject;
                Mailmsg.Priority = MailPriority.High;
                if (eMailFormat == "HTML")
                { Mailmsg.IsBodyHtml = true; }
                Mailmsg.Body = eMailBody;
                try
                { myMail.Send(Mailmsg); }
                catch (Exception ex)
                {
                    string ms = ex.Message;
                }
                Mailmsg.Dispose();
                result = "Successfully";
            }
            catch (Exception ex)
            {
                string ms = ex.Message;
                result = "Failed";
            }
            return result;
        }
        private static string AssemblingeMail(string eMailTo, string eMailCC, string eMailBCC, string eMailForm, string eMailSubject, string eMailBody, string eMailFormat, System.Net.Mail.Attachment iCalendar)
        {
            string result = "Failed";
            try
            {
                System.Net.Mail.SmtpClient myMail = new System.Net.Mail.SmtpClient();
                myMail.Host = WebConfigurationManager.AppSettings["SMTPServer"];

                System.Net.Mail.MailMessage Mailmsg = new System.Net.Mail.MailMessage();

                Mailmsg.To.Clear();
                LoopAddress("mailTo", eMailTo, ref Mailmsg);
                LoopAddress("mailCC", eMailCC, ref Mailmsg);
                LoopAddress("mailBcc", eMailBCC, ref Mailmsg);
                LoopAddress("mailFrom", eMailForm, ref Mailmsg);

                Mailmsg.Attachments.Add(iCalendar);

                Mailmsg.Subject = eMailSubject;
                Mailmsg.Priority = MailPriority.High;
                if (eMailFormat == "HTML")
                { Mailmsg.IsBodyHtml = true; }
                Mailmsg.Body = eMailBody;

                try
                { myMail.Send(Mailmsg); }
                catch (Exception ex)
                {
                    string ms = ex.Message;
                }
                Mailmsg.Dispose();
                result = "Successfully";
            }
            catch
            {
                result = "Failed";
            }
            return result;
        }
        private static string AssemblingeMail(string eMailTo, string eMailCC, string eMailBCC, string eMailForm, string eMailSubject, string eMailBody, string eMailFormat, string attachement1, string attachement2)
        {
            string result = "Failed";
            try
            {
                System.Net.Mail.SmtpClient myMail = new System.Net.Mail.SmtpClient();
                myMail.Host = WebConfigurationManager.AppSettings["SMTPServer"];

                System.Net.Mail.MailMessage Mailmsg = new System.Net.Mail.MailMessage();
                Mailmsg.To.Clear();
                LoopAddress("mailTo", eMailTo, ref Mailmsg);
                LoopAddress("mailCC", eMailCC, ref Mailmsg);
                LoopAddress("mailBCC", eMailBCC, ref Mailmsg);
                LoopAddress("mailFrom", eMailForm, ref Mailmsg);


                Mailmsg.Subject = eMailSubject;
                Mailmsg.Priority = MailPriority.High;
                if (eMailFormat == "HTML")
                { Mailmsg.IsBodyHtml = true; }
                Mailmsg.Body = eMailBody;
                if (attachement1 != "") AddAttachments(attachement1, ref Mailmsg);

                if (attachement2 != "") AddAttachments(attachement2, ref Mailmsg);

                try
                { myMail.Send(Mailmsg); }
                catch
                { }
                Mailmsg.Dispose();
                result = "Successfully";
            }
            catch
            {
                result = "Failed";
            }
            return result;
        }
        private static void AddAttachments(string atta, ref System.Net.Mail.MailMessage Mailmsg)
        {
            System.Net.Mail.Attachment myAttachment = new System.Net.Mail.Attachment(atta);
            Mailmsg.Attachments.Add(myAttachment);
        }
        private static void LoopAddress(string Type, string eMailADD, ref System.Net.Mail.MailMessage Mailmsg)
        {
            if (eMailADD.IndexOf("@") > 0)
            {
                string[] myArray = eMailADD.Split(';');
                for (int x = 0; x < myArray.Length; x++)
                {
                    try
                    {
                        AddAddress(Type, myArray[x], ref Mailmsg);
                    }
                    catch
                    { }

                }


                //if (eMailADD.IndexOf(";") > 0)
                //{ string[] myArray = eMailADD.Split(';');
                //    for (int x = 0; x < myArray.Length - 1; x++)
                //    {  AddAddress(Type, myArray[x], ref Mailmsg);
                //    }
                //}
                //else
                //{  AddAddress(Type, eMailADD, ref Mailmsg);
                //}
            }
            else
            { }
        }
        private static void AddAddress(string addType, string eMailADD, ref System.Net.Mail.MailMessage Mailmsg)
        {
            try
            {
                if (eMailADD.IndexOf("@") > 0)
                {

                    switch (addType)
                    {
                        case "mailTo":
                            Mailmsg.To.Add(new System.Net.Mail.MailAddress(eMailADD));
                            break;
                        case "mailCC":
                            Mailmsg.CC.Add(new System.Net.Mail.MailAddress(eMailADD));
                            break;
                        case "mailBcc":
                            Mailmsg.Bcc.Add(new System.Net.Mail.MailAddress(eMailADD));
                            break;
                        default:
                            Mailmsg.From = new System.Net.Mail.MailAddress(eMailADD);
                            break;
                    }
                }

            }
            catch { }

        }
        private static string getEmailBodyByType(string operate, string userID, string schoolyear, string schoolcode, string employeeid, string noticeType)
        {
            string ebody = "";
            switch (noticeType)
            {
                case "ALP":
                    ebody = "Annual Learning Plan notification";
                    break;
                case "EPA":
                    ebody = "Performance Appraisal Notification";
                    break;
                case "STR":
                    ebody = "NTIP Strategy Form Sign Off Notification";
                    break;
                default:
                    ebody = "EPA email Notification";
                    break;
            }
            return ebody;
        }
        private static string getEmailSubjectByType(string operate, string userID, string schoolyear, string schoolcode, string employeeid, string noticeType)
        {
            string ebody = "";
            switch (noticeType)
            {
                case "ALP":
                    ebody = "Annual Learning Plan notification";
                    break;
                case "EPA":
                    ebody = "Performance Appraisal Notification";
                    break;
                case "STR":
                    ebody = "NTIP Strategy Form Sign Off Notification";
                    break;
                default:
                    ebody = "EPA email Notification";
                    break;
            }
            return ebody;
        }

        public static string FeedBackeMail(string operate, string userID, string noticType)
        {
            try
            {
                var parameter = new
                {
                    Operate = operate,
                    UserID = HttpContext.Current.User.Identity.Name,
                    NoticeType = noticType
                };
                string sp = GetSP("FeedBackeMail");
                return CommonExecute<string>.ValueOfT(sp, parameter);

            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }
        }
        public static string FeedBackeMail(string operate, string userID, string noticeType, string emailAddress)
        {
            try
            {
                var parameter = new
                {
                    Operate = operate,
                    UserID = HttpContext.Current.User.Identity.Name,
                    NoticeType = noticeType,
                    eMailAddress = emailAddress
                };
                string sp = GetSP("FeedBackeMailSave");
                return CommonExecute<string>.ValueOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }
        }
        public static string NotificationeMail(string operate, string userID, string schoolyear, string schoolcode, string employeeId, string sessionID, string noticeType, string noticeArea)
        {
            var parameter = new EmailNoticePara()
            {
                Operate = operate,
                UserID = userID,
                SchoolYear = schoolyear,
                SchoolCode = schoolcode,
                EmployeeID = employeeId,
                SessionID = sessionID,
                NoticeType = noticeType,
                NoticeArea = noticeArea
            };

            string sp = GetSP("NotificationeMail");
            return CommonExecute<string>.ValueOfT(sp, parameter);
        }

        public static string NotificationeMail(object parameter)
        {
            try
            {
                string sp = GetSP("NotificationeMail");
                return CommonExecute<string>.ValueOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }
        }
        public static string NotificationeMailUser(string objType, EmailNoticePara parameter)
        {
            try
            {
                parameter.NoticeType = objType;

                string sp = GetSP("NotificationeUserEmail");
                return CommonExecute<string>.ValueOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }
        }
        public static string NotificationeMailSave(object parameter)
        {
            try
            {
                string sp = GetSP("NotificationeMailSave");
                return CommonExecute<string>.ValueOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }
        }
        public static string NotificationeTemplate(string operate, string userID, string category, string noticeType, string noticeArea, string noticeGo, string noticeFrom, string purpose)

        {
            try
            {
                var parameter = new
                {
                    Operate = operate,
                    UserID = HttpContext.Current.User.Identity.Name,
                    Category = category,
                    NoticeType = noticeType,
                    NoticeArea = noticeArea,
                    NoticeGo = noticeGo,
                    NoticeFrom = noticeFrom,
                    Purpose = purpose
                };
                string sp = GetSP("NotificationeTemplate");
                return CommonExecute<string>.ValueOfT(sp, parameter);

            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }
        }
        public static string NotificationeTemplate(string operate, string userID, string category, string noticeType, string noticeArea, string noticeGo, string noticeFrom, string purpose, string subject)

        {
            try
            {
                var parameter = new
                {
                    Operate = operate,
                    UserID = HttpContext.Current.User.Identity.Name,
                    Category = category,
                    NoticeType = noticeType,
                    NoticeArea = noticeArea,
                    NoticeGo = noticeGo,
                    NoticeFrom = noticeFrom,
                    Purpose = purpose,
                    Subject = subject
                };
                string sp = GetSP("NotificationeTemplateSave");
                return CommonExecute<string>.ValueOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }
        }
        public static string NotificationeTemplate(string operate, string userID, string category, string noticeType, string noticeArea, string noticeGo, string noticeFrom, string purpose, string subject, string template)

        {
            try
            {
                var parameter = new
                {
                    Operate = operate,
                    UserID = HttpContext.Current.User.Identity.Name,
                    Category = category,
                    NoticeType = noticeType,
                    NoticeArea = noticeArea,
                    NoticeGo = noticeGo,
                    NoticeFrom = noticeFrom,
                    Purpose = purpose,
                    Subject = subject,
                    Template = template
                };
                string sp = GetSP("NotificationeTemplateSaveSubject");
                return CommonExecute<string>.ValueOfT(sp, parameter);


            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }
        }
        public static string NotificationeTemplatePersonal(string operate, string userID, string category, string noticeType, string noticeArea, string noticeGo, string noticeFrom, string purpose)

        {
            try
            {
                var parameter = new
                {
                    Operate = operate,
                    UserID = HttpContext.Current.User.Identity.Name,
                    Category = category,
                    NoticeType = noticeType,
                    NoticeArea = noticeArea,
                    NoticeGo = noticeGo,
                    NoticeFrom = noticeFrom,
                    Purpose = purpose
                };
                string sp = GetSP("NotificationeTemplatePersonal");
                return CommonExecute<string>.ValueOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }
        }
        public static string NotificationeTemplatePersonal(string operate, string userID, string category, string noticeType, string noticeArea, string noticeGo, string noticeFrom, string purpose, string templateType)

        {
            try
            {
                var parameter = new
                {
                    Operate = operate,
                    UserID = HttpContext.Current.User.Identity.Name,
                    Category = category,
                    NoticeType = noticeType,
                    NoticeArea = noticeArea,
                    NoticeGo = noticeGo,
                    NoticeFrom = noticeFrom,
                    Purpose = purpose,
                    TemplateType = templateType
                };
                string sp = GetSP("NotificationeTemplatePersonalSave");
                return CommonExecute<string>.ValueOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }
        }
        public static string NotificationeTemplatePersonal(string operate, string userID, string category, string noticeType, string noticeArea, string noticeGo, string noticeFrom, string purpose, string templateType, string subject, string template, string autoNotice)

        {
            try
            {
                var parameter = new
                {
                    Operate = operate,
                    UserID = HttpContext.Current.User.Identity.Name,
                    Category = category,
                    NoticeType = noticeType,
                    NoticeArea = noticeArea,
                    NoticeGo = noticeGo,
                    NoticeFrom = noticeFrom,
                    Purpose = purpose,
                    TemplateType = templateType,
                    Subject = subject,
                    Template = template,
                    AutoNotice = autoNotice
                };
                string sp = GetSP("NotificationeTemplatePersonalSaveAuto");
                return CommonExecute<string>.ValueOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }
        }


        public static string GetSP(string action)
        {
            if (SPSource.SPFile == "")
            { return GetSPInClass(action); }
            else
            { return "";// JsonFileReadSP.GetSPFromJsonFile(action);
            }

        }

        private static string GetSPInClass(string action)
        {

            string parameters = " @Operate,@UserID";
            string parameters1 = parameters + ",@SchoolYear,@SchoolCode,@EmployeeID,@SessionID,@NoticeType,@NoticeArea";
            string parameters2 = parameters + ",@Category,@NoticeType,@NoticeArea,@NoticeGo,@NoticeFrom,@Purpose";


            switch (action)
            {
                case "FeedBackeMail":
                    return "dbo.EPA_sys_EmailFeedBack" + parameters;
                case "FeedBackeMailSave":
                    return "dbo.EPA_sys_EmailFeedBack" + parameters + ",@eMailAddress";
 
                case "NotificationeUserEmail":
                    return "dbo.EPA_Appr_AppraisalProcess_EmailUser" + parameters + "@SchoolYear,@SchoolCode,@EmployeeID,@SessionID,@NoticeType";
                case "NotificationeMail":
                    return "dbo.EPA_Appr_AppraisalProcess_Notification" + parameters1;
                case "NotificationeMailSave":
                    return "dbo.EPA_Appr_AppraisalProcess_Notification" + parameters1 + ",@NoticeDate,@DeadlineDate,@NoticeSubject,@Comments";
                case "NotificationeTemplate":
                    return "dbo.EPA_Appr_AppraisalProcess_NotificationTemplate" + parameters2;
                case "NotificationeTemplateSave":
                    return "dbo.EPA_Appr_AppraisalProcess_NotificationTemplate" + parameters2 + ",@Subject";
                case "NotificationeTemplateSaveSubject":
                    return "dbo.EPA_Appr_AppraisalProcess_NotificationTemplate" + parameters2 + ",@Subject,@Template";
                case "NotificationeTemplatePersonal":
                    return "dbo.EPA_Appr_AppraisalProcess_NotificationTemplatePersonal" + parameters2;
                case "NotificationeTemplatePersonalSave":
                    return "dbo.EPA_Appr_AppraisalProcess_NotificationTemplatePersonal" + parameters2 + ",@TemplateType,@Subject";
                case "NotificationeTemplatePersonalSaveAuto":
                    return "dbo.EPA_Appr_AppraisalProcess_NotificationTemplatePersonal" + parameters2 + ",@TemplateType,@Subject,@Template,@AutoNotice";

                default:
                    return action;

            }
        }




    }
}
