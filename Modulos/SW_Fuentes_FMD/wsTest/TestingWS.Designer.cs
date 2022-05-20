namespace wsTest
{
    partial class TestingWS
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
            this.tx_result = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.bt_test3 = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.bt_test2 = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.bt_test1 = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.tx_fecha = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // tx_result
            // 
            this.tx_result.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tx_result.Location = new System.Drawing.Point(222, 91);
            this.tx_result.Multiline = true;
            this.tx_result.Name = "tx_result";
            this.tx_result.Size = new System.Drawing.Size(335, 102);
            this.tx_result.TabIndex = 13;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(35, 157);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(65, 13);
            this.label3.TabIndex = 12;
            this.label3.Text = "Output ODS";
            // 
            // bt_test3
            // 
            this.bt_test3.Location = new System.Drawing.Point(107, 152);
            this.bt_test3.Name = "bt_test3";
            this.bt_test3.Size = new System.Drawing.Size(75, 23);
            this.bt_test3.TabIndex = 11;
            this.bt_test3.Text = "Test &3";
            this.bt_test3.UseVisualStyleBackColor = true;
            this.bt_test3.Click += new System.EventHandler(this.bt_test3_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(35, 128);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(66, 13);
            this.label2.TabIndex = 10;
            this.label2.Text = "Output RCM";
            // 
            // bt_test2
            // 
            this.bt_test2.Location = new System.Drawing.Point(107, 123);
            this.bt_test2.Name = "bt_test2";
            this.bt_test2.Size = new System.Drawing.Size(75, 23);
            this.bt_test2.TabIndex = 9;
            this.bt_test2.Text = "Test &2";
            this.bt_test2.UseVisualStyleBackColor = true;
            this.bt_test2.Click += new System.EventHandler(this.bt_test2_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(35, 99);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(56, 13);
            this.label1.TabIndex = 8;
            this.label1.Text = "Input DCE";
            // 
            // bt_test1
            // 
            this.bt_test1.Location = new System.Drawing.Point(107, 94);
            this.bt_test1.Name = "bt_test1";
            this.bt_test1.Size = new System.Drawing.Size(75, 23);
            this.bt_test1.TabIndex = 7;
            this.bt_test1.Text = "Test &1";
            this.bt_test1.UseVisualStyleBackColor = true;
            this.bt_test1.Click += new System.EventHandler(this.bt_test1_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(38, 24);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(78, 13);
            this.label4.TabIndex = 14;
            this.label4.Text = "Fecha Reporte";
            // 
            // tx_fecha
            // 
            this.tx_fecha.Location = new System.Drawing.Point(123, 24);
            this.tx_fecha.Name = "tx_fecha";
            this.tx_fecha.Size = new System.Drawing.Size(189, 20);
            this.tx_fecha.TabIndex = 15;
            // 
            // TestingWS
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(569, 205);
            this.Controls.Add(this.tx_fecha);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.tx_result);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.bt_test3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.bt_test2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.bt_test1);
            this.Name = "TestingWS";
            this.Text = "TestingWS";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox tx_result;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button bt_test3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button bt_test2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button bt_test1;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox tx_fecha;
    }
}