using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.UtilityMethod
{
   abstract class MenuItem
    {
        public int Item_Id { get; set; }
        public string Item_Name { get; set; }
        public virtual string ItemName(int _Id) {
            string _ItemName = "";
            return _ItemName;
        }
        public virtual void ChangeName(int _Id, string _itemname)
        {
          // to save change to database 
        }
    }
    class TopMenuItem : MenuItem
    {

    }
    class CategoryItem : MenuItem
    { 
    }
    class TopicItem : MenuItem
    { 
    }
}
