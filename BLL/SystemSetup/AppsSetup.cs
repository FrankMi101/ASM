using ClassLibrary;
using System;
using System.Collections.Generic;

namespace BLL
{
    public class AppsSetup
    {
        public static string GetSP(string action)
        {
            switch (SPSource.SPFile)
            {
                case "JsonFile":
                    return GetSPFrom.JsonFile(action);
                case "DBTable":
                    return GetSPFrom.DbTable(action, "AppraisalSetup");
                default:
                    return GetSPInClass(action, "");
            }
        }

        public static List<T> CommonList<T>(string action, object parameter)
        {
            try
            {
                string sp = GetSP(action);
                var myList = new CommonOperate<T>();
                return myList .ListOfT(sp, parameter);
               // return CommonExecute<T>.ListOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                string em = ex.StackTrace;
                throw;
            }

        }
        public static T CommonValue<T>(string action, object parameter)
        {
            try
            {
                string sp = GetSP(action);
                var myValue = new CommonOperate<T>();
                return myValue.ValueOfT(sp, parameter);

             //   return CommonExecute<T>.ValueOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                string em = ex.StackTrace;
                throw;
            }
        }

        public static List<AreaList> AreaList(object parameter)
        {
            return CommonList<AreaList>("AreaList", parameter);
        }
        public static string SaveArea(object parameter)
        {
            return CommonValue<string>("AreaSave", parameter);
        }
        public static List<AreaList> CategoryList(object parameter)
        {
            return CommonList<AreaList>("CategoryList", parameter);
        }
        public static string SaveCategory(object parameter)
        {
            return CommonValue<string>("CategorySave", parameter);
        }
        public static string MessageForRole(object parameter)
        {
            return CommonValue<string>("MessageForRole", parameter);
        }
        public static string MessageForRoleSave(object parameter)
        {
            return CommonValue<string>("MessageForRoleSave", parameter);
        }

        //public static string GetSP(string action, string page)
        //{
        //    return GetSPbyDelegateHelp(action, page);
        //}

        //private delegate string GetSPNameAndParameters(string value, string value2);
        //private static string GetSPHelper(GetSPNameAndParameters delegateFunc, string value, string value2)
        //{
        //    return delegateFunc(value, value2);
        //}
        //private static string GetSPbyDelegateHelp(string action, string page)
        //{
        //    if (SPSource.SPFile == "")
        //    {
        //        return GetSPHelper(GetSPInClass, action, page);
        //    }
        //    else
        //    {
        //        return GetSPHelper(JsonFileReadSP.GetSPFromJsonFile, action, page);
        //    }
        //}
        //private static string GetSPbyDelegateFunc(string action, string page)
        //{
        //    Func<string, string, string> mySP;
        //    if (SPSource.SPFile == "")
        //    {
        //        mySP = GetSPInClass;
        //    }
        //    else
        //    {
        //        mySP = JsonFileReadSP.GetSPFromJsonFile;
        //    }
        //    return mySP(action, page);
        //}

        private static string GetSPInClass(string action, string page)
        {



            string parameters = " @Operate,@UserID,@Category,@Area";
            string parameters1 = parameters + ",@Code,@UserRole";
            string parameters2 = " @Operate,@UserID,@IDs,@Code,@Name,@Comments,@Active";
            string parameters3 = parameters + "@IDs,@Code,@Name,@Comments,@Active";


            switch (action)
            {
                case "AreaList":
                    return "dbo.EPA_sys_SetupAppraisalArea  @Operate,@UserID" ;
                case "AreaSave":
                    return "dbo.EPA_sys_SetupAppraisalArea" + parameters2;
                case "CategoryList":
                    return "dbo.EPA_sys_SetupAppraisalCategory  @Operate,@UserID" ;
                case "CategorySave":
                    return "dbo.EPA_sys_SetupAppraisalCategory" + parameters2 + "@Value";
                case "MessageForRole":
                    return "dbo.EPA_sys_HelpTextMessageForRole" + parameters1;
                case "MessageForRoleSave":
                    return "dbo.EPA_sys_HelpTextMessageForRole" + parameters1 + ",@Value";

                case "District":
                    return "dbo.EPA_ORG_DistrictList" + parameters ;
                case "DistrictSave":
                    return "dbo.EPA_ORG_DistrictList" + parameters3;  
                case "RegionArea":
                    return "dbo.EPA_ORG_RegionAreaList" + parameters;  
                case "RegionAreaSave":
                    return "dbo.EPA_ORG_RegionAreaList" + parameters3 + ",@District,@SuperID,@Officer";
                case "Schools":
                    return "dbo.EPA_ORG_SchoolsList" + parameters;
                case "SchoolInformation":
                    return "dbo.EPA_ORG_SchoolsList" + parameters + ",@IDs";
                case "SchoolInforamtion2":
                    return "dbo.EPA_ORG_SchoolsList" + parameters +",@IDs,@Code";
                case "SchoolInformationSave":
                    return "dbo.EPA_ORG_SchoolsList" + parameters3 + ",@District,@Header,@AreaCode,@Panel,@TPA,@PPA";
                case "SystemItems":
                    return "dbo.EPA_sys_SystemItemsList @Operate,@UserID,@Category,@ItemType";
                case "SystemItemsSave":
                    return "dbo.EPA_sys_SystemItemsList @Operate,@UserID,@Category,@ItemType,@IDs,@Code,@Name,@Comments,@Active,@Orders,@KeyPoint";

                case "MultipleSchoolUser":
                    return "dbo.EPA_sys_ApplicationUsersMultipleSchool" + parameters + ",@SchoolYear";
                case "MultipleSchoolUserSave":
                    return "dbo.EPA_sys_ApplicationUsersMultipleSchool" + parameters + ",@SchoolYear,@SchoolCode,@IDs,@PrincipalID,@Comments,@Active";
                case "AppRole":
                    return "dbo.EPA_sys_ApplicationRole" + parameters;
                case "AppRoleSave":
                    return "dbo.EPA_sys_ApplicationRole" + parameters3 ;
                case "AppUser":
                    return "dbo.EPA_sys_ApplicationUsers" + parameters;
                case "AppUserSave":
                    return "dbo.EPA_sys_ApplicationUsers" + parameters3 + ",@UserRole";
                case "SetupListPhase":
                case "SetupListCycle":
                case "SetupListSteps":
                case "SetupListRate":
                case "SetupListProcess":
                    return "dbo.EPA_sys_SystemItemsList " + parameters;
                case "SetupSavePhase":
                case "SetupSaveCycle":
                case "SetupSaveSteps":
                case "SetupSaveRate":
                case "SetupSaveProcess":
                    return "dbo.EPA_sys_SystemItemsList " + parameters + ",@IDs,@Code,@Name,@Comments,@Active,@Orders,@KeyPoint";


                default:
                    return action;

            }
        }
        //private static string GetSPFromJsonFile(string action, string page)
        //{
        //    try
        //    {
        //        string JsonFile = SPSource.SPFile;
        //        DataSourceItemList myspname = JsonFileReader<DataSourceItemList>.GetSP_fromList(JsonFile); //.JsonFileReader(JsonFile);
        //        var mylist = from p in myspname.SystemSetup
        //                     where p.action == action
        //                     select p.objName.ToString() + p.parameters.ToString();
        //        return mylist.FirstOrDefault();
        //    }
        //    catch (Exception ex)
        //    {
        //        string em = ex.Message;
        //        string es = ex.StackTrace;
        //        throw;
        //    }

        //}
    }


}
