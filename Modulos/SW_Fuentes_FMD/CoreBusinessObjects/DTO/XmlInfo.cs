#pragma warning disable 1591
using System;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using CoreBusinessObjects.Collections;
using CoreBusinessObjects.Common;

namespace CoreBusinessObjects.DTO
{
    /// <summary>
    /// Clase de informacion para archivo xml input/ouput
    /// </summary>
    [Serializable()]
    [XmlType("XmlInfo")]
    public class XmlInfo : IDisposable
    {
        private TemplateDataAddressCollection<TemplateDataAddress> _AddressCollection = new TemplateDataAddressCollection<TemplateDataAddress>();
        private DataDirection _XmlDirection = DataDirection.Output;
        private string _XmlNodeName;
        private string _XmlRootNode;

        /// <summary>
        /// Retorna la Coleccion de Campos asociadas a la plantilla.
        /// </summary>
        [XmlArrayItem(ElementName = "CellInfoAddress", Type = typeof(TemplateDataAddress))]
        public TemplateDataAddressCollection<TemplateDataAddress> AddressCollection { get { return _AddressCollection; } set { _AddressCollection = value; } }

        /// <summary>
        /// Indica la colunna donde empiezan los datos para lectura
        /// </summary>
        /// <remarks>Independiente si las columnas se encuentran en rango</remarks>
        [XmlElement("ColumnStart")]
        public int ColumnStart { get; set; }

        /// <summary>
        /// Catalogo.
        /// </summary>
        public string DBCatalog { get; set; }

        /// <summary>
        /// Indica la fila donde empiezan los datos para lectura
        /// </summary>
        /// <remarks></remarks>
        [XmlElement("RowStart")]
        public int RowStart { get; set; }

        /// <summary>
        /// Indica si se pregunta al usuario por el nombre de archivo excel a guardar
        /// </summary>
        [XmlElement("SaveAsPrompt")]
        public bool SaveAsPrompt { get; set; }

        /// <summary>
        /// Fuente de donde se obtendra el dato, debe ser el nombre del DataTable
        /// </summary>
        [XmlAttribute("ValueSource")]
        public string ValueSource { get; set; }

        /// <summary>
        /// Indica la direccion de la hoja input/output/inputoutput
        /// </summary>
        [XmlElement("XmlDirection")]
        public DataDirection XmlDirection { get { return _XmlDirection; } set { _XmlDirection = value; } }
        /// <summary>
        /// Indica el nombre de la enumeracion del elemento xml
        /// </summary>
        [XmlElement("XmlNodeName")]
        public string XmlNodeName { get { return _XmlNodeName.Normalize(NormalizationForm.FormKC); } set { _XmlNodeName = value; } }

        /// <summary>
        /// Indica el nombre del nodo raiz xml
        /// </summary>
        [XmlElement("XmlRootNode")]
        public string XmlRootNode { get { return _XmlRootNode.Normalize(NormalizationForm.FormKC); } set { _XmlRootNode = value; } }
        
        #region Implementacion IDisposable

        private bool disposed = false;

        ~XmlInfo()
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
                    //this._ExcelFile = null;
                }
                disposed = true;
            }
        }
        #endregion Implementacion IDisposable
    }
}