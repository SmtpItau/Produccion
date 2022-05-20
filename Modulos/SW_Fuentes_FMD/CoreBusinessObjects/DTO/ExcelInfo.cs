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
    /// Clase de informacion de archivo excel para input/ouput
    /// </summary>
    [Serializable()]
    [XmlType("ExcelInfo")]
    public class ExcelInfo : IDisposable
    {
        
        private TemplateDataAddressCollection<TemplateDataAddress> _AddressCollection = new TemplateDataAddressCollection<TemplateDataAddress>();
        private string _ExcelSheetName;
        private DataDirection _ExcelSheetDirection = DataDirection.Output;

        /// <summary>
        /// Indica la direccion de la hoja input/output/inputoutput
        /// </summary>
        [XmlElement("SheetDirection")]
        public DataDirection ExcelSheetDirection { get { return _ExcelSheetDirection; } set { _ExcelSheetDirection = value; } }

        /// <summary>
        /// Indica el nombre de la hoja con la que se realiza la lectura
        /// </summary>
        [XmlElement("SheetName")]
        public string ExcelSheetName { get { return _ExcelSheetName.Normalize(NormalizationForm.FormKC); } set { _ExcelSheetName = value; } }


        /// <summary>
        /// Indica la fila donde empiezan los datos para lectura
        /// </summary>
        /// <remarks></remarks>
        [XmlElement("RowStart")]
        public int ExcelRowStart { get; set; }

        /// <summary>
        /// Indica la colunna donde empiezan los datos para lectura
        /// </summary>
        /// <remarks>Independiente si las columnas se encuentran en rango</remarks>
        [XmlElement("ColumnStart")]
        public int ExcelColumnStart { get; set; }


        /// <summary>
        /// Indica si se pregunta al usuario por el nombre de archivo excel a guardar
        /// </summary>
        [XmlElement("SaveAsPrompt")]
        public bool ExcelSaveAsPrompt { get; set; }


        /// <summary>
        /// Fuente de donde se obtendra el dato, debe ser el nombre del DataTable
        /// </summary>
        [XmlAttribute("ValueSource")]
        public string ExcelValueSource { get; set; }

        /// <summary>
        /// Admite paginacion
        /// </summary>
        [XmlAttribute("AllowPaging")]
        public bool AllowPaging { get; set; }


        /// <summary>
        /// Tamañano de pagina
        /// </summary>
        [XmlAttribute("PageSize")]
        public int PageSize {
            get{
                return _pageSize;
            } 
            set{
                if (AllowPaging == true)
                {
                    _pageSize = value;
                }
                else {
                    _pageSize = -1;
                }
            } 
        }
        private int _pageSize;

        /// <summary>
        /// Retorna la Coleccion de Direcciones de celdas asociadas a la plantilla.
        /// </summary>
        [XmlArrayItem(ElementName = "CellInfoAddress", Type = typeof(TemplateDataAddress))]
        public TemplateDataAddressCollection<TemplateDataAddress> AddressCollection { get { return _AddressCollection; } set { _AddressCollection = value; } }

        #region Implementacion IDisposable
        ~ExcelInfo()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        private bool disposed = false;
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

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        #endregion
    }
}
