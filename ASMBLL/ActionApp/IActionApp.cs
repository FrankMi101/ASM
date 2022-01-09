using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public interface IActionApp<T>:IActionGet<T>
    {
        string GetValue(object parameter);

        string AddObj(T parameter);
        string EditObj(T parameter);
        string RemoveObj(T parameter);
        string DeleteObj(int id);
        
        string EditObj(string apiType, string uri, T parameter);
        string AddObj(string apiType, string uri, T parameter);
        string DeleteObj(string apiType, string uri,int id);
    }
}
