using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class Apps : AppClass
    {
        public string AppName { get; set; }
        public string Owners { get; set; }
        public string Developer { get; set; }
        public bool ActiveFlag { get; set; }
        public string AppUrl { get; set; }
        public string AppUrlTest { get; set; }
        public string AppUrlTrain { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }

    }
    public class AppsList : Apps
    {
        public int RowNo { get; set; }
        public string Actions { get; set; }
        public string DeleteAction { get; set; }
        public string EditAction { get; set; }
        public string SubActions { get; set; }
   
    }
    public class AppsModel : Apps
    {
        public string ModelID { get; set; }
        public string ModelName { get; set; }
    }
    public class AppsModelList : AppsList
    {
        public string ModelID { get; set; }
        public string ModelName { get; set; }
    }

}
