#pragma warning disable 1591
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using System.IO;
using CoreBusinessObjects.Common;

namespace CoreBusinessObjects.DTO
{
    public class QueryInfo:IDisposable
    {
        private string _QueryFileName;
        private FileInfo _QueryFile;
        private string _QueryString;
        private DataDirection _QueryDirection = DataDirection.Output;

        /// <summary>
        /// Direccion de la query Input/Output
        /// </summary>
        public DataDirection QueryDirection { get { return _QueryDirection; } set { _QueryDirection = value; } }


        /// <summary>
        /// Catalogo de la query.
        /// </summary>
        public string DBCatalog {get;set;}

        /// <summary>
        /// Consulta SQL Asociada a la Plantilla
        /// </summary>
        [XmlElement("QueryString")]
        public string QueryString
        {
            get
            {
                string query = string.Empty;
                if (_QueryFile == null)
                {
                    return string.Empty;
                }
                if (_QueryFile.Exists)
                {
                    StreamReader reader = new StreamReader(_QueryFile.FullName, Encoding.Default, true);
                    StringBuilder sb = new StringBuilder();
                    string sLine = string.Empty;
                    while (reader.Peek() > 0)
                    {
                        sLine = reader.ReadLine();
                        if (sLine != null)
                        {
                            sb.AppendLine(sLine);
                        }
                    }
                    return sb.ToString();
                }
                else
                {
                    return string.Empty;
                }
            }
            set { _QueryString = value; }
        }
        
        /// <summary>
        /// Archivo de Consulta
        /// </summary>
        [XmlIgnore]
        public FileInfo QueryFile { get { return _QueryFile; } }
        
        /// <summary>
        /// Nombre del Archivo de Consulta
        /// </summary>
        [XmlElement("QueryFileName")]
        public string QueryFileName
        {
            get { return _QueryFileName; }
            set
            {
                _QueryFileName = value;
                _QueryFile = new FileInfo(value);
            }
        }

        
        #region Implementacion IDisposable
        private bool disposed = false;

        ~QueryInfo()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    //Liberacion de recursos tomados.
                    //this._TemplateFile = null;
                }
                disposed = true;
            }
        }
        #endregion
    }
}
