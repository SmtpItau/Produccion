using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using CoreBusinessObjects.Common;
using CoreBusinessObjects.DTO;
using System.Xml.Linq;
using System.Xml;
using CoreLib.Common;
using Const = CoreBusinessObjects.Common.Constants;

namespace CoreBusinessObjects.BLayer
{

    /// <summary>
    /// Implementacion de logica de negocio XML
    /// </summary>
    public sealed class XmlFacadeBL : AFacade
    {
        private static System.Object MonitorLock = new System.Object();


        /// <summary>
        /// Proceso de volcado de los datos, segun datos de la plantilla.
        /// </summary>
        /// <param name="TData">Plantilla de exportacion</param>
        /// <param name="data">DataSet con el conjunto de datos a exportar</param>
        /// <param name="newFileName">Retorna el nombre de archivo </param>
        /// <returns>True/False</returns>
        public static new  bool ExportData(TemplateData TData, DataSet data, ref string newFileName)
        {
            string msg = string.Empty;
            if (TData == null)
            {
                throw new ArgumentNullException("TData", Const.MSG_TDATA_NOT_NULL);
            }

            if (TData.TemplateDirection == DataDirection.Input)
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
                    throw new ArgumentException(msg, "TData.XmlFile");
                }
                else {
                    if (!TData.IOFile.Extension.Contains(".xml"))
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

            //entelegencia para determinar si genera un archivo nuevo o utiliza un archivo existente.
            bool useNewFileName = false;
            if (TData.IOFile != null && string.IsNullOrEmpty(newFileName)) {
                useNewFileName = false;
            }
            else if (TData.IOFile == null && !string.IsNullOrEmpty(newFileName)) {
                useNewFileName = true;
            }

            List<XmlInfo> lXmlInfo = (from XmlInfo xInfo in TData.ListXmlInfo
                                      where xInfo.XmlDirection == DataDirection.Output || xInfo.XmlDirection == DataDirection.InputOutput
                                      select xInfo
                                              ).ToList();


            XDeclaration xDec = new XDeclaration("1.0", "UTF-8", "yes");
            XDocument xdoc = new XDocument(xDec);

            //TODO: incorporar validacion de XmlRootNode y xmlNodeName

            foreach (XmlInfo xInfo in lXmlInfo)
            {
                string tableName = xInfo.ValueSource;
                DataTable dt = data.Tables[tableName];
                XElement rootNode = new XElement(xInfo.XmlRootNode);
                if (dt != null)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        XElement xElem = new XElement(xInfo.XmlNodeName);
                        foreach (TemplateDataAddress pos in xInfo.AddressCollection)
                        {
                            try
                            {
                                if (pos.RenderAsAttribute == true)
                                {
                                    XAttribute xAttrib = new XAttribute(pos.ColumnName, row[pos.ValueMember]);
                                    xAttrib.Value = xAttrib.Value.Trim();
                                    xElem.Add(xAttrib);
                                }
                                else
                                {
                                    XElement xChild = new XElement(pos.ColumnName, row[pos.ValueMember]);
                                    xChild.Value = xChild.Value.Trim();
                                    xElem.Add(xChild);
                                }
                            }
                            catch (Exception)
                            {
                                if (pos.RenderAsAttribute == true)
                                {
                                    XAttribute xAttrib = new XAttribute(pos.ColumnName, string.Empty);
                                    xAttrib.Value = xAttrib.Value.Trim();
                                    xElem.Add(xAttrib);
                                }
                                else
                                {
                                    XElement xChild = new XElement(pos.ColumnName, string.Empty);
                                    xChild.Value = xChild.Value.Trim();
                                    xElem.Add(xChild);
                                }
                            }
                        } //end foreach AddressCollection
                        rootNode.Add(xElem);
                    } //end foreachrow
                }
                xdoc.Add(rootNode);
            }//end foreach ValueSource


            if (useNewFileName)
            {
                xdoc.Save(newFileName);
            }
            else { 
                //Generacion automagica de nombres de archivos.
            
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

    }
}