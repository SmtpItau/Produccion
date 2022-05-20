using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Data;
using System.Text;


namespace CoreLib.Helpers
{
   
        using System.IO;
        using System.Diagnostics;
        using OfficeOpenXml;
        using OfficeOpenXml.Drawing;
        using System.Data;

        /// <summary>
        /// Enumera las opciones de exportacion
        /// </summary>
        [Flags]
        public enum ExportOptions
        {
            /// <summary>
            /// Indica si se incluye la hora en formato HH:mm:ss.
            /// </summary>
            IncludeTime = 0x0,
            /// <summary>
            /// Indica si se debe utilizar el formato AÑO-MES-DIA para la exportacion de fechas.
            /// </summary>
            YMD_DateFormat = 0x1,
            /// <summary>
            /// Indica si se incluyen comentarios en la primera fila o cabecera del archivo generado.
            /// </summary>
            IncludeComments = 0x2,
            /// <summary>
            /// Indica si se va a exportar un DataSet completo con todas sus tablas.
            /// </summary>
            AllowMultipleSheets = 0x4,
            //Next Values for enum : 0x8,0x10,0x20,0x40
            /// <summary>
            /// Indica si se va a exportar la estructura del dataset sin datos.
            /// </summary>
            ExportStructure = 0x8,
            /// <summary>
            /// Si existe el archivo, lo sobre escribe
            /// </summary>
            OverWriteFile = 0x10
        }

        /// <summary>
        /// Clase de Exportacion a Excel
        /// </summary>
        public static class ExcelExport
        {

            /// <summary>
            /// Wrapper de exportacion a excel (Boxing / Unboxing de funciones de exportacion)
            /// </summary>
            /// <param name="data">Objeto a exportar</param>
            /// <param name="file">FileInfo con los datos del archivo a exportar</param>
            /// <param name="options">Opciones de Exportacion</param>
            /// <param name="comments">Diccionario (columna,comentario) de comentarios para agregar a la primera fila del excel</param>
            /// <returns>True/False si se concreto la operacion de exportacion o no.</returns>
            public static bool Export(object data, FileInfo file, ExportOptions options, Dictionary<string, string> comments = null)
            {
                switch (data.GetType().ToString())
                {
                    case "System.Data.DataSet":
                        return Export_DataSet((DataSet)data, file, options, comments);
                        //return false;
                    case "System.Data.DataTable":
                        return Export_DataTable((DataTable)data, file, options, comments);
                    default:
                        return false;
                }
            }

            /// <summary>
            /// Clase con Informacion para generar excel de un dataset con multiples tablas
            /// </summary>
            private class DataSetInfo
            {
                /// <summary>
                /// Coleccion interna de objetos con informacion del dataset    
                /// </summary>
                private DataSetInfoCollection<DataSetInfo> _infoCollection = new DataSetInfoCollection<DataSetInfo>();
                /// <summary>
                /// Id unico de cada dataset
                /// </summary>
                protected Guid? _UniqueID;

                /// <summary>
                /// Id unico de cada dataset
                /// </summary>
                public Guid? UniqueID { get { return _UniqueID; } set { _UniqueID = value; } }

                /// <summary>
                /// Nombre de la tabla del dataset
                /// </summary>
                public string TableName { get; set; }

                /// <summary>
                /// NameSpace XML del dataset   
                /// </summary>
                public string NameSpace { get; set; }

                /// <summary>
                /// Total de Registros de la tabla
                /// </summary>
                public int TotalRecordsInTable { get; set; }

                /// <summary>
                /// Total de Hojas generadas por el total de datos del tablename
                /// </summary>
                public decimal TotalSheets { get; set; }

                /// <summary>
                /// Instancia un objeto DataSetInfo Vacio
                /// </summary>
                public DataSetInfo() { }

                /// <summary>
                /// Instancia un objeto DataSetInfo, con la informacion de un DataSet
                /// </summary>
                public DataSetInfo(DataSet obj)
                {
                    if (obj == null || obj.Tables.Count == 0)
                    {
                        return;
                    }

                    DataSetInfo info = new DataSetInfo();
                    foreach (DataTable dt in obj.Tables)
                    {
                        info.NameSpace = dt.Namespace;
                        info.TableName = dt.TableName;
                        info.TotalRecordsInTable = dt.Rows.Count;
                        decimal total_sheets = dt.Rows.Count / ExcelPackage.MaxRows;
                        info.TotalSheets = Math.Ceiling(total_sheets);
                        _infoCollection.Add(info);
                    }
                }
                /// <summary>
                /// Agrega un elemento a la collection
                /// </summary>
                /// <param name="obj">Objeto DataSetInfo</param>
                public void Add(DataSetInfo obj)
                {
                    _infoCollection.Add(obj);
                }
                /// <summary>
                /// Coleccion de objetos DataSetInfo
                /// </summary>
                /// <returns>Collection</returns>
                public DataSetInfoCollection<DataSetInfo> InfoCollection()
                {
                    return _infoCollection;
                }
            }

            /// <summary>
            /// Enumerador de Coleccion DataSetInfoCollection
            /// </summary>
            /// <typeparam name="T"></typeparam>
            private class DataSetInfoEnumerator<T> : IEnumerator<T> where T : DataSetInfo
            {
                protected DataSetInfoCollection<T> _collection; //coleccion enumerada
                protected int index; //current index
                protected T _current; // current enumerated object in the collection
                public DataSetInfoEnumerator() { }
                public DataSetInfoEnumerator(DataSetInfoCollection<T> collection) { _collection = collection; index = -1; _current = default(T); }
                public virtual T Current { get { return _current; } }
                object IEnumerator.Current { get { return _current; } }
                public virtual void Dispose() { _collection = null; _current = default(T); index = -1; }
                public virtual bool MoveNext() { if (++index >= _collection.Count) { return false; } else { _current = _collection[index]; } return true; }
                public virtual void Reset() { _current = default(T); index = -1; }
            }

            /// <summary>
            /// Coleccion de objetos DataSetInfo
            /// </summary>
            /// <typeparam name="T">Objeto DataSetInfo</typeparam>
            private class DataSetInfoCollection<T> : ICollection<T> where T : DataSetInfo
            {
                protected ArrayList _innerArray;
                protected bool _IsReadOnly;
                public DataSetInfoCollection() { this._innerArray = new ArrayList(); }
                public virtual T this[int index] { get { return (T)_innerArray[index]; } set { _innerArray[index] = value; } }
                public virtual int Count { get { return _innerArray.Count; } }
                public virtual bool IsReadOnly { get { return _IsReadOnly; } }
                public virtual bool Remove(T DataSetInfo)
                {
                    bool result = false;
                    for (int i = 0; i < _innerArray.Count; i++)
                    {
                        T obj = (T)_innerArray[i];
                        if (obj.UniqueID == DataSetInfo.UniqueID)
                        {
                            _innerArray.RemoveAt(i);
                            result = true;
                            break;
                        }
                    }
                    return result;
                }
                public virtual bool Contains(T DataSetInfo)
                {
                    foreach (T obj in _innerArray)
                    {
                        if (obj.UniqueID == DataSetInfo.UniqueID) { return true; }
                    }
                    return false;
                }
                public virtual void Add(T DataSetInfo) { _innerArray.Add(DataSetInfo); }
                public virtual void Clear() { _innerArray.Clear(); }
                public virtual void CopyTo(T[] DataSetInfoArray, int index)
                {
                    throw new Exception("Metodo no valido para esta implementacion");
                }
                public virtual IEnumerator<T> GetEnumerator()
                {
                    //return null;
                    return new DataSetInfoEnumerator<T>(this);
                }
                IEnumerator IEnumerable.GetEnumerator()
                {
                    //return null;
                    return new DataSetInfoEnumerator<T>(this);
                }
            }

            /// <summary>
            /// Exporta un DataSet a archivo excel
            /// </summary>
            ///<param name="data">Objeto DataSet para exportar a excel</param>
            /// <param name="file">FileInfo de archivo a generar</param>
            /// <param name="options">Opciones de exportacion</param>
            /// <param name="comments">Diccionario (columna,comentario) de comentarios para agregar a la primera fila del excel</param>
            /// <returns>True/False si se exportaron los datos o no</returns>
            public static bool Export_DataSet(DataSet data, FileInfo file, ExportOptions options, Dictionary<string, string> comments = null)
            {
                bool YMD_DateFormat = false;
                bool IncludeTime = false;
                bool IncludeComments = false;
                bool AllowMultipleSheets = false;

                if ((options & ExportOptions.IncludeTime) == ExportOptions.IncludeTime) { IncludeTime = true; }
                if ((options & ExportOptions.YMD_DateFormat) == ExportOptions.YMD_DateFormat) { YMD_DateFormat = true; }
                if ((options & ExportOptions.IncludeComments) == ExportOptions.IncludeComments) { IncludeComments = true; }
                if ((options & ExportOptions.AllowMultipleSheets) == ExportOptions.AllowMultipleSheets) { AllowMultipleSheets = true; }
                if ((options & ExportOptions.OverWriteFile) == ExportOptions.OverWriteFile) { if (file.Exists) { file.Delete(); } }


                if ((options & ExportOptions.ExportStructure) == ExportOptions.ExportStructure) {
                    return Export_DataSet_EmptyRows(data, file);
                }

                if (ValidateBeforeToExport(data, file, options))
                {
                    DataSetInfo info = new DataSetInfo(data);
                    DataSetInfoCollection<DataSetInfo> collectionInfo = info.InfoCollection();
                    ExcelPackage pkg = new ExcelPackage();
                    foreach (DataSetInfo obj in collectionInfo)
                    {
                        ExcelWorksheet sheet;
                        if (AllowMultipleSheets == true)
                        {
                            //TODO: HOW TO GENERATE MULTIPLE WORKSHEETS
                            // generamos los header de la hoja

                            //colocamos los datos en la hoja
                        
                        }
                        else
                        {

                            sheet = pkg.Workbook.Worksheets.Add(obj.TableName);                            
                            int column_counter = 1;
                            int row_counter = 2;
                            foreach (DataColumn column in data.Tables[obj.TableName].Columns)
                            {
                                sheet.Cells[1, column_counter].Value = column.ColumnName;
                                sheet.Cells[1, column_counter].Style.Font.Bold = true;

                                if (IncludeComments)
                                {
                                    if (comments != null)
                                    {
                                        if (comments.ContainsKey(column.ColumnName) == true)
                                        {
                                            sheet.Cells[1, column_counter].AddComment(comments[column.ColumnName], System.Environment.UserName);
                                        }
                                    }
                                }

                                column_counter++;
                            }
                            foreach (DataRow row in data.Tables[obj.TableName].Rows)
                            {
                                column_counter = 1;
                                foreach (DataColumn column in data.Tables[obj.TableName].Columns)
                                {
                                    sheet.Cells[row_counter, column_counter].Value = row[column.ColumnName];

                                    if (YMD_DateFormat || IncludeTime) {                                        
                                        if(column.DataType == typeof(DateTime))
                                        {
                                            sheet.Cells[row_counter, column_counter].Style.Numberformat.Format =
                                            Format(column.DataType, IncludeTime, YMD_DateFormat);
                                        }                                    
                                    }                                                                                                          
                                    column_counter++;
                                }
                                row_counter++;
                            }
                        }
                    }
                    pkg.SaveAs(file);
                }
                return true;
            }

            /// <summary>
            /// Exporta solo la estructura del dataset
            /// </summary>
            /// <param name="data">dataset a exportar</param>
            /// <param name="file">archivo al cual se exportara la estructura</param>
            /// <returns>true/false</returns>
            private static bool Export_DataSet_EmptyRows(DataSet data, FileInfo file) {
                DataSetInfo info = new DataSetInfo(data);
                DataSetInfoCollection<DataSetInfo> collectionInfo = info.InfoCollection();
                ExcelPackage pkg = new ExcelPackage();
                foreach (DataSetInfo obj in collectionInfo)
                {
                    ExcelWorksheet sheet;
                    sheet = pkg.Workbook.Worksheets.Add(obj.TableName);
                    int column_counter = 1;                    
                    foreach (DataColumn column in data.Tables[obj.TableName].Columns)
                    {
                        sheet.Cells[1, column_counter].Value = column.ColumnName;
                        sheet.Cells[1, column_counter].Style.Font.Bold = true;
                        column_counter++;
                    }
                }
                pkg.SaveAs(file);
                return true;
            }

           
            /// <summary>
            /// Valida que exista lo necesario respecto de los datos, para la exportacion
            /// </summary>
            /// <param name="data">Objeto con los datos a exportar (DataSet o DataTable)</param>
            /// <param name="file">FileInfo de archivo a generar</param>
            /// <param name="options">Opciones de exportacion</param>
            /// <returns>True/False si se exporto o no </returns>
            private static bool ValidateBeforeToExport(object data, FileInfo file, ExportOptions options)
            {

                //bool YMD_DateFormat = false;
                //bool IncludeTime = false;
                //bool IncludeComments = false;
                bool AllowMultipleSheets = false;

                //if ((options & ExportOptions.IncludeTime) == ExportOptions.IncludeTime) { IncludeTime = true; }
                //if ((options & ExportOptions.YMD_DateFormat) == ExportOptions.YMD_DateFormat) { YMD_DateFormat = true; }
                //if ((options & ExportOptions.IncludeComments) == ExportOptions.IncludeComments) { IncludeComments = true; }
                if ((options & ExportOptions.AllowMultipleSheets) == ExportOptions.AllowMultipleSheets) { AllowMultipleSheets = true; }


                // Vinculo con los limites de excel..
                //https://support.office.com/en-us/article/Excel-specifications-and-limits-16c69c74-3d6a-4aaf-ba35-e6eb276e8eaa

                string msg = string.Empty;

                if (data == null)
                {
                    throw new ArgumentNullException("data", "El argumento no puede ser nulo.");
                }

                if (file == null)
                {
                    throw new ArgumentNullException("file", "El parametro no puede ser nulo");
                }              

                string aux_file_extension = file.Extension.ToString().ToLower();

                if (data.GetType() == typeof(DataSet))
                {
                    // Implementar validacion por cada una de las tablas, que contenga
                    // la misma validacion, sin el throw Exception.

                    DataSet ds = (DataSet)data;

                    if (ds.Tables.Count == 0)
                    {
                        throw new ArgumentOutOfRangeException("data", "No se encuentran datos para exportar");
                    }

                    if (ds.Tables.Count > 0)
                    {
                        int table_null_counter = 0;

                        foreach (DataTable table in ds.Tables)
                        {
                            if (table.Rows.Count == 0)
                            {
                                table_null_counter++;
                            }
                        }

                        if (table_null_counter == ds.Tables.Count)
                        {
                            throw new ArgumentOutOfRangeException("data", "Las tablas en el set de datos estan vacias");
                        }
                    }
                }
                else if (data.GetType() == typeof(DataTable))
                {
                    DataTable table = (DataTable)data;

                    if (table.Rows.Count == 0)
                    {
                        throw new ArgumentOutOfRangeException("data", "No se encuentran filas para exportar");
                    }

                    if (table.Columns.Count > OfficeOpenXml.ExcelPackage.MaxColumns)
                    {
                        msg = "La cantidad de columnas supera lo soportado por Excel: {0} > {1} ";
                        msg = string.Format(msg, table.Columns.Count.ToString(), OfficeOpenXml.ExcelPackage.MaxColumns.ToString());
                        throw new ArgumentOutOfRangeException("data", msg);
                    }

                    if (AllowMultipleSheets == false)
                    {
                        if (table.Rows.Count > OfficeOpenXml.ExcelPackage.MaxRows)
                        {
                            msg = "La cantidad de filas supera lo soportado por Excel: {0} > {1} ";
                            msg = string.Format(msg, table.Columns.Count.ToString(), OfficeOpenXml.ExcelPackage.MaxColumns.ToString());
                            throw new ArgumentOutOfRangeException("data", msg);
                        }
                        if (table.Rows.Count > 65535 && aux_file_extension == "xls")
                        {
                            msg = "El total de filas supera lo soportado por el formato xls";
                            throw new Exception(msg);
                        }
                    }

                }

                if (!(data.GetType() == typeof(DataSet) || data.GetType() == typeof(DataTable)))
                {
                    throw new NotSupportedException("De momento, se exportan DataSet y DataTable");
                }

                return true;
            }

            /// <summary>
            /// Exporta un DataTable a excel
            /// </summary>
            /// <param name="table">Objeto DataTable con los datos a exportar</param>
            /// <param name="file">FileInfo de archivo a generar</param>
            /// <param name="options">Opciones de exportacion</param>
            /// <param name="comments">Diccionario (columna,comentario) de comentarios para agregar a la primera fila del excel</param>
            /// <returns>True/False si se exportaron los datos o no</returns>
            public static bool Export_DataTable(DataTable table, FileInfo file, ExportOptions options, Dictionary<string, string> comments = null)
            {
                bool YMD_DateFormat = false;
                bool IncludeTime = false;
                bool IncludeComments = false;

                if ((options & ExportOptions.IncludeTime) == ExportOptions.IncludeTime) { IncludeTime = true; }
                if ((options & ExportOptions.YMD_DateFormat) == ExportOptions.YMD_DateFormat) { YMD_DateFormat = true; }
                if ((options & ExportOptions.IncludeComments) == ExportOptions.IncludeComments) { IncludeComments = true; }
                if ((options & ExportOptions.OverWriteFile) == ExportOptions.OverWriteFile) { if (file.Exists) { file.Delete(); } }

                if (ValidateBeforeToExport(table, file, options))
                {
                    try
                    {
                        using (ExcelPackage pkg = new ExcelPackage())
                        {
                            ExcelWorksheet sheet = pkg.Workbook.Worksheets.Add(table.TableName);

                            int column_counter = 1;
                            int row_counter = 2;
                            foreach (DataColumn column in table.Columns)
                            {
                                sheet.Cells[1, column_counter].Value = column.ColumnName;
                                sheet.Cells[1, column_counter].Style.Font.Bold = true;

                                if (IncludeComments)
                                {
                                    if (comments != null)
                                    {
                                        if (comments.ContainsKey(column.ColumnName) == true)
                                        {
                                            sheet.Cells[1, column_counter].AddComment(comments[column.ColumnName], System.Environment.UserName);
                                        }
                                    }
                                }
                                column_counter++;
                            }

                            foreach (DataRow row in table.Rows)
                            {
                                column_counter = 1;
                                foreach (DataColumn column in table.Columns)
                                {
                                    sheet.Cells[row_counter, column_counter].Value = row[column.ColumnName];
                                    sheet.Cells[row_counter, column_counter].Style.Numberformat.Format =
                                        Format(column.DataType, IncludeTime, YMD_DateFormat);
                                    column_counter++;
                                }
                                row_counter++;
                            }
                            pkg.SaveAs(file);
                        }
                    }
                    catch (Exception)
                    {
                        throw;
                    }
                    return true;
                }
                else
                {
                    return false;
                }
            }
            
            #region Listos
            /// <summary>
            /// Retorna Formato en base al tipo de dato.
            /// </summary>
            /// <param name="type">System.Type, tipo de dato</param>
            /// <param name="IncludeTime">Incluir la hora para los formatos de fecha</param>
            /// <param name="YMD_DateFormat">Devolver el formato de fecha en YMD</param>
            /// <returns>String con el formato según tipo</returns>
            private static string Format(System.Type type, bool IncludeTime = true, bool YMD_DateFormat = true)
            {
                switch (Type.GetTypeCode(type))
                {
                    case TypeCode.Boolean: return "@";
                    case TypeCode.Byte: return "#,##0";
                    case TypeCode.Char: return "@";
                    case TypeCode.SByte: return "#,##0";
                    case TypeCode.DateTime:
                        {
                            if (IncludeTime == true)
                            {
                                if (YMD_DateFormat == true)
                                {
                                    return "yyyy-mm-dd HH:mm:ss";
                                }
                                else
                                {
                                    return "dd-mm-yyyy HH:mm:ss";
                                }
                            }
                            else
                            {
                                if (YMD_DateFormat == true)
                                {
                                    return "yyyy-mm-dd";
                                }
                                else
                                {
                                    return "dd-mm-yyyy";
                                }
                            }
                        }

                    //case TypeCode.Decimal: return "#,##0.0000";
                    case TypeCode.Decimal: return "G29";

                    case TypeCode.Double: return "#,##0";
                    case TypeCode.Single: return "#,##0";
                    case TypeCode.Int16: return "#,##0";
                    case TypeCode.Int32: return "#,##0";
                    case TypeCode.Int64: return "#,##0";
                    case TypeCode.UInt16: return "#,##0";
                    case TypeCode.UInt32: return "#,##0";
                    case TypeCode.UInt64: return "#,##0";
                    case TypeCode.String: return "@";
                    case TypeCode.DBNull: return "@";
                    case TypeCode.Empty: return "@";
                    case TypeCode.Object: return "@";
                    default: return "@";
                }
            }
            #endregion


        }
    

}
