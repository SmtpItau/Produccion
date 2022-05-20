using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Security.Cryptography;

namespace WSCentralizacion
{
    public partial class Service1 : ServiceBase
    {
        bool blBandera = false;
        public clsCentralizacionProcesos.clsLog oLog = new clsCentralizacionProcesos.clsLog();

        private string MSGEX;
        private string MSGEXCTR;
        private string TIPOMSEX;
        private int    NUMEX;
        private string MENSAJELOG;

        static string sOrigen = "Service.WSCentralizacion";

        public Service1()
        {
            oLog.PATHLOG = ConfigurationSettings.AppSettings["PATHLOG"].ToString();
            oLog.NOMBREARCHIVO = ConfigurationSettings.AppSettings["PRENAMELOG"].ToString();

            oLog.GeneraLog("Service BacIniciosAutomaticos", "InitializeComponent()");
            InitializeComponent();
            IniciarServicio();

        }

        protected override void OnStart(string[] args)
        {
            oLog.GeneraLog("Service BacIniciosAutomaticos", "OnStart()");
            //stLamso.Start();
        }

        protected override void OnStop()
        {
            oLog.GeneraLog("Service BacIniciosAutomaticos", "Stop()");
            //stLamso.Stop();
        }

        private void IniciarServicio()
        {
                oLog.GeneraLog("Service BacIniciosAutomaticos", "IniciarServicio()");


                clsCentralizacionProcesos.clsProcesoInicios clsprocesos = new clsCentralizacionProcesos.clsProcesoInicios();

                clsprocesos.UDL_BONOS = ConfigurationSettings.AppSettings["UDL_BONOS"].ToString();

                clsprocesos.UDL_BONOS = ConfigurationSettings.AppSettings["UDL_BONOS"].ToString();
                clsprocesos.UDL_SPOT = ConfigurationSettings.AppSettings["UDL_SPOT"].ToString();
                clsprocesos.UDL_FORWARD = ConfigurationSettings.AppSettings["UDL_FORWARD"].ToString();
                clsprocesos.UDL_LINEAS = ConfigurationSettings.AppSettings["UDL_LINEAS"].ToString();
                clsprocesos.UDL_PARAMETROS = ConfigurationSettings.AppSettings["UDL_PARAMETROS"].ToString();
                clsprocesos.UDL_SWAP = ConfigurationSettings.AppSettings["UDL_SWAP"].ToString();
                clsprocesos.UDL_TRADER = ConfigurationSettings.AppSettings["UDL_TRADER"].ToString();
                clsprocesos.UDL_OPCIONES = ConfigurationSettings.AppSettings["UDL_OPCIONES"].ToString();
                clsprocesos.UDL_PASIVO = ConfigurationSettings.AppSettings["UDL_PASIVO"].ToString();
                clsprocesos.UDL_PARAM_PASIVO = ConfigurationSettings.AppSettings["UDL_PARAM_PASIVO"].ToString();
                clsprocesos.DATA_SOURCE = ConfigurationSettings.AppSettings["DATA_SOURCE"].ToString();

                clsprocesos.USER_ID = ConfigurationSettings.AppSettings["USER_ID"].ToString();
                clsprocesos.PASSWORD = DesEcrypt(ConfigurationSettings.AppSettings["PASSWORD"].ToString());

                //clsprocesos.GSBAC_RECAL = ConfigurationSettings.AppSettings["GSBAC_RECAL"].ToString();
                //clsprocesos.GSBAC_DIRPAE = ConfigurationSettings.AppSettings["GSBAC_DIRPAE"].ToString();

                clsprocesos.START_TIME = ConfigurationSettings.AppSettings["START_TIME"].ToString();
                clsprocesos.END_TIME = ConfigurationSettings.AppSettings["END_TIME"].ToString();
                clsprocesos.INTERVAL_TIME = double.Parse(ConfigurationSettings.AppSettings["INTERVAL_TIME"].ToString());


                clsprocesos.CONNECT_TIMEOUT = Convert.ToInt32(ConfigurationSettings.AppSettings["CONNECT_TIMEOUT"].ToString());
                clsprocesos.CONNECT_RETRYCOUNT = Convert.ToInt32(ConfigurationSettings.AppSettings["CONNECT_RETRYCOUNT"].ToString());
                clsprocesos.CONNECT_RETRYINTERVAL = Convert.ToInt32(ConfigurationSettings.AppSettings["CONNECT_RETRYINTERVAL"].ToString());

                clsprocesos.EXECUTION_RETRYCOUNT = Convert.ToInt32(ConfigurationSettings.AppSettings["EXECUTION_RETRYCOUNT"].ToString());
                clsprocesos.EXECUTION_RETRYINTERVAL = Convert.ToInt32(ConfigurationSettings.AppSettings["EXECUTION_RETRYINTERVAL"].ToString());


                clsprocesos.PATHLOG = ConfigurationSettings.AppSettings["PATHLOG"].ToString();
                clsprocesos.PRENAMELOG = ConfigurationSettings.AppSettings["PRENAMELOG"].ToString();

                clsprocesos.TIPOLOGTXT = Convert.ToBoolean(ConfigurationSettings.AppSettings["TIPOLOGTXT"].ToString());

                //clsprocesos.PATHFILEPAE = ConfigurationSettings.AppSettings["PATHFILEPAE"].ToString();

                clsprocesos.MailEnable = bool.Parse(ConfigurationSettings.AppSettings["MailEnable"].ToString());
                clsprocesos.Mailhost = ConfigurationSettings.AppSettings["Mailhost"].ToString();
                clsprocesos.MailPort = Convert.ToInt32(ConfigurationSettings.AppSettings["MailPort"].ToString());
                clsprocesos.MailEnableSsl = bool.Parse(ConfigurationSettings.AppSettings["MailEnableSsl"].ToString());
                clsprocesos.MailhostUser = ConfigurationSettings.AppSettings["MailhostUser"].ToString();
                clsprocesos.MailPassword = DesEcrypt(ConfigurationSettings.AppSettings["MailPassword"].ToString());
                clsprocesos.MailFrom = ConfigurationSettings.AppSettings["MailFrom"].ToString();
                clsprocesos.MailTo = ConfigurationSettings.AppSettings["MailTo"].ToString();
                clsprocesos.MailSubject = ConfigurationSettings.AppSettings["MailSubject"].ToString();
                clsprocesos.MailBody = ConfigurationSettings.AppSettings["MailBody"].ToString();

                clsprocesos.Procesar();
            
          
        }
        [Obsolete]
        //private void stLamso_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        //{
        //    oLog.GeneraLog("Service BacIniciosAutomaticos", "stLamso_Elapsed()");

        //    if (blBandera) return;

        //    stLamso.Stop();//por seguimiento
             
        //    clsCentralizacionProcesos.clsProcesoInicios clsprocesos = new clsCentralizacionProcesos.clsProcesoInicios();

        //    clsprocesos.UDL_BONOS = ConfigurationSettings.AppSettings["UDL_BONOS"].ToString();

        //    clsprocesos.UDL_BONOS=ConfigurationSettings.AppSettings["UDL_BONOS"].ToString();
        //    clsprocesos.UDL_SPOT=ConfigurationSettings.AppSettings["UDL_SPOT"].ToString();
        //    clsprocesos.UDL_FORWARD=ConfigurationSettings.AppSettings["UDL_FORWARD"].ToString();
        //    clsprocesos.UDL_LINEAS=ConfigurationSettings.AppSettings["UDL_LINEAS"].ToString();
        //    clsprocesos.UDL_PARAMETROS=ConfigurationSettings.AppSettings["UDL_PARAMETROS"].ToString();
        //    clsprocesos.UDL_SWAP=ConfigurationSettings.AppSettings["UDL_SWAP"].ToString();
        //    clsprocesos.UDL_TRADER=ConfigurationSettings.AppSettings["UDL_TRADER"].ToString();
        //    clsprocesos.UDL_OPCIONES=ConfigurationSettings.AppSettings["UDL_OPCIONES"].ToString();
        //    clsprocesos.UDL_PASIVO = ConfigurationSettings.AppSettings["UDL_PASIVO"].ToString();
        //    clsprocesos.UDL_PARAM_PASIVO = ConfigurationSettings.AppSettings["UDL_PARAM_PASIVO"].ToString();
        //    clsprocesos.DATA_SOURCE = ConfigurationSettings.AppSettings["DATA_SOURCE"].ToString();

        //    clsprocesos.USER_ID = ConfigurationSettings.AppSettings["USER_ID"].ToString();
        //    clsprocesos.PASSWORD = DesEcrypt(ConfigurationSettings.AppSettings["PASSWORD"].ToString());

        //    clsprocesos.GSBAC_RECAL = ConfigurationSettings.AppSettings["GSBAC_RECAL"].ToString();
        //    clsprocesos.GSBAC_DIRPAE = ConfigurationSettings.AppSettings["GSBAC_DIRPAE"].ToString();

        //    clsprocesos.START_TIME =  ConfigurationSettings.AppSettings["START_TIME"].ToString();
        //    clsprocesos.END_TIME =  ConfigurationSettings.AppSettings["END_TIME"].ToString();
        //    clsprocesos.INTERVAL_TIME = double.Parse(ConfigurationSettings.AppSettings["INTERVAL_TIME"].ToString());
      
        //    clsprocesos.CONNECT_TIMEOUT = Convert.ToInt32( ConfigurationSettings.AppSettings["CONNECT_TIMEOUT"].ToString());
        //    clsprocesos.CONNECT_RETRYCOUNT = Convert.ToInt32( ConfigurationSettings.AppSettings["CONNECT_RETRYCOUNT"].ToString());
        //    clsprocesos.CONNECT_RETRYINTERVAL = Convert.ToInt32(ConfigurationSettings.AppSettings["CONNECT_RETRYINTERVAL"].ToString());

        //    clsprocesos.PATHLOG = ConfigurationSettings.AppSettings["PATHLOG"].ToString();
        //    clsprocesos.PRENAMELOG = ConfigurationSettings.AppSettings["PRENAMELOG"].ToString();

        //    clsprocesos.TIPOLOGTXT = Convert.ToBoolean(ConfigurationSettings.AppSettings["TIPOLOGTXT"].ToString());

        //    clsprocesos.PATHFILEPAE = ConfigurationSettings.AppSettings["PATHFILEPAE"].ToString();

        //    clsprocesos.MailEnable  = bool.Parse(ConfigurationSettings.AppSettings["MailEnable"].ToString());
        //    clsprocesos.Mailhost    = ConfigurationSettings.AppSettings["Mailhost"].ToString();
        //    clsprocesos.MailPort    = Convert.ToInt32(ConfigurationSettings.AppSettings["MailPort"].ToString());
        //    clsprocesos.MailEnableSsl = bool.Parse(ConfigurationSettings.AppSettings["MailEnableSsl"].ToString());
        //    clsprocesos.MailhostUser= ConfigurationSettings.AppSettings["MailhostUser"].ToString();
        //    clsprocesos.MailPassword= DesEcrypt(ConfigurationSettings.AppSettings["MailPassword"].ToString());
        //    clsprocesos.MailTo      = ConfigurationSettings.AppSettings["MailTo"].ToString();
        //    clsprocesos.MailSubject = ConfigurationSettings.AppSettings["MailSubject"].ToString();
        //    clsprocesos.MailBody    = ConfigurationSettings.AppSettings["MailBody"].ToString();



        //    clsprocesos.Procesar();

           
        //    //clsprocesos.TIPOLOGCMD= Convert.ToBoolean( ConfigurationSettings.AppSettings["TipoLogCmd"].ToString());
        //    //clsprocesos.TIPOLOGWIN= Convert.ToBoolean( ConfigurationSettings.AppSettings["TipoLogWin"].ToString());
        //    //clsprocesos.ActualizarValor()

           
        //    blBandera = false;

        //}

        public string DesEcrypt(string encrypted)
        {
            try
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
            catch (Exception ex)
            {
                oLog.GeneraLog("Service BacIniciosAutomaticos", "DesEcrypt");
                return "";
            }

        }


    }
}
