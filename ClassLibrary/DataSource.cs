using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    class DataSource
    {
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
        public List<DataSourceItem> Request { get; set; }
        public List<DataSourceItem> Approve { get; set; }
        public List<DataSourceItem> Publish { get; set; }
        public List<DataSourceItem> Candidate { get; set; }
        public List<DataSourceItem> Interview { get; set; }
        public List<DataSourceItem> Hiring { get; set; }
        public List<DataSourceItem> Hired { get; set; }
        public List<DataSourceItem> Apply { get; set; }

    }
}
