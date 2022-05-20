#pragma warning disable 1591
using System;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using CoreBusinessObjects.Collections;
using CoreBusinessObjects.Common;

namespace CoreBusinessObjects.DTO
{
    [Serializable()]
    public class StoreProcsInfo : IDisposable
    {
        private DataDirection _Direction = DataDirection.Output;
        private string _sheetName;
        private string _storeProcName;
        private TemplateStoreProcParamsCollection<TemplateStoreProcParams> _storeProcParams = new TemplateStoreProcParamsCollection<TemplateStoreProcParams>();       
        
        public StoreProcsInfo(string sheetName, string storeProcName, params TemplateStoreProcParams[] parameters)
        {
            this._sheetName = sheetName;
            this._storeProcName = storeProcName;
            this._storeProcParams = new TemplateStoreProcParamsCollection<TemplateStoreProcParams>();
            foreach (TemplateStoreProcParams p in parameters)
            {
                this._storeProcParams.Add(p);
            }
        }
        public StoreProcsInfo() { }

        /// <summary>
        /// Nombre del catalogo o base de datos donde buscar el procedimiento.
        /// </summary>
        public string DBCatalog { get; set; }


        /// <summary>
        /// Indica direccion de los resultados del store procs
        /// </summary>
        public DataDirection Direction { get { return _Direction; } set { _Direction = value; } }

        /// <summary>
        /// Especifica un time out para la conexion.
        /// </summary>
        [XmlElement("ConnectionTimeout")]
        public int ConnectionTimeout { get; set; }


        /// <summary>
        /// Indica si tiene parametros la ejecucion del store procedure
        /// </summary>
        [XmlIgnore()]
        public bool hasParameters
        {
            get
            {
                if (this._storeProcParams.Count == 0)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
        }

        /// <summary>
        /// Nombre de la hoja asociada a la ejecucion del Store Procedure
        /// </summary>
        [XmlElement("SheetName")]
        public string SheetName { 
            get {
                if (string.IsNullOrEmpty(_sheetName)) {
                    return string.Empty;
                }
                
                return _sheetName.Normalize(NormalizationForm.FormKC); 
            } set {
                _sheetName = value; 
            } 
        }

        /// <summary>
        /// Nombre del Store Procedure Input/Output
        /// </summary>
        [XmlElement("StoreProcName")]
        public string StoreProcName { get { return _storeProcName; } set { _storeProcName = value; } }

        /// <summary>
        /// Coleccion de parametros para el store procedure
        /// </summary>
        [XmlArray("ListStoreProcParams")]
        public TemplateStoreProcParamsCollection<TemplateStoreProcParams> ListStoreProcParams
        {
            get { return _storeProcParams; }
            set { _storeProcParams = value; }
        }


  


        //TODO: RETORNAR UN OBJETO IDBCOMMAND PARA EJECUCION DIRECTA CON HELPER

        #region Implementacion IDisposable
        private bool disposed = false;

        ~StoreProcsInfo()
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
