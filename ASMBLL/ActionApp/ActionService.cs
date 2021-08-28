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
    public class ActionService<T>  
    {
        private string _sp = MapClass<T>.SPName("Edit");
        private readonly string _objName = typeof(T).Name;
        private readonly string _invalidMessage = "Invalid Group " + typeof(T).Name + " ID";
        private readonly IActionApp<T> _actionApp; //= (IDataOperateService<T>)MapClass<T>.DBSource();  // new DataOperateService<T>(new DataOperateServiceSQL<T>());

        public ActionService(string objType)
        {
            this._actionApp = (IActionApp<T>)MapClass<T>.ClassType(objType) ;
        }
        public string GetSPName(string action)
        {
            return _actionApp.GetSPName(action);
        }
        public List<T> GetObjList(object parameter)
        {
            return _actionApp.GetObjList(parameter);
        }
        public List<T> GetObjList(string source, object parameter)
        {
            return _actionApp.GetObjList(parameter);
        }
        public List<T> GetObjByID(int id)
        {
            if (id <= 0) return null;
            return _actionApp.GetObjByID(id);
        }
        public List<T> GetObjByID(string source, int id)
        {
            if (id <= 0) return null;
            return _actionApp.GetObjByID(id);
        }
        public string AddObj(object parameter)
        {
            return _actionApp.AddObj((T)parameter);
        }

        public string EditObj(object parameter)
        {
            return _actionApp.EditObj((T)parameter);
        }
        public string EditObj(string obj, object parameter)
        {
            return _actionApp.EditObj((T)parameter); 
        }
        public string RemoveObj(object parameter)
        {
            return _actionApp.EditObj((T)parameter);
        }
        public string DeleteObj(int id)
        {
            if (id <= 0) return _invalidMessage;
            return _actionApp.DeleteObj(id);
        }

        private List<T> GetObjListFormAPI(string uri, object parameter)
        {
            List<T> listofT = null;
            try
            {
                string qStr = parameter.ToString(); // "/0354/SIC";
                // string url =  "https://webt.tcdsb.org/Webapi/ASM/api/"; // usergroup/list/" + qStr;
                string url = WebConfigurationManager.ConnectionStrings["APISite"].ConnectionString;
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(url);
                    //HTTP GET
                    var responseTask = client.GetAsync(uri + qStr);
                    responseTask.Wait();

                    var result = responseTask.Result;
                    if (result.IsSuccessStatusCode)
                    {
                        var readTask = result.Content.ReadAsAsync<List<T>>();
                        readTask.Wait();

                        listofT = readTask.Result;
                    }
                    else //web api sent error response 
                    {
                        //log response status here..

                        listofT = Enumerable.Empty<T>().ToList();
                    }
                }
                return listofT.ToList();


            }
            catch (Exception ex)
            {
                var mes = ex.Message;
                return listofT.ToList();

            }
        }
    }
}
