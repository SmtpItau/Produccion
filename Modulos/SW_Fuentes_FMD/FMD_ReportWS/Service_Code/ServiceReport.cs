#pragma warning disable 1591
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.ServiceProcess;
using System.Timers;
using CoreLib.Common;
using CoreLib.Helpers;

namespace WindowsServiceFMD
{

    using WebServiceFMD;
    using WindowsServiceFMD.Common.Collections;
    using WindowsServiceFMD.Common.DTO;
    using WindowsServiceFMD.Common.Enums;

    public partial class ServiceReport : ServiceBase
    {
        #region Private Members
        [System.Runtime.Serialization.DataContract]
        private struct AuxState {
            [System.Runtime.Serialization.DataMember]
            public int id_reporte { get; set; }
            [System.Runtime.Serialization.DataMember]
            public int id_modulo { get; set; }
            [System.Runtime.Serialization.DataMember]
            public string proc_date { get; set; }
        }
        
        /// <summary>Lista de Reportes del Sistema</summary>
        private ReportTypeCollection<ReportType> ReportTypes = new ReportTypeCollection<ReportType>();
        /// <summary>Lista de Modulos del Sistema</summary>
        private ModuleTypeCollection<ModuleType> ModuleTypes = new ModuleTypeCollection<ModuleType>();

        /// <summary>Fecha de Sistema</summary>
        private DateTime SystemDate = DateTime.Now;
        /// <summary>Dibuja una linea de 100 caracteres "===" </summary>
        private static string Log_Line { get { return ("=").PadLeft(100, '='); } }

        /// <summary>Clase de Contexto del servicio.</summary>
        public WSAppContext context = null;

        /// <summary>Cliente WebService </summary>
        private wsReportServicesSoapClient WebServiceFMD_Client =null;
        #endregion


        /// <summary>Service Constructor</summary>
        public ServiceReport()
        {
            InitializeComponent();
            InitializeEncrypted();

            ReportTypes = WindowsServiceFMD.Common.DAO.ReportTypeDao.GetReportTypeCollection(this.context.DBContext);
            ModuleTypes = WindowsServiceFMD.Common.DAO.ModuleTypeDao.GetModuleTypeCollection(this.context.DBContext);            
        }

        /// <summary>
        /// Modo Interactivo del servicio (para diagnostico y depuracion)
        /// </summary>
        /// <param name="args">argumentos de la linea de comando... (proxima implementacion?)</param>
        internal void InteractiveMode(string[] args)
        {
            string console_msg = string.Empty;
            console_msg = "Iniciando Servicio(Interactivo): FMD_ReportWS...";

            Console.WriteLine(console_msg);
            LogHelper.WriteLog(this.context, console_msg, 2000, LevelInfo.Informative);

            this.OnStart(args);
            Console.Write("Presione Enter para finalizar");

            while (Console.ReadKey().Key != ConsoleKey.Enter) { }
            this.OnStop();
            console_msg = "Deteniendo Servicio(Interactivo): FMD_ReportWS...";
            Console.WriteLine(console_msg);
            LogHelper.WriteLog(this.context, console_msg, 2000, LevelInfo.Informative);
        }

        /// <summary>
        /// Evento de Inicio de Servicio
        /// </summary>
        /// <param name="args">Argumentos de linea de comando (cuando corre en modo interactivo)</param>
        protected override void OnStart(string[] args)
        {

            LogHelper.WriteLog(this.context, "Iniciando..Evento:(OnStart)",1004,LevelInfo.Informative);

            // TODO: agregar código aquí para iniciar el servicio.
            if (this.context.AsyncMode)
            {
                LogHelper.WriteLog(this.context, "Iniciando modo Asincrono.",1004,LevelInfo.EngineConfig);
                this.context.Timer.Elapsed += new ElapsedEventHandler(ServiceTimeElapsedAsync);
            }
            else {
                LogHelper.WriteLog(this.context, "Iniciando modo Sincrono.",1004,LevelInfo.EngineConfig);
                this.context.Timer.Elapsed += new ElapsedEventHandler(ServiceTimeElapsed);
            }
            this.context.Timer.Start();
            this.context.Timer.AutoReset = true;
        }

        /// <summary>
        /// Evento de Finalizacion de Servicio
        /// </summary>
        protected override void OnStop()
        {
            // TODO: agregar código aquí para realizar cualquier anulación necesaria para detener el servicio.
            this.context.Timer.Stop();
        }

        /// <summary>
        /// Callback, para llamada asincrona a WebServiceFMD
        /// </summary>
        /// <param name="result">Resultado de Operacion Asincrona.</param>
        private void WebServiceFMD_Callback(IAsyncResult AsyncResult)
        {
           string msg_result = string.Empty;
           AuxState operation_params = (AuxState)((object[])AsyncResult.AsyncState)[1];               
           try
            {
               // AuxState operation_params = JSONHelper.Deserialize<AuxState>(((object[])AsyncResult.AsyncState)[1].ToString());
               
               WebServiceFMD.wsReportServicesSoapClient cliente = (WebServiceFMD.wsReportServicesSoapClient)((object[])AsyncResult.AsyncState)[0];
                              
               var web_call_result = cliente.EndGenerateAndSendReports(AsyncResult);

                if (web_call_result.GetType() == typeof(ArrayOfString))
                {
                    foreach (string str in (ArrayOfString)web_call_result)
                    {
                        msg_result += str + "\r\n";
                    }
                }
                else
                {
                    msg_result = web_call_result.ToString();
                }

                //actualizacion de estado de generacion de reporte.
                ActualizaGeneracionReporte(
                    this.ReportTypes.GetReport(operation_params.id_reporte),
                    this.ModuleTypes.GetModulo(operation_params.id_modulo),
                    true, 
                    msg_result);
            }
            catch (Exception ex)
            {
                LogHelper.WriteLog(this.context, ex, 3002, LevelInfo.EngineError);
                ActualizaGeneracionReporte(
                    this.ReportTypes.GetReport(operation_params.id_reporte),
                    this.ModuleTypes.GetModulo(operation_params.id_modulo),
                    false,
                    LogHelper.FormatException(ex,true));
            }
           string msg = "(Async)Respuesta del cliente WebService: Reporte({0}),Modulo({1}),resultado: {2}";
           msg = string.Format(msg, 
               this.ReportTypes.GetReport(operation_params.id_reporte).desc_reporte,
               this.ModuleTypes.GetModulo(operation_params.id_modulo).desc_modulo,
               msg_result);
           LogHelper.WriteLog(this.context, msg, 3001, LevelInfo.Informative);
        }           
        
        /// <summary>
        /// Evento producido al cumplirse el tiempo predeterminado para ejecucion de reportes (ejecucion de reportes asincronos)
        /// </summary>
        private void ServiceTimeElapsedAsync(object sender, ElapsedEventArgs e) {
            this.InitializeEncrypted();
            this.ReportTypes = WindowsServiceFMD.Common.DAO.ReportTypeDao.GetReportTypeCollection(this.context.DBContext);
            this.ModuleTypes = WindowsServiceFMD.Common.DAO.ModuleTypeDao.GetModuleTypeCollection(this.context.DBContext);



            TimeSpan now = this.context.GetRealTime();
            DateTime date_now = this.context.GetRealDate();
            LogHelper.WriteLog(this.context, "(AsyncMode)ServiceTimeElapsed: " + DateTime.Now.ToString("yyyy-MM-dd T HH:mm:ss.F"), 10000, LevelInfo.EngineCheck);
            bool inicio_dia, fin_dia, apertura_mesa, cierre_mesa, devengo;
            string msg = "(AsyncMode) Reporte:{0}, Modulo:{1}, now:{2} - starting:{3} - finish:{4}";

#if DEBUG==true
            LogHelper.WriteLog(this.context, "Seteo de flags de procesos generales", 10001, LevelInfo.Warning);
            inicio_dia = false;      //CheckProcesos(WindowsServiceFMD.Common.Enums.CheckProcess.InicioDia);
            fin_dia = true;        //CheckProcesos(WindowsServiceFMD.Common.Enums.CheckProcess.FinDia);
            apertura_mesa = true;   // CheckProcesos(WindowsServiceFMD.Common.Enums.CheckProcess.AperturaMesa);
            cierre_mesa = false;    // CheckProcesos(WindowsServiceFMD.Common.Enums.CheckProcess.CierreMesa);              
            devengo = true;
#endif
            try
            {

            
            foreach (ReportType TReport in ReportTypes) {
                List<ModuleType> mod_input = (from ModuleType mod in ModuleTypes
                                              where mod.id_reporte == TReport.id_reporte
                                              where mod.active == true
                                              orderby mod.processType ascending
                                              orderby mod.priority ascending 
                                              select mod).ToList<ModuleType>();
                foreach (ModuleType mod in mod_input) {

                    if (now >= mod.starting && now <= mod.finish) {

#if DEBUG==true
                        msg = string.Format(msg, TReport.desc_reporte, mod.desc_modulo, now.ToString(), mod.starting.ToString(), mod.finish.ToString());
                        LogHelper.WriteLog(this.context, msg, 10002, LevelInfo.EngineCheck);                        
#endif

                        if (DiaValido(mod)) {
                            //verifica la generacion
                            if (!CheckGeneracionReporte(TReport, mod))
                            {
                                //verifica el status de los sistemas que requeiere el reporte.
                                bool continuar = false;
                                switch (mod.require)
                                {
                                    case CheckProcess.Inicio_Dia:
                                        inicio_dia = CheckProcesos(mod.require, mod.require_ny);
                                        if (inicio_dia) { continuar = true; }
                                        break;
                                    case CheckProcess.Fin_Dia:
                                        fin_dia = CheckProcesos(mod.require, mod.require_ny);
                                        if (fin_dia) { continuar = true; }
                                        break;
                                    case CheckProcess.Apertura_Mesa:
                                        apertura_mesa = CheckProcesos(mod.require, mod.require_ny);
                                        if (apertura_mesa) { continuar = true; }
                                        break;
                                    case CheckProcess.Cierre_Mesa:
                                        cierre_mesa = CheckProcesos(mod.require, mod.require_ny);
                                        if (cierre_mesa) { continuar = true; }
                                        break;
                                    case CheckProcess.Devengo:
                                        devengo = CheckProcesos(mod.require, mod.require_ny);
                                        if (devengo) { continuar = true; }
                                        break;
                                }
                                if (continuar)
                                {
                                    DateProcess proc_date = this.ProcessDate(mod);

                                    ActualizaGeneracionReporte(TReport, mod, false, "PROCESANDO");


                                    try
                                    {
                                        System.Threading.Thread.Sleep(3000); //3 segundos
                                        WebServiceFMD_Client = new wsReportServicesSoapClient();

                                        LogHelper.WriteLog(this.context, "Llamando cliente WebService.", 3000, LevelInfo.Informative);
                                        string fecha = proc_date.FechaProceso.ToString("yyyy-MM-dd");
                                        AuxState reporte_invocado = new AuxState() {
                                            id_reporte = TReport.id_reporte
                                            ,id_modulo = mod.id_modulo
                                            ,proc_date = fecha
                                        };

                                        AsyncCallback cb = new AsyncCallback(WebServiceFMD_Callback);
                                        object[] status_obj = { WebServiceFMD_Client, reporte_invocado};
                                        WebServiceFMD_Client.BeginGenerateAndSendReports(mod.processType, TReport.desc_reporte, mod.modulo, fecha, true, cb, status_obj);

                                    }
                                    catch (Exception ex)
                                    {
                                        if (WebServiceFMD_Client != null)
                                        {
                                            if (WebServiceFMD_Client.State == System.ServiceModel.CommunicationState.Opened)
                                            {
                                                WebServiceFMD_Client.Close();
                                            }
                                            WebServiceFMD_Client = null;
                                        }
                                        LogHelper.WriteLog(this.context, ex, 3002, LevelInfo.EngineError);

                                        ActualizaGeneracionReporte(TReport, mod, true, ex.ToString());
                                    }
                                }

                            }//generacion reporte
                        
                        } //dia valido
                    
                    }//check de hora
                
                }//foreach modulo
            }//foreach report

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        /// <summary>
        /// Evento producido al cumplirse el tiempo predeterminado para ejecucion de reportes (ejecucion de reportes sincrono.)
        /// </summary>
        private void ServiceTimeElapsed(object sender, ElapsedEventArgs e)
        {
            this.InitializeEncrypted();
            this.ReportTypes = WindowsServiceFMD.Common.DAO.ReportTypeDao.GetReportTypeCollection(this.context.DBContext);
            this.ModuleTypes = WindowsServiceFMD.Common.DAO.ModuleTypeDao.GetModuleTypeCollection(this.context.DBContext);

            GC.Collect();

            TimeSpan now = this.context.GetRealTime();
            DateTime date_now = this.context.GetRealDate();

            LogHelper.WriteLog(this.context, "ServiceTimeElapsed: " + DateTime.Now.ToString("yyyy-MM-dd T HH:mm:ss.F"), 10000, LevelInfo.EngineCheck);

            bool inicio_dia, fin_dia, apertura_mesa, cierre_mesa, devengo;


#if DEBUG==true
            LogHelper.WriteLog(this.context, "Seteo de flags de procesos generales", 10001, LevelInfo.Warning);
            inicio_dia = false;      //CheckProcesos(WindowsServiceFMD.Common.Enums.CheckProcess.InicioDia);
            fin_dia = true;        //CheckProcesos(WindowsServiceFMD.Common.Enums.CheckProcess.FinDia);
            apertura_mesa = true;   // CheckProcesos(WindowsServiceFMD.Common.Enums.CheckProcess.AperturaMesa);
            cierre_mesa = false;    // CheckProcesos(WindowsServiceFMD.Common.Enums.CheckProcess.CierreMesa);              
            devengo = true;
#endif

            string msg = "(SyncMode)Reporte:{0}, Modulo:{1}, now:{2} - starting:{3} - finish:{4}";

            foreach (ReportType TReport in ReportTypes)
            {

                List<ModuleType> mod_output = (from ModuleType mod in ModuleTypes
                                               where mod.id_reporte == TReport.id_reporte
                                               where mod.active == true                                               
                                               orderby mod.id_reporte ascending
                                               orderby mod.processType ascending
                                               orderby mod.priority ascending
                                               select mod).ToList<ModuleType>();

                foreach (ModuleType mod in mod_output)
                {

                    msg = string.Format(msg, TReport.desc_reporte, mod.desc_modulo, now.ToString(), mod.starting.ToString(), mod.finish.ToString());
                    LogHelper.WriteLog(this.context, msg, 10003, LevelInfo.EngineCheck);

                    if (now >= mod.starting && now <= mod.finish)
                    {
                        #region otros_check

                        //verifica que este corriendo en dia habil.                            
                        if (DiaValido(mod))
                        {

                            //verifica la generacion
                            if (!CheckGeneracionReporte(TReport, mod))
                            {
                                //verifica el status de los sistemas que requeiere el reporte.
                                bool continuar = false;
                                switch (mod.require)
                                {
                                    case CheckProcess.Inicio_Dia:
                                        inicio_dia = CheckProcesos(mod.require, mod.require_ny);
                                        if (inicio_dia) { continuar = true; }
                                        break;
                                    case CheckProcess.Fin_Dia:
                                        fin_dia = CheckProcesos(mod.require, mod.require_ny);
                                        if (fin_dia) { continuar = true; }
                                        break;
                                    case CheckProcess.Apertura_Mesa:
                                        apertura_mesa = CheckProcesos(mod.require, mod.require_ny);
                                        if (apertura_mesa) { continuar = true; }
                                        break;
                                    case CheckProcess.Cierre_Mesa:
                                        cierre_mesa = CheckProcesos(mod.require, mod.require_ny);
                                        if (cierre_mesa) { continuar = true; }
                                        break;
                                    case CheckProcess.Devengo:
                                        devengo = CheckProcesos(mod.require, mod.require_ny);
                                        if (devengo) { continuar = true; }
                                        break;
                                }

                                if (continuar)
                                {
                                    ActualizaGeneracionReporte(TReport, mod, false, "PROCESANDO");
                                    string ws_result = string.Empty;
                                    if (ConsumirWebService(mod.processType, TReport, mod, true, ref ws_result))
                                    {
                                        ActualizaGeneracionReporte(TReport, mod, true, ws_result);
                                    }
                                    else
                                    {
                                        ActualizaGeneracionReporte(TReport, mod, false, ws_result);
                                    }
                                }
                            }//chequeo de retorpe.

                        }//fecha ahora <> de sabado y domingo            
                        #endregion
                    }
                }//foreach mod in mod_output
            }//foreach report            

        }

        /// <summary>
        /// Proceso de conexion a cliente webservice y envio de reportes según proceso.
        /// </summary>
        /// <param name="procType">Proceso Input/Output</param>
        /// <param name="TReport">Tipo de reporte</param>
        /// <param name="TModule">Tipo de modulo</param>
        /// <returns>true/false</returns>
        private bool ConsumirWebService(WebServiceFMD.ProcessType procType, ReportType TReport, ModuleType TModule, bool WithMergeFiles, ref string result)
        {
            string ws_result = string.Empty;
            wsReportServicesSoapClient client = null;
            try
            {
                DateProcess proc_date = this.ProcessDate(TModule);
                string fecha = proc_date.FechaProceso.ToString("yyyy-MM-dd");


                client = new wsReportServicesSoapClient();
                LogHelper.WriteLog(this.context, "Llamando cliente WebService.", 3000, LevelInfo.Informative);


                var obj_result = client.GenerateAndSendReports(procType, TReport.desc_reporte, TModule.modulo, fecha, WithMergeFiles);
                if (obj_result.GetType() == typeof(ArrayOfString))
                {
                    ws_result = "";
                    foreach (string str in (ArrayOfString)obj_result)
                    {
                        ws_result += str + "\r\n";
                    }
                }
                else
                {
                    ws_result = obj_result.ToString();
                }

                if (client.State == System.ServiceModel.CommunicationState.Opened)
                {
                    client.Close();
                }
                client = null;

                
            }
            catch (Exception ex)
            {
                if (client != null)
                {
                    if (client.State == System.ServiceModel.CommunicationState.Opened)
                    {
                        client.Close();
                    }
                    client = null;
                }
                ws_result = LogHelper.FormatException(ex);

                LogHelper.WriteLog(this.context, ex, 3002, LevelInfo.EngineError);
                return false;
            }

            string msg = "Respuesta del cliente WebService: Reporte({0}),Modulo({1}),resultado: {2}";
            msg = string.Format(msg, TReport.desc_reporte, TModule.desc_modulo, ws_result);
            LogHelper.WriteLog(this.context, msg, 3001, LevelInfo.Informative);
            result = msg;
            return true;
        }

    
    }

}

namespace WindowsServiceFMD
{
    using WindowsServiceFMD.Common.Collections;
    using WindowsServiceFMD.Common.DAO;
    using WindowsServiceFMD.Common.DTO;
    using WindowsServiceFMD.Common.Enums;

    public partial class ServiceReport : ServiceBase
    {
        #region Funciones
        /// <summary>
        /// Inicializador de clase de servicio y contexto 
        /// </summary>
        private void InitializeEncrypted()
        {
            try
            {
                SystemDate = DateTime.Now;
                byte[] aux_data;
                byte[] IV = System.Text.ASCIIEncoding.ASCII.GetBytes("34343434"); //vector de inicializacion.
                byte[] Key = System.Text.ASCIIEncoding.ASCII.GetBytes("12121212"); //llave de encryptacion.

                CryptoHelper crypto = new CryptoHelper(CryptographyAlgorithm.DES);
                crypto.IV = IV;
                crypto.Key = Key;
                var config = WindowsServiceFMD.Properties.Settings.Default;

                PropertyDescriptorCollection p_collection = TypeDescriptor.GetProperties(Properties.Settings.Default);
                Dictionary<string, object> p = (from PropertyDescriptor o in p_collection
                                                select new
                                                {
                                                    Key = o.Name.ToLowerInvariant(),
                                                    Value = o.GetValue(Properties.Settings.Default)
                                                }).ToDictionary(a => a.Key, a => a.Value);

                WSAppContext newContext = new WSAppContext();
                newContext.MailContext = new MailContext();
                newContext.LogContext = new LogContext();

                //WSAppContext.ReadConfig(newContext, p);
                //WSAppContext.ReadConfig(newContext.LogContext, p);
                //WSAppContext.ReadConfig(newContext.MailContext, p);

                newContext.LogContext.isEnable = Properties.Settings.Default.UseFileLog;
                newContext.LogContext.FriendlyLog = Properties.Settings.Default.UseFriendlyLog;
                newContext.LogContext.LogFileName = Properties.Settings.Default.LogFolder + "\\" + string.Format(newContext.LogContext.LogFileName, DateTime.Now.ToString("yyyyMMdd"));

                newContext.DBContext = JSONHelper.Deserialize<DBContext>(config.DBConnection);
                aux_data = Convert.FromBase64String(newContext.DBContext.DBUserPass);
                newContext.DBContext.DBUserPass = crypto.Decrypt(aux_data);

                if (this.context != null)
                {
                    if ((this.context.LogContext.LogFileName != string.Empty) && this.context.LogContext.LogFileName != newContext.LogContext.LogFileName)
                    {
                        string header = ("Time Stamp").PadRight(25, '\x20') + "\t" + ("Level").PadRight(15, '\x20') + "\tCode\tMessage";
                        LogHelper.WriteLog(newContext, header);
                        LogHelper.WriteLog(newContext, Log_Line);
                    }


                }
                this.context = newContext;

            }
            catch (Exception ex)
            {
                if (this.context != null)
                {
                    if (this.context.LogContext != null)
                    {
                        LogHelper.WriteLog(this.context, ex, 1000, LevelInfo.EngineError);
                    }
                }
                throw;
            }
        }

        /// <summary>
        /// Chequea si se realizaron los procesos asociados a los sistemas: cierre, apertura de dia, cierre y apertura de mesa.
        /// </summary>
        /// <param name="process">Proceso por el cual se esta chequeando</param>
        /// <returns>true/false</returns>
        private bool CheckProcesos(CheckProcess process, bool incluir_NY = false)
        {
            DataSet ds = new DataSet();
            string msg = @"Chequeo proceso({0})=[Estado:'{1}',Mensaje:'{2}',Descripcion:'{3}']";
            try
            {
                ds = SqlHelper.ExecuteDataset(this.context.DBContext.StringConnection, "SP_CONTROL_INICIO_SISTEMAS", (int)process, incluir_NY);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    bool result;
                    DataRow row = ds.Tables[0].Rows[0];
                    result = Convert.ToBoolean(row["Estado"]);
                    
                    msg = string.Format(msg, process.ToString(), result.ToString(), row["Mensaje"].ToString(), row["Descripcion"].ToString());

#if DEBUG==true                    
                    LogHelper.WriteLog(this.context, msg, 0000, LevelInfo.DebugMode);
                    return true;
#else                             
                    LogHelper.WriteLog(this.context, msg, 5000, LevelInfo.Informative);
                    return result;
#endif

                }
            }
            catch (Exception ex)
            {
                LogHelper.WriteLog(this.context, ex, 5001, LevelInfo.EngineError);
                return false;
            }
            return false;
        }

        /// <summary>
        /// Chequea que se haya realizado el envio de reportes.
        /// </summary>
        /// <param name="TReport">Tipo de reporte</param>
        /// <param name="TModule">Tipo de modulo</param>
        /// <param name="process">Proceso Inicio/Fin dia</param>
        /// <param name="opcion">0:verificacion,1:insercion,2:actualizacion</param>
        /// <param name="procesado">true/false</param>
        /// <returns>true/false</returns>
        private bool ActualizaGeneracionReporte(ReportType TReport, ModuleType TModule, bool procesado, string proc_detalle = null)
        {
            DateProcess fc = ProcessDate(TModule);
            string sqlcmd = "sp_proceso_reportes";

            List<SqlParameter> sql_params = new List<SqlParameter>();
            sql_params.Add(new SqlParameter("id_reporte", SqlDbType.Int));
            sql_params.Add(new SqlParameter("id_modulo", SqlDbType.Int));
            sql_params.Add(new SqlParameter("fecha_proc", SqlDbType.DateTime));
            sql_params.Add(new SqlParameter("procesado", SqlDbType.Bit));
            sql_params.Add(new SqlParameter("opcion", SqlDbType.Int));
            sql_params.Add(new SqlParameter("proc_detalle", SqlDbType.VarChar));

            sql_params[0].Value = TReport.id_reporte;
            sql_params[1].Value = TModule.id_modulo;
            sql_params[2].Value = fc.FechaProceso;
            sql_params[3].Value = procesado;
            sql_params[4].Value = 2;



            if (!string.IsNullOrEmpty(proc_detalle.Trim()))
            {
                if (proc_detalle.Length > 8000)
                {
                    proc_detalle = proc_detalle.Substring(0, 8000);
                }
                else
                {
                    sql_params[5].Value = proc_detalle;
                }
            }
            else
            {
                sql_params[5].Value = null;
            }

            string msg = string.Empty;
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(this.context.DBContext.StringConnection
                           , CommandType.StoredProcedure, sqlcmd, sql_params.ToArray());

                msg = "ActualizacionGeneracionReporte: Reporte {0}, Modulo {1}, FechaProceso:{2},resultado: {3}";
                if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    DataRow row = ds.Tables[0].Rows[0];                    
                    msg = string.Format(msg, TReport.desc_reporte, TModule.modulo, fc.FechaProceso.ToString("yyyy-MM-dd"), row.Field<bool>("procesado").ToString());
                    LogHelper.WriteLog(this.context, msg, 6000, LevelInfo.Informative);
                    return row.Field<bool>("procesado");

                }
                else
                {                    
                    msg = string.Format(msg, TReport.desc_reporte, TModule.modulo, fc.FechaProceso.ToString("yyyy-MM-dd"), (false).ToString());
                    LogHelper.WriteLog(this.context, msg, 6000, LevelInfo.Informative);
                    return false;
                }
            }
            catch (Exception ex)
            {
                LogHelper.WriteLog(this.context, ex, 6001, LevelInfo.EngineError);
                throw;
            }
        }

        /// <summary>
        /// Actualiza la tabla de registro de envio de reportes
        /// </summary>
        /// <param name="TReport">Tipo de Reporte</param>
        /// <param name="TModule">Tipo de modulo</param>
        /// <param name="process">Proceso Inicio Dia/Fin dia</param>
        /// <returns></returns>
        private bool CheckGeneracionReporte(ReportType TReport, ModuleType TModule)
        {
            DateProcess fc = ProcessDate(TModule);

            string sqlcmd = "sp_proceso_reportes";

            List<SqlParameter> sql_params = new List<SqlParameter>();
            sql_params.Add(new SqlParameter("id_reporte", SqlDbType.Int));
            sql_params.Add(new SqlParameter("id_modulo", SqlDbType.Int));
            sql_params.Add(new SqlParameter("fecha_proc", SqlDbType.DateTime));
            sql_params.Add(new SqlParameter("procesado", SqlDbType.Bit));
            sql_params.Add(new SqlParameter("opcion", SqlDbType.Int));
            sql_params.Add(new SqlParameter("proc_detalle", SqlDbType.VarChar));

            sql_params[0].Value = TReport.id_reporte;
            sql_params[1].Value = TModule.id_modulo;
            sql_params[2].Value = fc.FechaProceso;
            sql_params[3].Value = false;
            sql_params[4].Value = 0;
            sql_params[5].Value = null;

            string msg = "CheckGeneracionReporte: Reporte {0}, Modulo {1}, FechaProceso:{2},resultado: {3}";
            try
            {
                DataSet ds = SqlHelper.ExecuteDataset(this.context.DBContext.StringConnection
                           , CommandType.StoredProcedure, sqlcmd, sql_params.ToArray());

                if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    DataRow row = ds.Tables[0].Rows[0];
                    
                    if (row.Field<string>("proc_detalle").ToLower() == "procesando")
                    {
                        msg = string.Format(msg, TReport.desc_reporte, TModule.modulo, fc.FechaProceso.ToString("yyyy-MM-dd")
                            , "El reporte ya se encuentra en ejecucion."                            
                            );
                        LogHelper.WriteLog(this.context, msg, 7000, LevelInfo.Informative);
                        return true;
                    }

                    msg = string.Format(msg, TReport.desc_reporte, TModule.modulo, fc.FechaProceso.ToString("yyyy-MM-dd"), row.Field<bool>("procesado").ToString());
                    LogHelper.WriteLog(this.context, msg, 7000, LevelInfo.Informative);
                    return row.Field<bool>("procesado");
                }
                else
                {
                    msg = string.Format(msg, TReport.desc_reporte, TModule.modulo, fc.FechaProceso.ToString("yyyy-MM-dd"), (false).ToString());
                    LogHelper.WriteLog(this.context, msg, 7000, LevelInfo.Informative);
                    return false;
                }
            }
            catch (Exception ex)
            {
                LogHelper.WriteLog(this.context, ex, 7001, LevelInfo.EngineError);
                throw;
            }
        }
        
        /// <summary>
        /// Obtiene las fechas de los sistemas, segun el modulo consultado
        /// </summary>
        /// <param name="TModule">Modulo a consultar</param>
        /// <returns>Retorna:Fecha Anterior,Fecha de Proceso y Fecha Proxima de los sistemas BAC.</returns>
        private DateProcess ProcessDate(ModuleType TModule)
        {
            string module = string.Empty;
            switch (TModule.modulo_h)
            {
                case "CCS":
                    module = "PCS";
                    break;
                case "SWAP":
                    module = "PCS";
                    break;
                case "ODS":
                    module = "BFW";
                    break;
                case "DCE":
                    module = "BFW";
                    break;
                case "OPT":
                    module = "OPC";
                    break;
                case "FWD":
                    module = "BFW";
                    break;
                default:
                    module = TModule.modulo_h;
                    break;
            }
            try
            {

                DateProcessCollection<DateProcess> fechas = DateProcessDao.GetDateProcessCollectionByModulo(this.context.DBContext, module);
                DateProcess fc = new DateProcess();
                fc = fechas[module];
                string msg = "Obtencion Fecha Proceso: Modulo {0}, FechaProceso: {1}";
                msg = string.Format(msg, module, fc.FechaProceso.ToString("yyyy-MM-dd"));
                LogHelper.WriteLog(this.context, msg, 8000, LevelInfo.Informative);
                return fc;
            }
            catch (Exception ex)
            {
                LogHelper.WriteLog(this.context, ex, 1000, LevelInfo.EngineError);
            }
            return new DateProcess();
        }

        /// <summary>
        /// Valida al momento de la ejecucion que se esta en un dia habil (lunes a viernes),
        /// Si se indica en el modulo, ejecucion especial (TModule.special_mode)(ejecucion de fin de semana[sabado-domingo])
        /// </summary>
        /// <param name="TModule">Modulo a consultar</param>
        /// <returns>true/false</returns>
        private bool DiaValido(ModuleType TModule)
        {

            DateTime date_now = this.context.GetRealDate();
            LogHelper.WriteLog(this.context, TModule.desc_modulo + ", Check Dia Valido:" + date_now.DayOfWeek.ToString() + " ejecucion especial: " + TModule.special_mode.ToString(), 9000, LevelInfo.EngineCheck);

            if (date_now.DayOfWeek == DayOfWeek.Saturday || date_now.DayOfWeek == DayOfWeek.Sunday)
            {
                //indica si correra sabado o domingo de manera special.
                return TModule.special_mode;
            }
            else
            {
                //resto de la semana
                return true;
            }
        }
        
        #endregion
    }

}


#region PARA DEPRECAR
        /*
        /// <summary>
        /// Consume el WebService, segun tipo de reporte
        /// </summary>
        /// <param name="procType">Proceso Input/Output</param>
        /// <param name="TReport">Tipo de reporte</param>
        /// <returns>true/false</returns>
        private bool ConsumirWebService(WebServiceFMD.ProcessType procType, ReportType TReport, ref string result)
        {
            string ws_result = string.Empty;
            wsReportServicesSoapClient client = null;
            try
            {
                client = new wsReportServicesSoapClient();
                LogHelper.WriteLog(this.context, "Llamando cliente WebService.", 4000, LevelInfo.Informative);

                string fecha = string.Empty;
                if (TReport.desc_reporte.ToUpper() == "ADM")
                {
                    DateProcess fc = ProcessDate(ModuleTypes["ADM1"]);
                    fecha = fc.FechaProceso.ToString("yyyy-MM-dd");
#if DEBUG == true
                    fecha = "2015-12-30";
#endif
                }

                var obj_result = client.Automated_RCM_SendReports(procType, TReport.desc_reporte, fecha);

                if (obj_result.GetType() == typeof(ArrayOfString))
                {
                    ws_result = "";
                    foreach (string str in (ArrayOfString)obj_result)
                    {
                        ws_result += str + "\r\n";
                    }
                }
                else
                {
                    ws_result = obj_result.ToString();
                }

                if (client.State == System.ServiceModel.CommunicationState.Opened)
                {
                    client.Close();
                }
                client = null;
            }
            catch (Exception ex)
            {
                LogHelper.WriteLog(this.context, ex, 4002, LevelInfo.EngineError);
                if (client != null)
                {
                    if (client.State == System.ServiceModel.CommunicationState.Opened)
                    {
                        client.Close();

                    }
                    client = null;
                }
                return false;
            }

            string msg = "Respuesta del cliente WebService (Automatico): Reporte({0}),resultado: {1}";
            msg = string.Format(msg, TReport.desc_reporte, ws_result);
            LogHelper.WriteLog(this.context, msg, 4001, LevelInfo.Informative);
            result = msg;
            return true;
        }
        */

#endregion