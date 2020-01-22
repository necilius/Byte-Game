using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Byte
{
    public partial class StartForm : Form
    {
        public int size;

        public StartForm()
        {
            InitializeComponent();
            
        }

        private void btnQuit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnPvp_Click(object sender, EventArgs e)
        {
            
            SizeForm szf = new SizeForm(this);
            int size = 0;
            this.Hide();
            if (szf.ShowDialog() == DialogResult.Cancel)
            {
                size = szf.tableSize;
            }
            GameForm gmf = new GameForm(this,size,0);
            gmf.Show();

        }

        private void btnCvp_Click(object sender, EventArgs e)
        {
            SizeForm szf = new SizeForm(this);
            int size = 0;
            this.Hide();
            if (szf.ShowDialog() == DialogResult.Cancel)
            {
                size = szf.tableSize;
            }
            GameForm gmf = new GameForm(this, size, 1);
            gmf.Show();
        }

        private void btnPvc_Click(object sender, EventArgs e)
        {
            SizeForm szf = new SizeForm(this);
            int size = 0;
            this.Hide();
            if (szf.ShowDialog() == DialogResult.Cancel)
            {
                size = szf.tableSize;
            }
            GameForm gmf = new GameForm(this, size, 2);
            gmf.Show();
        }

        private void StartForm_Load(object sender, EventArgs e)
        {
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
        }
    }
}
