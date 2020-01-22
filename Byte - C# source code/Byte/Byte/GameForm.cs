using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Byte
{
    public partial class GameForm : Form
    {
        StartForm startForm;
        int velicina;
        int mode; // 0 - PvP, 1 - CvP, 2 - PvC
        Tabla tabla;
        int skorX;
        int skorY;
        int skorMin;
        LogPoruka logPoruka;

        int sirinaEkrana;
        int visinaEkrana;

        int pocetakTableX;
        int pocetakTableY;
        int sirinaTable;
        int velicinaPolja;
        int visinaFigure;

        bool pomeranje;
        int pomeranjeX;
        int pomeranjeY;

        string potez;
        int potezi;
        int potezj;
        int potezh;
        int potezk;
        int potezl;
        bool clickUp;

        Process process;
        int processprikaz;
        int processprikazI;
        int processprikazJ;
        bool processRacunarPotez;
        bool processPotezX;
        bool processPotezY;
        bool gameOver;

        private void DrawTable2(Graphics dc, int n)
        {
            Color grey = Color.FromArgb(150, 20, 20, 20);


            Pen pn = new Pen(grey, 1);
            SolidBrush sbFn = new SolidBrush(Color.FromArgb(255, 10, 10, 10));
            SolidBrush sb = new SolidBrush(Color.FromArgb(200, 180, 180, 180));
            SolidBrush sb2 = new SolidBrush(Color.FromArgb(50, 230, 182, 75));

            int startX = 30;
            int startY = 30;

            dc.FillRectangle(new SolidBrush(Color.FromArgb(240, 255, 255, 255)), new Rectangle(15, 15, n * 40 + 30, n * 40 + 30));

            for (int i = 0; i < n; i++)
            {
                char x = (char)(65 + i);
                dc.DrawString(x.ToString(), new Font(new FontFamily("Arial"), 10), sbFn, startX - 15, startY + i * 40 + 13);

            }

            for (int i = 0; i < n; i++)
            {
                startX = 30;

                for (int j = 0; j < n; j++)
                {
                    if (i == 0)
                    {
                        dc.DrawString((j + 1).ToString(), new Font(new FontFamily("Arial"), 10), sbFn, startX + 13, startY - 16);
                    }
                    if ((j + i) % 2 == 0)
                        dc.FillRectangle(sb, new Rectangle(startX, startY, 40, 40));
                    else
                        dc.FillRectangle(sb2, new Rectangle(startX, startY, 40, 40));

                    dc.DrawRectangle(pn, startX, startY, 40, 40);

                    startX += 40;
                }


                startY += 40;
            }
        }

        private void DrawTable(Graphics dc)
        {
            Pen crnaOlovka = new Pen(new SolidBrush(Color.FromArgb(255, 0, 0, 0)));
            Pen zelenaOlovka = new Pen(new SolidBrush(Color.FromArgb(255, 255, 255, 0)));
            Pen crvenaOlovka = new Pen(new SolidBrush(Color.FromArgb(255, 255, 0, 0)));
            SolidBrush bela = new SolidBrush(Color.FromArgb(255, 255, 255, 255));
            SolidBrush figuraSiva = new SolidBrush(Color.FromArgb(255, 40, 40, 40));
            SolidBrush sivkasta = new SolidBrush(Color.FromArgb(80, 0, 100, 0));
            SolidBrush zuckasta = new SolidBrush(Color.FromArgb(30, 0, 100, 0));

            SolidBrush font = new SolidBrush(Color.FromArgb(200, 30, 220, 30));
            dc.FillRectangle(bela, new Rectangle(this.pocetakTableX, this.pocetakTableY, this.sirinaTable, this.sirinaTable));

            int startX = this.pocetakTableX;
            int startY = this.pocetakTableY;


            for (int i = 0; i < this.velicina; i++)
            {
                dc.DrawString((i + 1).ToString(), new Font(new FontFamily("Arial"), 10), font, startX + i * this.velicinaPolja + this.velicinaPolja / 2 - 7, 0);
            }


            for (int i = 0; i < this.velicina; i++)
            {
                startX = this.pocetakTableX;

                for (int j = 0; j < this.velicina; j++)
                {
                    if (i == 0)
                    {
                        char x = (char)(65 + j);
                        dc.DrawString(x.ToString(), new Font(new FontFamily("Arial"), 10), font, this.pocetakTableX - 13, this.pocetakTableY + j * velicinaPolja + velicinaPolja / 2 - 5);

                    }

                    if ((j + i) % 2 == 0)
                    {
                        dc.FillRectangle(sivkasta, new Rectangle(startX, startY, this.velicinaPolja, this.velicinaPolja));

                        int tmp = 0;
                        while (tmp < 8)
                        {
                            if (tabla.matrica[i, j].stek[tmp] == 0)
                                break;
                            else
                            {
                                int pocetakX = startX;
                                int pocetakY = startY + velicinaPolja - (tmp + 1) * visinaFigure;
                                if (tabla.matrica[i, j].stek[tmp] == 1)
                                {
                                    dc.FillRectangle(figuraSiva, new Rectangle(pocetakX, pocetakY, this.velicinaPolja, this.visinaFigure));
                                    dc.DrawRectangle(zelenaOlovka, new Rectangle(pocetakX, pocetakY, this.velicinaPolja, this.visinaFigure));
                                }
                                else
                                {
                                    dc.FillRectangle(bela, new Rectangle(pocetakX, pocetakY, this.velicinaPolja, this.visinaFigure));
                                    dc.DrawRectangle(crvenaOlovka, new Rectangle(pocetakX, pocetakY, this.velicinaPolja, this.visinaFigure));
                                }

                            }
                            tmp++;
                        }
                    }
                    else
                        dc.FillRectangle(zuckasta, new Rectangle(startX, startY, this.velicinaPolja, this.velicinaPolja));

                    dc.DrawRectangle(crnaOlovka, startX, startY, this.velicinaPolja, this.velicinaPolja);



                    startX += this.velicinaPolja;
                }


                startY += this.velicinaPolja;
            }
        }

        private void DrawScore(Graphics dc)
        {
            SolidBrush sbFn = new SolidBrush(Color.FromArgb(255, 0, 100, 0));
            Pen pn = new Pen(sbFn, 5);
            //dc.FillRectangle(new SolidBrush(Color.FromArgb(200, 255, 255, 255)), new Rectangle(700, 15, 400, 150));
            int sirina = (int)(0.7 * sirinaEkrana / 3);
            int visina = (int)(0.7 * visinaEkrana / 3);
            dc.DrawRectangle(pn, new Rectangle(15, 15, sirina, visina));
            dc.DrawString("Black player's score: " + this.skorX, new Font(new FontFamily("Arial"), 15), sbFn, 15 + 10, 30);
            dc.DrawString("White player's score: " + this.skorY, new Font(new FontFamily("Arial"), 15), sbFn, 15 + 10, visina / 2 + 7);
            dc.DrawString("Winning score: " + this.skorMin, new Font(new FontFamily("Arial"), 15), sbFn, 15 + 10, visina - 15);

        }

        private void DrawMessageLog(Graphics dc)
        {
            SolidBrush sbFn = new SolidBrush(Color.FromArgb(255, 0, 100, 0));
            Pen pn = new Pen(sbFn, 5);

            int sirina = (int)(0.9 * sirinaEkrana / 3);
            int visina = (int)(visinaEkrana / 3);
            dc.DrawRectangle(pn, new Rectangle(15, this.visinaEkrana / 3 + 30, sirina, visina));
            dc.DrawString(this.logPoruka.s1, new Font(new FontFamily("Arial"), 15), sbFn, 15 + 10, this.visinaEkrana / 3 + visina / 6);
            dc.DrawString(this.logPoruka.s2, new Font(new FontFamily("Arial"), 15), sbFn, 15 + 10, this.visinaEkrana / 3 + visina / 6 * 2);
            dc.DrawString(this.logPoruka.s3, new Font(new FontFamily("Arial"), 15), sbFn, 15 + 10, this.visinaEkrana / 3 + visina / 6 * 3);
            dc.DrawString(this.logPoruka.s4, new Font(new FontFamily("Arial"), 15), sbFn, 15 + 10, this.visinaEkrana / 3 + visina / 6 * 4);
            dc.DrawString(this.logPoruka.s5, new Font(new FontFamily("Arial"), 15), sbFn, 15 + 10, this.visinaEkrana / 3 + visina / 6 * 5);
            dc.DrawString(this.logPoruka.s6, new Font(new FontFamily("Arial"), 15), sbFn, 15 + 10, this.visinaEkrana / 3 + visina / 6 * 6);
        }

        public GameForm(StartForm startForm, int velicina, int mode)
        {
            InitializeComponent();
            this.startForm = startForm;
            this.velicina = velicina;
            this.mode = mode;
            this.tabla = new Tabla((short)this.velicina);
            this.logPoruka = new LogPoruka();

            process = new Process();
            if(mode == 0)
                process.StartInfo.FileName = "pvp.bat";
            else
                process.StartInfo.FileName = "cvp.bat";

            process.StartInfo.UseShellExecute = false;
            process.StartInfo.CreateNoWindow = true;
            process.StartInfo.RedirectStandardOutput = true;
            process.StartInfo.RedirectStandardError = true;
            process.StartInfo.RedirectStandardInput = true;
            process.EnableRaisingEvents = true;
            process.OutputDataReceived += new DataReceivedEventHandler(OutputHandler);

            processprikaz = 0;
            processRacunarPotez = false;
            processPotezX = false;
            processPotezY = false;
            clickUp = false;
            gameOver = false;
            pomeranje = false;

            process.Start();
            process.BeginOutputReadLine();
            process.BeginErrorReadLine();

        }

        private void btnBack_Click(object sender, EventArgs e)
        {
            this.startForm.Show();
            this.Dispose();
        }

        private void GameForm_Load(object sender, EventArgs e)
        {
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.WindowState = FormWindowState.Normal;
            this.Bounds = Screen.PrimaryScreen.Bounds;

            this.sirinaEkrana = this.Width;
            this.visinaEkrana = this.Height;

            int sirina1 = 2 * sirinaEkrana / 3 - 30;
            int sirina2 = visinaEkrana - 30;

            this.velicinaPolja = (sirina1 < sirina2 ? sirina1 : sirina2) / velicina;
            this.sirinaTable = velicinaPolja * velicina;
            this.visinaFigure = (int)(velicinaPolja / 7.5);
            this.pocetakTableX = sirinaEkrana - 15 - sirinaTable;
            this.pocetakTableY = 15;
        }

        private void GameForm_Paint(object sender, PaintEventArgs e)
        {
            Graphics dc = e.Graphics;
            DrawTable(dc);
            DrawScore(dc);
            DrawMessageLog(dc);

            if (pomeranje)
            {
                Pen zelenaOlovka = new Pen(new SolidBrush(Color.FromArgb(125, 255, 255, 0)));
                Pen crvenaOlovka = new Pen(new SolidBrush(Color.FromArgb(125, 255, 0, 0)));
                SolidBrush bela = new SolidBrush(Color.FromArgb(125, 255, 255, 255));
                SolidBrush figuraSiva = new SolidBrush(Color.FromArgb(125, 40, 40, 40));

                int tmp = potezh;
                while (tmp < 8)
                {
                    if (tabla.matrica[potezi, potezj].stek[tmp] == 0)
                        break;
                    else
                    {
                        int pocetakX = pomeranjeX;
                        int pocetakY = pomeranjeY - (tmp + 1) * visinaFigure;
                        if (tabla.matrica[potezi, potezj].stek[tmp] == 1)
                        {
                            dc.FillRectangle(figuraSiva, new Rectangle(pocetakX, pocetakY, this.velicinaPolja, this.visinaFigure));
                            dc.DrawRectangle(zelenaOlovka, new Rectangle(pocetakX, pocetakY, this.velicinaPolja, this.visinaFigure));
                        }
                        else
                        {
                            dc.FillRectangle(bela, new Rectangle(pocetakX, pocetakY, this.velicinaPolja, this.visinaFigure));
                            dc.DrawRectangle(crvenaOlovka, new Rectangle(pocetakX, pocetakY, this.velicinaPolja, this.visinaFigure));
                        }

                    }
                    tmp++;
                }
            }
        }

        private void GameForm_MouseMove(object sender, MouseEventArgs e)
        {
            if (pomeranje)
            {
                pomeranjeX = e.X;
                pomeranjeY = e.Y;
                Invalidate();
            }
        }

        private void GameForm_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.X > this.pocetakTableX && e.X < this.pocetakTableX + this.sirinaTable && e.Y > this.pocetakTableY && e.Y < this.pocetakTableY + this.sirinaTable && !gameOver)
            {
                int j = (e.X - pocetakTableX) / velicinaPolja;
                int i = (e.Y - pocetakTableY) / velicinaPolja;
                int stek = (pocetakTableY + (i + 1) * velicinaPolja - e.Y) / visinaFigure;

                if (stek > 7)
                    return;

                if (this.processPotezX == true && tabla.matrica[i, j].stek[stek] == 1)
                {
                    this.potezi = i;
                    this.potezj = j;
                    this.potezh = stek;
                    clickUp = true;
                    pomeranje = true;
                }
                else if (this.processPotezY == true && tabla.matrica[i, j].stek[stek] == 2)
                {
                    this.potezi = i;
                    this.potezj = j;
                    this.potezh = stek;
                    clickUp = true;
                    pomeranje = true;
                }
            }
        }

        private void GameForm_MouseUp(object sender, MouseEventArgs e)
        {
            pomeranje = false;
            if (e.X > this.pocetakTableX && e.X < this.pocetakTableX + this.sirinaTable && e.Y > this.pocetakTableY && e.Y < this.pocetakTableY + this.sirinaTable && clickUp)
            {
                int j = (e.X - pocetakTableX) / velicinaPolja;
                int i = (e.Y - pocetakTableY) / velicinaPolja;

                this.potezk = i;
                this.potezl = j;

                if (potezk == potezi && potezl == potezj)
                {
                    Invalidate();
                    return;
                }


                clickUp = false;
                processPotezX = false;
                processPotezY = false;
                

                StringBuilder sb = new StringBuilder();
                sb.Append("((");
                sb.Append((char)(65 + potezi));
                sb.Append(" ");
                sb.Append((potezj + 1).ToString());
                sb.Append(") ");

                sb.Append("(");
                sb.Append((char)(65 + potezk));
                sb.Append(" ");
                sb.Append((potezl + 1).ToString());
                sb.Append(") " + potezh.ToString() + ")");
                this.potez = sb.ToString();

                this.logPoruka.s1 = this.logPoruka.s1 + " " + this.potez;
                process.StandardInput.WriteLine(this.potez);
                
            }
            Invalidate();
        }


        void OutputHandler(object sendingProcess, DataReceivedEventArgs outLine)
        {
            if (process.HasExited)
                return;
            //INICIJALIZACIJA
            if (outLine.Data.ToString() == "velicina")
            {
                process.StandardInput.WriteLine(this.velicina.ToString());
            }
            else if (outLine.Data.ToString() == "r")
            {
                if (this.mode == 0)
                    process.StandardInput.WriteLine("r");
                else if (this.mode == 1)
                    process.StandardInput.WriteLine("r");
                else if (this.mode == 2)
                    process.StandardInput.WriteLine("igracprvi");
            }

            //PRIKAZZZZZZZ
            else if (outLine.Data.ToString() == "prikaz")
            {
                this.tabla = null;
                this.tabla = new Tabla((short)this.velicina);
                this.processprikaz = 4;
            }
            else if (processprikaz == 4)
            {
                string minforwin = outLine.Data.ToString();
                this.skorMin = int.Parse(minforwin);
                processprikaz--;
            }
            else if (processprikaz == 3)
            {
                string skorx = outLine.Data.ToString();
                this.skorX = int.Parse(skorx);
                processprikaz--;

            }
            else if (processprikaz == 2)
            {
                string skoro = outLine.Data.ToString();
                this.skorY = int.Parse(skoro);
                processprikaz--;
                processprikazI = 0;
                processprikazJ = 0;
            }
            else if (processprikaz == 1)
            {
                string polje = outLine.Data.ToString();
                tabla.PopuniIzStringa(polje, processprikazI, processprikazJ);
                processprikazJ++;
                if (processprikazJ == velicina)
                {
                    processprikazI++;
                    processprikazJ = 0;
                }
                if (processprikazI == velicina)
                {
                    processprikaz = 0;
                    Invalidate();
                }
            }

            //Racunar potez
            else if (outLine.Data.ToString() == "racunarpotez")
            {
                processRacunarPotez = true;
            }
            else if (processRacunarPotez == true)
            {
                string tmp = "Computer played: ";
                string tmp2 = outLine.Data.ToString();
                StringBuilder sb = new StringBuilder(tmp2);
                
                int s = 0;
                char[] sep = new char[1];
                sep[0] = ' ';
                string[] niz = tmp2.Split(sep);

                int tmi = 0;
                s = 2;
                while(s < niz[0].Length)
                {
                    tmi = tmi * 10 + int.Parse(niz[0][s].ToString());
                    s++;
                }
                int tmj = 0;
                s = 0;
                while (niz[1][s] != ')')
                {
                    tmj = tmj * 10 + int.Parse(niz[1][s].ToString());
                    s++;
                }
                int tmk = 0;
                s = 1;
                while (s < niz[2].Length)
                {
                    tmk = tmk * 10 + int.Parse(niz[2][s].ToString());
                    s++;
                }
                int tml = 0;
                s = 0;
                while (niz[3][s] != ')')
                {
                    tml = tml * 10 + int.Parse(niz[3][s].ToString());
                    s++;
                }
                int tmh = int.Parse(niz[4][0].ToString());

                sb = new StringBuilder();
                sb.Append("((");
                sb.Append((char)(tmi + 65));
                sb.Append((" "));
                sb.Append((tmj + 1).ToString() + ") (");
                sb.Append((char)(tmk + 65));
                sb.Append((" "));
                sb.Append((tml + 1).ToString() + ") " + tmh.ToString() + ")");

                

                logPoruka.dodajString(tmp + sb.ToString());
                processRacunarPotez = false;


                Invalidate();
            }
            else if (outLine.Data.ToString() == "racunarnemapotez")
            {
                logPoruka.dodajString("Computer doesn't have a move.");
                Invalidate();
            }


            //IGRAC POTEZ
            else if (outLine.Data.ToString() == "potezx:")
            {
                logPoruka.dodajString("Black player's turn:");
                this.processPotezX = true;
                Invalidate();
            }
            else if (outLine.Data.ToString() == "potezo:")
            {
                logPoruka.dodajString("White player's turn:");
                this.processPotezY = true;
                Invalidate();
            }
            else if (outLine.Data.ToString() == "nevalidanpotez")
            {
                logPoruka.dodajString(potez + " is not valid move.");
                this.processPotezY = false;
                this.processPotezX = false;
                Invalidate();
            }
            else if (outLine.Data.ToString() == "nemapotezx")
            {
                logPoruka.dodajString("Black player doesn't have a move.");
            }
            else if (outLine.Data.ToString() == "nemapotezo")
            {
                logPoruka.dodajString("White player doesn't have a move.");
            }


            else if(outLine.Data.ToString() == "pobednikx")
            {
                logPoruka = new LogPoruka();
                logPoruka.dodajString("Black player is winner");
                gameOver = true;
                
            }
            else if(outLine.Data.ToString() == "pobedniko")
            {
                logPoruka = new LogPoruka();
                logPoruka.dodajString("White player is winner");
                gameOver = true;
                
            }
        }

        ~GameForm()
        {
            if(!process.HasExited)
                process.Kill();

        }
    }
        
}

