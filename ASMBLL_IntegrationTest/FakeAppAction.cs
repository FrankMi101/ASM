using ASMBLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL_IntegrationTest
{
    public class FakeAppAction<T> : IActionApp<T>
    {

        private readonly IActionApp<T> _iAction;
        public FakeAppAction(IActionApp<T> iAction)
        {
            _iAction = iAction;
        }


        public string AddObj(T parameter)
        {
            throw new NotImplementedException();
        }

        public string DeleteObj(int id)
        {
            throw new NotImplementedException();
        }

        public string EditObj(T parameter)
        {
            throw new NotImplementedException();
        }

        public string RemoveObj(T parameter)
        {
            throw new NotImplementedException();
        }
        public List<T> GetObjByID(int id)
        {
            throw new NotImplementedException();
        }

        public List<T> GetObjList(object parameter)
        {
            throw new NotImplementedException();
        }

        public string GetSPName(string action)
        {
            throw new NotImplementedException();
        }

        public string GetValue(object parameter)
        {
            throw new NotImplementedException();
        }

        public string EditObj(string apiType, string uri, T parameter)
        {
            throw new NotImplementedException();
        }

        public string AddObj(string apiType, string uri, T parameter)
        {
            throw new NotImplementedException();
        }

        public string DeleteObj(string apiType, string uri, int id)
        {
            throw new NotImplementedException();
        }

        public List<T> GetObjList(string dataSource, object parameter)
        {
            throw new NotImplementedException();
        }

        public List<T> GetObjByID(string dataSource, int id)
        {
            throw new NotImplementedException();
        }
    }
}
