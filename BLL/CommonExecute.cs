using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class CommonExecute<T>
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="SP"> store procedure name and @parameters, for example dbo.tcdsb_LTO_PageGeneral_List @Operate,@Para1,@Para1,@Para2,@Para3</param>
        /// <param name="parameter"> store procedure parameters data object. for example List2Item { Operate = "PostingRound", Para0 = "20192020", Para1 = "0529" }</param>
        /// <returns> general list of T class type </returns>
        public static List<T> ListOfT(string SP, object parameter)
        {
            try
            {
                var mylist = new CommonOperate<T>();
                return mylist.ListOfT(SP, parameter);
            }
            catch
            {
                throw;
            }
        }
        public static T ValueOfT(string SP, object parameter)
        {
            try
            {
                var myvalue = new CommonOperate<T>();
                return myvalue.ValueOfT(SP, parameter);
            }
            catch
            {
                throw;
            }
        }
        public static String ValueOfString(string SP, object parameter)
        {
            try
            {
                var myvalue = new CommonOperate<string>();
                return myvalue.ValueOfString(SP, parameter);
            }
            catch
            {
                throw;
            }
        }

    }
     
}
