#pragma warning disable 1591
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using CoreBusinessObjects.Collections;
using CoreBusinessObjects.Common;
using CoreLib.Helpers;

//using CoreBusinessObjects.DAO;

namespace CoreBusinessObjects.DTO
{

    /// <summary>
    /// Clase que con la informacion del reporte a generar
    /// </summary>
    [Serializable]
    [XmlType("Template")]
    public class TemplateData : IDisposable
    {
        protected Guid? _UniqueID;
        private FileInfo _TemplateFile;
        private string _TemplateFileName;
        
        private FileInfo _IOFile;
        private DataDirection _IOFileDirection = DataDirection.Output;
        private string _IOFileName;

        private List<ExcelInfo>   _ExcelInfo = new List<ExcelInfo>();
        private List<StoreProcsInfo> _StoreProcsInfo = new List<StoreProcsInfo>();
        private List<QueryInfo> _QueryInfo = new List<QueryInfo>();
        private List<XmlInfo>   _XmlInfo = new List<XmlInfo>();
        private List<PlainTextInfo> _PlainTextInfo = new List<PlainTextInfo>();

        //private List<string> _IOFileCopyDirectories = new List<string>();
        private IOFileCopyFoldersCollection<IOFileCopyFolders> _IOFileCopyDirectories = new IOFileCopyFoldersCollection<IOFileCopyFolders>();


        /// <summary>
        /// Default Constructor
        /// </summary>
        public TemplateData() { }

        /// <summary>
        /// Nombre del catalogo de BD para obtener los datos.
        /// </summary>
        [XmlElement]
        public string DBCatalog { get; set; }
        #region Informacion de la plantilla
        /// <summary>
        /// Id interno de la plantilla.
        /// </summary>
        //[XmlElement("UniqueID")]
        [XmlIgnore]
        public Guid? UniqueID { get { return _UniqueID; } set { _UniqueID = value; } }


        /// <summary>
        /// Identificador de base de datos.
        /// </summary>
        [XmlAttribute("TemplateID")]
        public int TemplateID { get; set; }
        public bool ShouldSerializeTemplateID() {
            return this.TemplateID > 0;
        }

        /// <summary>
        /// Nombre de la Plantilla
        /// </summary>
        [XmlElement("Name")]
        public string TemplateName { get; set; }
        public bool ShouldSerializeTemplateName() {
            return !string.IsNullOrEmpty(this.TemplateName);
        }


        /// <summary>
        /// Nombre de campo para asociacion con procesos
        /// </summary>
        [XmlElement("DataBindingName")]
        public string DataBindingName { get; set; }
        public bool ShouldSerializeDataBindingName() {
            return !string.IsNullOrEmpty(this.DataBindingName);
        }

        /// <summary>
        /// Descripcion de la Plantilla
        /// </summary>
        [XmlElement("Description")]
        public string TemplateDescription { get; set; }
        public bool ShouldSerializeTemplateDescription() {
            return !string.IsNullOrEmpty(this.TemplateDescription);
        }

        /// <summary>
        /// Direccion de la plantilla Input/Output
        /// </summary>
        [XmlAttribute("TemplateDirection")]
        public DataDirection TemplateDirection { get { return _TemplateDirection; } set { _TemplateDirection = value; } }
        //private string _TemplateDescription;

        /// <summary>
        /// Archivo de Plantilla 
        /// </summary>
        [XmlIgnore]
        public FileInfo TemplateFile { get { return _TemplateFile; } }


        /// <summary>
        /// Nombre del Archivo de Plantilla.
        /// </summary>
        [XmlElement("TemplateFileName")]
        public string TemplateFileName
        {
            get { return _TemplateFileName; }
            set
            {
                _TemplateFile = new FileInfo(value);
                _TemplateFileName = value;
            }
        }
        public bool ShouldSerializeTemplateFileName() {
            return !string.IsNullOrEmpty(TemplateFileName);
        }
        
        
        #endregion

        /// <summary>
        /// Indica si la plantilla utiliza procedimientos almancenados.
        /// </summary>
        [XmlAttribute("UseStoreProc")]
        public bool UseStoreProc { get; set; }
        
        private DataDirection _TemplateDirection = DataDirection.Output;
        /// <summary>
        /// Lista de procedimientos almacenados
        /// </summary>
        [XmlArray("ListStoreProcsInfo")]
        public List<StoreProcsInfo> ListStoreProcsInfo { get { return _StoreProcsInfo; } set { _StoreProcsInfo = value; } }
        public bool ShouldSerializeListStoreProcsInfo() {
            return null != this.ListStoreProcsInfo && this.ListStoreProcsInfo.Any();
        }
        

        /// <summary>
        /// Retorna un objeto StoreProcsInfo
        /// </summary>
        /// <param name="storeProcName">Nombre del procedimiento almacenado a buscar</param>
        /// <param name="sheetName">Nombre de hoja configurada del StoreProcsInfo</param>
        /// <param name="direction">Direccion configurada del StoreProcsInfo</param>
        /// <returns>StoreProcsInfo</returns>       
        [XmlIgnore]
        public StoreProcsInfo this[string storeProcName ,string sheetName,DataDirection direction]{
            get{
                foreach (StoreProcsInfo info in _StoreProcsInfo) {
                    if (info.StoreProcName == storeProcName && info.SheetName == sheetName && info.Direction == direction) {
                        return info;
                    }
                }
                return null;
            }
        }

        /// <summary>
        /// Busca todos los procedimientos almacenados asociados a un catalogo en particular.
        /// </summary>
        /// <param name="DBCatalog">Nombre del catalogo a buscar</param>
        /// <returns>List&lt;StoreProcsInfo&gt;</returns>
        [XmlIgnore]
        public List<StoreProcsInfo> this[string DBCatalog] {
            get {
                List<StoreProcsInfo> result = new List<StoreProcsInfo>();
                foreach (StoreProcsInfo info in this._StoreProcsInfo) {
                    if (info.DBCatalog == DBCatalog) {
                        result.Add(info);
                    }
                }
                return result;
            }        
        }
        
        /// <summary>
        /// Lista de informacion de las querys.
        /// </summary>
        [XmlArray("ListQueryInfo")]
        public List<QueryInfo> ListQueryInfo { get { return _QueryInfo; } set { _QueryInfo = value; } }
        public bool ShouldSerializeListQueryInfo() {
            return null != this.ListQueryInfo && this.ListQueryInfo.Any();
        }

        /// <summary>
        /// Lista de informacion para XML
        /// </summary>
        [XmlArray("ListXmlInfo")]
        public List<XmlInfo> ListXmlInfo { get { return _XmlInfo; } set { _XmlInfo = value; } }
        public bool ShouldSerializeListXmlInfo() {
            return null != this.ListXmlInfo && this.ListXmlInfo.Any();
        }

        /// <summary>
        /// Lista de informacion de Excel.
        /// </summary>
        [XmlArray("ListExcelInfo")]
        public List<ExcelInfo> ListExcelInfo { get { return _ExcelInfo; } set { _ExcelInfo = value; } }
        public bool ShouldSerializeListExcelInfo() {
            return null != this.ListExcelInfo && this.ListExcelInfo.Any();
        }
        
        /// <summary>
        /// Lista de Informacion para Generacion de Archivos en Texto Plano
        /// </summary>
        [XmlArray("ListPlainTextInfo")]
        public List<PlainTextInfo> ListPlainTextInfo { get { return _PlainTextInfo; } set { _PlainTextInfo = value; } }
        public bool ShouldSerializeListPlainTextInfo() {
            return null != this.ListPlainTextInfo && this.ListPlainTextInfo.Any();
        }

        /// <summary>
        /// FileInfo del Archivo Excel al cual se volcaran los datos
        /// </summary>
        [XmlIgnore]
        public FileInfo IOFile { get { return _IOFile; } set { _IOFile = value; } }
        

        /// <summary>
        /// Nombre del archivo al cual se volcaran los datos
        /// </summary>
        [XmlElement("IOFileName")]
        public string IOFileName { get { return _IOFileName; } set { _IOFile = new FileInfo(value); _IOFileName = value; } }
        public bool ShouldSerializeIOFileName() {
            return !string.IsNullOrEmpty(this.IOFileName);
        }

        /// <summary>
        /// Indica la direccion de los datos hacia o desde el archivo Excel
        /// </summary>
        /// <remarks>Valor por defecto: Output</remarks>
        [XmlElement("IOFileDirection")]
        public DataDirection IOFileDirection { get { return _IOFileDirection; } set { _IOFileDirection = value; } }

        /// <summary>
        /// Patron de nombre de archivo para generacion automagica..
        /// </summary>
        [XmlElement("IOFileNamePattern")]
        public IOFileNamePattern IOFileNamePattern{ get; set; }
        public bool ShouldSerializeIOFileNamePattern(){
            return this.IOFileNamePattern != null;
        }

        /// <summary>
        /// Directorio para entrega de archivos
        /// </summary>
        [XmlElement("IOFileBaseDirectory")]
        public string IOFileBaseDirectory { get; set; }
        public bool ShouldSerializeIOFileBaseDirectory() {
            return !string.IsNullOrEmpty(IOFileBaseDirectory);
        }

        /// <summary>
        /// Directorios para copia
        /// </summary>
        [XmlArray("IOFileCopyDirectories")]
        public IOFileCopyFoldersCollection<IOFileCopyFolders> IOFileCopyFolders { get { return _IOFileCopyDirectories; } set { _IOFileCopyDirectories = value; } }
        //public List<String> IOFileCopyDirectories { get { return _IOFileCopyDirectories; } set { _IOFileCopyDirectories = value; } }

        
        private bool _useAppFolders = false;
        /// <summary>
        /// Indica si usaran los directorios por default de la aplicacion 
        /// </summary>
        [XmlElement("useAppFolders")]
        public bool useAppFolders { get { return _useAppFolders; } set { _useAppFolders = value; } }        
        private bool _addinfo = false;
        
        /// <summary>
        /// Indica si se agregara la sig informacion al proceso de lectura de archivo : RowPosition,FileName,FileTime
        /// </summary>        
        /// <remarks>Default: False</remarks>
        [XmlAttribute("AdditionalInfo")]
        public bool AdditionalInfo {
            get {
                return _addinfo;           
            }
            set {
                _addinfo = value;                
            }
        }
        
        #region Metodos

        /// <summary>
        /// Convierte el objeto en un xml
        /// </summary>
        /// <returns>XmlDocument</returns>
        public XmlDocument ToXML()
        {
            XmlDocument doc = new XmlDocument();
            doc = XmlHelper.SerializeToXML<TemplateData>(this);
            return doc;
        }

        /// <summary>
        /// Convierte el objeto en un xml e incorpora codificacion distinta a UTF-8
        /// </summary>
        /// <returns>XmlDocument</returns>
        public XmlDocument ToXML(Encoding encode)
        {
            XmlDocument doc = new XmlDocument();
            doc = XmlHelper.SerializeToXML<TemplateData>(this, encode);
            return doc;
        }

        /// <summary>
        /// Lee un documento xml y lo transforma a objeto
        /// </summary>
        /// <param name="doc">XmlDocument con la informacion del objeto</param>
        /// <returns>Objeto de tipo</returns>
        public static TemplateData FromXML(XmlDocument doc)
        {
            TemplateData obj = new TemplateData();
            obj = XmlHelper.Deserialize<TemplateData>(doc);
            return obj;
        }

        #endregion

        #region Implementacion IDisposable
        ~TemplateData()
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
                    this._TemplateFile = null;
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
