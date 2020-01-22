using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Byte
{
    class Tabla
    {
        public short velicina;
        public Polje [,] matrica;

        public Tabla(short velicina)
        {
            this.velicina = velicina;
            this.matrica = new Polje[velicina, velicina];
            for (int i = 0; i < velicina; i++)
                for (int j = 0; j < velicina; j++)
                    matrica[i, j] = new Polje();
        }

        public void PopuniIzStringa(string polje, int i, int j)
        {
            if(polje[0] == 'N')
            {
                matrica[i, j].stek[0] = 0;
                matrica[i, j].stek[1] = 0;
                matrica[i, j].stek[2] = 0;
                matrica[i, j].stek[3] = 0;
                matrica[i, j].stek[4] = 0;
                matrica[i, j].stek[5] = 0;
                matrica[i, j].stek[6] = 0;
                matrica[i, j].stek[7] = 0;
            }
            if(polje[0] == '(')
            {
                int s = 1;
                int st = 0;
                while( polje[s] != ')')
                {
                    if(polje[s] == 'X')
                    {
                        matrica[i, j].stek[st++] = 1;
                        s++;
                    }
                    else if (polje[s] == 'O')
                    {
                        matrica[i, j].stek[st++] = 2;
                        s++;
                    }
                    else
                    {
                        s++;
                    }
                }
            }
        }
    }
}
