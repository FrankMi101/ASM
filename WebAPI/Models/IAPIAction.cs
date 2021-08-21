using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebAPI
{
   public interface IAPIAction<T>
    {
        List<T> ListOfT(string apiType, string sp, object parameter);
        string ValueOfT(string apiType, string sp, object parameter);
    }
}
