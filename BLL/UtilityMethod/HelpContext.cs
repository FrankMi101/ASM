
using System;
using System.Data;
using System.Web;

namespace BLL
{
    public class MessagesTips
    {
        public MessagesTips()
        { }
        public static string Message(string _aID, string _cID, string _pID, string _iID)
        {
            try
            {
                var parameter = new
                {
                    UserID = HttpContext.Current.User.Identity.Name,
                    ApplID = _aID,
                    CategoryID = _cID,
                    PageID = _pID,
                    ItemID = _iID 
                };
                string sp = "dbo.EPA_sys_TitleMessage @UserID,@ApplID,@CategoryID,@PageID,@ItemID";
                return HelpContentValue.GetValue(sp, parameter);
               
            }
            catch (Exception ex)
            { return "" + ex.Message; }
            finally
            { }
        }
        public static string Message(string _UserID, string _aID, string _cID, string _pID, string _iID, string _value)
        {
            try
            {
                var parameter = new
                {
                    UserID = _UserID,
                    ApplID = _aID,
                    CategoryID = _cID,
                    PageID = _pID,
                    ItemID = _iID,
                    Value = _value
                };
                string sp = "dbo.EPA_sys_TitleMessage @UserID,@ApplID,@CategoryID,@PageID,@ItemID,@Value";
                return HelpContentValue.GetValue(sp, parameter);
            }
            catch (Exception ex)
            { return "Fail - " + ex.Message; }
            finally
            { }

        }
        public static string Tips(string _aID, string _cID, string _pID, string _iID)
        {
            try
            {
                var parameter = new
                {
                    UserID = HttpContext.Current.User.Identity.Name,
                    ApplID = _aID,
                    CategoryID = _cID,
                    PageID = _pID,
                    ItemID = _iID
                };
                string sp = "dbo.EPA_sys_TitleTips @UserID,@ApplID,@CategoryID,@PageID,@ItemID";
                return HelpContentValue.GetValue(sp, parameter);
 
            }
            catch (Exception ex)
            { return "" + ex.Message; }
            finally
            { }
        }
        public static string Tips(string _UserID, string _aID, string _cID, string _pID, string _iID, string _value)
        {
            try
            {
                var parameter = new
                {
                    UserID = HttpContext.Current.User.Identity.Name,
                    ApplID = _aID,
                    CategoryID = _cID,
                    PageID = _pID,
                    ItemID = _iID,
                    Value = _value
                };
                string sp = "dbo.EPA_sys_TitleTips @UserID,@ApplID,@CategoryID,@PageID,@ItemID,@Value";
                return HelpContentValue.GetValue(sp, parameter);
            }
            catch (Exception ex)
            { return "Fail - " + ex.Message; }
            finally
            { }

        }
    }
    public class Title
    {
        public Title()
        { }
        public static string Url(string _model, string _iID, string _labelTitle)
        {
            string _url = _url = "<a title =" + '"' + "Edit DropDown List" + '"' + " href=" + '"' + "javascript:openListEditPage('" + _iID + "')" + '"' + ">" + _labelTitle + "</a> ";

            return _url;
        }
        public static string Url(string myOBJ, string _model, string _aID, string _cID, string _pID, string _iID, string _labelTitle)
        {
            string _url = "";
            switch (_model)
            {
                case "Design":
                    _url = "<a title =" + '"' + "Entry Title" + '"' + " href=" + '"' + "javascript:openEditPage('Show','Title','" + myOBJ + "','" + _aID + "','" + _cID + "','" + _pID + "','" + _iID + "')" + '"' + ">" + _labelTitle + "</a> ";
                    break;
                case "Upload":
                    _url = "<a title =" + '"' + "Upload file" + '"' + " href=" + '"' + "javascript:openEditPage('Show','Upload','" + myOBJ + "','" + _aID + "','" + _cID + "','" + _pID + "','" + _iID + "')" + '"' + ">" + _labelTitle + "</a> ";
                    // _url = "<A title =" + "'Upload file" + " href=" + "'javascript:openEditPage('Show','Upload','" + myOBJ + "','" + _aID + "','" + _cID + "','" + _pID + "','" + _iID + "')" + "'>";
                    break;
                case "DDLEdit":
                    _url = "<a title =" + '"' + "Edit DropDown List" + '"' + " href=" + '"' + "javascript:openListEditPage('" + myOBJ + "','" + _aID + "','" + _cID + "','" + _pID + "','" + _iID + "')" + '"' + ">" + _labelTitle + "</a> ";
                    break;
                case "DDLEdit2":
                    _url = "<a title =" + '"' + "Edit DropDown List" + '"' + " href=" + '"' + "javascript:openListEditPage('" + _iID + "')" + '"' + ">" + _labelTitle + "</a> ";
                    break;
                case "MenuItem":
                    _url = "<a title =" + '"' + "Entry Title" + '"' + " href=" + '"' + "javascript:openMenuEditPage('Show','Title','" + myOBJ + "','" + _aID + "','" + _cID + "','" + _pID + "','" + _iID + "')" + '"' + ">" + _labelTitle + "</a> ";
                    break;
                default:
                    _url = "<a title =" + '"' + "Entry Title" + '"' + " href=" + '"' + "javascript:openEditPage('Show','Title','" + myOBJ + "','" + _aID + "','" + _cID + "','" + _pID + "','" + _iID + "')" + '"' + ">" + _labelTitle + "</a> ";
                    break;
            }
            return _url;
        }
        public static string Url(string myOBJ, string _model, string _aID, string _cID, string _pID, string _iID, string _gID, string _labelTitle)
        {
            string _url = "";
            switch (_model)
            {
                case "Design":
                    _url = "<a title =" + '"' + "Entry Title" + '"' + " href=" + '"' + "javascript:openEditPage('Show','Title','" + myOBJ + "','" + _aID + "','" + _cID + "','" + _pID + "','" + _iID + "')" + '"' + ">" + _labelTitle + "</a> ";
                    break;
                case "Upload":
                    _url = "<a title =" + '"' + "Upload file" + '"' + " href=" + '"' + "javascript:openEditPage('Show','Upload','" + myOBJ + "','" + _aID + "','" + _cID + "','" + _pID + "','" + _iID + "')" + '"' + ">" + _labelTitle + "</a> ";
                    // _url = "<A title =" + "'Upload file" + " href=" + "'javascript:openEditPage('Show','Upload','" + myOBJ + "','" + _aID + "','" + _cID + "','" + _pID + "','" + _iID + "')" + "'>";
                    break;
                case "DDLEdit":
                    _url = "<a title =" + '"' + "Edit DropDown List" + '"' + " href=" + '"' + "javascript:openListEditPage('" + myOBJ + "','" + _aID + "','" + _cID + "','" + _pID + "','" + _iID + "')" + '"' + ">" + _labelTitle + "</a> ";
                    break;
                case "DDLEdit2":
                    _url = "<a title =" + '"' + "Edit DropDown List" + '"' + " href=" + '"' + "javascript:openListEditPage('" + _iID + "')" + '"' + ">" + _labelTitle + "</a> ";
                    break;
                case "ListItem":
                    _url = "<a title =" + '"' + "Entry Title" + '"' + " href=" + '"' + "javascript:openListEditPage('Show','Title','" + myOBJ + "','" + _aID + "','" + _cID + "','" + _pID + "','" + _iID + "','" + _gID + "')" + '"' + ">" + _labelTitle + "</a> ";
                    break;
                default:
                    _url = "<a title =" + '"' + "Entry Title" + '"' + " href=" + '"' + "javascript:openEditPage('Show','Title','" + myOBJ + "','" + _aID + "','" + _cID + "','" + _pID + "','" + _iID + "')" + '"' + ">" + _labelTitle + "</a> ";
                    break;
            }
            return _url;
        }
        public static string Name(string _UserID, string _aID, string _cID, string _pID, string _iID)
        {
            try
            {
                var parameter = new
                {
                    UserID = _UserID,
                    ApplID = _aID,
                    CategoryID = _cID,
                    PageID = _pID,
                    ItemID = _iID
                };
                string sp = "dbo.EPA_sys_Title @UserID,@ApplID,@CategoryID,@PageID,@ItemID";
                return HelpContentValue.GetValue(sp, parameter);
            }
            catch (Exception ex)
            { return "" + ex.Message; }
            finally
            { }
        }
        public static string Name(string _UserID, string _aID, string _cID, string _pID, string _iID, string _value)
        {
            try
            {
                var parameter = new
                {
                    UserID = _UserID,
                    ApplID = _aID,
                    CategoryID = _cID,
                    PageID = _pID,
                    ItemID = _iID,
                    Value = _value
                };
                string sp = "dbo.EPA_sys_Title @UserID,@ApplID,@CategoryID,@PageID,@ItemID,@Value";
                return HelpContentValue.GetValue(sp, parameter);

  
            }
            catch (Exception ex)
            { return "Fail - " + ex.Message; }
            finally
            { }

        }
        public static string Message(string _UserID, string _aID, string _cID, string _pID, string _iID)
        {
            try
            {
                var parameter = new
                {
                    UserID = _UserID,
                    ApplID = _aID,
                    CategoryID = _cID,
                    PageID = _pID,
                    ItemID = _iID 
                };
                string sp = "dbo.EPA_sys_TitleM @UserID,@ApplID,@CategoryID,@PageID,@ItemID";
                return HelpContentValue.GetValue(sp, parameter);
            
            }
            catch (Exception ex)
            { return "" + ex.Message; }
            finally
            { }
        }
        public static void Message(string _UserID, string _aID, string _cID, string _pID, string _iID, string _value)
        {
            try
            {
                var parameter = new
                {
                    UserID = _UserID,
                    ApplID = _aID,
                    CategoryID = _cID,
                    PageID = _pID,
                    ItemID = _iID,
                    Value = _value
                };
                string sp = "dbo.EPA_sys_TitleM @UserID,@ApplID,@CategoryID,@PageID,@ItemID,@Value";
                string result =  HelpContentValue.GetValue(sp, parameter);
            }
            catch (Exception ex)
            { var em = ex.Message; }
            finally
            { }

        }
        public static string NameLong(string _UserID, string _aID, string _cID, string _pID, string _iID)
        {
            try
            {
                var parameter = new
                {
                    UserID = _UserID,
                    ApplID = _aID,
                    CategoryID = _cID,
                    PageID = _pID,
                    ItemID = _iID 
                };
                string sp = "dbo.EPA_sys_Title2 @UserID,@ApplID,@CategoryID,@PageID,@ItemID";
                return HelpContentValue.GetValue(sp, parameter);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }
            finally
            { }
        }
        public static string NameLong(string _UserID, string _aID, string _cID, string _pID, string _iID, string _value)
        {

            try
            {
                var parameter = new
                {
                    UserID = _UserID,
                    ApplID = _aID,
                    CategoryID = _cID,
                    PageID = _pID,
                    ItemID = _iID,
                    Value = _value
                };
                string sp = "dbo.EPA_sys_Title2 @UserID,@ApplID,@CategoryID,@PageID,@ItemID,@Value";
                return HelpContentValue.GetValue(sp, parameter);
            }
            catch (Exception ex)
            { return "Fail - " + ex.Message; }
            finally
            { }

        }
        public static string NameHelp(string _UserID, string _aID, string _cID, string _pID, string _iID)
        {
            try
            {
                var parameter = new
                {
                    UserID = _UserID,
                    ApplID = _aID,
                    CategoryID = _cID,
                    PageID = _pID,
                    ItemID = _iID 
                };
                string sp = "dbo.EPA_sys_TitleHelp @UserID,@ApplID,@CategoryID,@PageID,@ItemID,@Value";
                return HelpContentValue.GetValue(sp, parameter);
            }
            catch (Exception ex)
            { return "" + ex.Message; }
            finally
            { }
        }
        public static string NameHelp(string _UserID, string _aID, string _cID, string _pID, string _iID, string _value)
        {

            try
            {
                var parameter = new
                {
                    UserID = _UserID,
                    ApplID = _aID,
                    CategoryID = _cID,
                    PageID = _pID,
                    ItemID = _iID,
                    Value = _value
                };
                string sp = "dbo.EPA_sys_TitleHelp @UserID,@ApplID,@CategoryID,@PageID,@ItemID,@Value";
                return HelpContentValue.GetValue(sp, parameter);
            }
            catch (Exception ex)
            { return "Fail - " + ex.Message; }
            finally
            { }

        }
        public static string NameHelpShow(string _UserID, string _aID, string _cID, string _pID, string _iID)
        {
            try
            {
                var parameter = new
                {
                    UserID = _UserID,
                    ApplID = _aID,
                    CategoryID = _cID,
                    PageID = _pID,
                    ItemID = _iID 
                };
                string sp = "dbo.EPA_sys_TitleHelpShow @UserID,@ApplID,@CategoryID,@PageID,@ItemID";
                return HelpContentValue.GetValue(sp, parameter);
            }
            catch (Exception ex)
            { return "" + ex.Message; }
            finally
            { }
        }
        public static string NameHelpShow(string _UserID, string _aID, string _cID, string _pID, string _iID, string _value)
        {

            try
            {
                var parameter = new
                {
                    UserID = _UserID,
                    ApplID = _aID,
                    CategoryID = _cID,
                    PageID = _pID,
                    ItemID = _iID,
                    Value = _value
                };
                string sp = "dbo.EPA_sys_TitleHelpShow @UserID,@ApplID,@CategoryID,@PageID,@ItemID,@Value";
                return HelpContentValue.GetValue(sp, parameter);
            }
            catch (Exception ex)
            { return "Fail - " + ex.Message; }
            finally
            { }

        }
    }
    public class HelpContext
    {
        private static readonly string sp = "dbo.EPA_sys_HelpTextContent @Operate,@UserID,@Category,@Area,@Code,@HelpType";
        public HelpContext()
        { }
        public static string Content(string operate, string userID, string categoryID, string areaID, string itemCode, string helpType)
        {
            try
            {
                var parameter = new
                {
                    Operate = operate,
                    UserID = userID,
                    Category = categoryID,
                    Area = areaID,
                    Code = itemCode,
                    HelpType = helpType 
                };
                return HelpContentValue.GetValue(sp  , parameter);
          
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }

        }
        public static string Content(string operate, string userID, string categoryID, string areaID, string itemCode, string helpType, string value)
        {
            try
            {
                var parameter = new
                {
                    Operate = operate,
                    UserID = userID,
                    Category = categoryID,
                    Area = areaID,
                    Code = itemCode,
                    HelpType = helpType,
                    Value = value
                };
                return HelpContentValue.GetValue(sp + ",@Value", parameter);

              }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }

        }

    }
    public class MessageContext
    {
        private static   string sp = "dbo.EPA_sys_HelpTextMessage @Operate,@UserID,@Category,@Area,@Code";
        public MessageContext()
        { }
        public static string Message(string operate, string userID, string categoryID, string areaID, string itemCode, string userrole)
        {
            try
            {
                var parameter = new
                { Operate = operate,
                    UserID = userID,
                    Category = categoryID,
                    Area = areaID,
                    Code = itemCode,
                    UserRole =  userrole
                };
                string sp = "dbo.EPA_sys_HelpTextMessageForRole @Operate,@UserID,@Category,@Area,@Code,@UserRole";
                return HelpContentValue.GetValue(sp, parameter);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }

        }
        public static string Message(string operate, string userID, string categoryID, string areaID, string itemCode, string userrole, string value)
        {
            try
            {
                var parameter = new
                {
                    Operate = operate,
                    UserID = userID,
                    Category = categoryID,
                    Area = areaID,
                    Code = itemCode,
                    UserRole = userrole,
                    Value = value
                };
                string sp = "dbo.EPA_sys_HelpTextMessageForRole @Operate,@UserID,@Category,@Area,@Code,@UserRole,@Value";
                return HelpContentValue.GetValue(sp, parameter);
               
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }

        }
        public static string Content(string operate, string userID, string categoryID, string areaID, string itemCode)
        {
            try
            {
                var parameter = new
                {
                    Operate = operate,
                    UserID = userID,
                    Category = categoryID,
                    Area = areaID,
                    Code = itemCode 
                };
                 return HelpContentValue.GetValue(sp, parameter);
             }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }

        }
        public static string Content(string operate, string userID, string categoryID, string areaID, string itemCode, string value)
        {
            try
            {
                var parameter = new
                {
                    Operate = operate,
                    UserID = userID,
                    Category = categoryID,
                    Area = areaID,
                    Code = itemCode,
                    Value = value
                };
                return HelpContentValue.GetValue(sp + ",@Value", parameter);
              }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }

        }
        public static string Statement(string operate, string userID, string category, string schoolYear, string schoolCode, string userRole)
        {
            try
            {
                var parameter = new
                {   Operate = operate,
                    UserID = userID,
                    Category = category,
                    SchoolYear = schoolYear,
                    SchoolCode = schoolCode,
                    UserRole = userRole 
                };

                return HelpContentValue.GetValue("dbo.EPA_sys_HelpTextStatement @Operate,@UserID,@Category,@SchoolYear, @SchoolCode,@UserRole", parameter);
 
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }

        }


    }
    public class TitleContext
    {
        private static readonly string sp = "dbo.EPA_sys_HelpTextTitles @Operate,@UserID,@Category,@Area,@Code";

        public TitleContext()
        { }


        public static string Content(object parameter)
        {         
               return HelpContentValue.GetValue(sp, parameter); 
        }
        public static string Content(string operate, string userID, string categoryID, string areaID, string itemCode)
        {
            try
            {

                var parameter = new
                {
                    Operate = operate,
                    UserID = userID,
                    Category = categoryID,
                    Area = areaID,
                    Code = itemCode
                };

                return HelpContentValue.GetValue(sp, parameter);

            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }

        }
        public static string Content(string operate, string userID, string categoryID, string areaID, string itemCode, string title, string subTitle)
        {
            try
            {
  
                var parameter = new
                {   Operate = operate, 
                    UserID = userID, 
                    Category = categoryID,
                    Area = areaID,
                    Code = itemCode,
                    Title = title,
                    SubTitle =  subTitle
                };

                return HelpContentValue.GetValue(sp +",@Title,@SubTitle", parameter);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }

        }
    }
    public class Menus
    {
        public Menus()
        { }
        private static string sp = "dbo.EPA_sys_MenuItemName @Operate,@UserID,@Category";
        public static string Items(string _UserID, string _aID, string _mID, string _Type, string _cID, string _gID, string _iID, string _tID)
        {
            try
            {
                string sp = "dbo.EPA_sys_Menus @UserID,@AppCode,@Model,@Type,@CategoryID,@GroupID,@ItemID,@TitleID";
                var parameter = new
                {
                    UserID = _UserID,
                    AppCode = _aID,
                    Model = _mID,
                    Type = _Type,
                    CategoryID = _cID,
                    GroupID = _gID,
                    ItemID = _iID,
                    TitleID = _tID
                };
                return HelpContentValue.GetValue(sp, parameter);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }
            finally
            { }
        }
        public static void Items(string _UserID, string _aID, string _mID, string _Type, string _cID, string _gID, string _iID, string _tID, string _value)
        {
            try
            {
                string sp = "dbo.EPA_sys_Menus @UserID,@AppCode,@Model,@Type,@CategoryID,@GroupID,@ItemID,@TitleID,@Value";
                var parameter = new
                {
                    UserID = _UserID,
                    AppCode = _aID,
                    Model = _mID,
                    Type = _Type,
                    CategoryID = _cID,
                    GroupID = _gID,
                    ItemID = _iID,
                    TitleID = _tID,
                    Value = _value
                };
                string result =  HelpContentValue.GetValue(sp, parameter);
            }
            catch (Exception ex)
            { var em = ex.Message; }
            finally
            { }
        }

        public static string ItemNamebyCode(string operate, string userID, string categoryID)
        {
       
            var parameter = new
            {
                Operate = operate,
                UserID = userID,
                CategoryID = categoryID 
            };
            return HelpContentValue.GetValue(sp, parameter);
        }
        public static string ItemNamebyCode(string operate, string userID, string categoryID, string areaID)
        {
         
            var parameter = new
            {
                Operate = operate,
                UserID = userID,
                Category = categoryID,
                Area = areaID 
            };
            return HelpContentValue.GetValue(sp + ",@Area", parameter);
        }
        public static string ItemNamebyCode(string operate, string userID, string categoryID, string areaID, string itemCode)
        {
            var parameter = new
            {
                Operate = operate,
                UserID = userID,
                Category = categoryID,
                Area = areaID,
                Code = itemCode 
            };
            return HelpContentValue.GetValue(sp + ",@Area,@Code", parameter);
 
        }
    }
    public class FeedBack
    {
        private static string sp = "dbo.EPA_sys_HelpTextFeedBack @Operate,@UserID,@Category,@Area,@Code,@UserRole,@SchoolYear,@Subject,@Feedback";
        public FeedBack()
        { }
        public static string Content(string operate, string userID, string categoryID, string areaID, string itemCode, string userRole, string schoolyear, string subject, string feedBack)
        {
            var parameter = new
            {
                Operate = operate,
                UserID = userID,
                Category = categoryID,
                Area = areaID,
                Code = itemCode,
                UserRole = userRole,
                SchoolYear = schoolyear,
                Subject = subject,
                Feedback = HttpContext.Current.Server.HtmlDecode(feedBack)
            };
            return HelpContentValue.GetValue(sp,parameter);
        }
        public static string Content(string operate, string userID, string categoryID, string areaID, string itemCode, string userRole, string schoolyear, string subject, string feedBack, string purpose)
        {
            var parameter = new
            {
                Operate = operate,
                UserID = userID,
                Category = categoryID,
                Area = areaID,
                Code = itemCode,
                UserRole = userRole,
                SchoolYear = schoolyear,
                Subject = subject,
                Feedback = HttpContext.Current.Server.HtmlDecode(feedBack),
                Purpose = purpose
            };
            return HelpContentValue.GetValue(sp + ", @Purpose", parameter);
        }
        
    }

    public class HelpContentValue
    {
        public static string GetValue(string sp, object parameter)
        {  try
            {
                return CommonExecute<string>.ValueOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }
        }
    }
}


