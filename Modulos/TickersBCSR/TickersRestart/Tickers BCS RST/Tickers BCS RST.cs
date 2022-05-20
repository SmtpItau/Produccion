using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Security.Cryptography;
using System.ServiceProcess;
using System.Timers;
using System.Configuration;

namespace Tickers_BCS_RST
{
    public partial class TickersBCSR : ServiceBase
    {
        System.Timers.Timer myTimer = null;
        public TickersBCSR()
        {
            InitializeComponent();
            myTimer = new System.Timers.Timer(ObtieneTiempoTimer());
            myTimer.Elapsed += new ElapsedEventHandler(MyTimerElapsed);
            myTimer.Start();
        }

        private void MyTimerElapsed(object sender, ElapsedEventArgs e)
        {
            ServiceController servicio = new ServiceController("Tickers BCS");
            servicio.Stop();
            servicio.WaitForStatus(ServiceControllerStatus.Stopped);
            servicio.Start();
            myTimer.Interval=ObtieneTiempoTimer();

        }

        private int ObtieneTiempoTimer()
        {
            SqlConnection sqlConn = sqlConnection();
            try
            {
                sqlConn.Open();
                SqlCommand cmd = new SqlCommand("select  MinutosReinicio from tbl_tickers_bolsa_config", sqlConn);
                cmd.CommandType = CommandType.Text;


                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                return Convert.ToInt32(cmd.ExecuteScalar()) * 60000; //Convierte a milisegundos los minutos
            }

            catch (Exception ex)
            {
                throw new Exception("Error en DAC_Ticker.cs - Metodo ObtieneNemoIIF - " + ex.Message);
            }
            finally
            {
                sqlConn.Close();
            }
            
        }

        public SqlConnection sqlConnection()
        {
            string strConn ="";
            strConn = "Data Source=" + ConfigurationManager.AppSettings["Server"].ToString() +";";
            strConn += "Initial Catalog=" + ConfigurationManager.AppSettings["database"].ToString() + ";";
            strConn += "User ID=" + ConfigurationManager.AppSettings["user"].ToString() + ";";
            strConn += "Password=" + DesEcrypt(ConfigurationManager.AppSettings["password"].ToString());

            var sqlConn = new SqlConnection {ConnectionString = strConn};

            return sqlConn;
        }

        public string DesEcrypt(string encrypted)
        {
            string RGBKEY = "12121212";
            string RGBIV = "34343434";

            byte[] data = System.Convert.FromBase64String(encrypted);
            byte[] rgbKey = System.Text.ASCIIEncoding.ASCII.GetBytes(RGBKEY);
            byte[] rgbIV = System.Text.ASCIIEncoding.ASCII.GetBytes(RGBIV);

            MemoryStream memoryStream = new MemoryStream(data.Length);
            DESCryptoServiceProvider desCryptoServiceProvider = new DESCryptoServiceProvider();
            CryptoStream cryptoStream = new CryptoStream(memoryStream, desCryptoServiceProvider.CreateDecryptor(rgbKey, rgbIV), CryptoStreamMode.Read);

            memoryStream.Write(data, 0, data.Length);
            memoryStream.Position = 0;

            string decrypted = new StreamReader(cryptoStream).ReadToEnd();

            cryptoStream.Close();

            return decrypted;


        }

    }
}
