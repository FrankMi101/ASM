using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
   public interface ICommonList<T>
    {
        List<T> GeneralList(object parameter);
        List<T> GeneralList(string sp, object parameter);
        List<T> GeneralList(object parameter, string page, string action);
  

    }
}
