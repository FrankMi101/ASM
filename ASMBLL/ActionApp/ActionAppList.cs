using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;

namespace ASMBLL
{
    public class ActionAppList<T, T2> : IActionGet<T>
    {
        private readonly IDataOperateService<T> _dataOperateService;
        public ActionAppList()  //DataOperateService<T> iDos)
        {
            this._dataOperateService = (IDataOperateService<T>)MapClass<T>.DBSource(); 
        }
        public ActionAppList(string dataSource)  //DataOperateService<T> iDos)
        {
            this._dataOperateService = (IDataOperateService<T>)MapClass<T>.DBSource(dataSource);
        }
        public List<T> GetObjByID(int id)
        {
            string sp = MapClass<T2>.SPName("Edit");
            var parameter = new { Operate = "Get", UserID = "asm", IDs = id };
            return GeneralList.CommonList<T>(sp, parameter);
        }

        public List<T> GetObjList(object parameter)
        {
            string sp = MapClass<T2>.SPName("Read");

            return GeneralList.CommonList<T>(sp, parameter);
        }
        //public List<T> GetObjList2(string obj, object parameter)
        //{
        //    if (obj == "ClassCall") obj = MapClass<T2>.SPName("Read");
                  
        //    return _dataOperateService.ListOfT(obj, parameter);

        //}
        public List<T> GetObjList(string dataSource, object parameter)
        {
            if (dataSource == "ClassCall") dataSource = MapClass<T2>.SPName("Read");

            return _dataOperateService.ListOfT(dataSource, parameter);

        }

      

        //public List<T> GetObjListFormAPI(string uri, object parameter)
        //{
        //    List<T> listofT = null;
        //    try
        //    {
        //        string qStr = parameter.ToString(); // "/0354/SIC";
        //        // string url =  "https://webt.tcdsb.org/Webapi/ASM/api/"; // usergroup/list/" + qStr;
        //        string url = WebConfigurationManager.ConnectionStrings["APISite"].ConnectionString;
        //        using (var client = new HttpClient())
        //        {
        //            client.BaseAddress = new Uri(url);
        //            //HTTP GET
        //            var responseTask = client.GetAsync(uri + qStr);
        //            responseTask.Wait();

        //            var result = responseTask.Result;
        //            if (result.IsSuccessStatusCode)
        //            {
        //                var readTask = result.Content.ReadAsAsync<List<T>>();
        //                readTask.Wait();

        //                listofT = readTask.Result;
        //            }
        //            else //web api sent error response 
        //            {
        //                //log response status here..

        //                listofT = Enumerable.Empty<T>().ToList();
        //            }
        //        }
        //        return listofT.ToList();


        //    }
        //    catch (Exception ex)
        //    {
        //        var mes = ex.Message;
        //        return listofT.ToList();

        //    }
        //}

      
      

        public string GetSPName(string action)
        {
            throw new NotImplementedException();
        }

     
    }
}
