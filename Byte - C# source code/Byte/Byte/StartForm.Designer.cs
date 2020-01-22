namespace Byte
{
    partial class StartForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnPvp = new System.Windows.Forms.Button();
            this.btnCvp = new System.Windows.Forms.Button();
            this.btnPvc = new System.Windows.Forms.Button();
            this.btnQuit = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnPvp
            // 
            this.btnPvp.BackColor = System.Drawing.Color.Transparent;
            this.btnPvp.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnPvp.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnPvp.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Black;
            this.btnPvp.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnPvp.Font = new System.Drawing.Font("Bookman Old Style", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnPvp.ForeColor = System.Drawing.Color.DarkGreen;
            this.btnPvp.Location = new System.Drawing.Point(137, 106);
            this.btnPvp.Name = "btnPvp";
            this.btnPvp.Size = new System.Drawing.Size(225, 45);
            this.btnPvp.TabIndex = 0;
            this.btnPvp.Text = "Player vs Player";
            this.btnPvp.UseVisualStyleBackColor = false;
            this.btnPvp.Click += new System.EventHandler(this.btnPvp_Click);
            // 
            // btnCvp
            // 
            this.btnCvp.BackColor = System.Drawing.Color.Transparent;
            this.btnCvp.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnCvp.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnCvp.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Black;
            this.btnCvp.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCvp.Font = new System.Drawing.Font("Bookman Old Style", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnCvp.ForeColor = System.Drawing.Color.DarkGreen;
            this.btnCvp.Location = new System.Drawing.Point(137, 180);
            this.btnCvp.Name = "btnCvp";
            this.btnCvp.Size = new System.Drawing.Size(225, 45);
            this.btnCvp.TabIndex = 1;
            this.btnCvp.Text = "Computer vs Player";
            this.btnCvp.UseVisualStyleBackColor = false;
            this.btnCvp.Click += new System.EventHandler(this.btnCvp_Click);
            // 
            // btnPvc
            // 
            this.btnPvc.BackColor = System.Drawing.Color.Transparent;
            this.btnPvc.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnPvc.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnPvc.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Black;
            this.btnPvc.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnPvc.Font = new System.Drawing.Font("Bookman Old Style", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnPvc.ForeColor = System.Drawing.Color.DarkGreen;
            this.btnPvc.Location = new System.Drawing.Point(137, 250);
            this.btnPvc.Name = "btnPvc";
            this.btnPvc.Size = new System.Drawing.Size(225, 45);
            this.btnPvc.TabIndex = 2;
            this.btnPvc.Text = "Player vs Computer";
            this.btnPvc.UseVisualStyleBackColor = false;
            this.btnPvc.Click += new System.EventHandler(this.btnPvc_Click);
            // 
            // btnQuit
            // 
            this.btnQuit.BackColor = System.Drawing.Color.Transparent;
            this.btnQuit.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnQuit.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btnQuit.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Black;
            this.btnQuit.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnQuit.Font = new System.Drawing.Font("Bookman Old Style", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnQuit.ForeColor = System.Drawing.Color.DarkGreen;
            this.btnQuit.Location = new System.Drawing.Point(137, 321);
            this.btnQuit.Name = "btnQuit";
            this.btnQuit.Size = new System.Drawing.Size(225, 45);
            this.btnQuit.TabIndex = 3;
            this.btnQuit.Text = "Quit";
            this.btnQuit.UseVisualStyleBackColor = false;
            this.btnQuit.Click += new System.EventHandler(this.btnQuit_Click);
            // 
            // StartForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackgroundImage = global::Byte.Properties.Resources.bkg1;
            this.ClientSize = new System.Drawing.Size(484, 462);
            this.ControlBox = false;
            this.Controls.Add(this.btnQuit);
            this.Controls.Add(this.btnPvc);
            this.Controls.Add(this.btnCvp);
            this.Controls.Add(this.btnPvp);
            this.DoubleBuffered = true;
            this.MaximumSize = new System.Drawing.Size(500, 500);
            this.MinimumSize = new System.Drawing.Size(500, 500);
            this.Name = "StartForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Form1";
            this.TransparencyKey = System.Drawing.Color.Transparent;
            this.Load += new System.EventHandler(this.StartForm_Load);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnPvp;
        private System.Windows.Forms.Button btnCvp;
        private System.Windows.Forms.Button btnPvc;
        private System.Windows.Forms.Button btnQuit;
    }
}

