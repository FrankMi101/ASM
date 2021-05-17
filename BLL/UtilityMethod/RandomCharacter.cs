using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.UtilityMethod
{
   public class Randomcharacter
    {
        public static string GetRandom( int cLength)
        {

            var random = new Random();
            var buffer = new char[cLength];
            for (var i = 0; i < cLength; i++)
                buffer[i] = (char) ('a' + random.Next(0, 26));

            var password = new string(buffer);
            return password;
        }
    }
}
