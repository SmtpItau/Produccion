#pragma warning disable 1591
using System;
using System.Xml;
using System.Xml.Serialization;
using System.IO;
using System.Linq;
using CoreLib.Helpers;
using CoreBusinessObjects.Common;
using CoreBusinessObjects.Collections;
using System.Text;

namespace CoreBusinessObjects.DTO
{
    /// <summary>
    /// Clase que almacena las coordenadas F/C e informacion adicional
    /// </summary>
    [Serializable]
    [XmlType("DataAddress")]
    public class TemplateDataAddress : IDisposable
    {


        #region Private Members
        private string  _ColumnName;
        private string _Format = string.Empty;
        private string _SheetName;
        private string _ColumnTitle;
        protected Guid? _UniqueID;        
        private bool _IsReadOnly    = false;
        private bool _RenderAsAttribute = false;
        private bool _CauseValidation = true;
        private DataDirection _Direction = DataDirection.InputOutput;
        private int _MaxWritableRows = 50;
        
        #endregion
        
        
        #region Propiedades
        /// <summary>
        /// Id unico de cada posicion de celda.
        /// </summary>
        //[XmlElement("UniqueID")]
        [XmlIgnore]
        public Guid? UniqueID { get { return _UniqueID; } set { _UniqueID = value; } }
        /// <summary>
        /// Posicion de Fila 
        /// </summary>
        [XmlElement("RowPosition")]
        public int RowPosition { get; set; }
        
        /// <summary>
        /// Posicion de Columna
        /// </summary>
        [XmlElement("ColumnPosition")]
        public int ColumnPosition { get; set; }

        /// <summary>
        /// Nombre de Columna (A,B,C,D,E,F,...)
        /// </summary>
        [XmlElement("ColumnName")]
        //public string ColumnName { get; set; }
        public string ColumnName
        {
            get
            {
                if (!string.IsNullOrEmpty(_ColumnName))
                {
                    return _ColumnName.Normalize(NormalizationForm.FormKC);
                }
                else
                {
                    return string.Empty;
                }
            }
            set { _ColumnName = value; }
        }
        public bool ShouldSerializeColumnName() {
            return !string.IsNullOrEmpty(this.ColumnName);
        }
        
        /// <summary>
        /// Titulo de la Columna 
        /// </summary>
        [XmlElement("ColumnTitle")]
        //public string ColumnTitle { get; set; }
        public string ColumnTitle { 
            get {
                if (!string.IsNullOrEmpty(_ColumnTitle))
                {
                  return _ColumnTitle.Normalize(NormalizationForm.FormKC);
                }
                else {
                    return string.Empty;                
                }            
            } 
            set { _ColumnTitle = value;}
        }
        public bool ShouldSerializeColumnTitle()
        {
            return !string.IsNullOrEmpty(this.ColumnTitle);
        }
        
        
        /// <summary>
        /// Identificador de columna (SQL) que contiene los datos a escribir en el Excel
        /// </summary>
        [XmlElement("ValueMember")]
        public string ValueMember { get; set; }
        public bool ShouldSerializeValueMember()
        {
            return !string.IsNullOrEmpty(this.ValueMember);
        }


        /// <summary>Indica si la columna es de solo lectura</summary>        
        [XmlAttribute("IsReadOnly")]
        public bool IsReadOnly { get { return _IsReadOnly; } set { _IsReadOnly = value; } }
        
        /// <summary>
        /// Indica si la celda se mostrara como attributo (solo para XML)
        /// </summary>
        [XmlAttribute("RenderAsAttribute")]
        public bool RenderAsAttribute{
            get { return _RenderAsAttribute; }
            set { _RenderAsAttribute = value; }        
        }
        /// <summary>
        /// Indica si la celda se utiliza en la validacion de contenido
        /// </summary>
        [XmlAttribute("CauseValidation")]
        public bool CauseValidation { get { return _CauseValidation; } set { _CauseValidation = value; } }
        /// <summary>
        /// Indica direccion de volcado de los datos en el archivo excel.
        /// </summary>
        [XmlAttribute("DataAddressDirection")]
        public DataDirection Direction { get { return _Direction; } set{_Direction = value;} }
       
        
        /// <summary>
        /// Comentarios para aplicar a la cabecera de la columna
        /// </summary>
        [XmlElement("Comments")]
        public string Comments { get; set; }
        public bool ShouldSerializeComments()
        {
            return !string.IsNullOrEmpty(this.Comments);
        }


        /// <summary>
        /// Maximo de filas a escribir , default: 50
        /// </summary>
        //[XmlElement(ElementName="MaxWritableRows")]
        [XmlAttribute("MaxWritableRows")]
        public int MaxWritableRows { get { return _MaxWritableRows; } set { _MaxWritableRows=value ;} }
        //public bool ShouldSerializeMaxWritableRows() {
        //    return this.MaxWritableRows != null;
        //}
        
        /// <summary>
        /// Retorna las coordenadas de la celda
        /// </summary>
        [XmlArrayItem("RowColumnPosition")]
        public int[] RowColumnPosition
        {
            get
            {
                int[] result = {this.RowPosition, this.ColumnPosition };
                return result;
            }
        }
        public bool ShouldSerializeRowColumnPosition() {
            return this.RowColumnPosition.Length > 0 && this.RowColumnPosition.Any();
        }
        
        
        /// <summary>
        /// Formato del dato de la celda
        /// </summary>
        [XmlElement("Format")]
        public string Format { get { return _Format; } set { _Format = value; } }
        public bool ShouldSerializeFormat()
        {
            return !string.IsNullOrEmpty(this.Format);
        }
        
        /// <summary>
        /// Formula para aplicar a la celda
        /// </summary>
        [XmlElement("Formula")]
        public string Formula { get; set; }
        public bool ShouldSerializeFormula()
        {
            return !string.IsNullOrEmpty(this.Formula);
        }

        /// <summary>
        /// Indica el nombre de la hoja a la que pertenece la columna
        /// </summary>
        [XmlElement("SheetName")]
        public string SheetName {
            get {
                if (!string.IsNullOrEmpty(_SheetName))
                {
                    return _SheetName.Normalize(NormalizationForm.FormKC);
                }
                else {
                    return string.Empty;                
                }            
            } 
            set { _SheetName = value;}
        }
        public bool ShouldSerializeSheetName()
        {
            return !string.IsNullOrEmpty(this.SheetName);
        }


        #region Para Motor de Texto Plano.
        /// <summary>
        /// Tamaño Maximo del campo(caracteres)
        /// </summary>
        [XmlElement("MaxFieldSize")]
        public int? MaxFieldSize { get; set; }
        public bool ShouldSerializeMaxFieldSize()
        {
            return this.MaxFieldSize != null;
        }

        /// <summary>
        /// Alineacion de la data (izquierda/derecha)
        /// </summary>
        [XmlElement("DataAlign")]
        public Align? DataAlign { get; set; }
        public bool ShouldSerializeDataAlign()
        {
            return this.DataAlign != null;
        }

        /// <summary>Caracter de relleno para campos</summary>
        [XmlElement("FillWith")]
        public string FillWith { get; set; }
        public bool ShouldSerializeFillWith()
        {
            return !string.IsNullOrEmpty(this.FillWith);
        } 
        #endregion

        #endregion
        #region Implementacion IDisposable
        /// <summary>
        /// Default Destructor
        /// </summary>
        ~TemplateDataAddress()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        /// <summary>
        /// Disposing Flag
        /// </summary>
        private bool disposed = false;
        
        /// <summary>
        /// Virtual Dispose Method
        /// </summary>
        /// <param name="disposing">true/false</param>        
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

        /// <summary>
        /// Dispose Method
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        #endregion

        /// <summary>
        /// Constructor
        /// </summary>
        public TemplateDataAddress() {
            this._UniqueID = Guid.NewGuid();
        }

        /// <summary>
        /// Convierte el objeto en xml
        /// </summary>
        /// <returns>XmlDocument</returns>
        public XmlDocument ToXML() {
            XmlDocument xdoc = new XmlDocument();
            xdoc = XmlHelper.SerializeToXML<TemplateDataAddress>(this);
            return xdoc;
        }

        /// <summary>
        /// Carga de un xml un TemplateDataAddress
        /// </summary>
        /// <returns>TemplateDataAddress</returns>
        public static TemplateDataAddress FromXML(XmlDocument doc)
        {
            TemplateDataAddress obj = new TemplateDataAddress();
            obj = XmlHelper.Deserialize<TemplateDataAddress>(doc);
            return obj;
        }
    }


}
