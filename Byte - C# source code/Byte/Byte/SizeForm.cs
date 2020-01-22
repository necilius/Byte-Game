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
    public partial class SizeForm : Form
    {
        StartForm startForm;
        public int tableSize;

        public SizeForm(StartForm startForm)
        {
            InitializeComponent();
            this.startForm = startForm;
        }

        private void SizeForm_Load(object sender, EventArgs e)
        {
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
        }

        private void btn10x10_Click(object sender, EventArgs e)
        {
            this.tableSize = 10;
            this.Close();
        }

        private void btn14x14_Click(object sender, EventArgs e)
        {
            this.tableSize = 14;
            this.Close();
        }

        private void btn16x16_Click(object sender, EventArgs e)
        {
            this.tableSize = 16;
            this.Close();
        }

        private void btn8x8_Click(object sender, EventArgs e)
        {
            this.tableSize = 8;
            this.startForm.size = 8;
            this.Close();
        }

        private void btn12x12_Click(object sender, EventArgs e)
        {
            this.tableSize = 12;
            this.Close();
        }

        private void SizeForm_Shown(object sender, EventArgs e)
        {
            
        }

        private void SizeForm_Paint(object sender, PaintEventArgs e)
        {
            
        }

        private void SizeForm_VisibleChanged(object sender, EventArgs e)
        {
            
        }
    }
}
