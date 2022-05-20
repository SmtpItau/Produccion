using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using CoreBusinessObjects.Common;
using CoreBusinessObjects.DTO;
using CoreBusinessObjects.Collections;
using CoreLib.Common;
using CoreLib.Helpers;
using Const = CoreBusinessObjects.Common.Constants;

namespace CoreBusinessObjects.BLayer
{



    //TODO: MODIFICAR TBL_MODULO_FUSION, INCORPORAR CAMPO MOTOR O HACER QUE EL SISTEMA INFIERA EL MOTOR DE EXPORTACION
    //TODO: UNIFICAR PROCESOS SIMILARES EN FUNCIONES PARA OPTIMIZAR APLICACION.
    //TODO: MEJORAR SERVICIO WINDOWS PARA EJECUCION ASINCRONA
    //TODO: TERMINAR PLANTILLAS (4/7)
    
    /// <summary>
    /// Implementacion de logica de negocio exportacion a texto plano, separador por coma, posicion y largo fijo.
    /// </summary>
    public class PlainTextFacade : AFacade
    {
        /// <summary>
        /// estructura para generar campo de largo fijo.
        /// </summary>
        private struct FixedFieldSize
        {
            public string ColumnName { get; set; }
            public string ValueMember { get; set; }
            public string Source { get; set; }
            public int? Size { get; set; }
            public Align? vAlign { get; set; }
            public string FillWith { get; set; }
            public int ColumnOrdinal { get; set; }
        }

               



        private static System.Object MonitorLock = new System.Object();

        /// <summary>
        /// Rutina de exportacion a texto plano, delimitado o de largo fijo
        /// </summary>
        /// <param name="TData">Datos de Plantilla</param>
        /// <param name="data">Datos a exportar</param>
        /// <param name="newFileName">Nombre de archivo a usar para la exportacion</param>
        /// <returns>True/False</returns>
        public static new bool ExportData(TemplateData TData, DataSet data, ref string newFileName)
        {
            Validate(TData, data, newFileName, ProcessEngineType.Output);
            try
            {
                StringBuilder sb = new StringBuilder();
                foreach (PlainTextInfo textInfo in TData.ListPlainTextInfo)
                {
                    //lista de campos 
                    List<FixedFieldSize> aux_fixed_field = (from TemplateDataAddress item in textInfo.AddressCollection
                                                            select new FixedFieldSize()
                                                            {

                                                                ColumnName = item.ColumnTitle,
                                                                ValueMember = item.ValueMember,
                                                                Size = item.MaxFieldSize,
                                                                vAlign = item.DataAlign,
                                                                FillWith = item.FillWith,
                                                                Source = item.SheetName,
                                                                ColumnOrdinal = item.ColumnPosition
                                                            }).ToList();

                    #region Generacion de Cabezera
                    if (textInfo.DataOnly == false)
                    {
                        if (!string.IsNullOrEmpty(textInfo.Token))
                        {
                            IEnumerable<string> columnNames = aux_fixed_field.Select(x => x.ColumnName);
                            sb.AppendLine(string.Join(textInfo.Token, columnNames));
                        }
                        else
                        {
                            string aux_data = string.Empty;
                            foreach (FixedFieldSize item in aux_fixed_field)
                            {
                                #region Tamaño fijo
                                int aux_size = 0;
                                if (!(item.Size == null) && !(item.Size <= 0)) { aux_size = (int)item.Size;}
                                else if (!(textInfo.MaxRowSize == null) && !(textInfo.MaxRowSize <= 0)) { aux_size = (int)textInfo.MaxRowSize; }

                                char pad = ' ';
                                if (!string.IsNullOrEmpty(item.FillWith))
                                {
                                    pad = item.FillWith[0];
                                }

                                if (item.vAlign == Align.Left)
                                {
                                    aux_data += item.ColumnName.PadLeft(aux_size, pad).Substring(0, aux_size); //row[item.ValueMember].ToString().PadLeft(aux_size, pad).Substring(0, aux_size);
                                }
                                else
                                {
                                    aux_data += item.ColumnName.PadRight(aux_size, pad).Substring(0, aux_size);
                                }
                                #endregion
                            }
                            if (!string.IsNullOrEmpty(aux_data))
                            {
                                //si no hay token separador, se aplica el criterio que la exportacion es de campo fijo
                                //por lo tanto la opcion de validar el tamaño se aplica, siempre y cuando exista un valor 
                                //en el campo de plantilla MaxRowSize.
                                if (string.IsNullOrEmpty(textInfo.Token))
                                {
                                    if (textInfo.ValidateMaxSize)
                                    {
                                        if (!(textInfo.MaxRowSize == null) && !(textInfo.MaxRowSize <= 0))
                                        {
                                            if (aux_data.Length != textInfo.MaxRowSize)
                                            {
                                                aux_data = Const.MSG_TDATA_INVALID_SIZE + "|" + aux_data;
                                            }
                                        }
                                    }
                                }
                                sb.AppendLine(aux_data);
                            }
                        }
                        //generacion de la cabezera                    
                    } 
                    #endregion
                    
                    #region Volcado de datos.


                    DataTable table = data.Tables[textInfo.ValueSource];
                    foreach (DataRow row in table.Rows)
                    {
                        string aux_data = string.Empty;
                        foreach (FixedFieldSize item in aux_fixed_field)
                        {
                            if (!string.IsNullOrEmpty(textInfo.Token))
                            {
                                #region con separador de campo
                                IEnumerable<string> fields = row.ItemArray.Select(
                                                            field => Regex.IsMatch(field.ToString().Replace(",", "").Replace(".", ""), @"\A^\d*$\z") == true ?  //verifica que sea numero
                                                                    field.ToString().Replace(",", ".").Trim() :  //si es numero, reemplaza la coma por punto
                                                                    field.ToString().Replace(",", " ").Trim());         //si no es numero, reemplaza la coma por un espacio, para que no choque con el token separador   
                                aux_data = string.Join(textInfo.Token, fields);
                                #endregion
                            }
                            else
                            {
                                #region Tamaño fijo
                                int aux_size = 0;
                                if (!(item.Size == null) && !(item.Size <= 0)) { aux_size = (int)item.Size; }
                                else if (!(textInfo.MaxRowSize == null) && !(textInfo.MaxRowSize <= 0)) { aux_size = (int)textInfo.MaxRowSize; }

                                char pad = ' ';
                                if (!string.IsNullOrEmpty(item.FillWith))
                                {
                                    pad = item.FillWith[0];
                                }


                                if (item.vAlign == Align.Left)
                                {
                                    aux_data += row[item.ValueMember].ToString().PadLeft(aux_size, pad).Substring(0, aux_size);
                                }
                                else
                                {
                                    aux_data += row[item.ValueMember].ToString().PadRight(aux_size, pad).Substring(0, aux_size);
                                }

                             

                                #endregion
                            }
                        }//foreach FixedFieldSize

                        if (!string.IsNullOrEmpty(aux_data))
                        {
                            //si no hay token separador, se aplica el criterio que la exportacion es de campo fijo
                            //por lo tanto la opcion de validar el tamaño se aplica, siempre y cuando exista un valor 
                            //en el campo de plantilla MaxRowSize.
                            if (string.IsNullOrEmpty(textInfo.Token)) {
                                if (textInfo.ValidateMaxSize)
                                {
                                    if (!(textInfo.MaxRowSize == null) && !(textInfo.MaxRowSize <= 0)) {
                                        if (aux_data.Length != textInfo.MaxRowSize)
                                        {
                                            aux_data = Const.MSG_TDATA_INVALID_SIZE + "|" + aux_data;
                                        }                                    
                                    }
                                }
                            }
                            sb.AppendLine(aux_data);
                        }
                    }//foreach datarow  

                    
                    #endregion
                
                } //foreach textInfo           

                if (sb.Length <= 0) { 
                    sb.AppendLine("");
                    File.WriteAllText(newFileName,sb.ToString());
                }else{
                    File.WriteAllText(newFileName, sb.ToString().Substring(0,sb.Length-2));                
                }                
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return true;
        }







        /// <summary>
        /// Rutina de exportacion a texto plano, en bruto.
        /// </summary>
        /// <param name="context">Contexto de Aplicacion</param>
        /// <param name="TData">Datos de Plantilla</param>        
        /// <param name="cmdProcedures">Lista de Procedimientos preparados para ejecutar</param>
        /// <param name="token">token separador de campos.</param>
        /// <param name="newFileName">Nombre de archivo a usar para la exportacion</param>
        /// <returns>True/False</returns>
        /// <remarks>
        /// Procesa un unico procedimiento almacenado, que devuelva 2 tablas, procesa la primera directo al archivo
        /// y la segunda tabla la arroja como encabezado del archivo (esto se debe mejorar y ajustar a la mecanica de la plantilla)
        /// o ver algun mecanismo que permita la generalizacion (flags o algo por el estilo)
        /// </remarks>
        public static new bool ExportDataRaw(string tempFolder, TemplateData TData
            , List<Tuple<string, string, List<SqlParameter>>> cmdProcedures
            , ref string newFileName, string token = "")
        {

            try
            {


                //TODO: AJUSTAR A LA MECANICA DE LAS PLANTILLAS, lectura de parametros y opciones de procesamiento, verificacion de columnas de datos
                //versus columnas de la plantilla, etc.
                DirectoryInfo dir = new DirectoryInfo(tempFolder);
                FileInfo file_info = new FileInfo(newFileName);
                string temp_file = string.Empty;

                if (!dir.Exists)
                {
                    throw new ArgumentException(Const.MSG_FILE_NOTFOUND, "tempFolder");
                }

                temp_file = dir.FullName + "\\" + file_info.Name;

                if (File.Exists(temp_file))
                {
                    File.Delete(temp_file);
                }

                string first_line = string.Empty;
                using (StreamWriter sw = new StreamWriter(temp_file, false))
                {
                    //sw.WriteLine(); //primera linea vacia..                
                    foreach (Tuple<string, string, List<SqlParameter>> sp_aux_data in cmdProcedures)
                    {
                        int aux_counter = 0;
                        SqlDataReader sql_reader = SqlHelper.ExecuteReader(sp_aux_data.Item1, sp_aux_data.Item2, sp_aux_data.Item3.ToArray());
                        do
                        {
                            while (sql_reader.Read())
                            {
                                var aux_row = new object[sql_reader.FieldCount];
                                int column_count = sql_reader.GetValues(aux_row);
                                List<string> fields = aux_row.AsEnumerable().Select(field => field.ToString()).ToList();

                                if (aux_counter > 0)
                                {
                                    first_line = string.Join(token, fields);
                                }
                                else
                                {
                                    sw.WriteLine(string.Join(token, fields));
                                }
                            }
                            aux_counter++;
                        } while (sql_reader.NextResult());
                    }
                }//fin stream writer temporal.


                StreamReader reader = new StreamReader(temp_file);
                StreamWriter writer = new StreamWriter(newFileName, false);
                
                string line = string.Empty;
                if (!string.IsNullOrEmpty(first_line))
                {
                    line = first_line;
                }
                
                do
                {                    
                    writer.WriteLine(line);

                } while ((line = reader.ReadLine()) != null);

                reader.Close();
                writer.Close();

                if (File.Exists(temp_file))
                {
                    File.Delete(temp_file);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return true;
        }


        /// <summary>
        /// Rutina de exportacion a texto plano, en bruto.
        /// </summary>
        /// <param name="TData">Datos de Plantilla</param>
        /// <param name="data">Datos a exportar</param>
        /// <param name="newFileName">Nombre de archivo a usar para la exportacion</param>
        /// <returns>True/False</returns>
        public static new bool ExportDataRaw(TemplateData TData, DataSet data, ref string newFileName)
        {
            
            Validate(TData, data, newFileName, ProcessEngineType.Output);
            try
            {
               
                using (StreamWriter sw = new StreamWriter(newFileName, false))
                {

                    foreach (PlainTextInfo textInfo in TData.ListPlainTextInfo)
                    {
                        #region Volcado de datos.
                        DataTable table = data.Tables[textInfo.ValueSource];
                        IEnumerable<string> str_fields = (from TemplateDataAddress item in textInfo.AddressCollection
                                                          select item.ValueMember).ToList();

                        IEnumerable<string> columns = table.Columns.OfType<DataColumn>().Select(x => x.ColumnName).Except(str_fields).ToList();

                        //limpieza de columnas adicionales.
                        if (columns.Count() > 0)
                        {
                            foreach (string column in columns)
                            {
                                table.Columns.Remove(column);
                            }
                        }

                        foreach (DataRow row in table.Rows)
                        {
                            //aux_data = string.Join(textInfo.Token, fields);
                            List<string> fields = row.ItemArray.Select(field => field.ToString()).ToList();

                            if (!string.IsNullOrEmpty(textInfo.Token))
                            {
                                sw.WriteLine(string.Join(textInfo.Token, fields));
                             
                            }
                            else
                            {
                                sw.WriteLine(string.Join("", fields));
                                
                            }
                        }//foreach datarow  
                        #endregion

                    } //foreach textInfo           



                }            
            }
            catch (Exception ex)
            {
                throw ex;
            }

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
            throw new NotImplementedException();
        }

        /// <summary>
        /// Validacion basica para las distintas operaciones a realizar por el motor.
        /// </summary>
        /// <param name="TData">Plantilla de proceso</param>
        /// <param name="data">Datos a procesar por la plantilla</param>
        /// <param name="newFileName">nombre de archivo a generar</param>
        /// <param name="proctype">Tipo de Proceso Input/Output</param>
        private static void Validate(TemplateData TData, DataSet data, string newFileName, ProcessEngineType proctype)
        {
            string msg = string.Empty;


            if (proctype == ProcessEngineType.Input)
            {
                if (TData.IOFileDirection == DataDirection.Output)
                {
                    throw new ArgumentOutOfRangeException("TData", Const.MSG_TDATA_OUTPUT);
                }
            }
            else
            {
                if (TData.IOFileDirection == DataDirection.Input)
                {
                    throw new ArgumentOutOfRangeException("TData", Const.MSG_TDATA_INPUT);
                }
            }

            if (TData == null)
            {
                throw new ArgumentNullException("TData", Const.MSG_TDATA_NOT_NULL);
            }

            if (TData.ListPlainTextInfo.Count == 0)
            {
                throw new ArgumentNullException("TData.ListPlainTextInfo", Const.MSG_TDATA_MISSCONFIG);
            }

            if (string.IsNullOrEmpty(TData.ListPlainTextInfo[0].ValueSource))
            {
                throw new ArgumentNullException("TData.ListPlainTextInfo.ValueSource", Const.MSG_PARAM_NOT_NULL);
            }


            if (data == null || data.Tables.Count == 0)
            {
                throw new ArgumentNullException("data", Const.MSG_DATA_NOT_FOUND);
            }

            //validacion de archivo para el volcado.
            if (TData.IOFile != null)
            {
                if (TData.IOFile.Exists == false)
                {
                    msg = string.Format(Const.MSG_FILE_NOTFOUND, TData.IOFileName);
                    throw new ArgumentException(msg, "TData.PlainText");
                }
                else
                {
                    if (proctype == ProcessEngineType.Input)
                    {
                        if (!Regex.IsMatch(TData.IOFile.Extension.ToLower(), ".txt|.dat|.csv"))
                        {
                            msg = string.Format(Const.MSG_FILE_EXTENSION, TData.IOFile.Extension);
                            throw new ArgumentException(msg, "TData.IOFile.Extension");
                        }
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
        }
    }
}
