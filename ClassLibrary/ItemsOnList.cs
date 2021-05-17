using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
   public interface IItemsOnList
    {
          int RowNo { get; set; }
          string Actions { get; set; }
          string DeleteAction { get; set; }
          string EditAction { get; set; }
          string SubActions { get; set; }
    }
}
