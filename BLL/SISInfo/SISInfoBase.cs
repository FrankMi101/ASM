using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL 
{
    public class SISInfoBase : CommonSP
    {

        readonly static string _db = DBConnection.OtherDB("SISDB");
        public override string GetSPandParametersByOverride(string action)
        {
            switch (SPSource.SPFile)
            {
                case "JsonFile":
                    return GetSPFrom.JsonFile(action);
                case "DBTable":
                    return GetSPFrom.DbTable(action, "AppraisalPageHelp");
                default:
                    return GetSPInClass(action);
            }
        }
        public static string GetSP(string action)
        {
            switch (SPSource.SPFile)
            {
                case "JsonFile":
                    return GetSPFrom.JsonFile(action);
                case "DBTable":
                    return GetSPFrom.DbTable(action, "AppraisalGeneral");
                default:
                    return GetSPInClass(action);
            }
        }
        public static List<T> CommonList<T>(string action, object parameter)
        {
            try
            {
                string sp = GetSP(action);
                var myList = new CommonOperate<T>();
                return myList.ListOfT(_db, sp, parameter);
                //  return CommonExecute<T>.ListOfT(sp, parameter);
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
                return myValue.ValueOfT(_db,sp, parameter);
                //  return CommonExecute<T>.ValueOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                string em = ex.StackTrace;
                throw;
            }

        }

        public static List<T> JsonSourceList<T>(string JsonSource, string ddlType, string action)
        { // tempraryly 
            var myList = new CommonOperate<T>();
            var parameter = new { Operate = "Json", Type = ddlType, Action = action };
            return myList.ListOfT(action, parameter);
        }

        private static string GetSPInClass(string action)
        {
            string parameter = " @Operate,@UserID,@UserRole,@SchoolYear,@PersonID";
            string parameter1 = parameter + ",@SchoolCode,@EnrolmentTypeID,@EffectiveDate,@ActiveFlag";

            switch (action)
            {
                case "EnrolmentRecords":
                    return "dbo.tcdsb_Trillium_StudentEnrolment_Records" + parameter ;
                case "GetRecord":
                    return "dbo.tcdsb_Trillium_StudentEnrolment_RecordOperate " + parameter1;
                case "Delete":
                    return "dbo.tcdsb_Trillium_StudentEnrolment_RecordOperate " + parameter1;
                case "Insert":
                    return "dbo.tcdsb_Trillium_StudentEnrolment_RecordOperate " + parameter1 + ",@EntryTypeName,@RegisterCode,@SchoolYearTrack,@Grade,@LanguageInstruct, @FundingPayerType,@FundingResidentFlag,@Remark";
                case "Update":
                    return "dbo.tcdsb_Trillium_StudentEnrolment_RecordOperate " + parameter1 + ",@EntryTypeName,@RegisterCode,@SchoolYearTrack,@Grade,@LanguageInstruct, @FundingPayerType,@FundingResidentFlag,@Remark";
                case "Demit":
                    return "dbo.tcdsb_Trillium_StudentEnrolment_RecordOperate " + parameter1 + ",@EntryTypeName,@RegisterCode,@SchoolYearTrack,@Grade,@LanguageInstruct, @FundingPayerType,@FundingResidentFlag,@Remark,@DemitNextSchool,@DemitReasonName";
                case "TabList":
                    return "dbo.SIC_sys_TabList" + parameter;
                case "ActionMenuList":
                    return "dbo.SIC_sys_ActionMenuList" + parameter + ",@TabID,@ObjID,@Semester,@Term,@AppID";

                default:
                    return action;

            }


        }

    }
}

