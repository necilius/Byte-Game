namespace Byte
{
    partial class SizeForm
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
            this.btn12x12 = new System.Windows.Forms.Button();
            this.btn10x10 = new System.Windows.Forms.Button();
            this.btn8x8 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btn12x12
            // 
            this.btn12x12.BackColor = System.Drawing.Color.Transparent;
            this.btn12x12.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn12x12.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btn12x12.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Black;
            this.btn12x12.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn12x12.Font = new System.Drawing.Font("Bookman Old Style", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn12x12.ForeColor = System.Drawing.Color.DarkGreen;
            this.btn12x12.Location = new System.Drawing.Point(138, 284);
            this.btn12x12.Name = "btn12x12";
            this.btn12x12.Size = new System.Drawing.Size(225, 45);
            this.btn12x12.TabIndex = 6;
            this.btn12x12.Text = "12 x 12";
            this.btn12x12.UseVisualStyleBackColor = false;
            this.btn12x12.Click += new System.EventHandler(this.btn12x12_Click);
            // 
            // btn10x10
            // 
            this.btn10x10.BackColor = System.Drawing.Color.Transparent;
            this.btn10x10.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn10x10.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btn10x10.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Black;
            this.btn10x10.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn10x10.Font = new System.Drawing.Font("Bookman Old Style", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn10x10.ForeColor = System.Drawing.Color.DarkGreen;
            this.btn10x10.Location = new System.Drawing.Point(138, 207);
            this.btn10x10.Name = "btn10x10";
            this.btn10x10.Size = new System.Drawing.Size(225, 45);
            this.btn10x10.TabIndex = 5;
            this.btn10x10.Text = "10 x 10";
            this.btn10x10.UseVisualStyleBackColor = false;
            this.btn10x10.Click += new System.EventHandler(this.btn10x10_Click);
            // 
            // btn8x8
            // 
            this.btn8x8.BackColor = System.Drawing.Color.Transparent;
            this.btn8x8.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btn8x8.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Transparent;
            this.btn8x8.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Black;
            this.btn8x8.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btn8x8.Font = new System.Drawing.Font("Bookman Old Style", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn8x8.ForeColor = System.Drawing.Color.DarkGreen;
            this.btn8x8.Location = new System.Drawing.Point(138, 129);
            this.btn8x8.Name = "btn8x8";
            this.btn8x8.Size = new System.Drawing.Size(225, 45);
            this.btn8x8.TabIndex = 4;
            this.btn8x8.Text = "8 x 8";
            this.btn8x8.UseVisualStyleBackColor = false;
            this.btn8x8.Click += new System.EventHandler(this.btn8x8_Click);
            // 
            // SizeForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackgroundImage = global::Byte.Properties.Resources.bkg1;
            this.ClientSize = new System.Drawing.Size(484, 462);
            this.ControlBox = false;
            this.Controls.Add(this.btn12x12);
            this.Controls.Add(this.btn10x10);
            this.Controls.Add(this.btn8x8);
            this.DoubleBuffered = true;
            this.MaximumSize = new System.Drawing.Size(500, 500);
            this.MinimumSize = new System.Drawing.Size(500, 500);
            this.Name = "SizeForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "SizeForm";
            this.Load += new System.EventHandler(this.SizeForm_Load);
            this.Shown += new System.EventHandler(this.SizeForm_Shown);
            this.VisibleChanged += new System.EventHandler(this.SizeForm_VisibleChanged);
            this.Paint += new System.Windows.Forms.PaintEventHandler(this.SizeForm_Paint);
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Button btn12x12;
        private System.Windows.Forms.Button btn10x10;
        private System.Windows.Forms.Button btn8x8;
    }
}