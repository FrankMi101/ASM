using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    
    public class SPSource
    {
        private static string _SPFile = "";
 
        public static string SPFile
        {
            get { return _SPFile; }
            set { _SPFile = value; }
        }
    }
}
