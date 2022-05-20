#pragma warning disable 1591
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Runtime.Serialization;
using CoreBusinessObjects.BLayer;
using CoreBusinessObjects.Collections;
using CoreBusinessObjects.Common;
using CoreBusinessObjects.DTO;
using CoreLib.Common;
using CoreLib.Common.Collections;
using CoreLib.Helpers;
using WebServiceFMD.Common;
using WebServiceFMD.Common.Collection;
using WebServiceFMD.Common.DAO;
using WebServiceFMD.Common.DTO;

namespace WebServiceFMD.Common
{
    /// <summary>
    /// Struct con Constantes de mensajes enviadas por el servicio.
    /// </summary>
    public struct Const
    {
        /// <summary>
        /// Mensaje que indica que no se encontraron datos para procesar.
        /// </summary>
        public const string MSG_DATANOTFOUND = "No se encuentran datos para procesar";

        /// <summary>
        /// Mensaje de operación fallida.
        /// </summary>
        public const string MSG_FAILURE_OPERATION = "La operacion presenta problemas";

        /// <summary>
        /// Mensaje de operación exitosa.
        /// </summary>
        public const string MSG_SUCCESS_OPERATION = "Operación completada con exito";

        /// <summary>
        /// Mensaje de operación no valida.
        /// </summary>
        public const string MSG_NOTVALID_OPERATION = "Operación no valida.";

        /// <summary>
        /// Mensaje de operación no implmenentada.
        /// </summary>
        public const string MSG_NOTIMPLEMENTED = "Operación no implementada";

        /// <summary>
        /// Mensaje que indica que el producto o modulo para la generación de reportes no se encuentra.
        /// </summary>
        public const string MSG_PRODUCTTYPE_NOTFOUND = "El producto solicitado no se encuentra";

        /// <summary>
        /// Mensaje que indica que el tipo de reporte no se encuentra o no es el indicado.
        /// </summary>
        public const string MSG_REPORTTYPE_NOTFOUND = "El tipo de reporte solicitado no se encuentra";

        /// <summary>
        /// Mensaje que el proceso indicado no esta soportado por la aplicación.
        /// </summary>
        public const string MSG_PROCESS_NOTSUPORTED = "Proceso no soportado";

        /// <summary>
        /// Mensaje que indica que no hay archivos para procesar.
        /// </summary>
        public const string MSG_PROCESS_FILESNOTFOUND = "No hay archivos para procesar";


        /// <summary>
        /// Mensaje que indica que no se encuentran los archivos de plantilla para procesar
        /// </summary>
        public const string MSG_TEMPLATE_FILESNOTFOUND = "No se encuentran archivos de plantilla para procesar";
      
    }

    /// <summary>
    /// Enumera los tipos de proceso soportado
    /// </summary>
    [Serializable]
    [DataContract(Name = "ProcessType")]
    public enum ProcessType
    {
        /// <summary>
        /// Indica importacion de información, utilizado para el proceso de apertura de dia.
        /// </summary>
        Input = 0,
        /// <summary>
        /// Indica exportacion de información, utilizado para el proceso de cierre de dia.
        /// </summary>
        Output = 1
    }

    [Serializable]
    [DataContract(Name = "CheckProcess")]
    public enum CheckProcess
    {
        Inicio_Dia = 0,
        Fin_Dia = 1,
        Apertura_Mesa = 2,
        Cierre_Mesa = 3,
        Devengo = 4
    }
}


namespace WebServiceFMD
{
    /// <summary>
    /// Servicios de Reporteria.
    /// </summary>
    public partial class wsReportServices : System.Web.Services.WebService
    {
        #region Private Members.
        private ModuleTypeCollection<ModuleType> ModuleTypes = new ModuleTypeCollection<ModuleType>();
        private ReportTypeCollection<ReportType> ReportTypes = new ReportTypeCollection<ReportType>();
        private wsReportContext context { get; set; }
        private string Log_Line { get { return ("=").PadLeft(100, '='); } }
        private string ParametroFecha { get; set; }
        private bool ProcesoAutomatico = false;
        private System.Threading.Thread CompressThread;
        #endregion



        /// <summary>
        /// Default Constructor.
        /// </summary>
        public wsReportServices()
        {
            InitializeEncrypted();
        }



        /// <summary>
        /// Carga una lista de file info en base al directorio base y patron de busqueda
        /// </summary>
        /// <param name="BaseDirectory">Directorio base en el cual se van a buscar archivos</param>
        /// <param name="FileNamePattern">Patron de busqueda para archivos.</param>
        /// <returns>Lista de FileInfo</returns>
        private List<FileInfo> LoadFileToImport(string BaseDirectory, string FileNamePattern)
        {
            if (string.IsNullOrEmpty(BaseDirectory))
            {
                throw new ArgumentNullException("BaseDirectory", "El parametro no puede ser nulo.");
            }

            if (string.IsNullOrEmpty(FileNamePattern))
            {
                FileNamePattern = "*.*";
            }

            DirectoryInfo dirInfo = new DirectoryInfo(BaseDirectory);
            //FileInfo[] files = dirInfo.GetFiles(FileNamePattern, SearchOption.AllDirectories); //--> Deprecado
            FileInfo[] files = dirInfo.GetFiles(FileNamePattern);
            return files.ToList();

        }

        /// <summary>
        /// Carga una lista de file info en base al tipo de reporte, al directorio base y patron de busqueda
        /// </summary>
        /// <param name="TReport">Tipo de reporte</param>
        /// <param name="BaseDirectory">Directorio base en el cual se van a buscar archivos</param>
        /// <param name="FileNamePattern">Patron de busqueda para archivos.</param>
        /// <returns>Lista de FileInfo</returns>
        private List<FileInfo> LoadFileToImport(ReportType TReport, string BaseDirectory, string FileNamePattern)
        {
            List<FileInfo> TemplateFiles = new List<FileInfo>();
            if (TReport != null)
            {
                if (string.IsNullOrEmpty(BaseDirectory))
                {
                    BaseDirectory = this.context.UploadFolder;
                }

                if (string.IsNullOrEmpty(FileNamePattern))
                {
                    FileNamePattern = "*.*";
                }

                DirectoryInfo dirInfo = new DirectoryInfo(BaseDirectory);
                DirectoryInfo[] TemplateDirectory = dirInfo.GetDirectories(TReport.desc_reporte);
                if (TemplateDirectory.Length > 0)
                {
                    foreach (DirectoryInfo dinfo in TemplateDirectory)
                    {
                        FileInfo[] files = dinfo.GetFiles(FileNamePattern);
                        TemplateFiles = files.ToList<FileInfo>();
                    }
                }
                dirInfo = null;
                TemplateDirectory = null;
                return TemplateFiles;
            }
            return TemplateFiles;
        }

        /// <summary>
        /// Lee segun tipo de reporte los archivos de plantilla.
        /// </summary>
        /// <param name="TReport"></param>
        /// <returns></returns>
        private List<FileInfo> LoadFileTemplates(ReportType TReport)
        {

            List<FileInfo> TemplateFiles = new List<FileInfo>();
            if (TReport != null)
            {
                LogHelper.WriteLog(this.context, "Buscando archivos de plantilla...", 2000, LevelInfo.EngineConfig);

                DirectoryInfo dirInfo = new DirectoryInfo(this.context.TemplateFolder);
                DirectoryInfo[] TemplateDirectory = dirInfo.GetDirectories(TReport.desc_reporte);

                if (TemplateDirectory.Length > 0)
                {
                    foreach (DirectoryInfo dinfo in TemplateDirectory)
                    {
                        FileInfo[] files = dinfo.GetFiles("*.xml");
                        foreach (FileInfo f in files)
                        {
                            TemplateFiles.Add(f);
                            LogHelper.WriteLog(this.context, f.Name, 2000, LevelInfo.EngineConfig);
                        }
                    }
                }
                dirInfo = null;
                TemplateDirectory = null;
                LogHelper.WriteLog(this.context, "Fin de busqueda de archivos de plantilla...", 2000, LevelInfo.EngineConfig);
                return TemplateFiles;
            }
            return TemplateFiles;
        }

        /// <summary>
        /// Carga en memoria los archivos de plantilla
        /// </summary>
        /// <param name="TemplateFiles">Lista de archivos de plantilla</param>
        /// <param name="process">Tipo de proceso(para filtrar las plantillas)</param>
        /// <param name="IncludeInputOutput">Indica si se incluyen las plantillas de tipo InputOutput</param>
        /// <returns>Collection de objetos TemplateData</returns>
        private TemplateDataCollection<TemplateData> LoadTemplates(List<FileInfo> TemplateFiles, ProcessType process, bool IncludeInputOutput = false)
        {
            DataDirection _direction1 = DataDirection.InputOutput;
            DataDirection _direction2 = DataDirection.Output;
            if (process == ProcessType.Input)
            {
                _direction2 = DataDirection.Input;
            }
            else if (process == ProcessType.Output)
            {
                _direction2 = DataDirection.Output;
            }


            TemplateDataCollection<TemplateData> result = new TemplateDataCollection<TemplateData>();
            LogHelper.WriteLog(this.context, "Cargando archivos de plantilla...", 2002, LevelInfo.EngineConfig);
            foreach (FileInfo f in TemplateFiles)
            {
                TemplateData TData = new TemplateData();
                TData = AFacade.LoadTemplate(f.FullName);
                if (IncludeInputOutput)
                {
                    if (TData.TemplateDirection == _direction1 || TData.TemplateDirection == _direction2)
                    {
                        result.Add(TData);
                    }
                }
                else
                {
                    if (TData.TemplateDirection == _direction2)
                    {
                        result.Add(TData);
                    }

                }
            }
            if (result.Count > 0)
            {
                LogHelper.WriteLog(this.context, "Carga de archivos de plantilla finalizado...", 2003, LevelInfo.EngineConfig);
            }
            else if (result.Count == 0)
            {
                LogHelper.WriteLog(this.context, "Carga de archivos de plantilla finalizado..No hay archivos para cargar...", 2004, LevelInfo.EngineError);
            }
            return result;
        }

        /// <summary>
        /// Extrae de la base de datos el ultimo de folio para la generacion de informes
        /// </summary>
        /// <param name="TReport">Tipo de Reporte.</param>
        /// <param name="TModule">Tipo de Modulo/Producto</param>
        /// <returns>Integer. con un nuevo numero de folio</returns>
        public int LoadFolios(ReportType TReport, ModuleType TModule)
        {
            //TODO: Implementar logica para extraccion de folios
            return 1;
        }

        /// <summary>
        /// Actualiza la tabla de folios
        /// </summary>
        /// <param name="TReport">Tipo de reporte</param>
        /// <param name="TModule">Tipo de Modulo</param>
        /// <param name="newFileName"></param>
        /// <param name="seed">Folio a actualizar</param>
        public void UpdateFolios(ReportType TReport, ModuleType TModule, string newFileName, int seed)
        {
            // Implementar si se requiere actualizacin de folios de informe.
            //throw new NotImplementedException();
        }

        /// <summary>
        /// Genera nombre de archivo.
        /// </summary>
        /// <param name="TData"></param>
        /// <param name="seed"></param>
        /// <returns></returns>
        public string NewFileName(TemplateData TData, object seed)
        {
            string aux_IOFileBaseDirectory = TData.IOFileBaseDirectory;
            TData.IOFileBaseDirectory = string.Empty;


            // \\DownloadFolder\\IOFileBasedirectory\FileName
            string newFileName = string.Empty;

            if (string.IsNullOrEmpty(TData.IOFileBaseDirectory))
            {
                if (TData.IOFileNamePattern.useDatePattern == true)
                {
                    newFileName = this.context.DownloadFolder + "\\" + TData.IOFileNamePattern.newFileName((DateTime)seed);

                }
                else if (TData.IOFileNamePattern.useNumericPattern == true)
                {
                    newFileName = this.context.DownloadFolder + "\\" + TData.IOFileNamePattern.newFileName((int)seed);
                }
            }
            else
            {
                if (TData.IOFileBaseDirectory.LastIndexOf("\\") == TData.IOFileBaseDirectory.Length - 1)
                {
                    TData.IOFileBaseDirectory = TData.IOFileBaseDirectory.Substring(0, TData.IOFileBaseDirectory.Length - 1);
                }

                if (TData.IOFileNamePattern.useDatePattern == true)
                {
                    newFileName = TData.IOFileBaseDirectory + "\\" + TData.IOFileNamePattern.newFileName((DateTime)seed);
                }
                else if (TData.IOFileNamePattern.useNumericPattern == true)
                {
                    newFileName = TData.IOFileBaseDirectory + "\\" + TData.IOFileNamePattern.newFileName((int)seed);
                }
            }

            TData.IOFileBaseDirectory = aux_IOFileBaseDirectory;
            return newFileName;
        }
        
        /// <summary>
        /// Carga configuracion y miscelaneos para el servicio (webconfig encryptado.)
        /// </summary>
        private void InitializeEncrypted()
        {

            byte[] aux_data;
            byte[] IV = System.Text.ASCIIEncoding.ASCII.GetBytes("34343434"); //vector de inicializacion.
            byte[] Key = System.Text.ASCIIEncoding.ASCII.GetBytes("12121212"); //llave de encryptacion.

            CryptoHelper crypto = new CryptoHelper(CryptographyAlgorithm.DES);
            crypto.IV = IV;
            crypto.Key = Key;

            var config = WebServiceFMD.Properties.Settings.Default;

            //aux_data = Convert.FromBase64String(config.DBConnections);
            //string dbConnections = crypto.Decrypt(aux_data);

            //aux_data = Convert.FromBase64String(config.DefaultCatalog);
            //string DefaultCatalog = crypto.Decrypt(aux_data);

            //aux_data = Convert.FromBase64String(config.MailServer);
            //string MailServer = crypto.Decrypt(aux_data);

            //aux_data = Convert.FromBase64String(config.MailAccount);
            //string MailAccount = crypto.Decrypt(aux_data);

            //Descomentar para incluir password de cuenta de email sender.
            //aux_data = Convert.FromBase64String(config.MailAccountPass);
            //string MailPass = crypto.Decrypt(aux_data);



            wsReportContext newContext = new wsReportContext();

            PropertyDescriptorCollection p_collection = TypeDescriptor.GetProperties(WebServiceFMD.Properties.Settings.Default);
            Dictionary<string, object> p = (from PropertyDescriptor o in p_collection
                                            select new
                                            {
                                                Key = o.Name.ToLowerInvariant(),
                                                Value = o.GetValue(WebServiceFMD.Properties.Settings.Default)
                                            }).ToDictionary(a => a.Key, a => a.Value);

            DBContextCollection<DBContext> db_ctx_collection = new DBContextCollection<DBContext>();

            MailContext mail_ctx = new MailContext();
            LogContext log_ctx = new LogContext();

            AppContext.ReadConfig(newContext, p);
            AppContext.ReadConfig(log_ctx, p);
            AppContext.ReadConfig(mail_ctx, p);

            //mail_ctx.MailAccount = MailPass;
            //mail_ctx.MailAccount = MailAccount;
            //mail_ctx.MailServer = MailServer;

            newContext.MailContext = mail_ctx;

            log_ctx.isEnable = WebServiceFMD.Properties.Settings.Default.UseFileLog;
            log_ctx.FriendlyLog = WebServiceFMD.Properties.Settings.Default.UseFriendlyLog;


            newContext.DBContextCollection = JSONHelper.Deserialize<DBContextCollection<DBContext>>(config.DBConnections);

            foreach (DBContext dbCtx in newContext.DBContextCollection)
            {
                aux_data = Convert.FromBase64String(dbCtx.DBUserPass);
                dbCtx.DBUserPass = crypto.Decrypt(aux_data);
            }

            string rootFolder = Server.MapPath(".");

            newContext.LogFolder = WebServiceFMD.Properties.Settings.Default.LogFolder;
            //newContext.LogFolder = rootFolder + "\\" + WebServiceFMD.Properties.Settings.Default.LogFolder;
            newContext.UploadFolder = rootFolder + "\\" + WebServiceFMD.Properties.Settings.Default.UploadFolder;
            newContext.DownloadFolder = rootFolder + "\\" + WebServiceFMD.Properties.Settings.Default.DownloadFolder;
            newContext.TemplateFolder = rootFolder + "\\" + WebServiceFMD.Properties.Settings.Default.TemplateFolder;

            log_ctx.LogFileName = newContext.LogFolder + "\\" + log_ctx.LogFileName;
            newContext.LogContext = log_ctx;

            if (newContext.DBContextCollection.Contains(config.DefaultCatalog, StringComparison.InvariantCultureIgnoreCase))
            {
                newContext.DBContext = newContext.DBContextCollection[config.DefaultCatalog];
                //ReportTypes = ReportTypeDao.GetReportTypeCollection(newContext.DBContext);
                //ModuleTypes = ModuleTypeDao.GetModuleTypeCollection(newContext.DBContext);
            }

            // ModuleTypes = JSONHelper.Deserialize<ModuleTypeCollection<ModuleType>>(wsReportes_CM.Properties.Settings.Default.ModuleTypes);
            newContext.AllowPaging = WebServiceFMD.Properties.Settings.Default.AllowPaging;
            this.context = newContext;
        }

        /// <summary>
        /// Imprime encabezado en archivo de log
        /// </summary>
        /// <param name="process">Tipo de Proceso</param>
        /// <param name="TReport">Tipo de Reporte</param>
        /// <param name="TModule">Modulo </param>
        /// <param name="date">Fecha</param>
        /// <param name="Auto">Indica si es de generacion automatica o normal</param>
        private void PrintLogHeader(ProcessType process, ReportType TReport, ModuleType TModule, DateTime date, bool Auto = false)
        {

            string automatic = string.Empty;
            string aux_header = string.Empty;
            LogHelper.WriteLog(this.context, "Comenzando ...", 1000, LevelInfo.Informative);

            if (Auto == true)
            {
                automatic = ", Automatico";
                aux_header = @"Proceso:{0}| Fecha a procesar: <Fecha de proceso por sistema.>| Tipo Reporte:{1}";
                aux_header = string.Format(aux_header, (process.ToString() + "," + TReport.desc_reporte + automatic), TReport.desc_reporte);
            }
            else
            {
                aux_header = @"Proceso:{0}| Fecha a procesar: {1}| Tipo Reporte:{2}";
                aux_header = string.Format(aux_header, (process.ToString() + "," + TReport.desc_reporte + automatic), date.ToString("dd-MM-yyyy"), TReport.desc_reporte);
            }

            if (TModule != null)
            {
                LogHelper.WriteLog(this.context, aux_header + "|Modulo:" + TModule.modulo, 1000, LevelInfo.Informative);
            }
            else
            {
                LogHelper.WriteLog(this.context, aux_header, 1000, LevelInfo.Informative);
            }

        }

        /// <summary>
        /// Ejecuta el procedimiento almancenado de salida de datos
        /// </summary>
        /// <param name="TData">Template Data</param>
        /// <param name="data">DataSet resultante</param>
        /// <param name="date">Fecha a enviar en la ejecucion del sp</param>
        /// <param name="error">Errores</param>
        private void ExecOutputTemplateStoreProcedure(TemplateData TData, DateTime date, out DataSet data, ref string error)
        {
            //LogHelper.WriteLog(this.context, Log_Line);
            string sp_name = string.Empty;

            LogHelper.WriteLog(this.context, "Preparando datos (Turing).", 5000, LevelInfo.Informative);
            try
            {
                LogHelper.WriteLog(this.context, "Procesando parametros de fecha.", 5001, LevelInfo.EngineConfig);

                
                foreach (StoreProcsInfo spInfo in TData.ListStoreProcsInfo)
                {
                    sp_name += spInfo.StoreProcName + "|";    
                    foreach (TemplateStoreProcParams sp_param in spInfo.ListStoreProcParams)
                    {
                        if (sp_param.DBType == DbType.Date ||
                            sp_param.DBType == DbType.DateTime ||
                            sp_param.DBType == DbType.DateTime2)
                        {
                            sp_param.ParameterValue = date;
                        }
                    }
                }
                if (sp_name != string.Empty) {
                    sp_name = sp_name.Substring(0, sp_name.Length - 1);
                }                

                LogHelper.WriteLog(this.context, "Ejecutando Store Procedure...:" + sp_name, 5002, LevelInfo.Informative);                
                DataSet ds = new DataSet();
                AFacade.ExecureOutputProcedure(this.context, TData, out ds);
                data = ds;
                LogHelper.WriteLog(this.context, "Fin Ejecucion...", 5003, LevelInfo.Informative);
            }
            catch (Exception e)
            {
                LogHelper.WriteLog(this.context, e, 5004, LevelInfo.EngineError);
                data = new DataSet();
                error = LogHelper.FormatException(e, this.context.LogContext.FriendlyLog);
                return;
            }
            //LogHelper.WriteLog(this.context, Log_Line);
        }

        /// <summary>
        /// Ejecuta el procedimiento almancenado de salida de datos
        /// </summary>
        /// <param name="TData">Template Data</param>
        /// <param name="data">DataSet resultante</param>        
        /// <param name="error">Errores</param>
        private void ExecOutputTemplateStoreProcedure(TemplateData TData, out DataSet data, ref string error)
        {
            //LogHelper.WriteLog(this.context, Log_Line);
            string sp_name = string.Empty;

            LogHelper.WriteLog(this.context, "Preparando datos (Turing).", 5000, LevelInfo.Informative);
            try
            {
                LogHelper.WriteLog(this.context, "Ejecutando Store Procedure...", 5002, LevelInfo.Informative);
                DataSet ds = new DataSet();
                AFacade.ExecureOutputProcedure(this.context, TData, out ds);
                data = ds;
                LogHelper.WriteLog(this.context, "Fin Ejecucion...", 5003, LevelInfo.Informative);
            }
            catch (Exception e)
            {
                LogHelper.WriteLog(this.context, e, 5004, LevelInfo.EngineError);
                data = new DataSet();
                error = LogHelper.FormatException(e, this.context.LogContext.FriendlyLog);
                return;
            }
            //LogHelper.WriteLog(this.context, Log_Line);
        }


        /// <summary>
        /// Prepara una lista de SqlCommand para ejecutar por el motor, segun configuracion de la plantilla/Motor.
        /// </summary>
        /// <param name="TData">Informacion de la plantilla</param>
        /// <param name="sqlcmd">Lista de SqlCommand para ejecutar.</param>
        /// <param name="error">Mensaje de error devuelto por la rutina.</param>
        private void PrepareTemplateStoreProcedureCommand(TemplateData TData, out List<Tuple<string, string, List<SqlParameter>>> sqlcmd, ref string error)
        {

            LogHelper.WriteLog(this.context, "Preparando Store Procedure", 5000, LevelInfo.EngineConfig);
            try
            {
                sqlcmd = AFacade.PrepareCommand(this.context, TData);                
                LogHelper.WriteLog(this.context, "Fin preparacion", 5003, LevelInfo.Informative);
            }
            catch (Exception e)
            {
                LogHelper.WriteLog(this.context, e, 5004, LevelInfo.EngineError);
                sqlcmd = null;
                error = LogHelper.FormatException(e, this.context.LogContext.FriendlyLog);
                return;
            }
        }







        /// <summary>
        /// Copia un archivo en los directorios indicados por TData.IOFileCopyFolders
        /// </summary>
        /// <param name="TData">Template Data</param>
        /// <param name="FileName">nombre del archivo a copiar</param>
        private void CopyOutputFiles(TemplateData TData, ref string FileName)
        {
            FileInfo f_aux = new FileInfo(FileName);
            LogHelper.WriteLog(this.context, "Copiando archivo(s): " + f_aux.Name, 4000, LevelInfo.Informative);


            string aux_Folder = string.Empty;

            if (TData.useAppFolders == false && TData.IOFileCopyFolders.Count > 0)
            {
                string aux_name = string.Empty;
                foreach (IOFileCopyFolders folder in TData.IOFileCopyFolders)
                {

                    if (folder.FolderDirection == FolderDirection.Output)
                    {
                        string root = this.context.InterfaceRootFolder + "\\" + TData.IOFileBaseDirectory;
                        aux_Folder = folder.FolderName;
                        folder.FolderName = root + folder.FolderName;

                        //check for existence
                        if (!folder.DirectoryInfo.Exists)
                        {
                            folder.DirectoryInfo.Create();
                            LogHelper.WriteLog(this.context, "Creando Directorio: " + folder.FolderName, 4001, LevelInfo.Informative);
                        }

                        f_aux.CopyTo(folder.DirectoryInfo.FullName + "\\" + f_aux.Name, true);

                        if (folder.CompressedFiles == true)
                        {

                            string aux_compressed = folder.DirectoryInfo.FullName + "\\" + f_aux.Name;
                            string aux_compressed_folder = folder.DirectoryInfo.FullName;
                            CompressThread = new System.Threading.Thread(
                                () =>
                                {                            
                                    int counter = 0;
                                    string pattern = f_aux.Name + "*.zip";
                                    string aux_compressed_file = string.Empty;
                                    DirectoryInfo d = new DirectoryInfo(aux_compressed_folder);
                                    FileInfo[] aux_files = d.GetFiles(pattern);
                                    
                                    counter = aux_files.Count();

                                    if (counter > 0) { 
                                        aux_compressed_file = aux_compressed + "." + counter.ToString().PadLeft(3,'0') + ".zip";
                                    }else{
                                        aux_compressed_file = aux_compressed + ".zip";
                                    }                                   
                                    
                                    ZipHelper.ZipFile(aux_compressed,aux_compressed_file, true);
                                }
                                );
                            CompressThread.Start();
                        }

                        LogHelper.WriteLog(this.context, "Destino: " + folder.DirectoryInfo.FullName + "\\" + f_aux.Name, 4002, LevelInfo.Informative);
                        if (folder.MainFolder == true)
                        {
                            aux_name = folder.DirectoryInfo.FullName + "\\" + f_aux.Name;
                        }

                    }

                    folder.FolderName = aux_Folder;
                }

                if (this.context.DeleteFiles)
                {
                    LogHelper.WriteLog(this.context, "Opcion <DeleteFiles>: True", 4003, LevelInfo.EngineConfig);
                    f_aux.Delete();
                }
                else
                {
                    LogHelper.WriteLog(this.context, "Opcion <DeleteFiles>: False", 4004, LevelInfo.EngineConfig);
                }

                FileName = aux_name;
            }
            else
            {
                LogHelper.WriteLog(this.context, "No hay otros directorios al cual copiar el archivo", 4005, LevelInfo.Warning);
            }
        }

        /// <summary>
        /// Copia archivo en rutas de destino
        /// </summary>
        /// <param name="TData">Template Data</param>
        /// <param name="FileNames">Lista de archivos a copiar</param>
        private void CopyOutputFiles(TemplateData TData, ref List<String> FileNames)
        {
            List<string> aux_files = new List<string>();
            string aux_filename = string.Empty;

            foreach (string filename in FileNames)
            {
                aux_filename = filename;
                CopyOutputFiles(TData, ref aux_filename);
                aux_files.Add(aux_filename);
            }
            FileNames = aux_files;
        }

        /// <summary>
        /// Agrupación de funciones para mezcla de archivos
        /// </summary>
        /// <param name="TData">Template Data</param>
        /// <param name="TReport">Tipo de Reporte</param>
        /// <param name="TModule">Modulo o producto</param>
        /// <param name="date">Fecha a procesar o generar reporte</param>
        /// <param name="withMergeFiles">Indica si mezclan los archivos FINDUR/TURING</param>
        /// <param name="ds">DataSet de resultado</param>
        private void MergeFiles(TemplateData TData, ReportType TReport, ModuleType TModule, DateTime date, bool withMergeFiles, ref DataSet ds)
        {
            //LogHelper.WriteLog(this.context, Log_Line);
            LogHelper.WriteLog(this.context, "Preparando archivos para mezcla (Findur/Turing).", 6000, LevelInfo.Informative);

            wsReportContext ctx = new wsReportContext();
            ctx = this.context;
            ctx.DBContext = this.context.DBContextCollection[TData.DBCatalog];


            DataSet merge_ds = new DataSet();
            string pattern = string.Empty;
            bool aux_additional_info = TData.AdditionalInfo;
            TData.AdditionalInfo = false;

            pattern = date.ToString("yyyyMMdd") + "*" + TModule.modulo_h + "*.xls*";
            LogHelper.WriteLog(ctx, "Patron de busqueda de archivos para mezcla: " + pattern, 6001, LevelInfo.Informative);

            List<FileInfo> mergeFiles = new List<FileInfo>();


            #region MultiRuta
            LogHelper.WriteLog(ctx, "Leyendo directorio de entrega.(buscando archivos)", 6002, LevelInfo.Informative);
            if (TData.useAppFolders == false && TData.IOFileCopyFolders.Count > 0)
            {
                string root = ctx.InterfaceRootFolder + "\\" + TData.IOFileBaseDirectory + "\\";

                foreach (IOFileCopyFolders folder in TData.IOFileCopyFolders)
                {
                    if (folder.FolderDirection == FolderDirection.Input)
                    {
                        folder.FolderName = root + folder.FolderName;

                        mergeFiles.AddRange(LoadFileToImport(folder.FolderName, pattern));
                    }
                }

            }
            else
            {
                mergeFiles = LoadFileToImport(TReport, ctx.UploadFolder, pattern);
            }
            #endregion

            if (mergeFiles.Count > 0)
            {
                LogHelper.WriteLog(ctx, "Procesando archivos: ", 6003, LevelInfo.Informative);
                foreach (FileInfo f in mergeFiles)
                {
                    bool importResult = ExcelFacadeBL.ImportData(ctx, TData, f.FullName, out merge_ds, false);

                    if (importResult)
                    {
                        LogHelper.WriteLog(ctx, "Resultado: ImportData(True) " + f.Name, 6004, LevelInfo.Informative);
                    }
                    else
                    {
                        LogHelper.WriteLog(ctx, "Resultado: ImportData(False) " + f.Name, 6005, LevelInfo.Error);
                    }
                    //Proceso de match dce 
                    if (importResult)
                    {
                        LogHelper.WriteLog(ctx, "Proceso de Match Findur: ", 6006, LevelInfo.Informative);
                        ExcelFacadeBL.DCEMatching(ctx, TData, merge_ds, out merge_ds);
                        LogHelper.WriteLog(ctx, "Fin de Proceso de Match Findur: ", 6007, LevelInfo.Informative);
                        LogHelper.WriteLog(ctx, "Respaldo archivo de mezcla: ", 6008, LevelInfo.Informative);

                        IOFileCopyFoldersCollection<IOFileCopyFolders> aux_folders = new IOFileCopyFoldersCollection<IOFileCopyFolders>();
                        foreach (IOFileCopyFolders folders in TData.IOFileCopyFolders)
                        {
                            aux_folders.Add(folders.Copy());
                        }
                        List<IOFileCopyFolders> dirs = (from IOFileCopyFolders fx in TData.IOFileCopyFolders
                                                        where fx.FolderDirection == FolderDirection.Backup
                                                        select fx.Copy()).ToList();
                        TData.IOFileCopyFolders.Clear();
                        foreach (var obj in dirs)
                        {
                            obj.FolderDirection = FolderDirection.Output;
                            TData.IOFileCopyFolders.Add(obj);
                        }


                        string aux_filename = f.FullName;
                        CopyOutputFiles(TData, ref aux_filename);
                        TData.IOFileCopyFolders.Clear();
                        foreach (IOFileCopyFolders folders in aux_folders)
                        {
                            TData.IOFileCopyFolders.Add(folders.Copy());
                        }
                    }
                }
            }
            else
            {
                LogHelper.WriteLog(ctx, "No se encuentran archivos para proceso de mezcla (Findur/Turing)", 6009, LevelInfo.Warning);
                withMergeFiles = false;
            }
            TData.AdditionalInfo = aux_additional_info;
            LogHelper.WriteLog(ctx, "Fin de proceso de lectura de archivos para mezcla(Findur/Turing)", 6010, LevelInfo.Informative);
            //LogHelper.WriteLog(ctx, Log_Line);


            //merge de los dataset
            if (withMergeFiles)
            {
                LogHelper.WriteLog(ctx, "Mesclando datos (Findur/Turing).", 6011, LevelInfo.Informative);
                if (ds != null && ds.Tables.Count > 0)
                {
                    if (merge_ds.Tables.Count > 0 && merge_ds.Tables[0].Rows.Count > 0)
                    {
                        DataTable dt2 = merge_ds.Tables[0];
                        foreach (DataRow row in dt2.Rows)
                        {
                            DataRow row2 = ds.Tables[0].NewRow();
                            row2.ItemArray = row.ItemArray;
                            ds.Tables[0].Rows.Add(row2);
                        }
                        LogHelper.WriteLog(ctx, "Fin de mezcla (Findur/Turing).", 6012, LevelInfo.Informative);
                    }
                    else
                    {
                        LogHelper.WriteLog(ctx, "No hay datos Findur para mezclar. (Findur/Turing).", 6013, LevelInfo.Warning);
                    }
                }

            }



        }//Fin Merge
        
        /// <summary>
        /// Valida que el string de fecha sea valido, si no devuelve la fecha de proceso.
        /// </summary>
        /// <param name="TModule">Tipo modulo</param>
        /// <param name="date">fecha en string para revision</param>
        /// <returns>DateTime</returns>
        private DateTime ProcessDate(ModuleType TModule, string date = null)
        {
            DateTime fecha_proceso;

            string module = string.Empty;

            #region Evita que no se obtenga la fecha correcta de los sistemas
            string module_aux = string.Empty;
            ReportType TReport = ReportTypes[TModule.id_reporte];
            if (TReport.desc_reporte == "ADM")
            {
                module_aux = TModule.modulo_h;
            }
            else
            {
                module_aux = TModule.modulo;
            }
            #endregion
            switch (module_aux)
            {
                case "CCS": module = "PCS"; break;
                case "SWAP": module = "PCS"; break;
                case "ODS": module = "BFW"; break;

                case "DCE": module = "BFW"; break;
                case "OPT": module = "OPC"; break;
                case "FWD": module = "BFW"; break;
                case "BFW": module = "BFW"; break;
                case "IRS": module = "PCS"; break;
#region VFBF 15-01-2019 Se agrega anexo 01 para Forward
                case "ANX": module = "BFW"; break;
#endregion
                default: module = module_aux; break;
            }

            if ((!string.IsNullOrEmpty(date)) || (!string.IsNullOrWhiteSpace(date)))
            {
                if (DateTime.TryParse(date, out fecha_proceso))
                {
                    return fecha_proceso;
                }
                else
                {
                    //obtencion fecha de proceso en caso de no poder parsear la fecha.
                    DateProcessCollection<DateProcess> fechas = DateProcessDao.GetDateProcessCollectionByModulo(this.context.DBContext, module);
                    DateProcess fc = fechas[module];
                    fecha_proceso = fc.FechaProceso;
                }
            }
            else
            {
                DateProcessCollection<DateProcess> fechas = DateProcessDao.GetDateProcessCollectionByModulo(this.context.DBContext, module);
                DateProcess fc = fechas[module];
                fecha_proceso = fc.FechaProceso;
            }
            return fecha_proceso;
        }//
        
        /// <summary>
        /// Chequeo de Conexion a BD
        /// </summary>
        /// <param name="ctx"></param>
        /// <returns></returns>
        private bool CheckConnectionDB(wsReportContext ctx)
        {
            string header = ("Time Stamp").PadRight(25, '\x20') + "\t" + ("Level").PadRight(15, '\x20') + "\tCode\tMessage";
            LogHelper.WriteLog(this.context, header);
            LogHelper.WriteLog(this.context, Log_Line);


            /* Check y Registro de Conexion a base de datos.*/
            System.Data.SqlClient.SqlConnection connection = (System.Data.SqlClient.SqlConnection)ctx.DBContext.Connection;
            try
            {
                LogHelper.WriteLog(ctx, "Prueba de conexion a BD..", 1001, LevelInfo.EngineCheck, true);
                connection.Open();
            }
            catch (Exception ex)
            {
                LogHelper.WriteLog(ctx, "Problemas en conexion...:" + ex.Message, 1002, LevelInfo.EngineError);
                return false;
            }
            finally
            {
                if (connection.State == ConnectionState.Open)
                {
                    connection.Close();
                }
                LogHelper.WriteLog(ctx, "Fin prueba de conexion a BD..", 1003, LevelInfo.EngineCheck, true);
            }
            return true;
        }

        /// <summary>
        /// Limpia el directorio temporal de generacion de interfaces 
        /// </summary>
        /// <param name="ctx">Contexto de Aplicacion</param>
        /// <returns></returns>
        private bool CleanTemporaryFiles(wsReportContext ctx)
        {

            DirectoryInfo dir = new DirectoryInfo(ctx.DownloadFolder);
            string pattern = "*.*";
            FileInfo[] aux_files = dir.GetFiles(pattern);
            try
            {
                List<FileInfo> Files = (from FileInfo f in aux_files
                                        where f.Extension != ".txt"
                                        select f).ToList();
                if (Files.Count() > 0)
                {
                    foreach (FileInfo file in Files)
                    {
                        try
                        {
                            if (file.IsReadOnly == false)
                                file.Delete();
                        }
                        catch (Exception)
                        {
                            continue;
                        }
                    }
                    return true;
                }
                return true;
            }
            catch (Exception) { }
            return true;
        }
        
        /// <summary>
        /// Modo mantencion, comprime los archivos generados, limpia la carpeta temporal 
        /// </summary>
        /// <param name="ctx">Contexto de aplicacion</param>
        /// <param name="date">Fecha de la cual se toma el mes y el año para realizar el respaldo</param>
        /// <param name="error">Mensaje devuelto por el servicio</param>
        /// <param name="comprimir_principales">Indica si se respaldaran los directorios principales // no recomendado</param>
        /// <returns></returns>
        private bool MaintenanceMode(wsReportContext ctx, DateTime date, ref string error,bool comprimir_principales = false) {
        
            /*Limpeza de archivos temporales*/
            CleanTemporaryFiles(ctx);

            /* Extraccion de archivos de plantilla*/
            DirectoryInfo dirInfo = new DirectoryInfo(this.context.TemplateFolder);
            List<FileInfo> files = dirInfo.GetFiles("*.xml", SearchOption.AllDirectories).ToList();

            /*carga de archivos de plantilla*/
            List<TemplateData> aux_data = (from FileInfo file in files 
                                 select AFacade.LoadTemplate(file.FullName)
                                 ).ToList();
            //Filtro
            List<Tuple<string,List<IOFileCopyFolders>,string>>
                xdata = (from data in aux_data
                         group data by new
                         {
                             data.IOFileBaseDirectory,
                             IOFileCopyFolders = (from f in data.IOFileCopyFolders                                                                                                   
                                                 // where f.FolderDirection == FolderDirection.Output
                                                  select f).Distinct().ToList(),
                             data.IOFileNamePattern.Extension

                         } into g
                         select Tuple.Create(g.Key.IOFileBaseDirectory, g.Key.IOFileCopyFolders,g.Key.Extension)                    
                         ).Distinct().ToList();

            //Filtro
            List<Tuple<string, string, FolderDirection, bool,string,bool>> ydata = new List<Tuple<string, string, FolderDirection, bool,string,bool>>();
            foreach (Tuple<string, List<IOFileCopyFolders>,string> obj in xdata) {
                foreach (IOFileCopyFolders item in obj.Item2)
                {
                    ydata.Add(new Tuple<string, string,FolderDirection, bool,string,bool>(
                           obj.Item1,item.FolderName,item.FolderDirection,item.MainFolder,obj.Item3,item.CompressedFiles)
                           );
                }
            }
                    
            //filtro de directorios historicos 
            var hist_output_folders = (from data in ydata 
                                       where data.Item4 == false
                                       where data.Item3 == FolderDirection.Output
                                       select data).Distinct().ToList();
            
            //filtro de directorios principales.
            var main_output_folders = (from data in ydata
                                        where data.Item4 == true
                                        where data.Item3 == FolderDirection.Output
                                        select data).Distinct().ToList();


            //directorio de alojamiento de interfaces generadas.
            string root = ctx.InterfaceRootFolder;
            string aux_folder = string.Empty;
            
            //patron inicial de busqueda de archivos.
            string root_pattern = "*" + date.ToString("yyyyMM") + "*" ;
            
            //patron de busqueda de archivos 
            string search_pattern = string.Empty;

            string ZipFileName = string.Empty;
            
            int aux_result = 0;
            


            #region Rutinas de compresion directorios de salida
	
            var directorios = hist_output_folders;
            if (comprimir_principales == true)
            {
                directorios = main_output_folders;
            }

            
            foreach (var item in directorios) {
                aux_folder = root + "\\" + item.Item1 + "\\" + item.Item2;
                DirectoryInfo dir = new DirectoryInfo(aux_folder);
                if (dir.Exists) {                    
                    //validacion de existencia previa de archivos acumulativos zip
                    search_pattern = "*" + date.ToString("yyyy_MM") + ".zip";
                    List<FileInfo> zipFiles = dir.GetFiles(search_pattern, SearchOption.TopDirectoryOnly).ToList();
                    
                    //Lista de archivos a comprimir.
                    List<string> ToZipFiles = new List<string>();

                    // validacion para plantillas con opcion de comprimir historicos //-> para ODS
                    if (item.Item6 == true)
                    {
                        string zip_pattern = string.Empty;
                        search_pattern = root_pattern + (item.Item5.StartsWith(".") == true ? item.Item5 : "." + item.Item5);
                        zip_pattern = search_pattern + ".zip";
                                                                                               
                        ToZipFiles = dir.GetFiles(search_pattern, SearchOption.TopDirectoryOnly).ToList().Select(f => f.FullName).ToList();
                        ToZipFiles.AddRange(dir.GetFiles(zip_pattern, SearchOption.TopDirectoryOnly).ToList().Select(f => f.FullName).ToList());                                                
                    }
                    else {
                        search_pattern = root_pattern + (item.Item5.StartsWith(".") == true ? item.Item5 : "." + item.Item5);
                        ToZipFiles = dir.GetFiles(search_pattern, SearchOption.TopDirectoryOnly).ToList().Select(f => f.FullName).ToList();
                    }
                    //patron de respaldo zip
                    ZipFileName = aux_folder + "\\BACKUP_" + item.Item1.Replace("\\", " ").Trim() + "_" + date.ToString("yyyy_MM") + ".zip";                                        
                    
                    if (zipFiles.Count != 0)
                    {
                        //tratamiento para archivos ya comprimidos.                    
                        if (ToZipFiles.Count > 0) {
                            if (ZipHelper.AddToZipFile(ToZipFiles, ZipFileName, System.IO.Packaging.CompressionOption.Maximum, true))
                            {                             
                                aux_result++;
                            }                            
                        }
                    }
                    else {                    
                        if (ToZipFiles.Count > 0)
                        {
                            //comprimir
                            if (ZipHelper.ZipFile(ToZipFiles, ZipFileName, System.IO.Packaging.CompressionOption.Maximum, true))
                            {                               
                                aux_result++;   
                            }
                        }
                    }
                }//if directory exists.
            }//foreach 
	       
            #endregion
             
            if (aux_result > 1)
            {
                error = "Proceso de limpieza completado";
            }
            else {
                error = "Proceso completado parcialmente.";
            }

            
            return true;            
        }
        
        /// <summary>
        /// Modo mantencion, comprime los archivos de log
        /// </summary>
        /// <param name="ctx"></param>
        /// <param name="date"></param>
        /// <param name="error"></param>
        /// <returns></returns>
        private bool MaintenanceMode_Log(wsReportContext ctx,DateTime date,ref string error) {

            #region Compresion de Archivos de Log

            string ZipFileName = string.Empty;
            string search_pattern = string.Empty;
            int aux_result = 0;
            DirectoryInfo logFolder = new DirectoryInfo(ctx.LogFolder);
            if (!logFolder.Exists)
            {
               error = "No se puede encontrar el directorio: "+ ctx.LogFolder;
               return false;
            }   
                
            ZipFileName = logFolder.FullName + "\\BACKUP_LOGS_" + date.ToString("yyyy_MM") + ".zip";

            search_pattern = "*" + date.ToString("yyyy_MM") + "*.zip";
            List<string> zip_log_files = logFolder.GetFiles(search_pattern).Select(z => z.FullName).ToList();

            search_pattern = date.ToString("yyyyMM") + "*.log.txt";
            List<string> log_files = logFolder.GetFiles(search_pattern).Select(z => z.FullName).ToList();
            
            //removemos el archivo de log actual.
            if (log_files.Contains(ctx.LogContext.LogFileName.Replace("\\\\","\\")))
            {
                log_files.Remove(ctx.LogContext.LogFileName.Replace("\\\\","\\"));
            }


            string file_errors = string.Empty;

            #region SECCION NO IMPLEMENTADA PARA CONTROL DE ACCESO PARA ARCHIVOS CON PROBLEMAS

            //Seccion para control de acceso para archivos con problemas.             
            //FileSecurity templateSecurity = File.GetAccessControl(ctx.LogContext.LogFileName);
            //FileSecurity newFS = new FileSecurity();
            //byte[] securityDescriptor = templateSecurity.GetSecurityDescriptorBinaryForm();
            //newFS.SetSecurityDescriptorBinaryForm(securityDescriptor);
            //
            //////string userName = System.Security.Principal.WindowsIdentity.GetCurrent().Name; --> CUENTA DE USUARIO / APP POOL
            //////FileSystemAccessRule newAccessRule = new FileSystemAccessRule(userName, FileSystemRights.FullControl, AccessControlType.Allow);
            //////newFS.AddAccessRule(newAccessRule);
            //
            //foreach (string f in log_files)
            //{
            //    try
            //    {
            //        FileInfo file = new FileInfo(f);
            //        if (file.Exists)
            //        {
            //            File.SetAccessControl(f,newFS);                                                                                
            //        }
            //    }
            //    catch (Exception ex)
            //    {
            //        //file_errors += LogHelper.FormatException(ex, false) + "\r\n";
            //        file_errors += f + "|";
            //        continue;
            //    }
            //}
            
            #endregion
            
            //verificamos la existencia de archivos de log comprido para:
            //1.- añadir a un respaldo anterior o incompleto
            //2.- para generar un respaldo nuevo.
            if (zip_log_files.Count > 0)
            {               
                if (log_files.Count > 0)
                {
                    if (ZipHelper.AddToZipFile(log_files, ZipFileName, System.IO.Packaging.CompressionOption.Maximum, false)){aux_result++;}
                }
            }
            else
            {
                if (log_files.Count > 0)
                {
                    if (ZipHelper.ZipFile(log_files, ZipFileName, System.IO.Packaging.CompressionOption.Maximum, false)){aux_result++;}
                }
            }

            //tratar de eliminar los archivos de Log
            foreach (string f in log_files) {
                try
                {
                    if (File.Exists(f)) {
                        File.Delete(f);
                    }                    
                }
                catch (Exception)
                {                    
                    file_errors += f +"|";
                    continue;
                }
            }
                                   
            if (aux_result > 1){
                error = "Proceso de limpieza completado"; 
            }else { 
                error = "Proceso completado parcialmente.";
            }

            if (file_errors != string.Empty)
            {
                error = file_errors.Substring(0, file_errors.Length - 1);
                
            }

            return true;
            #endregion
        }

        /// <summary>Escribe en log de aplicacion el status de los dataset, para revision.</summary>
        /// <param name="ds">DataSet a Revisar</param>
        /// <param name="TData">Datos de Plantilla</param>
        /// <param name="TReport">Tipo de Reporte</param>
        /// <param name="TModule">Modulo de Reporte</param>
        /// <param name="Method">Metodo en el cual se esta revisando la data.</param>
        private void LogDataDebug(DataSet ds, TemplateData TData, ReportType TReport, ModuleType TModule, string Method)
        {
            LogHelper.WriteLog(this.context, Log_Line + Log_Line);
            string head = "Revision de Conjunto de Datos: Function/Method: {0}, Template: {1}, Reporte {2}, Modulo('{3}'):{4}";            
            head = string.Format(head, Method, TData.TemplateName, TReport.desc_reporte, TModule.modulo, TModule.desc_modulo);
            LogHelper.WriteLog(this.context, head, 0000, LevelInfo.DebugMode);

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                LogHelper.WriteLog(this.context, "ds!=null|ds.Tables.count>0|ds.tables[0].rows.count>0", 0000, LevelInfo.DebugMode);
            }
            else if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count == 0)
            {
                LogHelper.WriteLog(this.context, "ds!=null|ds.Tables.count>0|ds.tables[0].rows.count>0", 0000, LevelInfo.DebugMode);
            }
            else
            {
                if (ds == null)
                {
                    LogHelper.WriteLog(this.context, "ds==null", 0000, LevelInfo.DebugMode);
                }
                if (ds.Tables.Count == 0)
                {
                    LogHelper.WriteLog(this.context, "ds.Tables.Count==0", 0000, LevelInfo.DebugMode);
                }
            }
            LogHelper.WriteLog(this.context, Log_Line + Log_Line);
        }

    }
}