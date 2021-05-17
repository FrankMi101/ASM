using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
   public  class CommentsBank
    {
        public static string GetSP(string action)
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

        public static List<T> CommonList<T>(string action, object parameter)
        {
            try
            {
                string sp = GetSP(action);
                var myList = new CommonOperate<T>();
                return myList.ListOfT(sp, parameter);

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
                return myValue.ValueOfT(sp, parameter);
               // return CommonExecute<T>.ValueOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                string em = ex.StackTrace;
                throw;
            }
        }


       

        public static List<CommentBank> CommentsBankTree(object parameter)
        {
            return CommonList<CommentBank>("CommentsBankTree", parameter);
        }

        public static List<CommentBank> SchoolLearningPlan(object parameter)
        {
            return CommonList<CommentBank>("SchoolLearningPlan", parameter);
        }
        
        public static List<StrategyBank> StrategiesBank(object parameter)
        {
            return CommonList<StrategyBank>("StrategiesBank", parameter);
        }

    


        public static string OLFCategorySave(object parameter)
        {
            return CommonValue<string>("OLFCategorySave", parameter);
        }
       

        private static string GetSPInClass(string action)
        {

            string parameters = " @Operate, @UserID, @Type, @Owner"; 

            switch (action)
            {
                case "CommentsBankTree":
                    return "dbo.EPA_sys_CommentsBankTree" + parameters;

                case "SchoolLearningPlan":
                    return "dbo.EPA_sys_CommentsBankTreeLearningPlan" + parameters;

                case "OLFCategories":
                    return "dbo.EPA_sys_CommentsOLFLibaray" + " @Operate,@UserID";
                case "OLFCategoriesByPanel":
                    return "dbo.EPA_sys_CommentsOLFLibaray" + " @Operate,@UserID,@Panel";
                case "OLFCategorySave":
                    return "dbo.EPA_sys_CommentsOLFLibaray" + " @Operate,@UserID,@Panel, @Level2,@Level3,@Level4,@Notes";
                case "StrategiesBank":
                    return "dbo.EPA_sys_CommentsStrategies" + " @Operate,@UserID,@Panel";
 

                case "DocFile":
                    return "dbo.EPA_Appr_AppraisalProcess_GoPage" + parameters;
                case "PageItem":
                    return "dbo.EPA_Appr_AppraisalProcess_GoPage" + parameters;
                case "PageNext":
                    return "dbo.EPA_Appr_AppraisalProcess_GoPage" + parameters;
                case "PagePrevious":
                    return "dbo.EPA_Appr_AppraisalProcess_GoPage" + parameters;
                case "PageActiveFor":
                    return "dbo.EPA_Appr_AppraisalProcess_GoPage" + parameters;
                case "PageRecover":
                    return "dbo.EPA_Appr_AppraisalProcess_GoPage" + parameters;
                case "PageHelp":
                    return "dbo.EPA_Appr_AppraisalProcess_GoPage" + parameters;
                case "PageEP":
                    return "dbo.EPA_Appr_AppraisalProcess_GoPage" + parameters;
                case "CommentsBankList":
                    return "dbo.EPA_sys_CommentsBankList @Operate,@UserID,@Category,@Area,@Type,@Owner";
                case "CommentsBankSave":
                   return "dbo.EPA_sys_CommentsBankList @Operate,@UserID,@Category,@Area,@Type,@Owner,@IDs,@DomainID,@Shared,@Comments,@Active" ;
                 
                default:
                    return action;

            }
        }

    }
}