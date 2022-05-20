using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Configuration;
using System.Data;
using System.Timers;

using System.Diagnostics;
using System.Threading;

namespace clsCentralizacionProcesos
{
    public class clsProcesoInicios
    {
        /*clases generales*/
        public clsDb oDB = new clsDb();
        public clsLog oLog = new clsLog();
        public clsUtil oUtil = new clsUtil();

        public DataTable oLogReturn;
        public DataTable oLogReturnDB;

        bool _bStatusBonex;
        bool _bStatusSpot;
        bool _bStatusForward;
        bool _bStatusSwap;
        bool _bStatusTrader;
        bool _bStatusSAO;
        bool _bStatusPasivos;


        string _UDL_BONOS;
        string _UDL_SPOT;
        string _UDL_FORWARD;
        string _UDL_LINEAS;
        string _UDL_PARAMETROS;
        string _UDL_SWAP;
        string _UDL_TRADER;
        string _UDL_OPCIONES;
        string _UDL_PASIVO;
        string _UDL_PARAM_PASIVO;

        string _DATA_SOURCE;
        string _USER_ID;
        string _PASSWORD;
 
        string _GSBAC_RECAL;
        string _GSBAC_DIRPAE;

        string _START_TIME;
        string _END_TIME;
        double _INTERVAL_TIME;
        bool _LOGEXESERVICE;

        int _CONNECT_TIMEOUT;
        int _CONNECT_RETRYCOUNT;
        int _CONNECT_RETRYINTERVAL;

        int _EXECUTION_RETRYCOUNT;
        int _EXECUTION_RETRYINTERVAL;

        string _PATHLOG;
        string _PRENAMELOG;
        bool _TIPOLOGTXT;
        string _PATHFILEPAE;
        string sOrigen;

        bool   _MailEnable;
        string _Mailhost;
        int    _MailPort;
        bool   _MailEnableSsl;
        string _MailhostUser;
        string _MailPassword;
        string _MailFrom;
        string _MailTo;
        string _MailSubject;
        string _MailBody;

        bool tProceso=false;

        public string UDL_BONOS { get => _UDL_BONOS; set => _UDL_BONOS = value; }
        public string UDL_SPOT { get => _UDL_SPOT; set => _UDL_SPOT = value; }
        public string UDL_FORWARD { get => _UDL_FORWARD; set => _UDL_FORWARD = value; }
        public string UDL_LINEAS { get => _UDL_LINEAS; set => _UDL_LINEAS = value; }
        public string UDL_PARAMETROS { get => _UDL_PARAMETROS; set => _UDL_PARAMETROS = value; }
        public string UDL_SWAP { get => _UDL_SWAP; set => _UDL_SWAP = value; }
        public string UDL_TRADER { get => _UDL_TRADER; set => _UDL_TRADER = value; }
        public string UDL_OPCIONES { get => _UDL_OPCIONES; set => _UDL_OPCIONES = value; }
        public string UDL_PASIVO { get => _UDL_PASIVO; set => _UDL_PASIVO = value; }
        public string UDL_PARAM_PASIVO { get => _UDL_PARAM_PASIVO; set => _UDL_PARAM_PASIVO = value; }

        public int CONNECT_TIMEOUT { get => _CONNECT_TIMEOUT; set => _CONNECT_TIMEOUT = value; }
        public int CONNECT_RETRYCOUNT { get => _CONNECT_RETRYCOUNT; set => _CONNECT_RETRYCOUNT = value; }
        public int CONNECT_RETRYINTERVAL { get => _CONNECT_RETRYINTERVAL; set => _CONNECT_RETRYINTERVAL = value; }
        public string PATHLOG { get => _PATHLOG; set => _PATHLOG = value; }
        public bool TIPOLOGTXT { get => _TIPOLOGTXT; set => _TIPOLOGTXT = value; }
        public string GSBAC_RECAL { get => _GSBAC_RECAL; set => _GSBAC_RECAL = value; }
        public string GSBAC_DIRPAE { get => _GSBAC_DIRPAE; set => _GSBAC_DIRPAE = value; }
        public string PATHFILEPAE { get => _PATHFILEPAE; set => _PATHFILEPAE = value; }
        public string PRENAMELOG { get => _PRENAMELOG; set => _PRENAMELOG = value; }
        public string START_TIME { get => _START_TIME; set => _START_TIME = value; }
        public string END_TIME { get => _END_TIME; set => _END_TIME = value; }
        public string USER_ID { get => _USER_ID; set => _USER_ID = value; }
        public string PASSWORD { get => _PASSWORD; set => _PASSWORD = value; }
        public double INTERVAL_TIME { get => _INTERVAL_TIME; set => _INTERVAL_TIME = value; }
        public string DATA_SOURCE { get => _DATA_SOURCE; set => _DATA_SOURCE = value; }
   
        public bool MailEnable { get => _MailEnable; set => _MailEnable = value; }
        public string Mailhost { get => _Mailhost; set => _Mailhost = value; }
        public int MailPort { get => _MailPort; set => _MailPort = value; }
        public bool MailEnableSsl { get => _MailEnableSsl; set => _MailEnableSsl = value; }
        public string MailhostUser { get => _MailhostUser; set => _MailhostUser = value; }
        public string MailPassword { get => _MailPassword; set => _MailPassword = value; }
        public string MailTo { get => _MailTo; set => _MailTo = value; }
        public string MailSubject { get => _MailSubject; set => _MailSubject = value; }
        public string MailBody { get => _MailBody; set => _MailBody = value; }
        
        
        public bool LOGEXESERVICE { get => _LOGEXESERVICE; set => _LOGEXESERVICE = value; }

        public int EXECUTION_RETRYCOUNT { get => _EXECUTION_RETRYCOUNT; set => _EXECUTION_RETRYCOUNT = value; }
        public int EXECUTION_RETRYINTERVAL { get => _EXECUTION_RETRYINTERVAL; set => _EXECUTION_RETRYINTERVAL = value; }
        public bool BStatusBonex { get => _bStatusBonex; set => _bStatusBonex = value; }
        public bool BStatusSpot { get => _bStatusSpot; set => _bStatusSpot = value; }
        public bool BStatusForward { get => _bStatusForward; set => _bStatusForward = value; }
        public bool BStatusSwap { get => _bStatusSwap; set => _bStatusSwap = value; }
        public bool BStatusTrader { get => _bStatusTrader; set => _bStatusTrader = value; }
        public bool BStatusSAO { get => _bStatusSAO; set => _bStatusSAO = value; }
        public string MailFrom { get => _MailFrom; set => _MailFrom = value; }
        public bool BStatusPasivos { get => _bStatusPasivos; set => _bStatusPasivos = value; }

        private static System.Timers.Timer aTimer;

          public void Procesar()
        {
        
            sOrigen= "clsCentralizacionProcesos.clsProcesoInicios";
        
            oLog.PATHLOG = PATHLOG;
            oLog.NOMBREARCHIVO = PRENAMELOG;

            oUtil.oLog.PATHLOG = PATHLOG;
            oUtil.oLog.NOMBREARCHIVO = PRENAMELOG;

            oLog.GeneraLog(sOrigen, "Inicio Proceso automatico");

            /*actualizacion udls control reintentos*/
        
            oLog.GeneraLog(sOrigen, "Rescate Configuracion");

            DATA_SOURCE = "Data Source=" + DATA_SOURCE;

            UDL_BONOS       += ";" + DATA_SOURCE + ";User ID=" + USER_ID.ToString() + ";Password=" + PASSWORD.ToString() + ";Connection Timeout=" + CONNECT_TIMEOUT.ToString() + ";ConnectRetryCount=" + CONNECT_RETRYCOUNT.ToString() + ";ConnectRetryInterval=" + CONNECT_RETRYINTERVAL.ToString();
            UDL_SPOT        += ";" + DATA_SOURCE + ";User ID=" + USER_ID.ToString() + ";Password=" + PASSWORD.ToString() + ";Connection Timeout=" + CONNECT_TIMEOUT.ToString() + ";ConnectRetryCount=" + CONNECT_RETRYCOUNT.ToString()+ ";ConnectRetryInterval="+ CONNECT_RETRYINTERVAL.ToString();
            UDL_FORWARD     += ";" + DATA_SOURCE + ";User ID=" + USER_ID.ToString() + ";Password=" + PASSWORD.ToString() + ";Connection Timeout=" + CONNECT_TIMEOUT.ToString() + ";ConnectRetryCount=" + CONNECT_RETRYCOUNT.ToString() + ";ConnectRetryInterval=" + CONNECT_RETRYINTERVAL.ToString();
            UDL_LINEAS      += ";" + DATA_SOURCE + ";User ID=" + USER_ID.ToString() + ";Password=" + PASSWORD.ToString() + ";Connection Timeout=" + CONNECT_TIMEOUT.ToString() + ";ConnectRetryCount=" + CONNECT_RETRYCOUNT.ToString() + ";ConnectRetryInterval=" + CONNECT_RETRYINTERVAL.ToString();
            UDL_PARAMETROS  += ";" + DATA_SOURCE + ";User ID=" + USER_ID.ToString() + ";Password=" + PASSWORD.ToString() + ";Connection Timeout=" + CONNECT_TIMEOUT.ToString() + ";ConnectRetryCount=" + CONNECT_RETRYCOUNT.ToString() + ";ConnectRetryInterval=" + CONNECT_RETRYINTERVAL.ToString();
            UDL_SWAP        += ";" + DATA_SOURCE + ";User ID=" + USER_ID.ToString() + ";Password=" + PASSWORD.ToString() + ";Connection Timeout=" + CONNECT_TIMEOUT.ToString() + ";ConnectRetryCount=" + CONNECT_RETRYCOUNT.ToString() + ";ConnectRetryInterval=" + CONNECT_RETRYINTERVAL.ToString();
            UDL_TRADER      += ";" + DATA_SOURCE + ";User ID=" + USER_ID.ToString() + ";Password=" + PASSWORD.ToString() + ";Connection Timeout=" + CONNECT_TIMEOUT.ToString() + ";ConnectRetryCount=" + CONNECT_RETRYCOUNT.ToString() + ";ConnectRetryInterval=" + CONNECT_RETRYINTERVAL.ToString();
            UDL_OPCIONES    += ";" + DATA_SOURCE + ";User ID=" + USER_ID.ToString() + ";Password=" + PASSWORD.ToString() + ";Connection Timeout=" + CONNECT_TIMEOUT.ToString() + ";ConnectRetryCount=" + CONNECT_RETRYCOUNT.ToString() + ";ConnectRetryInterval=" + CONNECT_RETRYINTERVAL.ToString();
            UDL_PASIVO      += ";" + DATA_SOURCE + ";User ID=" + USER_ID.ToString() + ";Password=" + PASSWORD.ToString() + ";Connection Timeout=" + CONNECT_TIMEOUT.ToString() + ";ConnectRetryCount=" + CONNECT_RETRYCOUNT.ToString() + ";ConnectRetryInterval=" + CONNECT_RETRYINTERVAL.ToString();
            UDL_PARAM_PASIVO+= ";" + DATA_SOURCE + ";Connection Timeout=" + CONNECT_TIMEOUT.ToString() + ";ConnectRetryCount=" + CONNECT_RETRYCOUNT.ToString() + ";ConnectRetryInterval=" + CONNECT_RETRYINTERVAL.ToString();


            var nowTime = DateTime.Now;
            var startTime = DateTime.Parse(START_TIME);
            var endTime = DateTime.Parse(END_TIME);


            // Create a timer with a two second interval.
            aTimer = new System.Timers.Timer(INTERVAL_TIME);
            // Hook up the Elapsed event for the timer. 
            aTimer.Elapsed += OnTimedEvent;
            aTimer.AutoReset = true;
            aTimer.Enabled = true;

            oLog.GeneraLog(sOrigen, "Configuracion Inicial (nowTime,startTime,endTime,interval_time) : " + nowTime + "," + startTime + "," + endTime+","+ INTERVAL_TIME);

            //oLog.GeneraLog(sOrigen, "Configuracion Inicial : " + );

        }

        private void OnTimedEvent(Object source, ElapsedEventArgs e)
        {
            //START_TIME = ConfigurationSettings.AppSettings["START_TIME"].ToString();
            //END_TIME = ConfigurationSettings.AppSettings["END_TIME"].ToString();
            //INTERVAL_TIME = double.Parse(ConfigurationSettings.AppSettings["INTERVAL_TIME"].ToString());

            LOGEXESERVICE = bool.Parse( ConfigurationSettings.AppSettings["LOGEXESERVICE"].ToString());

            var nowTime = DateTime.Now;
            var startTime = DateTime.Parse(START_TIME);
            var endTime = DateTime.Parse(END_TIME);

           // if (LOGEXESERVICE) { oLog.GeneraLog(sOrigen, "Control OnTimedEvent (nowTime <= endTime) & (nowTime >= startTime) (nowTime,startTime,endTime) : " + nowTime + "," + startTime + "," + endTime); }
            
            if ((nowTime <= endTime) & (nowTime >= startTime))
            {
                //if (LOGEXESERVICE) { oLog.GeneraLog(sOrigen, "Ejecucion segun periodo (nowTime <= endTime) & (nowTime >= startTime) (Proceso) : " + tProceso); }

                if (!tProceso)
                {
                    if (LOGEXESERVICE) { oLog.GeneraLog(sOrigen, "Control estado ejecucion  : Inicio ejecucion servicio"); }

                    tProceso = true;
                    oLog.GeneraLog(sOrigen, "!tProceso" + " - " + tProceso );

                    aTimer.Stop();
                    //GeneraInicioTimer();
                    GeneraInicioTimerReintento();
                    aTimer.Start();

                    if (LOGEXESERVICE) { oLog.GeneraLog(sOrigen, "Control estado ejecucion  : Fin ejecucion servicio"); }

                }
            }

            //if (LOGEXESERVICE) { oLog.GeneraLog(sOrigen, "Control estado ejecucion (Proceso,nowTime > endTime) : " + tProceso + "," + nowTime +">"+ endTime); }

            if (nowTime > endTime)
            {
                if (tProceso) { oLog.GeneraLog(sOrigen, "Control estado ejecucion  : inicio nuevo periodo servicio");  }
                tProceso = false;
                
                //if (LOGEXESERVICE) { oLog.GeneraLog(sOrigen, "Cambio estado ejecucion (Proceso,nowTime,startTime,endTime) : " + tProceso+","+ nowTime + "," + startTime + "," + endTime); }
            }
        }


        public void GeneraInicioTimerReintento()
        {
            bool bEstadoEjecuion = false;
            int iCtrRetryciunt = 0;
            DataTable dDatosEstadoR;
            string sBody = "";
            //RETRYCOUNT

            var nowTime = DateTime.Now;
            var startTime = DateTime.Parse(START_TIME);
            var endTime = DateTime.Parse(END_TIME);

            if (LOGEXESERVICE) { oLog.GeneraLog(sOrigen, "Control estado ejecucion (Proceso,nowTime > endTime) : " + tProceso + "," + nowTime + ">" + endTime); };

            while (iCtrRetryciunt < EXECUTION_RETRYCOUNT+1)
            {
                oLog.dtLog.Rows.Clear();//limpia log centrlaizacion por ejecucion

                if (iCtrRetryciunt >= 1)
                {
                    oLog.GeneraLog(sOrigen, "Problemas al ejecutar inicio de día, reintento :" + iCtrRetryciunt + '/' + EXECUTION_RETRYCOUNT);
                }

                bEstadoEjecuion = GeneraInicioTimer();

                if (bEstadoEjecuion)
                {
                    dDatosEstadoR = oUtil.LeerEstados(1);

                    oUtil.AgregaRetornoLog(dDatosEstadoR);

                    if (dDatosEstadoR != null)
                    {
                        sBody = MailBody + oUtil.GeneraBodyHMTL(dDatosEstadoR, "informe control operativo");

                    }
                    else
                    {
                        sBody = MailBody;

                    }

                    if (oLog != null)
                    {
                        sBody += oUtil.GeneraBodyHMTL(oLog.dtLog, "informe control log");
                    }

                    if (MailEnable)
                    {
                        oUtil.EnvioEmail(Mailhost, MailPort, MailEnableSsl, MailhostUser, MailPassword,MailFrom, MailTo, MailSubject, sBody);
                    }

                    break;
                }

                iCtrRetryciunt++;
                
            }
            if (iCtrRetryciunt >= EXECUTION_RETRYCOUNT)
            {
                
                oLog.GeneraLog(sOrigen, "Problemas al ejecutar inicio de día, se ha cumplido el máximo de reintentos");

                if (MailEnable)
                {
                    dDatosEstadoR = oUtil.LeerEstados(1);//estao operativo

                    oUtil.AgregaRetornoLog(dDatosEstadoR);

                    if (oLogReturn != null & oLogReturnDB != null)
                    {
                        oLogReturn.Merge(oLogReturnDB);
                    }


                    //oLogReturn.Merge(oLogReturnDB);//log retorno modulo
                    //oLogReturn.Merge(oLog.dtLog);//log centalizacion
                    
                    if (MailEnable)
                    {
                        sBody = MailBody + oUtil.GeneraBodyHMTL(dDatosEstadoR, "informe control operativo");

                        if (oLogReturn != null )
                        {
                            if (oLog != null)
                            {
                                oLogReturn.Merge(oLog.dtLog);
                            }

                            sBody += oUtil.GeneraBodyHMTL(oLogReturn, "informe control log");
                        }

                       


                        if (MailEnable)
                        {
                            oUtil.EnvioEmail(Mailhost, MailPort, MailEnableSsl, MailhostUser, MailPassword, MailFrom, MailTo, MailSubject, sBody);
                        }

                    }
                }
            }

        }

        public bool GeneraInicioTimer()
        {
            //oUtil.EnvioEmail(Mailhost, MailPort, MailEnableSsl, MailhostUser, MailPassword, MailTo, MailSubject, MailBody);
            DataTable dDatosEstado;
            
            int SwIniBCC = 0;
            int SwIniBFW = 0;
            int SwIniBNX = 0;
            int SwIniSAO = 0;
            int SwIniSWP = 0;
            int SwIniBTR = 0;
            int SwIniPAS = 0;

            int SwFinBCC = 0;
            int SwFinBFW = 0;
            int SwFinBNX = 0;
            int SwFinSAO = 0;
            int SwFinSWP = 0;
            int SwFinBTR = 0;
            int SwFinPAS = 0;


            oUtil.oDB.DbUDL = UDL_PARAMETROS;
            oUtil.oDB.PATHLOG = PATHLOG;
            oUtil.oDB.NOMBREARCHIVO = PRENAMELOG;

            /*
            dDatosEstado = oUtil.LeerEstados(0);

            SwIniBCC = int.Parse(dDatosEstado.Rows[0]["INI_DIA"].ToString());
            SwIniBFW = int.Parse(dDatosEstado.Rows[1]["INI_DIA"].ToString());
            SwIniBNX = int.Parse(dDatosEstado.Rows[2]["INI_DIA"].ToString());
            SwIniSAO = int.Parse(dDatosEstado.Rows[3]["INI_DIA"].ToString());
            SwIniSWP = int.Parse(dDatosEstado.Rows[4]["INI_DIA"].ToString());
            SwIniBTR = int.Parse(dDatosEstado.Rows[5]["INI_DIA"].ToString());
            SwIniPAS = int.Parse(dDatosEstado.Rows[6]["INI_DIA"].ToString());

            SwFinBCC = int.Parse(dDatosEstado.Rows[0]["FIN_DIA"].ToString());
            SwFinBFW = int.Parse(dDatosEstado.Rows[1]["FIN_DIA"].ToString());
            SwFinBNX = int.Parse(dDatosEstado.Rows[2]["FIN_DIA"].ToString());
            SwFinSAO = int.Parse(dDatosEstado.Rows[3]["FIN_DIA"].ToString());
            SwFinSWP = int.Parse(dDatosEstado.Rows[4]["FIN_DIA"].ToString());
            SwFinBTR = int.Parse(dDatosEstado.Rows[5]["FIN_DIA"].ToString());
            SwFinPAS = int.Parse(dDatosEstado.Rows[6]["FIN_DIA"].ToString());
            */
           

            oLogReturn = null;
            oLogReturnDB = null;

            tProceso = true;


          
            //INICIO DIA SPOT
             if (!BStatusSpot)
            {
                oLog.GeneraLog(sOrigen, "Inicio Proceso Spot");

                dDatosEstado = oUtil.LeerEstados(0,"BCC");

                if (dDatosEstado == null)
                {
                    oLogReturn = oUtil.oDB.dtLog;
                }

                if (dDatosEstado != null)
                {
                    SwIniBCC = int.Parse(dDatosEstado.Rows[0]["INI_DIA"].ToString());
                    SwFinBCC = int.Parse(dDatosEstado.Rows[0]["FIN_DIA"].ToString());

                    if (SwIniBCC == 0 & SwFinBCC == 1)
                    {
                        clsSpot sysSpot = new clsSpot();

                        sysSpot.oDB.DbUDL = UDL_SPOT;
                        sysSpot.UDL_PARAMETROS = UDL_PARAMETROS;

                        sysSpot.oLog.PATHLOG = PATHLOG;
                        sysSpot.oLog.NOMBREARCHIVO = PRENAMELOG;

                        sysSpot.oUtil.oLog.PATHLOG = PATHLOG;
                        sysSpot.oUtil.oLog.NOMBREARCHIVO = PRENAMELOG;

                        sysSpot.oDB.PATHLOG = PATHLOG;
                        sysSpot.oDB.NOMBREARCHIVO = PRENAMELOG;

                        //oUtil.EnvioEmail("bytellejos@gmail.com", "bytellejos@gmail.com", "bytellejos@gmail.com", "bytellejos@gmail.com");

                        BStatusSpot = sysSpot.ProcesarInicioDia();

                        if (!BStatusSpot)
                        {
                            oLogReturn = sysSpot.oLog.dtLog;
                            oLogReturnDB = sysSpot.oDB.dtLog;
                            oLog.GeneraLog(sOrigen, "Fin Proceso Spot");
                            return false;
                        }
                    }
                    else
                    {
                        if (SwIniBCC == 1) { oLog.GeneraLog(sOrigen, "Inicio de dia Spot ya generado"); BStatusSpot = true; };
                        if (SwFinBCC == 0) { oLog.GeneraLog(sOrigen, "Fin de dia Spot no ha sido generado"); };
                    }
                    oLog.GeneraLog(sOrigen, "Fin Proceso Spot");
                }
            }



            //INICIO DIA FORWARD
            if (!BStatusForward)
            {
                oLog.GeneraLog(sOrigen, "Inicio Proceso Forward");

                dDatosEstado = oUtil.LeerEstados(0, "BFW");

                if (dDatosEstado == null)
                {
                    oLogReturn = oUtil.oDB.dtLog;
                }

                if (dDatosEstado != null)
                {
                    SwIniBFW = int.Parse(dDatosEstado.Rows[0]["INI_DIA"].ToString());
                    SwFinBFW = int.Parse(dDatosEstado.Rows[0]["FIN_DIA"].ToString());

                    if (SwIniBFW == 0 & SwFinBFW == 1)
                    {
                        clsForward sysForward = new clsForward();

                        sysForward.oDB.DbUDL = UDL_FORWARD;
                        sysForward.UDL_PARAMETROS = UDL_PARAMETROS;

                        sysForward.oLog.PATHLOG = PATHLOG;
                        sysForward.oLog.NOMBREARCHIVO = PRENAMELOG;

                        sysForward.oUtil.oLog.PATHLOG = PATHLOG;
                        sysForward.oUtil.oLog.NOMBREARCHIVO = PRENAMELOG;

                        sysForward.oDB.PATHLOG = PATHLOG;
                        sysForward.oDB.NOMBREARCHIVO = PRENAMELOG;


                        BStatusForward = sysForward.ProcesarInicioDia();

                        if (!BStatusForward)
                        {
                            oLogReturn = sysForward.oLog.dtLog;
                            oLogReturnDB = sysForward.oDB.dtLog;
                            oLog.GeneraLog(sOrigen, "Fin Proceso Forward");
                            return false;
                        }
                    }
                    else
                    {
                        if (SwIniBFW == 1) { oLog.GeneraLog(sOrigen, "Inicio de dia Forward ya generado"); BStatusForward = true; };
                        if (SwFinBFW == 0) { oLog.GeneraLog(sOrigen, "Fin de dia Forward no ha sido generado"); };
                    }
                    oLog.GeneraLog(sOrigen, "Fin Proceso Forward");
                }
            }


            //INICIO DIA BONEX
            if (!BStatusBonex)
            {
                oLog.GeneraLog(sOrigen, "Inicio Proceso Bonex");

                dDatosEstado = oUtil.LeerEstados(0, "BNX");

                if (dDatosEstado == null)
                {
                    oLogReturn = oUtil.oDB.dtLog;
                }


                if (dDatosEstado != null)
                {
                    SwIniBNX = int.Parse(dDatosEstado.Rows[0]["INI_DIA"].ToString());
                    SwFinBNX = int.Parse(dDatosEstado.Rows[0]["FIN_DIA"].ToString());

                    if (SwIniBNX == 0 & SwFinBNX == 1)
                    {
                        clsBonex sysBonex = new clsBonex();

                        sysBonex.oDB.DbUDL = UDL_BONOS;
                        sysBonex.UDL_PARAMETROS = UDL_PARAMETROS;

                        sysBonex.oLog.PATHLOG = PATHLOG;
                        sysBonex.oLog.NOMBREARCHIVO = PRENAMELOG;

                        sysBonex.oUtil.oLog.PATHLOG = PATHLOG;
                        sysBonex.oUtil.oLog.NOMBREARCHIVO = PRENAMELOG;

                        sysBonex.oDB.PATHLOG = PATHLOG;
                        sysBonex.oDB.NOMBREARCHIVO = PRENAMELOG;


                        BStatusBonex = sysBonex.ProcesoInicioDia();

                        if (!BStatusBonex)
                        {
                            oLogReturn = sysBonex.oLog.dtLog;
                            oLogReturnDB = sysBonex.oDB.dtLog;
                            oLog.GeneraLog(sOrigen, "Fin Proceso Bonex");
                            return false;
                        }
                    }
                    else
                    {
                        if (SwIniBNX == 1) { oLog.GeneraLog(sOrigen, "Inicio de dia Bonex ya generado"); BStatusBonex = true; };
                        if (SwFinBNX == 0) { oLog.GeneraLog(sOrigen, "Fin de dia Bonex no ha sido generado"); };
                    }
                    oLog.GeneraLog(sOrigen, "Fin Proceso Bonex");
                }
            }

            //INICIO DIA SAO
            if (!BStatusSAO)
            {
                oLog.GeneraLog(sOrigen, "Inicio Proceso SAO");

                dDatosEstado = oUtil.LeerEstados(0, "SAO");

                if (dDatosEstado == null)
                {
                    oLogReturn = oUtil.oDB.dtLog;
                }

                if (dDatosEstado != null)
                {
                    SwIniSAO = int.Parse(dDatosEstado.Rows[0]["INI_DIA"].ToString());
                    SwFinSAO = int.Parse(dDatosEstado.Rows[0]["FIN_DIA"].ToString());

                    if (SwIniSAO == 0 & SwFinSAO == 1)
                    {
                        clsSao sysSao = new clsSao();

                        sysSao.oDB.DbUDL = UDL_OPCIONES;
                        sysSao.UDL_PARAMETROS = UDL_PARAMETROS;

                        sysSao.oLog.PATHLOG = PATHLOG;
                        sysSao.oLog.NOMBREARCHIVO = PRENAMELOG;

                        sysSao.oUtil.oLog.PATHLOG = PATHLOG;
                        sysSao.oUtil.oLog.NOMBREARCHIVO = PRENAMELOG;

                        sysSao.oDB.PATHLOG = PATHLOG;
                        sysSao.oDB.NOMBREARCHIVO = PRENAMELOG;


                        BStatusSAO = sysSao.ProcesoInicioDia();

                        if (!BStatusSAO)
                        {
                            oLogReturn = sysSao.oLog.dtLog; //aqui
                            oLogReturnDB = sysSao.oDB.dtLog;
                            oLog.GeneraLog(sOrigen, "Fin Proceso SAO");
                            return false;
                        }
                    }
                    else
                    {
                        if (SwIniSAO == 1) { oLog.GeneraLog(sOrigen, "Inicio de dia SAO ya generado"); BStatusSAO = true; };
                        if (SwFinSAO == 0) { oLog.GeneraLog(sOrigen, "Fin de dia SAO no ha sido generado"); };
                    }
                    oLog.GeneraLog(sOrigen, "Fin Proceso SAO");
                }
            }

            //INICIO DIA SWAP
            if (!BStatusSwap)
            {
                oLog.GeneraLog(sOrigen, "Inicio Proceso Swap");

                dDatosEstado = oUtil.LeerEstados(0, "SWP");

                if (dDatosEstado == null)
                {
                    oLogReturn = oUtil.oDB.dtLog;
                }

                if (dDatosEstado != null)
                {
                    SwIniSWP = int.Parse(dDatosEstado.Rows[0]["INI_DIA"].ToString());
                    SwFinSWP = int.Parse(dDatosEstado.Rows[0]["FIN_DIA"].ToString());

                    if (SwIniSWP == 0 & SwFinSWP == 1)
                    {

                        clsSwap sysSwap = new clsSwap();

                        sysSwap.oDB.DbUDL = UDL_SWAP;
                        sysSwap.UDL_PARAMETROS = UDL_PARAMETROS;

                        sysSwap.oLog.PATHLOG = PATHLOG;
                        sysSwap.oLog.NOMBREARCHIVO = PRENAMELOG;

                        sysSwap.oUtil.oLog.PATHLOG = PATHLOG;
                        sysSwap.oUtil.oLog.NOMBREARCHIVO = PRENAMELOG;

                        sysSwap.oDB.PATHLOG = PATHLOG;
                        sysSwap.oDB.NOMBREARCHIVO = PRENAMELOG;


                        BStatusSwap = sysSwap.ProcesoInicioDia();

                        if (!BStatusSwap)
                        {
                            oLogReturn = sysSwap.oLog.dtLog;
                            oLogReturnDB = sysSwap.oDB.dtLog;
                            oLog.GeneraLog(sOrigen, "Fin Proceso Swap");
                            return false;
                        }
                    }
                    else
                    {
                        if (SwIniSWP == 1) { oLog.GeneraLog(sOrigen, "Inicio de dia Swap ya generado"); BStatusSwap = true; };
                        if (SwFinSWP == 0) { oLog.GeneraLog(sOrigen, "Fin de dia Swap no ha sido generado"); };
                    }
                    oLog.GeneraLog(sOrigen, "Fin Proceso Swap");
                }
            }



            //INICIO DIA TRADER
            if (!BStatusTrader)
            {
                oLog.GeneraLog(sOrigen, "Inicio Proceso Renta Fija");

                dDatosEstado = oUtil.LeerEstados(0, "BTR");

                if (dDatosEstado == null)
                {
                    oLogReturn = oUtil.oDB.dtLog;
                }

                if (dDatosEstado != null)
                {
                    SwIniBTR = int.Parse(dDatosEstado.Rows[0]["INI_DIA"].ToString());
                    SwFinBTR = int.Parse(dDatosEstado.Rows[0]["FIN_DIA"].ToString());

                    if (SwIniBTR == 0 & SwFinBTR == 1)
                    {
                        clsTrader sysTrader = new clsTrader();

                        sysTrader.oDB.DbUDL = UDL_TRADER;
                        sysTrader.UDL_PARAMETROS = UDL_PARAMETROS;

                        sysTrader.oLog.PATHLOG = PATHLOG;
                        sysTrader.oLog.NOMBREARCHIVO = PRENAMELOG;

                        sysTrader.oUtil.oLog.PATHLOG = PATHLOG;
                        sysTrader.oUtil.oLog.NOMBREARCHIVO = PRENAMELOG;

                        sysTrader.oDB.PATHLOG = PATHLOG;
                        sysTrader.oDB.NOMBREARCHIVO = PRENAMELOG;

                        sysTrader.GSBAC_DIRPAE = _GSBAC_DIRPAE;
                        sysTrader.GSBAC_RECAL = GSBAC_RECAL;
                        sysTrader.PATHFILEPAE = PATHFILEPAE;


                        BStatusTrader = sysTrader.ProcesoInicioDia();

                        if (!BStatusTrader)
                        {
                            oLogReturn = sysTrader.oLog.dtLog;
                            oLogReturnDB = sysTrader.oDB.dtLog;
                            oLog.GeneraLog(sOrigen, "Fin Proceso Renta Fija");
                            return false;
                        }
                    }
                    else
                    {
                        if (SwIniBTR == 1) { oLog.GeneraLog(sOrigen, "Inicio de dia Renta Fija ya generado"); BStatusTrader = true; };
                        if (SwFinBTR == 0) { oLog.GeneraLog(sOrigen, "Fin de dia Renta Fija no ha sido generado"); };
                    }
                    oLog.GeneraLog(sOrigen, "Fin Proceso Renta Fija");
                }
            }

            //INICIO DIA PASIVOS
            if (!BStatusPasivos)
            {
                oLog.GeneraLog(sOrigen, "Inicio Proceso Pasivo");

                dDatosEstado = oUtil.LeerEstados(0, "PAS");

                if (dDatosEstado == null)
                {
                    oLogReturn = oUtil.oDB.dtLog;
                }

                if (dDatosEstado != null)
                {
                    SwIniPAS = int.Parse(dDatosEstado.Rows[0]["INI_DIA"].ToString());
                    SwFinPAS = int.Parse(dDatosEstado.Rows[0]["FIN_DIA"].ToString());

                    if (SwIniPAS == 0 & SwFinPAS == 1)
                    {

                        clsPasivo sysPasivo = new clsPasivo();

                        sysPasivo.oDB.DbUDL = UDL_PASIVO;
                        sysPasivo.UDL_PARAMETROS = UDL_PARAM_PASIVO;

                        sysPasivo.oLog.PATHLOG = PATHLOG;
                        sysPasivo.oLog.NOMBREARCHIVO = PRENAMELOG;

                        sysPasivo.oUtil.oLog.PATHLOG = PATHLOG;
                        sysPasivo.oUtil.oLog.NOMBREARCHIVO = PRENAMELOG;

                        sysPasivo.oDB.PATHLOG = PATHLOG;
                        sysPasivo.oDB.NOMBREARCHIVO = PRENAMELOG;



                        BStatusPasivos = sysPasivo.ProcesarInicioDia();

                        if (!BStatusPasivos)
                        {
                            oLogReturn = sysPasivo.oLog.dtLog;
                            oLogReturnDB = sysPasivo.oDB.dtLog;
                            oLog.GeneraLog(sOrigen, "Fin Proceso Pasivo");
                            return false;
                        }
                    }
                    else
                    {
                        if (SwIniPAS == 1) { oLog.GeneraLog(sOrigen, "Inicio de dia Pasivo ya generado"); BStatusPasivos = true; };
                        if (SwFinPAS == 0) { oLog.GeneraLog(sOrigen, "Fin de dia Pasivo no ha sido generado"); };
                    }
                    oLog.GeneraLog(sOrigen, "Fin Proceso Pasivo");

                }
            }

            //Generacion intervalo entre ejecuciones
            var stopwatch = Stopwatch.StartNew();
            Thread.Sleep(EXECUTION_RETRYINTERVAL); //pausa en ms
            stopwatch.Stop();



            //tProceso = false;
            if (BStatusBonex & BStatusSpot & BStatusForward & BStatusSwap & BStatusTrader & BStatusSAO & BStatusPasivos)
            {
                return true;
            }
            else
            {
                return false;
            }
            
        }
    }
    
}
