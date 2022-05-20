#pragma warning disable 1591
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using CoreLib.Helpers;
//using CoreBusinessObjects.DAO;


namespace CoreBusinessObjects.DTO
{
    [Serializable()]
    [XmlType("StoreProcParams")]
    public class TemplateStoreProcParams:IDisposable
    {

        /// <summary>
        /// Default Construct
        /// </summary>
        public TemplateStoreProcParams(){}

        #region Propiedades
        //[XmlElement("UniqueID")]
        [XmlIgnore]
        public Guid? UniqueID { get { return _UniqueID; } set { _UniqueID = value; } }
        protected Guid? _UniqueID;


        /// <summary>
        /// Nombre del procedimiento almacenado
        /// </summary>
        [XmlElement("StoreProcName")]
        public string StoreProcName { get; set; }

        /// <summary>
        /// Nombre del parametro
        /// </summary>
        [XmlElement("ParameterName")]
        public string ParameterName { get; set; }

        /// <summary>
        /// Direccion del parametro
        /// </summary>
        [XmlElement("Direction")]
        public ParameterDirection Direction{ get; set; }

        
        /// <summary>
        /// Cantidad de digitos
        /// </summary>
        [XmlElement("Precision")]
        public byte Precision { get { return _Precision; } set { _Precision = value; } }
        private byte _Precision = 0;
        /// <summary>
        /// Determina la escala de los parametros numericos (cant. de decimales)
        /// </summary>
        [XmlElement("Scale")]
        public byte Scale { get { return _Scale; } set { _Scale = value; } }
        private byte _Scale = 0x0;

        /// <summary>
        /// Tamaño maximo de caracteres o numeros admitidos por el parametro
        /// </summary>
        [XmlElement("Size")]
        public int Size { get { return _Size; } set { _Size = value; } }
        private int _Size = 0;
        
        
        /// <summary>
        /// Tipo de dato SQL
        /// </summary>
        [XmlElement("DBType")]
        public DbType DBType { get { return _DBType; } set { _DBType = value; } }
        private DbType _DBType = DbType.Object;

        /// <summary>
        /// Inidica si puede ser nulo o no.
        /// </summary>
        [XmlElement("Nullable")]
        public bool IsNullable { get { return _IsNullable; } set { _IsNullable = value; } }
        private bool _IsNullable = true;
        

        /// <summary>
        /// Valor por defecto del parametro
        /// </summary>
        [XmlElement("ParameterValue")]
        public object ParameterValue { get; set; }

        //public 

        /// <summary>
        /// Indica si se debe utilizar el valor del parametro o solicitar al usuario
        /// por defecto utiliza el parametro (true)
        /// </summary>
        [XmlElement("UseParameterValue")]
        public bool UseParameterValue { get { return _UseParameterValue; } set { _UseParameterValue = value; } }
        private bool _UseParameterValue = true;


        /// <summary>
        /// Obtiene o establece la columna del origen de datos (cuando la plantilla es de input / inputoutput
        /// </summary>
        [XmlElement("SourceColumn")]
        public string SourceColumn { get; set; }


        #endregion

        #region Implementacion IDisposable
        ~TemplateStoreProcParams()
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

        #region Metodos

        /// <summary>
        /// Retorna IDataParameter del parametro de plantilla.
        /// </summary>
        /// <returns>IDataParameter</returns>
        public IDataParameter Parameter(){
            try
            {

                IDataParameter obj = new SqlParameter();
                obj.DbType = this._DBType;
                obj.Direction = this.Direction;
                obj.ParameterName = this.ParameterName;
                obj.Value = this.ParameterValue;
                obj.SourceColumn = this.SourceColumn;
                return obj;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public SqlParameter sqlParameter() {
            try
            {
                SqlParameter obj = new SqlParameter();
                obj.DbType = this._DBType;
                obj.Direction = this.Direction;
                obj.ParameterName = this.ParameterName;

                if (this.Direction == ParameterDirection.Input || this.Direction == ParameterDirection.InputOutput)
                {
                    if (this.ParameterValue == null) {
                        obj.Value = this.ParameterValue;

                    }else if (this.ParameterValue.ToString() == string.Empty)
                    {
                        obj.Value = DBNull.Value;
                    }
                    else
                    {
                        obj.Value = this.ParameterValue;
                    }
                }
                else {
                        obj.Value = this.ParameterValue;
                }
                
                obj.IsNullable = this.IsNullable;
                obj.Scale = this.Scale;
                obj.Size = this.Size;
                obj.Precision = this.Precision;
                obj.SourceColumn = this.SourceColumn;
                return obj;
            /*    switch (DbType)
                {
                    case DbType.AnsiString:
                        break;
                    case DbType.AnsiStringFixedLength:
                        break;
                    case DbType.Binary:
                        break;
                    case DbType.Boolean:
                        break;
                    case DbType.Byte:
                        break;
                    case DbType.Currency:
                        break;
                    case DbType.Date:
                        break;
                    case DbType.DateTime:
                        break;
                    case DbType.DateTime2:
                        break;
                    case DbType.DateTimeOffset:
                        break;
                    case DbType.Decimal:
                        break;
                    case DbType.Double:
                        break;
                    case DbType.Guid:
                        break;
                    case DbType.Int16:
                        break;
                    case DbType.Int32:
                        break;
                    case DbType.Int64:
                        break;
                    case DbType.Object:
                        break;
                    case DbType.SByte:
                        break;
                    case DbType.Single:
                        break;
                    case DbType.String:
                        break;
                    case DbType.StringFixedLength:
                        break;
                    case DbType.Time:
                        break;
                    case DbType.UInt16:
                        break;
                    case DbType.UInt32:
                        break;
                    case DbType.UInt64:
                        break;
                    case DbType.VarNumeric:
                        break;
                    case DbType.Xml:
                        break;
                    default:
                        break;
                }*/
            }
            catch (Exception)
            {
                
                throw;
            }
        }
        

        /// <summary>
        /// Convierte el objeto en un xml
        /// </summary>
        /// <returns>XmlDocument</returns>
        public XmlDocument ToXML()
        {
            XmlDocument doc = new XmlDocument();
            doc = XmlHelper.SerializeToXML<TemplateStoreProcParams>(this);
            return doc;
        }

        /// <summary>
        /// Convierte el objeto en un xml e incorpora codificacion distinta a UTF-8
        /// </summary>
        /// <returns>XmlDocument</returns>
        public XmlDocument ToXML(Encoding encode)
        {
            XmlDocument doc = new XmlDocument();
            doc = XmlHelper.SerializeToXML<TemplateStoreProcParams>(this, encode);
            return doc;
        }

        /// <summary>
        /// Lee un documento xml y lo transforma a objeto
        /// </summary>
        /// <param name="doc">XmlDocument con la informacion del objeto</param>
        /// <returns>Objeto de tipo</returns>
        public static TemplateStoreProcParams FromXML(XmlDocument doc)
        {
            TemplateStoreProcParams obj = new TemplateStoreProcParams();
            obj = XmlHelper.Deserialize<TemplateStoreProcParams>(doc);
            return obj;
        } 
        #endregion

    }
}
