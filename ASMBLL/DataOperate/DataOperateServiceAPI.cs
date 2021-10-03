using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;

namespace ASMBLL
{/// <summary>
/// Data From Web API
/// </summary>
/// <typeparam name="T"></typeparam>
    public class DataOperateServiceAPI<T> : IDataOperateService<T>
    {
        public T OperateResult(string apiType, string uri, object parameter)
        {
            throw new NotImplementedException();
        }
        public string EditResult(string apiType, string uri, object parameter)
        {
            switch (apiType)
            {
                case "ADD":
                    return POST_Method(uri, parameter);
                case "Edit":
                    return PUT_Method(uri, parameter);
                case "Remove":
                    return PUT_Method(uri, parameter);
                case "DELETE":
                    return DELETE_Method(uri, parameter);
                default:
                    return "";
            }

        }

        public List<T> ListOfT(string apiType, string uri, object parameter)
        {
            return GET_Method(uri, parameter);
        }
        public List<T> ListOfT(string uri, object parameter)
        {
            return GET_Method(uri, parameter);
        }


        private List<T> GET_Method(string uri, object parameter)
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
        private string POST_Method(string uri, object parameter)
        {
            try
            {
                string url = WebConfigurationManager.ConnectionStrings["APISite"].ConnectionString;
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(url);

                    //HTTP POST
                    var postTask = client.PostAsJsonAsync<T>(uri, (T)parameter);
                    postTask.Wait();

                    var result = postTask.Result;
                    if (result.IsSuccessStatusCode)
                    {
                        return result.ToString();
                    }
                }
                return "";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
        private string PUT_Method(string uri, object parameter)
        {         
            try
            {
                string url = WebConfigurationManager.ConnectionStrings["APISite"].ConnectionString;
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(url);
                    string id = (string)parameter;
                    //HTTP POST
                    var putTask = client.PutAsJsonAsync<T>(uri, (T)parameter);
                    putTask.Wait();

                    var result = putTask.Result;
                    if (result.IsSuccessStatusCode)
                    {
                        return result.ToString();
                    }
                }
                return "";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
        private string DELETE_Method(string uri, object parameter)
        {
            try
            {
                string url = WebConfigurationManager.ConnectionStrings["APISite"].ConnectionString;
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(url);
                    string id = (string)parameter;
                    //HTTP DELETE
                    var deleteTask = client.DeleteAsync(uri +  id.ToString());
                    deleteTask.Wait();

                    var result = deleteTask.Result;
                    if (result.IsSuccessStatusCode)
                    {
                        return result.ToString();
                    }
                }
                return "";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

      
    }
}
