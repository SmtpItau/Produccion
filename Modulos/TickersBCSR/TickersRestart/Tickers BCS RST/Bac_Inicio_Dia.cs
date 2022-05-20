using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Timers;
using System.Configuration;
using System.IO;
using System.Security.Cryptography;
using System.Data.SqlClient;


namespace Tickers_BCS_RST
{
    partial class Bac_Inicio_Dia : ServiceBase
    {
        bool Ejecucion;
        // Se Agrega para el control de Inicio de la Actividad
        bool SwEjecucion_FD_NY;

        string errNemo;
        string errMensaje;

        string Tiempo_TImer;

        string ObjHora_WebConfig;
        DateTime ObjHora_Configurada;

        string ObjHora_HoraMaquina;
        DateTime ObjHora_TiempoReal;

        // Se utilizan para el fin de día de New York
        bool Sw_FinDia = false;
        string ObjHoraFinDia_AppConfig;
        DateTime ObjHoraFinDia_Configurada;
        // Se utilizan para el fin de día de New York

        System.Timers.Timer Timer_Inicio_Dia = null;

        public Bac_Inicio_Dia()
        {
            InitializeComponent();

            // Fin de Día New York
            SwEjecucion_FD_NY = false;
            Sw_FinDia = Leer_HoraFinDia_NY();

            // Inicio de Dia Chile y New York
            Ejecucion = false;

            Timer_Inicio_Dia = new System.Timers.Timer(Leer_Tiempo_Ejecucion());
            Timer_Inicio_Dia.Elapsed += new ElapsedEventHandler(MyTimerElapsed);
            Timer_Inicio_Dia.Start();
        }

        private bool Leer_HoraFinDia_NY()
        {
               // Lee la Hora de configuracion que se encuentra en el APP.Config, (Para el proceso de Cierre de NY)
            try
            {
                ObjHoraFinDia_Configurada = Convert.ToDateTime(ConfigurationManager.AppSettings["NY_HoraCierreDia"].ToString());
                return true; 
            }
            catch (Exception)
            {
                ObjHoraFinDia_Configurada = Convert.ToDateTime("00:00:00");
                return false; 
            }
            
        }

        private int Leer_Tiempo_Ejecucion()
        {
            Tiempo_TImer = ConfigurationManager.AppSettings["Tiempo_Ejecucion"].ToString();

            // Lee la hora definida en el File Config
            ObjHora_WebConfig = ConfigurationManager.AppSettings["Hora_de_Inicio"].ToString();
            ObjHora_Configurada = Convert.ToDateTime(ObjHora_WebConfig.ToString());

            if (Tiempo_TImer.Length == 0)
                Tiempo_TImer = "0";

            Log_Event("1 - Leer Tiempo Etablecido en Web Config : " + Tiempo_TImer.ToString() );

            return Convert.ToInt32(Tiempo_TImer);
        }


        private void MyTimerElapsed(object sender, ElapsedEventArgs e)
        {
            // Lee la hora de la maquina en tiempo real
            ObjHora_HoraMaquina = DateTime.Now.Hour.ToString("00") + ":" + DateTime.Now.Minute.ToString("00") + ":" + DateTime.Now.Second.ToString("00");
            ObjHora_TiempoReal = Convert.ToDateTime(ObjHora_HoraMaquina.ToString());

            if ((Convert.ToInt32(ObjHora_TiempoReal.Hour) == Convert.ToInt32(ObjHora_Configurada.Hour)) & (Convert.ToInt32(ObjHora_TiempoReal.Minute) >= Convert.ToInt32(ObjHora_Configurada.Minute)))
                {
                    if (Ejecucion == false)
                        {
                            Timer_Inicio_Dia.Interval = 100000;

                            // Ejecuta el Inicio de Día en New York antes de Chile, por los feriados. 
                            if (Ejecuta_Proceso_Inicio_Dia_NewYork() == true)
                            {
                                Timer_Inicio_Dia.Interval = 100000;
                            }
                            // Ejecuta el Inicio de Dia en Chile
                            if (Ejecuta_Proceso_Inicio_Dia() == true)
                            {
                                Timer_Inicio_Dia.Interval = Convert.ToInt32(Tiempo_TImer);
                            }

                        }
                }
            else
            {   Ejecucion = false;
                Timer_Inicio_Dia.Interval = 100000;
            }

        ////// Control Horario (Hora) para iniciar actividades de Inicio de Día
        ////// Busca la Hora de inicio
        ////if (Convert.ToInt32(ObjHora_TiempoReal.Hour) == Convert.ToInt32(ObjHora_Configurada.Hour))
        ////{
        ////    // Control Horario (minutors) para iniciar actividades de Inicio de Día
        ////    // Busca el Minuto exacto para iniciar
        ////    if (Convert.ToInt32(ObjHora_TiempoReal.Minute) >= Convert.ToInt32(ObjHora_Configurada.Minute))
        ////    {
        ////        if (Ejecucion == false)
        ////        {
        ////            Timer_Inicio_Dia.Interval = 100000;

        ////            // Ejecuta el Inicio de Día en New York antes de Chile, por los feriados. 
        ////            // (New York contiene el control y recalculo de lineas, en caso que sea feriado en chile.)
        ////            if (Ejecuta_Proceso_Inicio_Dia_NewYork() == true)
        ////            {
        ////                Timer_Inicio_Dia.Interval = 100000;
        ////            }

        ////            // Ejecuta el Inicio de Dia en Chile
        ////            if (Ejecuta_Proceso_Inicio_Dia() == true)
        ////            {
        ////                Timer_Inicio_Dia.Interval = Convert.ToInt32(Tiempo_TImer);
        ////            }

        ////        }   //  if (Ejecucion == false)

        ////    }   // if (Convert.ToInt32(ObjHora_TiempoReal.Minute) >= Convert.ToInt32(ObjHora_Configurada.Minute))

        ////}   // if (Convert.ToInt32(ObjHora_TiempoReal.Hour) == Convert.ToInt32(ObjHora_Configurada.Hour))
        ////else
        ////{
        ////    Ejecucion = false;
        ////    Timer_Inicio_Dia.Interval = 100000;
        ////}


// **** P R O C E S O   D E   F I N    D E   D I A   D E S C O N E C T A D O                             **** 
// **********************************************************************************************************
// **********************************************************************************************************

//
//            //  Debe estar activado el Sw, que indica que la hora se leyo correctamente, mas la configuracion de Hora y Minuto adecuados para la ejecucion
//            if  (   (Sw_FinDia == true)
//                &   (   (Convert.ToInt32(ObjHora_TiempoReal.Hour) == Convert.ToInt32(ObjHoraFinDia_Configurada.Hour)) & (Convert.ToInt32(ObjHora_TiempoReal.Minute) >= Convert.ToInt32(ObjHoraFinDia_Configurada.Minute))
//                    )
//                )
//                { 
//                    if (SwEjecucion_FD_NY == false)
//                    {
//                        Timer_Inicio_Dia.Interval = 100000;
//                        if (Ejecuta_FinDia_NY() == true)
//                        {
//                            Timer_Inicio_Dia.Interval = 100000;
//                        }
//                    }
//                }

// **** P R O C E S O   D E   F I N    D E   D I A   D E S C O N E C T A D O                             **** 
// **********************************************************************************************************
// **********************************************************************************************************


        }



        private bool Ejecuta_FinDia_NY()
        {
            // Para el control de partida de las actividades de Cierre.
            SwEjecucion_FD_NY = true;

            try
            {
                errNemo = "";   errMensaje = "";

                OBJ_Fin_Dia_Centralizado.Genera_Fin_Dia Dll_FDia = new OBJ_Fin_Dia_Centralizado.Genera_Fin_Dia();

                Dll_FDia.servidor = ConfigurationManager.AppSettings["NY_Servidor"].ToString();
                Dll_FDia.Usuario = ConfigurationManager.AppSettings["NY_Usuario"].ToString();
                Dll_FDia.Clave = DesEcrypt(ConfigurationManager.AppSettings["NY_Password"].ToString());
                Dll_FDia.db_Parametros = ConfigurationManager.AppSettings["NY_dbParametros"].ToString();
                Dll_FDia.db_Swap = ConfigurationManager.AppSettings["NY_dbSwap"].ToString();
                Dll_FDia.db_Forward = ConfigurationManager.AppSettings["NY_dbForward"].ToString();
                Dll_FDia.db_Bonex = ConfigurationManager.AppSettings["NY_dbBonex"].ToString();
                Dll_FDia.LoginTime = Convert.ToInt16(ConfigurationManager.AppSettings["LoginTimeOut"].ToString());
                Dll_FDia.QueryTime = Convert.ToInt16(ConfigurationManager.AppSettings["QueryTimeOut"].ToString());
                Dll_FDia.db_Opciones = ConfigurationManager.AppSettings["NY_dbOpciones"].ToString();
                Dll_FDia.usr_Opciones = ConfigurationManager.AppSettings["NY_UsrOpciones"].ToString();
                Dll_FDia.pwd_Opciones = ConfigurationManager.AppSettings["NY_PwdOpciones"].ToString();
                Dll_FDia.Conf_FileLog = ConfigurationManager.AppSettings["PathLog"].ToString();
                Dll_FDia.Conf_Path_GL_Forward = ConfigurationManager.AppSettings["NY_Path_SG14"].ToString();
                Dll_FDia.Conf_Path_Sigir_Forward =ConfigurationManager.AppSettings["NY_Path_SG14"].ToString();
                Dll_FDia.Conf_Mod_Sigir_Forward=ConfigurationManager.AppSettings["NY_Mod_SG14"].ToString();
                Dll_FDia.Conf_Path_GL_Swap =ConfigurationManager.AppSettings["NY_Path_SG52"].ToString();
                Dll_FDia.Conf_Path_Sigir_Swap =ConfigurationManager.AppSettings["NY_Path_SG52"].ToString();
                Dll_FDia.Conf_Mod_Sigir_Swap=ConfigurationManager.AppSettings["NY_Mod_SG52"].ToString();
                Dll_FDia.Conf_Path_GL_Bonex=ConfigurationManager.AppSettings["NY_Path_SG51"].ToString();
                Dll_FDia.Conf_Path_Sigir_Bonex =ConfigurationManager.AppSettings["NY_Path_SG51"].ToString();
                Dll_FDia.Conf_Mod_Sigir_Bonex=ConfigurationManager.AppSettings["NY_Mod_SG51"].ToString();
                Dll_FDia.Conf_Path_P40_Bonex=ConfigurationManager.AppSettings["NY_Path_P40BEX"].ToString();
                Dll_FDia.ConfiguraIpMail = ConfigurationManager.AppSettings["ConfIpMail"].ToString();
                Dll_FDia.ConfiguraPuertoMail=ConfigurationManager.AppSettings["ConfPtoMail"].ToString();
                Dll_FDia.ConfiguraCuentaMail=ConfigurationManager.AppSettings["ConfCtaMail"].ToString();

                if (1 == 1)
                    {   Log_Event("1. Fin de Día NY - Proceso ha sido desconectado desde el Servicio.");
                        return true;
                    }


            // **** E J E C U C I O N   D E L   P R O C E S O   D E   F I N    D E   D I A   D E S C O N E C T A D O  **** 
            // ***********************************************************************************************************
            // ***********************************************************************************************************
            //      if (Dll_FDia.Generar_Procesos() == false)
            //          {   errNemo = Dll_FDia.oNemo;
            //              errMensaje = Dll_FDia.oMensaje;
            //              throw new EvaluateException("-1. F. Dia NY - Error interno en DLL de Fin de Día New York " + Dll_FDia.oNemo + " Mensaje : " + Dll_FDia.oMensaje);
            //          }
            // ***********************************************************************************************************
            // ***********************************************************************************************************
            // **** E J E C U C I O N   D E L   P R O C E S O   D E   F I N    D E   D I A   D E S C O N E C T A D O  **** 

                else
                    {   Log_Event("1. F. Dia NY - Proceso se ejecuto correctamente.");
                        return true;
                    }
             }
            catch (Exception ErrFinDia)
            {   Log_Event("-1. F. Dia NY - Error Error Catch : [" + ErrFinDia.Message.ToString() + "]");
                return false;
            }

        }


        private bool Ejecuta_Proceso_Inicio_Dia_NewYork()
        {
            Ejecucion = true;

            try
            {
                // Limpio las variables de errores y mensajes
                errNemo = "";   errMensaje = "";

                Obj_CentralizaNY.DLL_CentralizaNY oDll_CentalizaNy = new Obj_CentralizaNY.DLL_CentralizaNY();
                oDll_CentalizaNy.Servidor = ConfigurationManager.AppSettings["NY_Servidor"].ToString();
                oDll_CentalizaNy.Usuario = ConfigurationManager.AppSettings["NY_Usuario"].ToString();
                oDll_CentalizaNy.Clave = DesEcrypt(ConfigurationManager.AppSettings["NY_Password"].ToString());
                oDll_CentalizaNy.LoginTime = Convert.ToInt16(ConfigurationManager.AppSettings["LoginTimeOut"].ToString());
                oDll_CentalizaNy.QueryTime = Convert.ToInt16(ConfigurationManager.AppSettings["QueryTimeOut"].ToString());
                oDll_CentalizaNy.db_Parametros = ConfigurationManager.AppSettings["NY_dbParametros"].ToString();
                oDll_CentalizaNy.db_Forward = ConfigurationManager.AppSettings["NY_dbForward"].ToString();
                oDll_CentalizaNy.db_Swap = ConfigurationManager.AppSettings["NY_dbSwap"].ToString();
                oDll_CentalizaNy.db_Bonex = ConfigurationManager.AppSettings["NY_dbBonex"].ToString();
                oDll_CentalizaNy.db_Lineas = ConfigurationManager.AppSettings["NY_dbLineas"].ToString();
                oDll_CentalizaNy.db_Opciones = ConfigurationManager.AppSettings["NY_dbOpciones"].ToString();
                oDll_CentalizaNy.usr_Opciones = ConfigurationManager.AppSettings["NY_UsrOpciones"].ToString();
                oDll_CentalizaNy.pwd_Opciones = ConfigurationManager.AppSettings["NY_PwdOpciones"].ToString();
                oDll_CentalizaNy.PathFileLog = ConfigurationManager.AppSettings["PathLog"].ToString();
                oDll_CentalizaNy.ConfiguraIpMail = ConfigurationManager.AppSettings["ConfIpMail"].ToString();
                oDll_CentalizaNy.ConfiguraPuertoMail = ConfigurationManager.AppSettings["ConfPtoMail"].ToString();
                oDll_CentalizaNy.ConfiguraCuentaMail = ConfigurationManager.AppSettings["ConfCtaMail"].ToString();

                if (oDll_CentalizaNy.Procesar_Aperturas() == false)
                    {   errNemo = oDll_CentalizaNy.oNemo;
                        errMensaje = oDll_CentalizaNy.oMensaje;
                        throw new EvaluateException("6. NY - Error interno en Dll de Contralizacion New York :" + errNemo.ToString() + " Mensaje : " + errMensaje.ToString());
                    }
                else
                    {   Log_Event("7. NY - Proceso Ejecuto Correctamente, Retornando un valor True.");
                        return true;
                    }
            }
            catch (Exception ErrInicioNY)
            {
                Log_Event("8. NY" + ErrInicioNY.Message.ToString());
                return false;
            }
        }

        
        private bool Ejecuta_Proceso_Inicio_Dia()
        {
            // --> Agregar llamada para incio de d�a

            Ejecucion = true;

            string Servidor         = ConfigurationManager.AppSettings["server"].ToString();
            string UsrBac           = ConfigurationManager.AppSettings["user"].ToString();
            string PwdBAC           = DesEcrypt(ConfigurationManager.AppSettings["password"].ToString());
            Int32  LoginTimeOut     = Convert.ToInt32(ConfigurationManager.AppSettings["LoginTimeOut"].ToString());
            Int32  QueryTimeOut     = Convert.ToInt32(ConfigurationManager.AppSettings["QueryTimeOut"].ToString());
            string Parametros       = ConfigurationManager.AppSettings["Parametros"].ToString();
            string Forward          = ConfigurationManager.AppSettings["Forward"].ToString();
            string Swap             = ConfigurationManager.AppSettings["Swap"].ToString();
            string Invex            = ConfigurationManager.AppSettings["Invex"].ToString();
            string Cambio           = ConfigurationManager.AppSettings["Cambio"].ToString();
            string Trader           = ConfigurationManager.AppSettings["Trader"].ToString();
            string Lineas           = ConfigurationManager.AppSettings["Lineas"].ToString();
            string SAO              = ConfigurationManager.AppSettings["SAO"].ToString();
            string UsrSAO           = ConfigurationManager.AppSettings["UsrSAO"].ToString();
            string PwdSAO           = ConfigurationManager.AppSettings["PwdSAO"].ToString();
            string PATH_RECAL       = ConfigurationManager.AppSettings["PATH_RECAL"].ToString();
            string Dir_PAE          = ConfigurationManager.AppSettings["Dir_PAE"].ToString();
            string PathLog          = ConfigurationManager.AppSettings["PathLog"].ToString();


            /*Nuevo para LD1*/
            string Path_BacLineas = ConfigurationManager.AppSettings["INIDIA_Lineas"].ToString();
            /*--------------*/

            string ConfMail_Ip      = ConfigurationManager.AppSettings["ConfIpMail"].ToString();
            string ConfMail_Pto     = ConfigurationManager.AppSettings["ConfPtoMail"].ToString();
            string ConfMail_Cta     = ConfigurationManager.AppSettings["ConfCtaMail"].ToString();

            try
            {
                errNemo =""; errMensaje = "";

                Objeto_Centraliza.DLL_Centraliza oDll_Centraliza = new Objeto_Centraliza.DLL_Centraliza();

                oDll_Centraliza.Servidor = Servidor;
                oDll_Centraliza.Usuario = UsrBac;
                oDll_Centraliza.Clave = PwdBAC;
                oDll_Centraliza.LoginTime = 120;
                oDll_Centraliza.QueryTime = 3600;
                oDll_Centraliza.db_Parametros = Parametros;
                oDll_Centraliza.db_Forward = Forward;
                oDll_Centraliza.db_Swap = Swap;
                oDll_Centraliza.db_Bonex = Invex;
                oDll_Centraliza.db_Spot = Cambio;
                oDll_Centraliza.db_Trader = Trader;
                oDll_Centraliza.db_Lineas = Lineas;
                oDll_Centraliza.db_Opciones = SAO;
                oDll_Centraliza.usr_Opciones = UsrSAO;
                oDll_Centraliza.pwd_Opciones = PwdSAO;
                oDll_Centraliza.DirRECAL = PATH_RECAL;
                oDll_Centraliza.DirPAE = Dir_PAE;
                oDll_Centraliza.PathFileLog = PathLog;

                /*NUEVO PARA LD1 RECALCULO DE LINEAS DRV*/
                oDll_Centraliza.DirLineas = Path_BacLineas;


                //  Se agregaron para configurar la cta de Mail (Ip, Puerto, Cuenta)
                oDll_Centraliza.ConfiguraIpMail = ConfMail_Ip;
                oDll_Centraliza.ConfiguraPuertoMail = ConfMail_Pto;
                oDll_Centraliza.ConfiguraCuentaMail = ConfMail_Cta;

                if (oDll_Centraliza.Procesar_Aperturas() == false)
                {
                    errNemo = oDll_Centraliza.oNemo;
                    errMensaje = oDll_Centraliza.oMensaje;
                    throw new EvaluateException("6 - Error interno en Dll de Centralización : " + errNemo.ToString() + " Mensaje : " + errMensaje.ToString());
                }
                else
                {
                    Log_Event("7 - Proceso se ejecuto correctamente, retornando un valor True.");
                    return true;
                }
                
            }
            catch (Exception err)
            {
                Log_Event("8." + err.Message.ToString());
                return false;
            }

        }

        private string DesEcrypt(string encrypted)
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
        private void Log_Event(string cMensaje)
        {
            System.Diagnostics.EventLog EventLog;
            try
            {
                EventLog = new System.Diagnostics.EventLog();
                EventLog.Log = "Application";   // "App_Inicio_Dia_BAC";
                EventLog.Source = "Servicio Mesa Dinero (Apertura y Cierre de Día)";   // "Inicio_Dia";

                if (!EventLog.SourceExists(EventLog.Source))
                    EventLog.CreateEventSource(EventLog.Source, EventLog.Log);

                EventLog.WriteEntry(cMensaje, EventLogEntryType.Information);
            }
            catch
            {

            }

        }
        protected override void OnStart(string[] args)
        {
            // TODO: agregar código aquí para iniciar el servicio.
        }
        protected override void OnStop()
        {
            // TODO: agregar código aquí para realizar cualquier anulación necesaria para detener el servicio.
        }
    }
}
