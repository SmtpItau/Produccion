using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using CoreBusinessObjects.Common;
using CoreBusinessObjects.DTO;
using CoreLib.Common;
using CoreLib.Helpers;
using OfficeOpenXml;
using Const = CoreBusinessObjects.Common.Constants;

namespace CoreBusinessObjects.BLayer
{
    /// <summary>
    /// Implementacion de logica de negocio para exportacion/importacion desde y hacia archivo excel
    /// </summary>
    public sealed class ExcelFacadeBL : AFacade
    {
        private static System.Object MonitorLock = new System.Object();

        /// <summary>
        /// Proceso de volcado de los datos en excel, dato por los datos de la plantilla
        /// </summary>
        /// <param name="TData">Plantilla de exportacion</param>
        /// <param name="data">DataSet con el conjunto de datos a exportar</param>
        /// <param name="newFileName">Retorna el nombre de archivo </param>
        /// <returns>True/False</returns>
        public static new bool ExportData(TemplateData TData, DataSet data, ref string newFileName)
        {
            string msg = string.Empty;
            if (TData == null)
            {
                throw new ArgumentNullException("TData", Const.MSG_TDATA_NOT_NULL);
            }
            if (TData.IOFileDirection == DataDirection.Input)
            {
                throw new ArgumentOutOfRangeException("TData", Const.MSG_TDATA_INPUT);
            }
            if (data == null || data.Tables.Count == 0)
            {
                throw new ArgumentNullException("data", Const.MSG_DATA_NOT_FOUND);
            }

            if (TData.IOFile != null)
            {
                if (TData.IOFile.Exists == false)
                {
                    msg = string.Format(Const.MSG_FILE_NOTFOUND, TData.IOFileName);
                    throw new ArgumentException(msg, "TData.ExcelFile");
                }
                else
                {
                    if (!TData.IOFile.Extension.ToLower().Contains(".xls"))
                    {
                        msg = string.Format(Const.MSG_FILE_EXTENSION, TData.IOFile.Extension);
                        throw new ArgumentException(msg, "TData.IOFile.Extension");
                    }
                }
            }
            else if (TData.IOFile == null)
            {
                if (string.IsNullOrEmpty(newFileName) || string.IsNullOrWhiteSpace(newFileName))
                {
                    throw new ArgumentException(Const.MSG_FILE_EMPTYNAME, "newFileName");
                }
            }

   

            #region Obtencion de archivos en los cuales volcar la data.

            ExcelPackage pkg = null;
            try
            {
                FileInfo newExcel;
                if (!string.IsNullOrEmpty(newFileName))
                {
                    newExcel = new FileInfo(newFileName);
                    pkg = new ExcelPackage(newExcel, TData.IOFile);
                }
                else
                {
                    string _auxFileName = string.Empty;
                    _auxFileName = TData.IOFile.FullName.Substring(0, TData.IOFile.FullName.LastIndexOf("."));
                    _auxFileName += "_" + System.DateTime.Now.ToString("yyyymmdd_HHmmss") + TData.IOFile.Extension;
                    TData.IOFile.CopyTo(_auxFileName, true);
                    newExcel = new FileInfo(_auxFileName);
                    newFileName = newExcel.FullName;
                    pkg = new ExcelPackage(newExcel, TData.IOFile);
                }
            }
            catch (IOException ioe)
            {
                throw ioe;
            }

            #endregion Obtencion de archivos en los cuales volcar la data.

            int row_counter = 0;
            int MaxWritableRows = 0;
            Dictionary<string, ExcelWorksheet> listaHojas = WorksheetList(pkg);

            List<ExcelInfo> lExcelInfo = (from ExcelInfo eInfo in TData.ListExcelInfo
                                          where eInfo.ExcelSheetDirection == DataDirection.Output || eInfo.ExcelSheetDirection == DataDirection.InputOutput
                                          select eInfo
                                              ).ToList();

            foreach (ExcelInfo eInfo in lExcelInfo)
            {
                string tableName = eInfo.ExcelSheetName.Normalize(NormalizationForm.FormKC).Replace(" ", "_");

                DataTable dt = data.Tables[tableName];

                if (dt != null)
                {
                    
                    
                    
                    foreach (DataRow row in dt.Rows)
                    {
                        foreach (TemplateDataAddress pos in eInfo.AddressCollection)
                        {
                            string sheetName = pos.SheetName.Normalize(NormalizationForm.FormKC).ToString();
                            if (listaHojas.ContainsKey(sheetName) == true)
                            {
                                ExcelWorksheet sheet = listaHojas[sheetName];
                                if (pos.IsReadOnly == false)
                                {
                                    // paso de valor
                                    sheet.Cells[row_counter + pos.RowPosition, pos.ColumnPosition].Value = row[pos.ValueMember];

                                    #region PARA PROXIMA IMPLEMENTACION  Y/O MODIFICACION

                                    //if (pos.Format != "@"){
                                    //    sheet.Cells[row_counter + pos.RowPosition, pos.ColumnPosition].Style.Numberformat.Format = pos.Format;
                                    //}

                                    // paso de comentarios
                                    //if (pos.Comments != string.Empty)
                                    //{
                                    //    if (pos.RowPosition == 1)
                                    //    {
                                    //        sheet.Cells[pos.RowPosition, pos.ColumnPosition].
                                    //            AddComment(pos.Comments, "cambiar author");
                                    //    }
                                    //    else
                                    //    {
                                    //        sheet.Cells[pos.RowPosition - 1, pos.ColumnPosition].
                                    //                AddComment(pos.Comments, "cambiar author");
                                    //    }
                                    //}
                                    // paso de formula

                                    //if (!string.IsNullOrEmpty(pos.Formula))
                                    //{
                                    //    sheet.Cells[row_counter + pos.RowPosition, pos.ColumnPosition].
                                    //        Formula = pos.Formula;
                                    //}

                                    #endregion PARA PROXIMA IMPLEMENTACION  Y/O MODIFICACION
                                }
                                if (pos.MaxWritableRows != -1)
                                {
                                    MaxWritableRows = pos.MaxWritableRows;
                                }
                            }
                        }//Foreach template
                        row_counter++;
                        if (row_counter == MaxWritableRows)
                        {
                            break;
                        }
                    }//Foreach row



                }//dt!=null
            }//Foreach eInfo

            pkg.Save();
            return true;
        }

        /// <summary>
        /// Importa la data indicada por fileToImport y mapeado por TData
        /// </summary>
        /// <param name="ctx">Contexto de aplicacion</param>
        /// <param name="TData">Plantilla</param>
        /// <param name="fileToImport">Nombre de archivo a importar</param>
        /// <param name="ds">DataSet devuelto con los datos importados</param>
        /// <param name="execStoreProc">Indica si se ejecutaran los store procs configurados en la plantilla</param>
        /// <returns>True/False</returns>
        public static new bool ImportData(AppContext ctx, TemplateData TData, string fileToImport, out DataSet ds, bool execStoreProc = false)
        {
            DBContext db_context = new DBContext();
            db_context = ctx.DBContext;

            #region Validacion de parametros de entrada

            string msg = string.Empty;
            if (db_context == null)
            {
                throw new ArgumentNullException("db_context", Const.MSG_TDATA_NOT_NULL);
            }

            if (TData == null)
            {
                throw new ArgumentNullException("TData", Const.MSG_TDATA_NOT_NULL);
            }
            if (string.IsNullOrWhiteSpace(fileToImport) || string.IsNullOrEmpty(fileToImport))
            {
                throw new ArgumentNullException("fileToImport", Const.MSG_FILE_EMPTYNAME);
            }

            if (TData.IOFileDirection == DataDirection.Output)
            {
                throw new ArgumentException(Const.MSG_TDATA_OUTPUT, "TData");
            }

            FileInfo fileImport = new FileInfo(fileToImport);
            if((fileImport.Extension.ToLower().Contains(".xlsx")  || fileImport.Extension.ToLower().Contains(".xls")) == false)
            {
                msg = string.Format(Const.MSG_FILE_EXTENSION, ".xlsx|.xls");
                throw new ArgumentOutOfRangeException("fileToImport", msg);
            }

            if (fileImport.Exists == false)
            {
                msg = string.Format(Const.MSG_FILE_NOTFOUND, fileToImport);
                throw new ArgumentOutOfRangeException("fileToImport", msg);
            }

            try
            {
                ExcelPackage pkg = new ExcelPackage(fileImport);
                Dictionary<string, ExcelWorksheet> listaHojas = WorksheetList(pkg);
                ds = new DataSet();

                List<ExcelInfo> XlsInfo = (from ExcelInfo eInf in TData.ListExcelInfo
                                           where eInf.ExcelSheetDirection != DataDirection.Output
                                           where eInf.ExcelValueSource !="DCE"
                                           select eInf).ToList();

                foreach (ExcelInfo eInfo in XlsInfo)
                {
                    DataTable dt;
                    if (listaHojas.ContainsKey(eInfo.ExcelSheetName))
                    {
                        ExcelWorksheet sheet = listaHojas[eInfo.ExcelSheetName];
                        var start = sheet.Dimension.Start;
                        var end = sheet.Dimension.End;

                        int _row = 1;
                        int _col = 1;
                        int _aux_column = 1;
                        if (start.Row < eInfo.ExcelRowStart)
                        {
                            _row = eInfo.ExcelRowStart;// +1;
                        }
                        else if (start.Row > eInfo.ExcelRowStart)
                        {
                            throw new ArgumentOutOfRangeException("ExcelRowStart", Const.MSG_TDATA_ROW);
                        }
                        else if (start.Row == eInfo.ExcelRowStart)
                        {
                            _row = start.Row + 1;
                        }

                        if (start.Column < eInfo.ExcelColumnStart)
                        {
                            _col = eInfo.ExcelColumnStart;
                            _aux_column = eInfo.ExcelColumnStart;
                        }
                        else if (start.Column > eInfo.ExcelColumnStart)
                        {
                            throw new ArgumentOutOfRangeException("ExcelColumnStart", Const.MSG_TDATA_COLUMN);
                        }
                        else if (start.Column == eInfo.ExcelColumnStart)
                        {
                            _col = start.Column;
                            _aux_column = start.Column;
                        }

                        //Generamos un datatable con las columnas que debe ser leidas
                        dt = new DataTable(eInfo.ExcelSheetName.Replace(" ", "_"));
                        foreach (TemplateDataAddress pos in eInfo.AddressCollection)
                        {
                            if (pos.Direction == DataDirection.Input || pos.Direction == DataDirection.InputOutput)
                            {
                                DataColumn col = new DataColumn(pos.ColumnTitle);
                                dt.Columns.Add(col);
                            }
                        }

                        if (dt.Columns.Count == 0)
                        {
                            throw new ArgumentOutOfRangeException(Const.MSG_TDATA_EMPTY_COLUMNS);
                        }

                        if (TData.AdditionalInfo)
                        {
                            dt.Columns.Add("RowPosition");
                            dt.Columns.Add("FileName");
                            dt.Columns.Add("FileTime");
                        }

                        //Llenamos el datatable dt
                        for (int row_counter = _row; row_counter <= end.Row; row_counter++)
                        {
                            DataRow row = dt.NewRow();
                            foreach (TemplateDataAddress pos in eInfo.AddressCollection)
                            {
                                if (pos.Direction == DataDirection.Input || pos.Direction == DataDirection.InputOutput)
                                {
                                    bool emptyValue =
                                        sheet.Cells[row_counter, pos.ColumnPosition].Text == null
                                        || string.IsNullOrEmpty(sheet.Cells[row_counter, pos.ColumnPosition].Text.ToString().Trim())
                                        || string.IsNullOrWhiteSpace(sheet.Cells[row_counter, pos.ColumnPosition].Text.ToString().Trim())
                                        ? true : false;

                                    if (!emptyValue)
                                    {
                                        //var value = sheet.Cells[row_counter, pos.ColumnPosition].Value.ToString();
                                        var value = sheet.Cells[row_counter, pos.ColumnPosition].Text.ToString().Trim();
                                        row[pos.ColumnTitle] = value.ToString().Trim();
                                    }
                                }
                            }

                            if (TData.AdditionalInfo == true)
                            {
                                if (CheckEmptyRows(row,eInfo.AddressCollection) == false)
                                {
                                    row["RowPosition"] = row_counter;
                                    row["FileName"] = fileImport.FullName;
                                    row["FileTime"] = fileImport.LastWriteTime;
                                    dt.Rows.Add(row);
                                }
                            }
                            else
                            {
                                if (!CheckEmptyRows(row,eInfo.AddressCollection))
                                {
                                    dt.Rows.Add(row);
                                }
                            }
                        }
                        //rana
                        if (dt.Rows.Count == 0)
                        {
                            throw new InvalidDataException(Const.MSG_DATA_NOT_FOUND);
                        }
                        ds.Tables.Add(dt);
                    }
                }//foreach eInfo

                if (execStoreProc == false)
                {
                    return true; //Fin de proceso de importacion.
                }
                else
                {
                    bool result = false;
                    List<DataTable> dt_errores;
                    result = ExecuteInputProcedure(ctx, TData, ds, out dt_errores);
                    foreach (DataTable dt in dt_errores)
                    {
                        ds.Tables.Add(dt);
                    }
                    return result;
                }
            }
            catch (Exception)
            {
                throw;
            }

            #endregion Validacion de parametros de entrada
        }

        /// <summary>
        /// Devuelve un Dictionary con los nombres y las hojas del libro
        /// </summary>
        /// <param name="pkg">Libro excel a obtener las hojas.</param>
        /// <returns>Dictionary</returns>
        public static Dictionary<string, ExcelWorksheet> WorksheetList(ExcelPackage pkg)
        {
            if (pkg == null)
            {
                throw new ArgumentNullException("pkg", Const.MSG_PARAM_NOT_NULL);
            }

            Dictionary<string, ExcelWorksheet> listaHojas = new Dictionary<string, ExcelWorksheet>();
            foreach (ExcelWorksheet sheet in pkg.Workbook.Worksheets)
            {
                if (sheet.Hidden == eWorkSheetHidden.Visible) {
                    listaHojas.Add(sheet.Name.Normalize(NormalizationForm.FormKC).ToString(), sheet);
                }
            }
            return listaHojas;

        }

        /// <summary>
        /// Exporta un dataset a excel con la informacion indicada por la plantilla
        /// </summary>
        /// <param name="TData">Objeto plantilla con informacion para generar archivos</param>
        /// <param name="data">Conjunto de datos a exportar</param>
        /// <param name="FileNames">Lista con nombres de archivos generados</param>
        /// <param name="processDate">Fecha de Proceso</param>
        /// <param name="BaseDirectory">Directorio base para entrega de archivos</param>        
        /// <returns>true</returns>
        public static bool ExportData(TemplateData TData, DataSet data,string BaseDirectory,DateTime processDate, out List<string> FileNames) {
            string msg = string.Empty;            
            #region Validacion            
            if (TData == null)
            {
                throw new ArgumentNullException("TData", Const.MSG_TDATA_NOT_NULL);
            }
            if (TData.IOFileDirection == DataDirection.Input)
            {
                throw new ArgumentOutOfRangeException("TData", Const.MSG_TDATA_INPUT);
            }
            if (data == null || data.Tables.Count == 0)
            {
                throw new ArgumentNullException("data", Const.MSG_DATA_NOT_FOUND);
            }
            if (TData.IOFile != null)
            {
                if (TData.IOFile.Exists == false)
                {
                    msg = string.Format(Const.MSG_FILE_NOTFOUND, TData.IOFileName);
                    throw new ArgumentException(msg, "TData.ExcelFile");
                }
                else
                {
                    if (!TData.IOFile.Extension.ToLower().Contains(".xls"))
                    {
                        msg = string.Format(Const.MSG_FILE_EXTENSION, TData.IOFile.Extension);
                        throw new ArgumentException(msg, "TData.IOFile.Extension");
                    }
                }
            }
            if (TData.IOFileNamePattern == null) {
                throw new ArgumentNullException("TData.IOFileNamePattern", Const.MSG_TDATA_QUERY_NOTNULL);
            }
            if (string.IsNullOrEmpty(BaseDirectory)) {
                throw new ArgumentNullException("TData.BaseDirectory", Const.MSG_PARAM_NOT_NULL);
            }
            if (TData.ListExcelInfo.Count == 0) {
                throw new ArgumentNullException("TData.ListExcelInfo", Const.MSG_PARAM_NOT_NULL);
            }
            if (data.Tables.Count == 0||data == null) {
                throw new ArgumentNullException("TData.data", Const.MSG_DATA_NOT_FOUND);
            }

            FileNames = new List<string>();
            
            #endregion

            #region Vers. Carretera
            /*
            List<ExcelInfo> lExcelInfo = new List<ExcelInfo>();
            
            foreach (ExcelInfo item in TData.ListExcelInfo)
            {
                if (item.ExcelSheetDirection == DataDirection.Output || item.ExcelSheetDirection == DataDirection.InputOutput)
                {
                    lExcelInfo.Add(item);
                }
            } 
            */
            #endregion
            
            #region Linq Vers.             
            List<ExcelInfo> lExcelInfo = (from ExcelInfo eInfo in TData.ListExcelInfo
                                          where eInfo.ExcelSheetDirection == DataDirection.Output || eInfo.ExcelSheetDirection == DataDirection.InputOutput
                                          where eInfo.ExcelValueSource !="DCE"
                                          select eInfo).ToList();
            #endregion
                       

            // para la generacion de nombres de archivos                     
            string aux_baseDirectory = TData.IOFileBaseDirectory;
            TData.IOFileBaseDirectory = BaseDirectory;
            string aux_Suffix = TData.IOFileNamePattern.Suffix;

            try
            {

                foreach (ExcelInfo eInfo in lExcelInfo)
                {
                    string tableName = eInfo.ExcelSheetName.Replace(" ", "_");
                    DataTable source_dt = data.Tables[tableName];

                    if (source_dt != null)
                    {

                        if (eInfo.AllowPaging == true && eInfo.PageSize > 0)
                        {
                            //split de datatable para generar multiples archivos
                            DataTable[] source_split = source_dt.AsEnumerable()
                                .Select((row, index) => new { row, index })
                                .GroupBy(x => x.index / eInfo.PageSize)
                                .Select(g => g.Select(x => x.row).CopyToDataTable())
                                .ToArray();

                            if (source_split.Length > 0)
                            {
                                //recorremos el split
                                for (int x = 0; x < source_split.Length; x++)
                                {
                                    int row_counter = 0;
                                    int MaxWritableRows = 0;

                                    //generacion de nombre
                                    IOFileNamePattern ioPattern = TData.IOFileNamePattern;
                                    ioPattern.Suffix = ioPattern.Suffix + "_" + (x + 1).ToString("00#");
                                    string aux_fileName = AFacade.GenerateFileName(TData, processDate, true);
                                    ioPattern.Suffix = aux_Suffix;

                                    //carga de plantilla excel
                                    FileInfo newExcel = new FileInfo(aux_fileName);
                                    ExcelPackage pkg = new ExcelPackage(newExcel, TData.IOFile);

                                    //obtencion de hojas de la plantilla
                                    Dictionary<string, ExcelWorksheet> sheetList = WorksheetList(pkg);

                                    //por cada fila en la tabla
                                    foreach (DataRow row in source_split[x].Rows)
                                    {
                                        //por cada Template de Celda, se va llenando con la informacion de cada fila
                                        foreach (TemplateDataAddress pos in eInfo.AddressCollection)
                                        {
                                            string sheetName = pos.SheetName;

                                            ExcelWorksheet sheet = sheetList[sheetName];

                                            if (pos.IsReadOnly == false)
                                            {
                                                // paso de valor
                                                sheet.Cells[row_counter + pos.RowPosition, pos.ColumnPosition].Value = row[pos.ValueMember];
                                                

                                                #region PARA PROXIMA IMPLEMENTACION  Y/O MODIFICACION
                                                /*
                                             Descomentar para habilitar (de forma experimental):
                                             * Aplicacion de Formato
                                             * Aplicacion de Comentarios por cada celda
                                             * Aplicacion de formula excel.
                                             
                                             */

                                                //paso de formato
                                                //if (pos.Format != "@"){
                                                //    sheet.Cells[row_counter + pos.RowPosition, pos.ColumnPosition].Style.Numberformat.Format = pos.Format;
                                                //}

                                                // paso de comentarios
                                                //if (pos.Comments != string.Empty)
                                                //{
                                                //    if (pos.RowPosition == 1)
                                                //    {
                                                //        sheet.Cells[pos.RowPosition, pos.ColumnPosition].
                                                //            AddComment(pos.Comments, "cambiar author");
                                                //    }
                                                //    else
                                                //    {
                                                //        sheet.Cells[pos.RowPosition - 1, pos.ColumnPosition].
                                                //                AddComment(pos.Comments, "cambiar author");
                                                //    }
                                                //}

                                                // paso de formula
                                                //if (!string.IsNullOrEmpty(pos.Formula))
                                                //{
                                                //    sheet.Cells[row_counter + pos.RowPosition, pos.ColumnPosition].
                                                //        Formula = pos.Formula;
                                                //}

                                                #endregion PARA PROXIMA IMPLEMENTACION  Y/O MODIFICACION
                                            }
                                            //verificacion de limites
                                            if (pos.MaxWritableRows != -1)
                                            {
                                                MaxWritableRows = pos.MaxWritableRows;
                                            }
                                        }//foreach pos

                                        row_counter++;
                                        if (row_counter == MaxWritableRows)
                                        {
                                            break;
                                        }
                                    }//foreach row

                                    FileNames.Add(aux_fileName);

                                    pkg.Save();
                                }//for x<source_split.length

                            }//source_split.length
                        }//AllowPaging == true && eInfo.PageSize >0
                    }
                }//end foreach eInfo

                TData.IOFileBaseDirectory = aux_baseDirectory;
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }
        
        /// <summary>
        /// Metodo de matching de lectura de DCE 
        /// </summary>
        /// <param name="ctx">Contexto de Aplicacion.</param>
        /// <param name="TData">Template object.</param>
        /// <param name="matching_data">data resultante del proceso.</param>
        /// <param name="data">data para hacer match con DCE.</param>
        public static void DCEMatching(AppContext ctx, TemplateData TData, DataSet data,out DataSet matching_data)
        {
            DBContext db_ctx = ctx.DBContext;            
            DataSet ds = new DataSet();
            
            
#if DEBUG==true
            List<ExcelInfo> lExcelInfo = new List<ExcelInfo>();
            foreach (ExcelInfo eInfo in TData.ListExcelInfo) {
                if (eInfo.ExcelValueSource == "DCE") {
                    lExcelInfo.Add(eInfo);
                }
            }
            List<string> sql_list = new List<string>();
#else
            List<ExcelInfo> lExcelInfo = (from ExcelInfo eInfo in TData.ListExcelInfo
                                          where eInfo.ExcelValueSource=="DCE"
                                          select eInfo).ToList();

#endif
            


            string template_sqlcmd = @"select dce_contrato_dce as [DCE Contract],* from view_dce_contrato where dce_tipo='{0}' and dce_contrato='{1}'";
            string sqlcmd = string.Empty;
            List<string> aux_value_params = new List<string>();

            foreach (ExcelInfo eInfo in lExcelInfo)
            {
                string tableName = eInfo.ExcelSheetName.Replace(" ", "_");
                DataTable source_dt = data.Tables[tableName];

                if (source_dt != null) {
                    ds.Tables.Add(source_dt.Copy());
                    

                    foreach (DataRow row in ds.Tables[0].Rows) {
                        try
                        {

                            #region MyRegion
                            aux_value_params.Clear();
                            foreach (TemplateDataAddress pos in eInfo.AddressCollection)
                            {
                                if (pos.ColumnPosition < 2)
                                {
                                    aux_value_params.Add(row[pos.ColumnTitle].ToString());
                                }
                            }//foreach pos

                            sqlcmd = string.Format(template_sqlcmd, aux_value_params.ToArray());
#if DEBUG==true
                            sql_list.Add(sqlcmd);
#endif
                            DataSet ds_value = SqlHelper.ExecuteDataset(db_ctx.StringConnection, CommandType.Text, sqlcmd);
                            if (ds_value.Tables.Count > 0 && ds_value.Tables[0].Rows.Count > 0)
                            {
                                DataRow row_value = ds_value.Tables[0].Rows[0];
                                foreach (TemplateDataAddress pos in eInfo.AddressCollection)
                                {
                                    if (pos.ColumnPosition == 2)
                                    {
                                        row[pos.ColumnTitle] = row_value[pos.ValueMember];
                                    }
                                }//foreach pos
                            }//if ds_value.table 
                            #endregion

                        }
                        catch (Exception)
                        {
                            
                            throw;
                        }

                    }//foreach datarow                
                }//source_dt!=null

            }//foreach einfo
            matching_data = ds;
            ds = null;            
        }
    }//sealed Class ExcelFacade
}