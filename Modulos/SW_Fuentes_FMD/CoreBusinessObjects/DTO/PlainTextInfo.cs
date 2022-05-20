#pragma warning disable 1591
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using CoreBusinessObjects.Collections;
using System.IO;
using CoreBusinessObjects.Common;

namespace CoreBusinessObjects.DTO
{
    
    /// <summary>
    /// Clase de informacion para generar archivo de texto plano,csv y de campo fijo
    /// </summary>
    [Serializable()]
    [XmlType("PlainTextInfo")]
    public class PlainTextInfo:IDisposable
    {
        #region Private Members
        private TemplateDataAddressCollection<TemplateDataAddress> _AddressCollection = new TemplateDataAddressCollection<TemplateDataAddress>();
        private DataDirection _PlainTextDirecction = DataDirection.Output;
        private string _Token;        
        #endregion

        #region Properties
        /// <summary>Indica la direccion de la plantilla.</summary>
        [XmlElement("PlainTextDirecction")]
        public DataDirection PlainTextDirection { get { return _PlainTextDirecction; } set { _PlainTextDirecction = value; } }

        /// <summary>Retorna la especificacion de campos </summary>
        [XmlArrayItem("PlainTextFieldInfo", Type = typeof(TemplateDataAddress))]
        public TemplateDataAddressCollection<TemplateDataAddress> AddressCollection
        {
            get { return _AddressCollection; }
            set { _AddressCollection = value; }
        }
        public bool ShouldSerializeAddressCollection()
        {
            return this.AddressCollection != null && this.AddressCollection.Any();
        }
        
        /// <summary>Separador para CSV</summary>
        [XmlElement("Token")]
        public string Token { get { return _Token; } set { _Token = value; } }
        public bool ShouldSerializeToken()
        {
            return !string.IsNullOrEmpty(this.Token);
        }

        /// <summary>Tamaño maximo de la fila (para comprobacion) / Total de caracteres x fila.</summary>
        [XmlElement("MaxRowSize")]
        public int? MaxRowSize { get; set; }
        public bool SouldSerializeMaxRowSize() {
            return this.MaxRowSize != null;
        }

        /// <summary>
        /// Indica si se utilizara solamente la data o las columnas para el volcado de informacion.
        /// </summary>
        [XmlElement("DataOnly")]
        public bool DataOnly { get; set; }

        /// <summary>
        /// Fuente de donde se obtendra el dato, debe ser el nombre del DataTable
        /// </summary>
        [XmlElement("ValueSource")]
        public string ValueSource { get; set; }

        [XmlElement("ValidateMaxSize")]
        public bool ValidateMaxSize { get; set; }
        #endregion
        

        #region Implementacion IDisposable

        /// <summary>Default Constructor.</summary>
        public PlainTextInfo() {}
        
        private bool disposed = false;

        /// <summary>Default Destructor</summary>
        ~PlainTextInfo()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        
        /// <summary>Dispose Object</summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        /// <summary>Dispose Object</summary>
        /// <param name="disposing"></param>
        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    //Liberacion de recursos tomados.                    
                }
                disposed = true;
            }
        }
        #endregion Implementacion IDisposable

    }
}
