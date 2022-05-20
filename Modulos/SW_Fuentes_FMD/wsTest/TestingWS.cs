using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using wsTest.ServiceWSReport;

namespace wsTest
{
    public partial class TestingWS : Form
    {
        public TestingWS()
        {
            InitializeComponent();
        }

        private void bt_test1_Click(object sender, EventArgs e)
        {
            //DCE input.
            DateTime date;
            DateTime.TryParse(tx_fecha.Text,out date);

            tx_result.Text = string.Empty;

            wsReportServicesSoapClient client = new wsReportServicesSoapClient();
            var result = client.Automated_RCM_SendReports(ProcessType.Input, "RCM", string.Empty);
            //var result = client.GenerateAndSendReports(ProcessType.Input, "RCM", "DCE", date,false);
            string result_str = string.Empty;

            if (result.GetType() == typeof(ArrayOfString))
            {
                foreach (string str in (ArrayOfString)result)
                {
                    result_str += str + "\r\n";
                }
                tx_result.Text = result_str;
            }
            else
            {
                tx_result.Text = result.ToString();
            }
        }

        private void bt_test2_Click(object sender, EventArgs e)
        {
            //RCM output
            DateTime date;
            DateTime.TryParse(tx_fecha.Text, out date);

            //tx_result.Text = string.Empty;

            wsReportServicesSoapClient client = new wsReportServicesSoapClient();
                        
            var result = client.Automated_RCM_SendReports(ProcessType.Output, "RCM", string.Empty);
            string result_str = string.Empty;

            foreach (string str in (ArrayOfString)result){
                    result_str += str + "\r\n";
            }
            tx_result.Text = result_str;
        }

        private void bt_test3_Click(object sender, EventArgs e)
        {
            DateTime date;
            DateTime.TryParse(tx_fecha.Text, out date);

            tx_result.Text = string.Empty;
            wsReportServicesSoapClient client = new wsReportServicesSoapClient();
            var result = client.GenerateAndSendReports(ProcessType.Output, "ODS", "ODS", tx_fecha.Text, false);

            string result_str = string.Empty;

            if (result.GetType() == typeof(ArrayOfString))
            {
                foreach (string str in (ArrayOfString)result)
                {
                    result_str += str + "\r\n";
                }
                tx_result.Text = result_str;
            }
            else
            {
                tx_result.Text = result.ToString();
            }


        }      
    }
}
