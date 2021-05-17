using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class JsonFileReader<T>
    {
        private static string JsonString(string JsonFile)
        {
            try
            {
                using (StreamReader sr = new StreamReader(JsonFile))  // Server.MapPath("~/test.json")))
                {
                    string jsonString = sr.ReadToEnd();
                    return jsonString;
                }
            }
            catch (System.Exception ex)
            {
                var em = ex.Message;
                return "";
            }
            finally
            { }
        }
        public static T GetSP_fromList(string JsonFile)
        {
            var jsonString = JsonString(JsonFile);
            try
            {
                var result = JsonConvert.DeserializeObject<T>(jsonString);
                return result;
            }
            catch (System.Exception ex)
            {
                var em = ex.Message;
                throw;
            }

        }

        public static T GetSP_fromList(string JsonFile, string pType, string action)
        {
            var jsonString = JsonString(JsonFile);
            try
            {
                //  var result = JsonConvert.DeserializeObject<SPName1>(jsonString);
                var result = JsonConvert.DeserializeObject<T>(jsonString);

                return result;

            }
            catch (System.Exception ex)
            {
                var em = ex.Message;
                throw;
            }

        }
    }
    public class GetSPFrom
    {
        public static string JsonFile(string action)
        {
            try
            {
                string JsonFile = SPSource.SPFile;
                DataSourceItemList myspname = JsonFileReader<DataSourceItemList>.GetSP_fromList(JsonFile); //.JsonFileReader(JsonFile);
                var mylist = from p in myspname.AppraisalManage
                             where p.action == action
                             select p.objName.ToString() + p.parameters.ToString();
                return mylist.FirstOrDefault();
            }
            catch (Exception ex)
            {
                string em = ex.Message;
                string es = ex.StackTrace;
                throw;
            }

        }
        public static string JsonFile(string action, string page)
        {
            try
            {
                string JsonFile = SPSource.SPFile;
                DataSourceItemList myspname = JsonFileReader<DataSourceItemList>.GetSP_fromList(JsonFile); //.JsonFileReader(JsonFile);
                var mylist = from p in myspname.SystemSetup
                             where p.action == action
                             select p.objName.ToString() + p.parameters.ToString();
                return mylist.FirstOrDefault();
            }
            catch (Exception ex)
            {
                string em = ex.Message;
                string es = ex.StackTrace;
                throw;
            }

        }

        public static string DbTable(string action, string className)
        {
            var parameter = new
            {
                Action = action,
                ClassName = className
            };
            string sp = "dbo.EPA_sys_StoreProcedureName";
            return CommonExecute<string>.ValueOfT(sp, parameter);
        }
    }
    public class DataSourceItem
    {
        public string source { get; set; }
        public string action { get; set; }
        public string objName { get; set; }
        public string parameters { get; set; }

    }
    public class DataSourcePage
    {
        public string page { get; set; }
        public DataSourceItem[] SourceList { get; set; }
    }

    public class DataSourcePageList
    {
        public List<DataSourcePage> DataAccessSource { get; set; }
    }

    public class DataSourceItemList
    {
        public List<DataSourceItem> General { get; set; }
        public List<DataSourceItem> AppraisalContents { get; set; }
        public List<DataSourceItem> AppraisalContentsDomain { get; set; }
        public List<DataSourceItem> AppraisalContentsStrategy { get; set; }
        public List<DataSourceItem> AppraisalManage { get; set; }
        public List<DataSourceItem> AppraisalProcess { get; set; }
        public List<DataSourceItem> SystemSetup { get; set; }
        public List<DataSourceItem> Staff { get; set; }
        public List<DataSourceItem> Summary { get; set; }

    }
}
