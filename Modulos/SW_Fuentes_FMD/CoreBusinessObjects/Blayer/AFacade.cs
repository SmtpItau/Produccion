#pragma warning disable 1591
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;
using CoreBusinessObjects.Collections;
using CoreBusinessObjects.Common;
using CoreBusinessObjects.DTO;
using CoreLib.Common;
using CoreLib.Helpers;
using Const = CoreBusinessObjects.Common.Constants;

namespace CoreBusinessObjects.BLayer
{
    /// <summary>
    /// Clase abstracta de Fachada para heredar según tipo de implementacion Xml, Excel, etc.
    /// </summary>
    public abstract class AFacade
    {
        /// <summary>
        /// Default Constructor
        /// </summary>
        public AFacade() { }

        //public abstract bool ExportData(TemplateData TData, DataSet data, ref string newFileName); // { throw new NotImplementedException(); }
        //public abstract bool ImportData(AppContext ctx, TemplateData TData, string fileToImport, out DataSet ds, bool execStoreProc = false); //{ throw new NotImplementedException(); }

        /// <summary>
        /// Funcion de Exportacion para implementar por las clases heredadas
        /// </summary>
        /// <param name="TData">Objeto con informacion de plantilla</param>
        /// <param name="data">DataSet con la informacion a exportar</param>
        /// <param name="newFileName">Si la plantilla no indica generacion automagica de nombres, se debe incluir este.</param>
        /// <returns>true/false</returns>
        public bool ExportData(TemplateData TData, DataSet data, ref string newFileName) { throw new NotImplementedException(); }

        /// <summary>
        /// Funcion de Importacion para implementar por las clases heredadas
        /// </summary>
        /// <param name="ctx">Contexto de aplicacion</param>
        /// <param name="TData">Objeto con informacion de plantilla</param>
        /// <param name="fileToImport">Nombre de archivo a importar</param>
        /// <param name="ds">DataSet con la informacion importada, incluye errores y filas en blanco</param>
        /// <param name="execStoreProc">Indica si se debe ejecutar los StoreProcedure indicados en la plantilla.</param>
        /// <returns>True/False</returns>
        public bool ImportData(AppContext ctx, TemplateData TData, string fileToImport, out DataSet ds, bool execStoreProc = false) { throw new NotImplementedException(); }


        /// <summary>
        /// Retorna una lista de SqlParameters, con sus respectivos valores        
        /// Nota: el TemplateStoreProcsParams debe tener mapeado su property SourceColumn, con tal de \r\nrealizar un binding entre SorceColumn y ColumnName del DataRow.
        /// </summary>
        /// <param name="ParametersCollection">Objeto tipo TemplateStoreProcsParamsCollection</param>
        /// <param name="row">DataRow con valores para llenar en los parametros</param>
        /// <param name="checkValue">Indica si se checkean los valores de los parametros vs opcion isNullable==false</param>
        /// <returns>List&lt;SqlParameter&gt;</returns>
        /// <remarks>
        /// 
        /// </remarks>
        public static List<SqlParameter> ValidParameters(TemplateStoreProcParamsCollection<TemplateStoreProcParams> ParametersCollection,DataRow row,bool checkValue = true) {
            List<SqlParameter> _SqlParams = (from TemplateStoreProcParams p in ParametersCollection
                                             where
                                             p.Direction != ParameterDirection.Output
                                             && p.Direction != ParameterDirection.ReturnValue
                                             select p.sqlParameter()).ToList();

            int input_params = _SqlParams.Count;
            int aux_counter = 0;
            foreach (SqlParameter _params in _SqlParams)
            {               
                _params.Value = row[_params.SourceColumn];
                if (checkValue == true) {
                    if (_params.Value == DBNull.Value && _params.IsNullable == false)
                    {
                        aux_counter++;
                    }
                }                
            }

            if (aux_counter != 0)
            {
                return new List<SqlParameter>();
            }
            
            /* Asignacion de parametros de salida y retorno*/
            List<SqlParameter> outputParams = (from TemplateStoreProcParams p in ParametersCollection
                                               where
                                               p.Direction == ParameterDirection.Output ||
                                               p.Direction == ParameterDirection.ReturnValue
                                               select p.sqlParameter()).ToList();

            if (outputParams.Count > 0) {
                _SqlParams.AddRange(outputParams);
            }            
            return _SqlParams;            
        }


        
        /// <summary>
        /// Check para el datarow esta empty o no.
        /// </summary>
        /// <param name="row">DataRow para chequear</param>
        /// <param name="TData">Plantilla</param>
        /// <returns>true: is empty / false: not empty</returns>
        public static bool CheckEmptyRows(DataRow row, TemplateDataAddressCollection<TemplateDataAddress> TData=null)
        {
            if (row == null)
            {
                return true;
            }
            else
            {
                if (TData == null)
                {
                    foreach (var value in row.ItemArray)
                    {
                        if (!string.IsNullOrEmpty(value.ToString()))
                        {
                            return false;
                        }
                    }
                    return true;
                }else {

                    TemplateDataAddressCollection<TemplateDataAddress> NoValida = new Collections.TemplateDataAddressCollection<TemplateDataAddress>();
                    NoValida.AddRange(
                        (from TemplateDataAddress address in TData where address.CauseValidation == false select address).ToArray()
                        );

                    int blanks = 0;                                                      
                    foreach (TemplateDataAddress address in TData) {
                        if (row[address.ValueMember] == DBNull.Value && NoValida[address.ValueMember]==null) {
                            blanks++;
                        }
                    }

                    int validables = TData.Count - NoValida.Count;
                    if (blanks == validables)
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

        /// <summary>
        /// Ejecuta el store procedure indicado en la plantilla en calidad de salida de datos.
        /// </summary>
        /// <param name="ctx">Contexto de aplicacion</param>
        /// <param name="TData">Datos de la plantilla</param>
        /// <param name="ds">DataSet con los datos devueltos por el store procedure</param>
        /// <returns>DataSet, true/false</returns>
        public static bool ExecureOutputProcedure(AppContext ctx, TemplateData TData, out DataSet ds)
        {
            string msg = string.Empty;
            string sp_name = string.Empty;
            if (ctx == null)
            {
                throw new ArgumentNullException("AppContext", Const.MSG_PARAM_NOT_NULL);
            }

            if (ctx.DBContext == null)
            {
                throw new ArgumentNullException("DBContext", Const.MSG_PARAM_NOT_NULL);
            }

            DBContext db_context = ctx.DBContext;

            if (TData == null)
            {
                throw new ArgumentNullException("TData", Const.MSG_TDATA_NOT_NULL);
            }
            if (TData.IOFileDirection == DataDirection.Input)
            {
                throw new ArgumentException(Const.MSG_TDATA_INPUT, "TData.ExcelFileDirection");
            }

            if (TData.UseStoreProc == false && TData.ListQueryInfo.Count == 0)
            {
                throw new ArgumentException(Const.MSG_TDATA_MISSCONFIG, "TData");
            }

            if (TData.ListStoreProcsInfo.Count == 0)
            {
                throw new ArgumentException(Const.MSG_TDATA_STOREPROCS_NOT_NULL, "StoreProcsInfo");
            }

            try
            {
                ds = new DataSet();
                DataSet ds_result;
                if (TData.UseStoreProc)
                {
                    List<StoreProcsInfo> TDataStoreProcsInfo = (from StoreProcsInfo sp_info in TData.ListStoreProcsInfo
                                                                where sp_info.Direction == DataDirection.Output
                                                                select sp_info
                                                                    ).ToList();
                    if (TDataStoreProcsInfo.Count == 0)
                    {
                        throw new ArgumentException(Const.MSG_TDATA_MISSCONFIG, "TData.StoreProcsInfo.Direction");
                    }
                    int aux_counter = 0;
                    foreach (StoreProcsInfo sp_info in TDataStoreProcsInfo)
                    {
                        aux_counter++;
                        var checkParams = (from TemplateStoreProcParams p in sp_info.ListStoreProcParams
                                           where
                                           p.UseParameterValue == false
                                           select p.sqlParameter()).ToArray();
                        if (checkParams.Length > 0)
                        {
                            throw new ArgumentException(Const.MSG_TDATA_MISSCONFIG, "TData.StoreProcInfo.UseParameterValue");
                        }
                        checkParams = null;
                        List<SqlParameter> _SqlParams = (from TemplateStoreProcParams p in sp_info.ListStoreProcParams
                                                         select p.sqlParameter()).ToList();


                        if (sp_info.ConnectionTimeout > 0) {
                            db_context.ConnectionTimeout = sp_info.ConnectionTimeout;
                        }
                        
                        sp_name = sp_info.StoreProcName;

                        ds_result = SqlHelper.ExecuteDataset(db_context.StringConnection,
                        CommandType.StoredProcedure, sp_info.StoreProcName, _SqlParams.ToArray());
                        
                        
                        foreach (DataTable dt in ds_result.Tables)
                        {                        
                            DataTable destTable = dt.Clone();
                            destTable.TableName = sp_info.SheetName.Replace(" ", "_");
                            dt.AsEnumerable().ToList().ForEach(row => destTable.ImportRow(row));
                            ds.Tables.Add(destTable);
                        }

                        ds_result = null;
                        SqlConnection.ClearAllPools();
                    }//end foreach
                }
                else if (TData.ListQueryInfo.Count != 0)
                {
                    foreach (QueryInfo qry_info in TData.ListQueryInfo)
                    {
                        ds_result = SqlHelper.ExecuteDataset(db_context.StringConnection, CommandType.Text, qry_info.QueryString);
                        ds.Tables.AddRange(ds_result.Tables.Cast<DataTable>().ToArray());
                    }
                }
                else if (TData.ListQueryInfo.Count == 0)
                {
                    throw new ArgumentException(Const.MSG_TDATA_MISSCONFIG, "TData.StoreProcsInfo.Direction");
                }
                return true;
            }
            catch (Exception ex)
            {
                Exception e = new Exception("Error en: " + sp_name, ex);
                throw e;
            }
        }

        /// <summary>
        /// Ejecuta el store procedure indicado en la plantilla en calidad de entrada de datos.
        /// </summary>
        /// <param name="ctx">Contexto de aplicacion</param>
        /// <param name="TData">Plantilla</param>
        /// <param name="ds">Datos para ingresar</param>
        /// <param name="dt_errores">DataTable con errores de los procedimientos</param>
        /// <returns></returns>
        public static bool ExecuteInputProcedure(AppContext ctx, TemplateData TData, DataSet ds, out List<DataTable> dt_errores)
        {
            dt_errores = new List<DataTable>();

            string msg = string.Empty;
            if (ctx == null)
            {
                throw new ArgumentNullException("AppContext", Const.MSG_PARAM_NOT_NULL);
            }

            DBContext db_context = ctx.DBContext;
            if (TData == null)
            {
                throw new ArgumentNullException("TData", Const.MSG_TDATA_NOT_NULL);
            }

            if (TData.IOFileDirection == DataDirection.Output)
            {
                throw new ArgumentException(Const.MSG_TDATA_OUTPUT, "TData");
            }

            if (TData.ListStoreProcsInfo.Count == 0)
            {
                msg = string.Format(Const.MSG_TDATA_STOREPARAMS_NOT_NULL, " ");
                throw new ArgumentOutOfRangeException("StoreProcsInfo", msg);
            }

            //Enviamos los datos a SQL 1 a 1
            try
            {
                foreach (StoreProcsInfo sp_info in TData.ListStoreProcsInfo)
                {
                    DataTable dt_err = new DataTable(sp_info.SheetName.Normalize(NormalizationForm.FormKC).Replace(" ", "_") + "_ERRORES");
                    DataTable dt_empty = new DataTable(sp_info.SheetName.Normalize(NormalizationForm.FormKC).Replace(" ", "_") + "_EMPTY");
                    DataTable dt = ds.Tables[sp_info.SheetName.Normalize(NormalizationForm.FormKC).Replace(" ", "_")];
                    if (dt != null)
                    {

                        List<SqlParameter> _SqlParams;
                        DataRow r_row;
                        foreach (DataRow row in dt.Rows)
                        {
                             _SqlParams = AFacade.ValidParameters(sp_info.ListStoreProcParams, row,true);
                            
                            if (_SqlParams.Count > 0)
                            {
                                #region Proceso de Insercion
                                if (dt_err.Columns.Count == 0)
                                {
                                    var columns = (from SqlParameter p in _SqlParams
                                                   where p.Direction != ParameterDirection.Input
                                                   select new DataColumn
                                                   {
                                                       ColumnName = p.ParameterName
                                                   }).ToArray();
                                    dt_err.Columns.AddRange(columns);
                                    columns = null;
                                }


                                DataSet ds_result = SqlHelper.ExecuteDataset(db_context.StringConnection,
                                CommandType.StoredProcedure, sp_info.StoreProcName, _SqlParams.ToArray());
                                SqlConnection.ClearAllPools();

                                var result = (from SqlParameter p in _SqlParams
                                              where
                                              p.Direction != ParameterDirection.Input
                                              && p.Value != DBNull.Value
                                              && !string.IsNullOrEmpty(p.Value.ToString())
                                              select new {                                                  
                                                 p.Value
                                              }).ToArray();

                                if (result.Length != 0)
                                {
                                    r_row = dt_err.NewRow();
                                    r_row.ItemArray = result;
                                    if (!CheckEmptyRows(r_row))
                                    {
                                        dt_err.Rows.Add(result);
                                    }
                                }

                                result = null;
                                #endregion Proceso de Insercion
                            } else {
                                _SqlParams  = AFacade.ValidParameters(sp_info.ListStoreProcParams,row,false);

                                if (dt_empty.Columns.Count==0)
                                {
                                    var columns = (from SqlParameter p in _SqlParams
                                                   select new DataColumn
                                                   {
                                                       ColumnName = p.ParameterName
                                                   }).ToArray();
                                    dt_empty.Columns.AddRange(columns);
                                    columns = null; 
                                }

                                r_row = dt_empty.NewRow();
                                var result = (from SqlParameter p in _SqlParams
                                              select new {
                                                  p.Value
                                              }).ToArray();
                                r_row.ItemArray = result;
                                dt_empty.Rows.Add(r_row);
                                
                            }                            
                        }//foreach row in dt

                        if (dt_err.Rows.Count > 0) {
                            dt_errores.Add(dt_err);
                        }
                        if (dt_empty.Rows.Count > 0) {
                            dt_errores.Add(dt_empty);
                        }                        
                    }
                }//foreach sp_info in storeprocs info
            }
            catch (Exception)
            {
                throw;
            }
            return true;
        }

        /// <summary>
        /// Carga un archivo sql en memoria
        /// </summary>
        /// <param name="fileName">Nombre del archivo a cargar</param>
        /// <returns>String</returns>
        public static string LoadQuery(string fileName)
        {
            if (string.IsNullOrEmpty(fileName))
            {
                throw new ArgumentException(Const.MSG_FILE_EMPTYNAME, "fileName");
            }

            string msg = string.Empty;
            FileInfo file = new FileInfo(fileName);
            StreamReader reader = null;
            StringBuilder sb = null;
            if (!file.Exists)
            {
                msg = string.Format(Const.MSG_FILE_NOTFOUND, file.FullName);
                throw new FileNotFoundException(msg);
            }
            else
            {
                reader = new StreamReader(file.FullName, Encoding.Default, true);
                sb = new StringBuilder();
                string line = string.Empty;
                while (reader.Peek() > 0)
                {
                    line = reader.ReadLine();
                    if (line != null)
                    {
                        sb.AppendLine(line);
                    }
                }
                reader.Close();
            }
            if (reader == null) { return string.Empty; }
            return sb.ToString();
        }

        /// <summary>
        /// Carga un archivo de plantilla y devuelve un objeto TemplataData.
        /// </summary>
        /// <param name="fileName">Nombre del archivo de plantilla</param>
        /// <returns>TemplateData object</returns>
        public static TemplateData LoadTemplate(string fileName)
        {
            if (string.IsNullOrEmpty(fileName) || string.IsNullOrWhiteSpace(fileName))
            {
                throw new ArgumentException(Const.MSG_FILE_EMPTYNAME, "fileName");
            }

            string msg = string.Empty;
            FileInfo file = new FileInfo(fileName);
            TemplateData TData = null;

            if (file.Extension != ".xml")
            {
                msg = string.Format(Const.MSG_FILE_EXTENSION, ".xml");
                throw new ArgumentOutOfRangeException("fileName", msg);
            }
            if (!file.Exists)
            {
                msg = string.Format(Const.MSG_FILE_NOTFOUND, file.FullName);
                throw new FileNotFoundException(msg);
            }
            else
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file.FullName);
                TData = TemplateData.FromXML(doc);
            }
            return TData;
        }

        /// <summary>
        /// Guarda el objeto plantilla en un nuevo archivo .xml
        /// </summary>
        /// <param name="fileName">nombre del archivo a guardar</param>
        /// <param name="TData">Objeto TemplateData a guardar</param>
        /// <returns>True/False</returns>
        public static bool SaveTemplate(string fileName, TemplateData TData)
        {
            if (string.IsNullOrEmpty(fileName) || string.IsNullOrWhiteSpace(fileName))
            {
                throw new ArgumentException(Const.MSG_FILE_EMPTYNAME, "fileName");
            }
            if (TData == null)
            {
                throw new ArgumentNullException("TData", Const.MSG_TDATA_NOT_NULL);
            }
            try
            {
                FileInfo file = new FileInfo(fileName);
                string bak_file = string.Empty;
                if (file.Exists == true)
                {
                    bak_file = file.Directory + DateTime.Now.ToString("yyyymmdd_HHmmss") + "_" + file.Name + ".bak";
                    file.CopyTo(bak_file, false);
                    file.Delete();
                }

                XmlDocument xdoc = TData.ToXML();
                xdoc.Save(fileName);
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        /// <summary>
        /// Genera Nombre de Archivo segun informacion de plantilla
        /// </summary>
        /// <param name="TData">Plantilla</param>
        /// <param name="seed">semilla para generacion de nombre</param>
        /// <param name="includeBaseDirectory">indica si se incluye el directorio base en la generacion del nombre</param>
        /// <returns>nombre de archivo a generar</returns>
        public static string GenerateFileName(TemplateData TData,object seed,bool includeBaseDirectory = false){
            if (seed == null) {
                throw new ArgumentNullException("TData.Seed", Const.MSG_PARAM_NOT_NULL);
            }
                       
            IOFileNamePattern io_pattern = TData.IOFileNamePattern;
            if(io_pattern==null){
                throw new ArgumentNullException("TData.IOFileNamePattern",Const.MSG_PARAM_NOT_NULL);
            }

            if (includeBaseDirectory == true) {
                if (string.IsNullOrEmpty(TData.IOFileBaseDirectory))
                {
                    throw new ArgumentNullException("TData.IOFileBaseDirectory", Const.MSG_PARAM_NOT_NULL);
                }            
            }

            string fileName = string.Empty;

            if (includeBaseDirectory == true)
            {
                if (io_pattern.useDatePattern == true)
                {
                    fileName = TData.IOFileBaseDirectory + "\\" + io_pattern.newFileName((DateTime)seed);
                }
                else
                {
                    fileName = TData.IOFileBaseDirectory + "\\" + io_pattern.newFileName((int)seed);
                }
            }
            else {
                if (io_pattern.useDatePattern == true)
                {
                    fileName = io_pattern.newFileName((DateTime)seed);
                }
                else
                {
                    fileName = io_pattern.newFileName((int)seed);
                }                        
            }
            return fileName;                                
        }


        /// <summary>
        /// Prepara una lista de SqlCommand, para ejecutar
        /// </summary>
        /// <param name="ctx">Contexto de Aplicacion</param>
        /// <param name="TData">Plantilla</param>
        /// <returns>Lista de SqlCommand</returns>
        public static List<Tuple<string,string,List<SqlParameter>>> PrepareCommand(AppContext ctx, TemplateData TData)
        {
            
            string sp_name = string.Empty;
            if (ctx == null)
            {
                throw new ArgumentNullException("AppContext", Const.MSG_PARAM_NOT_NULL);
            }

            if (ctx.DBContext == null)
            {
                throw new ArgumentNullException("DBContext", Const.MSG_PARAM_NOT_NULL);
            }

            if (TData == null)
            {
                throw new ArgumentNullException("TData", Const.MSG_TDATA_NOT_NULL);
            }

            if (TData.UseStoreProc == false && TData.ListQueryInfo.Count == 0)
            {
                throw new ArgumentException(Const.MSG_TDATA_MISSCONFIG, "TData");
            }

            if (TData.ListStoreProcsInfo.Count == 0)
            {
                throw new ArgumentException(Const.MSG_TDATA_STOREPROCS_NOT_NULL, "StoreProcsInfo");
            }

            DBContext db_context = ctx.DBContext;
            //List<SqlCommand> result = new List<SqlCommand>();
            List<Tuple<string, string, List<SqlParameter>>> result = new List<Tuple<string, string, List<SqlParameter>>>();


            if (TData.UseStoreProc)
            {
                List<StoreProcsInfo> TDataStoreProcsInfo = (from StoreProcsInfo sp_info in TData.ListStoreProcsInfo
                                                            where sp_info.Direction == DataDirection.Output
                                                            select sp_info
                                                                ).ToList();
                if (TDataStoreProcsInfo.Count == 0)
                {
                    throw new ArgumentException(Const.MSG_TDATA_MISSCONFIG, "TData.StoreProcsInfo.Direction");
                }
                int aux_counter = 0;
                foreach (StoreProcsInfo sp_info in TDataStoreProcsInfo)
                {
                    aux_counter++;
                    var checkParams = (from TemplateStoreProcParams p in sp_info.ListStoreProcParams
                                       where
                                       p.UseParameterValue == false
                                       select p.sqlParameter()).ToArray();
                    if (checkParams.Length > 0)
                    {
                        throw new ArgumentException(Const.MSG_TDATA_MISSCONFIG, "TData.StoreProcInfo.UseParameterValue");
                    }
                    checkParams = null;
                    List<SqlParameter> _SqlParams = (from TemplateStoreProcParams p in sp_info.ListStoreProcParams
                                                     select p.sqlParameter()).ToList();


                    //if (sp_info.ConnectionTimeout > 0)
                    //{
                    //    db_context.ConnectionTimeout = sp_info.ConnectionTimeout;
                    //}

                    sp_name = sp_info.StoreProcName;


                    //SqlCommand cmd = new SqlCommand();
                    //cmd.Connection = new SqlConnection(db_context.StringConnection);
                    //cmd.CommandType = CommandType.StoredProcedure;
                    //cmd.CommandText = sp_name;
                    //cmd.Parameters.AddRange(_SqlParams.ToArray());
                    Tuple<string, string, List<SqlParameter>> cmd = new Tuple<string, string, List<SqlParameter>>
                    (ctx.DBContext.StringConnection,sp_name,_SqlParams);
                                           
                    
                    result.Add(cmd);
                }//end foreach StoreProcsInfo
            }//end if (tdata.useStoreProc)

            return result;
        }


      
    }
}