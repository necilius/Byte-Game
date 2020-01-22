using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Byte
{
    class Polje
    {
        public short [] stek;

        public Polje()
        {
            this.stek = new short[8];
            for (int i = 0; i < 8; i++)
                this.stek[i] = 0;
        }
    }
}
