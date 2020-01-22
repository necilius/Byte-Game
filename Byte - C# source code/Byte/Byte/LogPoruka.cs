using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Byte
{
    class LogPoruka
    {
        public string s1;
        public string s2;
        public string s3;
        public string s4;
        public string s5;
        public string s6;

        public LogPoruka()
        {
           
        }

        public void dodajString(string s)
        {
            s6 = s5;
            s5 = s4;
            s4 = s3;
            s3 = s2;
            s2 = s1;
            s1 = s;

        }
    }
}
