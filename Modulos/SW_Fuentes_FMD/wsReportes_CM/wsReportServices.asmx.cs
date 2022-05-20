using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web.Services;
using CoreBusinessObjects.BLayer;
using CoreBusinessObjects.Collections;
using CoreBusinessObjects.Common;
using CoreBusinessObjects.DTO;
using CoreLib.Common;
using CoreLib.Helpers;
using WebServiceFMD.Common;
using WebServiceFMD.Common.DAO;
using WebServiceFMD.Common.DTO;

namespace WebServiceFMD
{
    /// <summary>
    /// Servicios de Reporteria.
    /// </summary>
    [WebService(Namespace = "http://fmdsfmc.corpbanca.cl/fmd")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio Web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
    [System.Web.Script.Services.ScriptService]
    public partial class wsReportServices : System.Web.Services.WebService
    {
        
        #region Public Services & WebMethods

        /// <summary>
        /// Boxing para generacion de reportes
        /// </summary>
        /// <param name="process">Tipo de proceso Input/Output</param>
        /// <param name="reportType">Tipo de reporte a generar</param>
        /// <param name="modulo">Modulo o producto del cual se va a generar el Input/Ouput</param>
        /// <param name="date">Fecha de proceso para la obtencion de datos.</param>
        /// <param name="withMergeFiles">Indica si se mesclaran los archivos</param>
        /// <returns>String con resultado de operacion.</returns>
        [WebMethod]
        public List<string> GenerateAndSendReports(ProcessType process, string reportType, string modulo, string date = null, bool withMergeFiles = false)
        {
            try
            {
                List<string> result = new List<string>();
                ProcesoAutomatico = false;
                
                if (!string.IsNullOrEmpty(date))
                {
                    this.ParametroFecha = date;
                }


                #region hack para log de falla de conexion a bd
                string log_filename = string.Format(this.context.LogContext.LogFileName, DateTime.Now.ToString("yyyyMMdd_HHmmss"), Convert.ToString(process));
                this.context.LogContext.LogFileName = log_filename;

                if (!CheckConnectionDB(this.context))
                {
                    result.Add("No se puede conectar a la BD, consulte el log para mas informacion: " + log_filename);
                    return result;
                };

                this.ReportTypes = ReportTypeDao.GetReportTypeCollection(this.context.DBContext);
                this.ModuleTypes = ModuleTypeDao.GetModuleTypeCollection(this.context.DBContext);
                #endregion

               
                ModuleType moduletype = ModuleTypes[modulo];
                if (moduletype == null)
                {
                    LogHelper.WriteLog(this.context, Const.MSG_PRODUCTTYPE_NOTFOUND + ": " + modulo, 1004, LevelInfo.EngineError);
                    result.Add(Const.MSG_PRODUCTTYPE_NOTFOUND);
                    return result;
                }

                ReportType type = ReportTypes[reportType];
                if (type == null)
                {
                    LogHelper.WriteLog(this.context, Const.MSG_REPORTTYPE_NOTFOUND + ": " + reportType, 1005, LevelInfo.EngineError);
                    result.Add(Const.MSG_REPORTTYPE_NOTFOUND);
                    return result;
                }



                DateTime date_process = this.ProcessDate(moduletype, date);

                List<string> resultFiles = new List<string>();
                if (type != null)
                {
                    switch (type.desc_reporte)
                    {
                        case "RCM":
                            string rcm_result = RCM_Reports(process, type, moduletype, date_process, withMergeFiles, out resultFiles);
                            if (resultFiles.Count == 0)
                            {
                                resultFiles.Add(rcm_result);
                            }
                            result.AddRange(resultFiles);
                            return result;
                        case "STK":
                            string stk_result = STOCK_Reports(process, type, moduletype, date_process, out resultFiles);
                            if (resultFiles.Count == 0)
                            {
                                resultFiles.Add(stk_result);
                            }
                            result.AddRange(resultFiles);
                            return result;
                        default:
                            result.Add(Export_Report(process, type, moduletype, date_process));
                            return result;
                    }
                }
                else
                {
                    LogHelper.WriteLog(this.context, Const.MSG_NOTVALID_OPERATION + ": " + reportType, 1006, LevelInfo.EngineError);
                    result.Add(Const.MSG_NOTVALID_OPERATION);
                    return result;
                }
            }
            catch (Exception e)
            {
                LogHelper.WriteLog(this.context, e, 1007, LevelInfo.EngineError);
                throw;
            }
        }


        /// <summary>
        /// Generacion automatica de reportes para casa matriz
        /// </summary>
        /// <param name="process">Tipo de proceso Input/Output</param>
        /// <param name="reportType">Tipo de reporte a generar</param>
        /// <param name="date">Fecha de proceso para la obtencion de datos.</param>
        /// <returns>List de string con mensajes generados por los sub-procesos.</returns>    
        [WebMethod]
        public List<string> Automated_RCM_SendReports(ProcessType process, string reportType, string date = null)
        {
            List<string> result = new List<string>();

            #region patch para limpieza de directorio DOWNLOAD
            CleanTemporaryFiles(this.context);
            #endregion


            #region hack para enviar con fecha o tomar fecha de proceso
            if (!string.IsNullOrEmpty(date))
            {
                this.ParametroFecha = date;
            }
            #endregion

            #region hack para log de falla de conexion a bd
            /* hack para log de falla de conexion a bd */
            string log_filename = string.Format(this.context.LogContext.LogFileName, DateTime.Now.ToString("yyyyMMdd_HHmmss"), "auto_" + Convert.ToString(process));
            this.context.LogContext.LogFileName = log_filename;

            if (!CheckConnectionDB(this.context))
            {
                result.Add("No se puede conectar a la BD, consulte el log para mas informacion: " + log_filename);
                return result;
            };
            this.ReportTypes = ReportTypeDao.GetReportTypeCollection(this.context.DBContext);
            this.ModuleTypes = ModuleTypeDao.GetModuleTypeCollection(this.context.DBContext);
            /* hack para log de falla de conexion a bd */

            #endregion

            DateTime date_process;
            ProcesoAutomatico = true;

            ReportType TReport = ReportTypes[reportType];

            if (TReport == null)
            {
                result.Add(Const.MSG_REPORTTYPE_NOTFOUND);
                LogHelper.WriteLog(this.context, Const.MSG_REPORTTYPE_NOTFOUND + " " + reportType, 1005, LevelInfo.EngineError);
                return result;
            }

            PrintLogHeader(process, TReport, null, DateTime.Now, true);

            try
            {
                List<ModuleType> lst_TModules = new List<ModuleType>();
                List<string> prev_result;

                LogHelper.WriteLog(this.context, "Discriminando por Tipo de Reporte: " + TReport.desc_reporte, 1006, LevelInfo.Informative);

                string error = string.Empty;
                ModuleType modulo = ModuleTypes["BFW"];

                switch (TReport.desc_reporte)
                {
                    case "MANTENCION":
                        LogHelper.WriteLog(this.context, "Modo Mantencion", 0000, LevelInfo.Informative);
                        date_process = this.ProcessDate(modulo, date);
                        MaintenanceMode(this.context, date_process, ref error);
                        result.Add(error);
                        break;
                    case "MANTENCION-LOG":
                        LogHelper.WriteLog(this.context, "Modo Mantencion-LOG", 0000, LevelInfo.Informative);
                        date_process = this.ProcessDate(modulo, date);
                        MaintenanceMode_Log(this.context, date_process, ref error);

                        if (error.Contains('|') == true)
                        {
                            result.AddRange(error.Split(new char[] { '|' }));
                        }
                        else
                        {
                            result.Add(error);
                        }
                        break;
                    case "RCM":
                        LogHelper.WriteLog(this.context, "Procesando RCM", 1000, LevelInfo.Informative);
                        LogHelper.WriteLog(this.context, "Filtrando Modulos, " + process.ToString(), 1000, LevelInfo.Informative);
                        if (process == ProcessType.Input)
                        {
                            lst_TModules = (from ModuleType m in ModuleTypes
                                            where m.modulo == "DCE"
                                            where m.id_reporte == TReport.id_reporte
                                            //where m.active == true
                                            orderby m.id_modulo descending
                                            select m).ToList<ModuleType>();

                        }
                        else
                        {
                            lst_TModules = (from ModuleType m in ModuleTypes
                                            where m.modulo != "DCE"
                                            where m.id_reporte == TReport.id_reporte
                                            //where m.active == true
                                            orderby m.id_modulo descending
                                            select m).ToList<ModuleType>();
                        }

                        prev_result = new List<string>();
                        foreach (ModuleType TModule in lst_TModules)
                        {
                            date_process = this.ProcessDate(TModule, date);
                            //LogHelper.WriteLog(this.context, Log_Line);
                            LogHelper.WriteLog(this.context, "Llamando Modulo:" + TModule.modulo, 1000, LevelInfo.Informative);
                            string str = RCM_Reports(process, TReport, TModule, date_process, true, out prev_result);
                            if (prev_result.Count == 0)
                            {
                                prev_result.Add(str);
                            }
                            result.AddRange(prev_result);
                        }
                        break;
                    case "STK":
                        LogHelper.WriteLog(this.context, "Procesando STOCK", 1100, LevelInfo.Informative);
                        if (process == ProcessType.Input)
                        {
                            result.Add(Const.MSG_NOTVALID_OPERATION + " - Tipo Reporte: STOCK, " + process.ToString());
                            LogHelper.WriteLog(this.context, Const.MSG_NOTVALID_OPERATION + " - Tipo Reporte: STOCK, " + process.ToString(), 1101, LevelInfo.EngineError);
                        }
                        else
                        {
                            prev_result = new List<string>();

                            LogHelper.WriteLog(this.context, "Filtrando Modulos, " + process.ToString(), 1100, LevelInfo.Informative);
                            lst_TModules = (from ModuleType m in ModuleTypes
                                            where m.id_reporte == TReport.id_reporte
                                            //where m.active == true
                                            orderby m.id_modulo descending
                                            select m).ToList<ModuleType>();
                            foreach (ModuleType TModule in lst_TModules)
                            {
                                date_process = this.ProcessDate(TModule, date);
                                LogHelper.WriteLog(this.context, "LLamando Modulo:" + TModule.modulo, 1100, LevelInfo.Informative);
                                string str = STOCK_Reports(process, TReport, TModule, date_process, out prev_result);
                                if (prev_result.Count == 0)
                                {
                                    prev_result.Add(str);
                                }
                                result.AddRange(prev_result);

                            }
                        }
                        break;                                        
                    default:                    
                        LogHelper.WriteLog(this.context, "Procesando " + TReport.desc_reporte,TReport.error_coding, LevelInfo.Informative);
                        if (process == ProcessType.Input)
                        {
                            result.Add(Const.MSG_NOTVALID_OPERATION + " - Tipo Reporte:" + TReport.desc_reporte + "," + process.ToString());
                            LogHelper.WriteLog(this.context, Const.MSG_NOTVALID_OPERATION + " - Tipo Reporte: " + TReport.desc_reporte +","
                                + process.ToString(), TReport.error_coding + 1 , LevelInfo.EngineError);
                        }
                        else
                        {
                            LogHelper.WriteLog(this.context, "Filtrando Modulos, " + process.ToString(), 2000, LevelInfo.Informative);

                            lst_TModules = (from ModuleType m in ModuleTypes
                                            where m.id_reporte == TReport.id_reporte
                                            //where m.active == true
                                            orderby m.id_modulo descending
                                            select m).ToList<ModuleType>();

                            foreach (ModuleType TModule in lst_TModules)
                            {
                                date_process = this.ProcessDate(TModule, date);
                                //LogHelper.WriteLog(this.context, Log_Line);
                                LogHelper.WriteLog(this.context, "LLamando Modulo:" + TModule.modulo, 2000, LevelInfo.Informative);
                                string str = ODS_Reports(process, TReport, TModule, date_process);
                                result.Add(str);
                            }
                        }
                        break;
                }
                LogHelper.WriteLog(this.context, "Finalizando proceso automatico...", 0, LevelInfo.Informative);                
                return result;
            }
            catch (Exception ex)
            {
                LogHelper.WriteLog(this.context, ex, 1007, LevelInfo.EngineError);
                result.Add(LogHelper.FormatException(ex, this.context.LogContext.FriendlyLog));
                return result;
            }
        }


        #endregion

        #region RCM


        /// <summary>
        /// Genera los reportes para casa Matriz
        /// </summary>
        /// <param name="process">Tipo de proceso (Input/Output)</param>
        /// <param name="TReport">Tipo de reporte a generar (solo ODS)</param>
        /// <param name="TModule">Tipo de modulo a generar (SWAP, FWD, NDF, CSS, etc)</param>
        /// <param name="date">Fecha de proceso para obtencion de datos para exportacion</param>
        /// <param name="withMergeFiles"> indica si se hace mix de archivos  </param>
        /// <param name="FileNames"> Listado de nombres generados     </param>
        /// <returns></returns>
        public string RCM_Reports(ProcessType process, ReportType TReport, ModuleType TModule, DateTime date, bool withMergeFiles, out List<string> FileNames)
        {
            FileNames = new List<string>();
            if (TReport.desc_reporte != "RCM")
            {
                return Const.MSG_NOTVALID_OPERATION;
            }

            if (ProcesoAutomatico != true)
            {
                PrintLogHeader(process, TReport, TModule, date);
            }


            TemplateDataCollection<TemplateData> TDataCollection = LoadTemplates(LoadFileTemplates(TReport), process, true);
            if (TDataCollection.Count == 0)
            {
                LogHelper.WriteLog(this.context, Const.MSG_FAILURE_OPERATION + "," + Const.MSG_TEMPLATE_FILESNOTFOUND, 2001, LevelInfo.EngineError);
                return Const.MSG_FAILURE_OPERATION + ", " + Const.MSG_TEMPLATE_FILESNOTFOUND;
            }

            if (TDataCollection.Count > 0)
            {

                foreach (TemplateData TData in TDataCollection)
                {
                    if (TData.DataBindingName == TModule.modulo)
                    {
                        DataSet ds = new DataSet();
                        string newFileName = string.Empty;
                        AppContext ctx = new AppContext();
                        ctx.DBContext = this.context.DBContextCollection[TData.DBCatalog];
                        int seed = 0;
                        string pattern = string.Empty;

                        switch (process)
                        {
                            case ProcessType.Input:
                                #region Importacion de Archivos
                                List<FileInfo> files = new List<FileInfo>();
                                IOFileNamePattern fPattern = TData.IOFileNamePattern;
                                pattern = fPattern.Prefix + "*" + date.ToString(fPattern.Pattern) + "*" + fPattern.Extension;

                                LogHelper.WriteLog(this.context, "Trayendo Archivos.", 3000, LevelInfo.Informative);


                                #region MultiRuta
                                if (TData.useAppFolders == false && TData.IOFileCopyFolders.Count > 0)
                                {
                                    string root = this.context.InterfaceRootFolder + "\\" + TData.IOFileBaseDirectory + "\\";

                                    foreach (IOFileCopyFolders folder in TData.IOFileCopyFolders)
                                    {
                                        if (folder.FolderDirection == FolderDirection.Input)
                                        {
                                            folder.FolderName = root + folder.FolderName;

                                            files.AddRange(LoadFileToImport(folder.FolderName, pattern));
                                        }
                                    }
                                }
                                else
                                {
                                    files = LoadFileToImport(TReport, this.context.UploadFolder, pattern);
                                }

                                #endregion

                                int counter = files.Count;
                                int aux = 0;

                                if (files.Count > 0)
                                {
                                    foreach (FileInfo f in files)
                                    {
                                        if (f.Exists == true)
                                        {
                                            LogHelper.WriteLog(this.context, "Procesando archivo: " + f.Name, 3001, LevelInfo.Informative);
                                            try
                                            {
                                                if (ExcelFacadeBL.ImportData(ctx, TData, f.FullName, out ds, true))
                                                {
                                                    LogHelper.WriteLog(this.context, "resultado: ImportData(True) " + f.Name, 3002, LevelInfo.Informative);
                                                    aux++;

                                                    /* Copiarsh al histerico */

                                                    string fname = f.FullName;
                                                    CopyOutputFiles(TData, ref fname);


                                                }
                                                else
                                                {
                                                    LogHelper.WriteLog(this.context, "resultado: ImportData(False) " + f.Name, 3003, LevelInfo.Error);
                                                };
                                            }
                                            catch (Exception e)
                                            {
                                                LogHelper.WriteLog(this.context, "Error:" +
                                                    LogHelper.FormatException(e, this.context.LogContext.FriendlyLog), 3004, LevelInfo.EngineError);
                                                return LogHelper.FormatException(e, this.context.LogContext.FriendlyLog);
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    LogHelper.WriteLog(this.context, Const.MSG_PROCESS_FILESNOTFOUND, 3005, LevelInfo.Error);
                                    //LogHelper.WriteLog(this.context, Log_Line);
                                    return Const.MSG_PROCESS_FILESNOTFOUND;
                                }
                                LogHelper.WriteLog(this.context, " Fin de proceso de importacion.", 3006, LevelInfo.Informative);

                                if (counter == aux)
                                {
                                    List<string> result = new List<string>();
                                    LogHelper.WriteLog(this.context, "Revision de Errores:", 3007, LevelInfo.Informative); ;
                                    foreach (ExcelInfo eInfo in TData.ListExcelInfo)
                                    {
                                        string tb_empty_pattern = eInfo.ExcelSheetName.Replace(" ", "_") + "_EMPTY";
                                        string tb_error_pattern = eInfo.ExcelSheetName.Replace(" ", "_") + "_ERRORES";
                                        string sb = string.Empty;
                                        DataTable tb;

                                        if (ds.Tables.Contains(tb_empty_pattern))
                                        {
                                            tb = ds.Tables[tb_empty_pattern];

                                            var lst = tb.AsEnumerable()
                                                .Select(r => r.Table.Columns.Cast<DataColumn>()
                                                    .Select(c => new KeyValuePair<string, string>(c.ColumnName, r[c.Ordinal].ToString()))
                                                    .ToDictionary(z => z.Key, z => z.Value)).ToList();

                                            foreach (Dictionary<string, string> item in lst)
                                            {
                                                sb = JSONHelper.JavaScript_Serialize(item);
                                                result.Add(sb);
                                            }
                                        }
                                        if (ds.Tables.Contains(tb_error_pattern))
                                        {
                                            tb = ds.Tables[tb_error_pattern];
                                            var lst = tb.AsEnumerable()
                                                .Select(r => r.Table.Columns.Cast<DataColumn>()
                                                    .Select(c => new KeyValuePair<string, object>(c.ColumnName, r[c.Ordinal]))
                                                    .ToDictionary(z => z.Key, z => z.Value)).ToList();
                                            foreach (Dictionary<string, object> item in lst)
                                            {
                                                sb = JSONHelper.JavaScript_Serialize(item);
                                                result.Add(sb);
                                            }
                                        }
                                    }

                                    if (result.Count > 0)
                                    {
                                        LogHelper.WriteLog(this.context, "Lista de archivos procesados:", 3008, LevelInfo.Informative);
                                        foreach (FileInfo f in files)
                                        {
                                            LogHelper.WriteLog(this.context, f.FullName, 3008, LevelInfo.Informative);
                                        }
                                        //LogHelper.WriteLog(this.context, Log_Line);
                                        LogHelper.WriteLog(this.context, "Errores y Filas con falla de datos:", 3009, LevelInfo.Informative);
                                        LogHelper.WriteLog(this.context, "<JSON Object>");
                                        foreach (string str in result)
                                        {
                                            LogHelper.WriteLog(this.context, str, 3009, LevelInfo.Error);
                                        }
                                        LogHelper.WriteLog(this.context, "</JSON Object>");
                                        //LogHelper.WriteLog(this.context, Log_Line);
                                        LogHelper.WriteLog(this.context, Const.MSG_SUCCESS_OPERATION, 3010, LevelInfo.Informative);
                                        return Const.MSG_SUCCESS_OPERATION;
                                    }
                                }

                                #endregion
                                break;
                            case ProcessType.Output:
                                #region  Salida de archivos

                                #region Ejecucion Store Procedure
                                string error = string.Empty;

                                #region hack para tomar fecha o tomar fecha proceso
                                if (!string.IsNullOrEmpty(this.ParametroFecha))
                                {
                                    ExecOutputTemplateStoreProcedure(TData, date, out ds, ref error);
                                }
                                else
                                {
                                    ExecOutputTemplateStoreProcedure(TData, out ds, ref error);
                                }
                                #endregion

                                if (!string.IsNullOrEmpty(error))
                                {
                                    return error;
                                }
                                #endregion

                                if (withMergeFiles == true)
                                {
                                    MergeFiles(TData, TReport, TModule, date, withMergeFiles, ref ds);
                                }

                                //LogHelper.WriteLog(this.context, Log_Line);
                                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                                {
                                    if (this.context.AllowPaging == true)
                                    {
                                        LogHelper.WriteLog(this.context, "Exportando datos a:", 7000, LevelInfo.Informative);
                                        string str = string.Empty;

                                        /* hack para no poner rutas en duro en las plantillas. */
                                        TData.IOFileName = this.context.TemplateFolder + "\\" + TReport.desc_reporte + "\\" + TData.IOFileName;


                                        if (ExcelFacadeBL.ExportData(TData, ds, this.context.DownloadFolder, date, out FileNames))
                                        {
                                            /* Extension para copia en multiples directorios*/

                                            //si Tdata.useAppFolders == falso, indica que se deben mover/copiar los archivos a otros directorios
                                            if (TData.useAppFolders == false && TData.IOFileCopyFolders.Count > 0)
                                            {

                                                CopyOutputFiles(TData, ref FileNames);
                                                str = JSONHelper.Serialize(FileNames);
                                                //LogHelper.WriteLog(this.context, Log_Line);
                                                return str;
                                            }
                                            else
                                            {
                                                //aqui se usan los directorios de aplicacion normal.
                                                foreach (string file in FileNames)
                                                {
                                                    LogHelper.WriteLog(this.context, "Archivo:" + file, 7001, LevelInfo.Informative);
                                                }
                                                str = JSONHelper.Serialize(FileNames);
                                            }
                                            //LogHelper.WriteLog(this.context, Log_Line);
                                            return str;
                                        }
                                    }
                                    else
                                    {
                                        #region Generacion de nombre de archivo
                                        if (process == ProcessType.Output)
                                        {
                                            if (TData.IOFileNamePattern.useDatePattern == true)
                                            {
                                                newFileName = this.NewFileName(TData, date);
                                            }
                                            else
                                            {
                                                seed = LoadFolios(TReport, TModule);
                                                newFileName = this.NewFileName(TData, seed);
                                            }
                                        }
                                        #endregion

                                        LogHelper.WriteLog(this.context, "Exportando datos a: " + newFileName, 7002, LevelInfo.Informative);
                                        if (ExcelFacadeBL.ExportData(TData, ds, ref newFileName))
                                        {
                                            LogHelper.WriteLog(this.context, "Resultado: ExportData(True)", 7003, LevelInfo.Informative);
                                            if (TData.IOFileNamePattern.useNumericPattern == true)
                                            {
                                                UpdateFolios(TReport, TModule, newFileName, seed);
                                            }
                                            LogHelper.WriteLog(this.context, "Proceso finalizado..:", 7004, LevelInfo.Informative);
                                            //LogHelper.WriteLog(this.context, Log_Line);
                                            return newFileName;
                                        };
                                    }
                                }
                                else
                                {
                                    LogHelper.WriteLog(this.context, "Resultado Proceso:" + Const.MSG_DATANOTFOUND + "(" + TModule.desc_modulo + ")", 7005, LevelInfo.Error);
                                    return Const.MSG_DATANOTFOUND + "(" + TModule.desc_modulo + ")";
                                }
                                #endregion
                                break;
                        }

                    } // fin DataBindingName == modulo

                } //end foreach
            }

            return Const.MSG_SUCCESS_OPERATION;
        }

        /// <summary>
        /// Genera reportes de Stock para casa Matriz
        /// </summary>
        /// <param name="process">Tipo de proceso (Input/Output)</param>
        /// <param name="TReport">Tipo de reporte a generar (solo ODS)</param>
        /// <param name="TModule">Tipo de modulo a generar (SWAP, FWD, NDF, CSS, etc)</param>
        /// <param name="date">Fecha de proceso para obtencion de datos para exportacion</param>
        /// <param name="FileNames"> Listado de nombres generados     </param>
        /// <returns></returns>
        private string STOCK_Reports(ProcessType process, ReportType TReport, ModuleType TModule, DateTime date, out List<string> FileNames)
        {
            FileNames = new List<string>();

            if (ProcesoAutomatico != true)
            {
                PrintLogHeader(process, TReport, TModule, date);
            }

            TemplateDataCollection<TemplateData> TDataCollection = LoadTemplates(LoadFileTemplates(TReport), process, true);
            if (TDataCollection.Count == 0)
            {
                LogHelper.WriteLog(this.context, Const.MSG_FAILURE_OPERATION + "," + Const.MSG_TEMPLATE_FILESNOTFOUND, 2001, LevelInfo.EngineError);
                return Const.MSG_FAILURE_OPERATION + ", " + Const.MSG_TEMPLATE_FILESNOTFOUND;
            }

            List<TemplateData> TDataList = (from TemplateData data in TDataCollection
                                            where data.DataBindingName == TModule.modulo
                                            select data).ToList<TemplateData>();



            if (TDataCollection.Count > 0)
            {
                foreach (TemplateData TData in TDataList)
                {
                    if (TData.DataBindingName == TModule.modulo)
                    {

                        string newFileName = string.Empty;
                        AppContext ctx = new AppContext();
                        ctx.DBContext = this.context.DBContextCollection[TData.DBCatalog];
                        int seed = LoadFolios(TReport, TModule);
                        DataSet ds;


                        switch (process)
                        {
                            case ProcessType.Input:
                                #region Importacion de datos
                                LogHelper.WriteLog(this.context, Const.MSG_NOTIMPLEMENTED, 3300, LevelInfo.EngineError);
                                return Const.MSG_NOTIMPLEMENTED;
                                #endregion
                            //break;
                            case ProcessType.Output:
                                #region Exportacion de datos

                                #region Generacion de Nombre de archivo para operacion output
                                LogHelper.WriteLog(this.context, "Generación de nombre de archivo...", 3301, LevelInfo.Informative);
                                /*hack para proceso */
                                string aux_IOFileBaseDirectory = TData.IOFileBaseDirectory;
                                TData.IOFileBaseDirectory = string.Empty;

                                if (process == ProcessType.Output)
                                {
                                    if (TData.IOFileNamePattern.useDatePattern == true)
                                    {
                                        newFileName = this.NewFileName(TData, date);
                                    }
                                    else
                                    {
                                        newFileName = this.NewFileName(TData, seed);
                                    }
                                }
                                /* hack para proceso*/
                                TData.IOFileBaseDirectory = aux_IOFileBaseDirectory;

                                #endregion

                                #region Ejecucion Store Procedure
                                string error = string.Empty;
                                #region hack para tomar fecha o tomar fecha proceso
                                if (!string.IsNullOrEmpty(this.ParametroFecha))
                                {
                                    ExecOutputTemplateStoreProcedure(TData, date, out ds, ref error);
                                }
                                else
                                {
                                    ExecOutputTemplateStoreProcedure(TData, out ds, ref error);
                                }
                                #endregion

                                if (!string.IsNullOrEmpty(error))
                                {
                                    return error;
                                }


                                #endregion

                                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                                {
                                    LogHelper.WriteLog(this.context, "Exportando datos a:" + newFileName, 3302, LevelInfo.Informative);

                                    TData.IOFileName = this.context.TemplateFolder + "\\" + TReport.desc_reporte + "\\" + TData.IOFileName;
                                    string str = string.Empty;

                                    if (ExcelFacadeBL.ExportData(TData, ds, this.context.DownloadFolder, date, out FileNames))
                                    {

                                        #region Copia en multi directorios
                                        CopyOutputFiles(TData, ref FileNames);
                                        str = JSONHelper.Serialize(FileNames);
                                        #endregion
                                        LogHelper.WriteLog(this.context, "Resultado: ExportData(True)", 3303, LevelInfo.Informative);
                                        LogHelper.WriteLog(this.context, "Proceso finalizado..:", 3304, LevelInfo.Informative);
                                        return str;
                                    }
                                    else
                                    {
                                        LogHelper.WriteLog(this.context, "Resultado: ExportData(False)", 3305, LevelInfo.Error);
                                        return "Resultado: ExportData(False)";
                                    }
                                }
                                else
                                {
                                    LogHelper.WriteLog(this.context, "Resultado Proceso:" + Const.MSG_DATANOTFOUND + "(" + TModule.desc_modulo + ")", 3306, LevelInfo.Error);
                                    return "Resultado Proceso:" + Const.MSG_DATANOTFOUND + "(" + TModule.desc_modulo + ", " + TData.TemplateName + ")";

                                }
                                #endregion
                        }

                    }//fin DataBindingName == Modulo
                }//fin foreach
            }//fin TCollection.Count>0

            return Const.MSG_SUCCESS_OPERATION;
        }
        #endregion

        #region Reprocesados

        /// <summary>
        /// Genera los datos para ODS
        /// </summary>
        /// <param name="process">Tipo de proceso (Input/Output)</param>
        /// <param name="TReport">Tipo de reporte a generar (solo ODS)</param>
        /// <param name="TModule">Tipo de modulo a generar (SWAP, FWD, NDF, CSS, etc)</param>
        /// <param name="date">Fecha de proceso para obtencion de datos para exportacion ODS</param>
        /// <returns>Cadena con resultado de operacion.</returns>
        public string ODS_Reports(ProcessType process, ReportType TReport, ModuleType TModule, DateTime date = new DateTime())
        {
            return Export_Report(process, TReport, TModule, date);
        }
        /// <summary>
        /// Genera los datos para ADM
        /// </summary>
        /// <param name="process">Tipo de proceso (Input/Output)</param>
        /// <param name="TReport">Tipo de reporte a generar (solo ODS)</param>
        /// <param name="TModule">Tipo de modulo a generar (SWAP, FWD, NDF, CSS, etc)</param>
        /// <param name="date">Fecha de proceso para obtencion de datos para exportacion ODS</param>
        /// <returns>Cadena con resultado de operacion.</returns>
        private string ADM_Reports(ProcessType process, ReportType TReport, ModuleType TModule, DateTime date)
        {
            return Export_Report(process, TReport, TModule, date);
        }
       
        
        /// <summary>
        /// Genera los datos para reportes RENTABILIDAD
        /// </summary>
        /// <param name="process">Tipo de proceso (Input/Output)</param>
        /// <param name="TReport">Tipo de reporte a generar (solo ODS)</param>
        /// <param name="TModule">Tipo de modulo a generar (SWAP, FWD, NDF, CSS, etc)</param>
        /// <param name="date">Fecha de proceso para obtencion de datos para exportacion ODS</param>
        /// <returns>Cadena con resultado de operacion.</returns>
        private string RNT_Reports(ProcessType process, ReportType TReport, ModuleType TModule, DateTime date)
        {
            return Export_Report(process, TReport, TModule, date);
        }
        
        #endregion
        
        /// <summary>
        /// Procesa la plantilla para la exportacion de datos.
        /// </summary>
        /// <param name="process">Tipo de proceso (Input/Output)</param>
        /// <param name="TReport">Tipo de reporte a generar (solo ODS)</param>
        /// <param name="TModule">Tipo de modulo a generar (SWAP, FWD, NDF, CSS, etc)</param>
        /// <param name="date">Fecha de proceso para obtencion de datos para exportacion</param>
        /// <returns>Cadena con resultado de operacion.</returns>
        private string Export_Report(ProcessType process, ReportType TReport, ModuleType TModule,
            DateTime date            
            )
        {
            if (process == ProcessType.Input) {
                LogHelper.WriteLog(this.context, Const.MSG_PROCESS_NOTSUPORTED, TReport.error_coding, LevelInfo.EngineError);
                return Const.MSG_PROCESS_NOTSUPORTED;                
            }


            //FileNames = new List<string>();

            //impresion de cabezera de log, cuando se invoca un modulo individual
            if (ProcesoAutomatico != true) { PrintLogHeader(process, TReport, TModule, date); }

            //Se cargan las plantillas disponibles en el sistema de archivo: ..\TEMPLATE\*.XML
            TemplateDataCollection<TemplateData> TDataCollection = LoadTemplates(LoadFileTemplates(TReport), process, true);

            //chequeo de total de plantillas
            if (TDataCollection.Count == 0)
            {
                LogHelper.WriteLog(this.context, Const.MSG_FAILURE_OPERATION + "," + Const.MSG_TEMPLATE_FILESNOTFOUND, 2001, LevelInfo.EngineError);
                return Const.MSG_FAILURE_OPERATION + ", " + Const.MSG_TEMPLATE_FILESNOTFOUND;
            }

            // filtro de plantilla segun modulo
            List<TemplateData> TDataList = (from TemplateData data in TDataCollection
                                            where data.DataBindingName == TModule.modulo
                                            select data).ToList<TemplateData>();
            //semilla para la codificacion de errores
            int ERROR_CODING = TReport.error_coding;

            if (TDataCollection.Count > 0)
            {
                foreach (TemplateData TData in TDataList)
                {
                    if (TData.DataBindingName == TModule.modulo)
                    {

                        string newFileName = string.Empty;
                        AppContext ctx = new AppContext();
                        ctx.DBContext = this.context.DBContextCollection[TData.DBCatalog];
                        int seed = LoadFolios(TReport, TModule);
                        DataSet ds = new DataSet();
                        //List<SqlCommand> cmdProcedures = new List<SqlCommand>();
                        List<Tuple<string, string, List<SqlParameter>>> cmdProcedures = new List<Tuple<string, string, List<SqlParameter>>>();

                        #region Generacion de Nombre Archivo

                        LogHelper.WriteLog(this.context, "Generación de nombre de archivo...", ERROR_CODING + 1, LevelInfo.Informative);
  
                        if (TData.IOFileNamePattern.useDatePattern == true)
                        {
                            newFileName = this.NewFileName(TData, date);
                        }
                        else
                        {
                            newFileName = this.NewFileName(TData, seed);
                        }
                        #endregion

                        #region Ejecucion Store Procedure
                        
                        string error = string.Empty;
                        switch (TModule.engine)
                        {
                            case Engine.PlainTextRaw:
                                PrepareTemplateStoreProcedureCommand(TData, out cmdProcedures, ref error);
                                break;
                            default:
                                if (!string.IsNullOrEmpty(this.ParametroFecha))
                                {
                                    ExecOutputTemplateStoreProcedure(TData, date, out ds, ref error);
                                }
                                else
                                {
                                    ExecOutputTemplateStoreProcedure(TData, out ds, ref error);
                                }
                                if (!string.IsNullOrEmpty(error))
                                {
                                    return error;
                                }
                                break;
                        }

                        #endregion
#if DEBUG == true
                        //chequeo de datos del DataSet
                        LogDataDebug(ds, TData, TReport, TModule, "Export_Report");
#endif

                        LogHelper.WriteLog(this.context, "Exportando datos a:" + newFileName, ERROR_CODING + 2, LevelInfo.Informative);
                        bool partialExport = false;

                        //validacion para motor PlainTextRaw
                        if (TModule.engine != Engine.PlainTextRaw) { 

                            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                            {
                                partialExport = false; //full export (datos y extructura)
                            }
                            else if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count == 0)
                            {
                                partialExport = true; // partial export (solo estructura, ya que no hay filas en los datasets)
                            }
                            else {
                                LogHelper.WriteLog(this.context, "Resultado Proceso:" + Const.MSG_DATANOTFOUND + "(" + TModule.desc_modulo + ")", ERROR_CODING + 6, LevelInfo.Error);
                                return "Resultado Proceso:" + Const.MSG_DATANOTFOUND + "(" + TModule.desc_modulo + ", " + TData.TemplateName + ")";
                            }
                        }



                        bool ExportStatus = false;
                        switch (TModule.engine)
                        {
                            case Engine.Excel:
                                //NO IMPLEMENTADO YA QUE LOS UNICOS REPORTES QUE UTIILZAN ESTE MOTOR ES RCM Y STOCK.
                                break;
                            case Engine.ExcelRaw:
                                if (partialExport == true)
                                {
                                    ExportStatus =
                                    ExcelExport.Export_DataSet(ds, new FileInfo(newFileName),
                                                ExportOptions.ExportStructure |
                                                ExportOptions.OverWriteFile);
                                }
                                else
                                {
                                    ExportStatus =
                                    ExcelExport.Export_DataSet(ds, new FileInfo(newFileName),
                                                    ExportOptions.IncludeTime |
                                                    ExportOptions.YMD_DateFormat |
                                                    ExportOptions.OverWriteFile);

                                }
                                break;
                            case Engine.PlainText:
                                ExportStatus = PlainTextFacade.ExportData(TData, ds, ref newFileName);
                                break;
                            case Engine.PlainTextRaw:
                                //TODO: AUTOMATIZAR PARA ESTE TIPO DE PROCESAMIENTO.
                                newFileName = this.context.InterfaceRootFolder + "\\" 
                                    + TData.IOFileBaseDirectory + "\\"  
                                    + TData.IOFileCopyFolders[0].FolderName + "\\"
                                    + TData.IOFileNamePattern.newFileName(date);
                                newFileName = newFileName.Replace("\\\\", "\\");
                                //ExportStatus = PlainTextFacade.ExportDataRaw(TData,ds,ref newFileName);
                                ExportStatus = PlainTextFacade.ExportDataRaw(this.context.DownloadFolder,TData,cmdProcedures, ref newFileName);
                                break;
                            case Engine.Xml:
                                ExportStatus = XmlFacadeBL.ExportData(TData, ds, ref newFileName);
                                break;
                        }

                        if (ExportStatus == true)
                        {
                            #region Copia en multi directorios
                            if (TModule.engine != Engine.PlainTextRaw) {
                                CopyOutputFiles(TData, ref newFileName);
                            }
                           
                            #endregion                                                        
                            if (partialExport == true)
                            {
                                LogHelper.WriteLog(this.context, "Resultado: ExportData(True)<SOLO ESTRUCTURA>",ERROR_CODING + 3, LevelInfo.Informative);
                            }
                            else {
                                LogHelper.WriteLog(this.context, "Resultado: ExportData(True)", ERROR_CODING + 3, LevelInfo.Informative);
                            }
                                                     
                            if (TData.IOFileNamePattern.useNumericPattern == true)
                            {
                                UpdateFolios(TReport, TModule, newFileName, seed);
                            }
                            LogHelper.WriteLog(this.context, "Proceso finalizado..:", ERROR_CODING + 4, LevelInfo.Informative);
                            return newFileName;
                        }
                        else {
                            LogHelper.WriteLog(this.context, "Resultado: ExportData(False)", ERROR_CODING +5, LevelInfo.Error);
                            return "Resultado: ExportData(False)";
                        }
                    }//TData.DataBindingName == TModule.modulo
                }//foreach TData in TDataList
            }//TDATACollection.Count>0
            return Const.MSG_SUCCESS_OPERATION;
        }
    }
}