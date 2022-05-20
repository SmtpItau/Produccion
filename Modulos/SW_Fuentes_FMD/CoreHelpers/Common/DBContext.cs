#pragma warning disable 1591
using System;
using System.Data;
using System.Data.Common;
using System.Runtime.Serialization;
using System.Xml;
using System.Xml.Serialization;
namespace CoreLib.Common
{

    /// <summary>
    /// Clase de contexto
    /// </summary>
    [Serializable()]
    [XmlType("DBContext")] 
    [DataContract(Name="DBContext")]
    public class DBContext : IDisposable
    {
        #region "DataLoginAccessContext"
        protected Guid? _UniqueID = Guid.NewGuid();
        
        /// <summary>
        /// Instance Unique Identifier
        /// </summary>
        [XmlIgnore]        
        public Guid? UniqueID { get { return _UniqueID; } set { _UniqueID = value; } }

        /// <summary>
        /// Servidor
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public string DBServerName { get; set; }

        /// <summary>
        /// Direccion IP del servidor
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public string DB_IP_Address { get; set; }

        /// <summary>
        /// Indica si usa la direcion IP del servidor en vez del nombre
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public bool Use_IP_Address { get; set; }

        /// <summary>
        /// User Name
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public string DBUserName { get; set; }

        /// <summary>
        /// User Password
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public string DBUserPass { get; set; }

        /// <summary>
        /// Base de datos o catalogo
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public string DBCatalog { get; set; }

        /// <summary>
        /// Usa seguridad integrada
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public bool IntegratedSecurity { get; set; }


        /// <summary>
        /// Usa conexion de confianza
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public bool TrustedConnection { get; set; }

        /// <summary>
        /// Timeout de la conexion
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public int ConnectionTimeout { get; set; }


        #region Pooling Settings
        /// <summary>
        /// Indica si utiliza pooling de connexiones (default: TRUE)
        /// </summary>        
        [XmlAttribute()]
        [DataMember]
        public bool DBPooling
        {
            get { return _DBPooling; }
            set { _DBPooling = value; }
        }
        private bool _DBPooling = true;

        /// <summary>
        /// Cantidad minima de conexiones en el pool de conexiones (default: 2)
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public int DBMinConnection { get { return _DBMinConnection; } set { _DBMinConnection = value; } }
        private int _DBMinConnection = 2;

        /// <summary>
        /// Cantidad maxima de conexiones en el pool de conexiones (default:6)
        /// </summary>
        [XmlAttribute()]
        [DataMember]
        public int DBMaxConnection { get { return _DBMaxConnection; } set { _DBMaxConnection = value; } }
        private int _DBMaxConnection = 6;

        #endregion

        /// <summary>
        /// Retorna Connection String
        /// </summary>
        /// <returns>string</returns>
        [XmlIgnore]
        public string StringConnection
        {
            get
            {
                string user_data = @" User ID = {0}; Pwd = {1}";
                string pooling_data = @" Pooling = {0}; Min Pool Size = {1}; Max Pool Size = {2}";
                string address_data = @"{0} = {1}; Initial Catalog={2}";

                user_data = string.Format(user_data, DBUserName, DBUserPass);

                if (Use_IP_Address)
                {
                    address_data = string.Format(address_data, "Data Source", DB_IP_Address, DBCatalog);
                }
                else
                {
                    address_data = string.Format(address_data, "Data Source", DBServerName, DBCatalog);
                }

                if (DBPooling)
                {
                    pooling_data = string.Format(pooling_data, "True", DBMinConnection, DBMaxConnection);
                }
                else
                {
                    pooling_data = string.Empty;
                }

                string result;
                if (DBPooling == false)
                {
                    result = address_data + ";" + user_data;
                }
                else
                {
                    result = address_data + ";" + pooling_data + ";" + user_data;
                }

                if (TrustedConnection)
                {
                    result += ";" + "Trusted_Connection = True";
                }
                if (IntegratedSecurity)
                {
                    result += ";" + "Integrated Security = SSPI";
                }

                if (ConnectionTimeout > 0) {
                    result += ";" + "Connection Timeout = " + ConnectionTimeout.ToString();
                        
                }
                return result;
            }
        }

        /// <summary>
        /// Retorna objeto IDbConnection
        /// </summary>
        [XmlIgnore]
        public IDbConnection Connection
        {
            get
            {
                if (this.isValid)
                {
                    _connection = new System.Data.SqlClient.SqlConnection();
                    _connection.ConnectionString = this.StringConnection;
                    return (IDbConnection)_connection;
                }
                else
                {
                    return null;
                }
            }
            set
            {
                _connection = value;
            }
        }
        private IDbConnection _connection;

        /// <summary>
        /// Indica si la cadena de conexion es valida.
        /// </summary>
        [XmlIgnore]
        public bool isValid
        {
            get
            {
                try
                {
                    DbConnectionStringBuilder csb = new DbConnectionStringBuilder();
                    csb.ConnectionString = this.StringConnection;
                }
                catch (Exception)
                {
                    _isValid = false;
                    return _isValid;
                }
                _isValid = true;
                return _isValid;
            }
        }
        private bool _isValid = false;


        #endregion
        #region Implementacion IDisposable
        public DBContext() { }
        ~DBContext()
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
    }

}
